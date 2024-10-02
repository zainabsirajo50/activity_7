import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAndRotatingImage(),
    );
  }
}

class FadingTextAndRotatingImage extends StatefulWidget {
  @override
  _FadingTextAndRotatingImageState createState() =>
      _FadingTextAndRotatingImageState();
}

class _FadingTextAndRotatingImageState extends State<FadingTextAndRotatingImage>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false; // Start with text invisible
  bool _isSpinning = false; // Image will not spin initially
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    ); // Do not start animation until button is pressed
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Toggle visibility of text
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Toggle spinning of the image
  void toggleSpinning() {
    setState(() {
      if (_isSpinning) {
        _controller.stop(); // Stop spinning
      } else {
        _controller.repeat(); // Start spinning
      }
      _isSpinning = !_isSpinning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text and Rotating Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Fading text with visibility controlled by button
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0, // Change opacity based on _isVisible
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: const Text(
                'Hello, Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),

          // Color changing text (animation runs immediately)
          Center(
            child: AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: _isVisible ? 24 : 40,
                  fontWeight: _isVisible ? FontWeight.normal : FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                duration: Duration(seconds: 1),
                child: Text('Text Animation!'),
              ),
          ),
          SizedBox(height: 30),

          // Rotating image controlled by button
          Center(
            child: RotationTransition(
              turns: _controller, // Rotation controlled by _controller
              child: Image.network(
                'https://cdn.pixabay.com/photo/2023/12/15/21/47/cat-8451431_1280.jpg',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),

      // Floating action buttons to control animations
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Button to control text visibility
          FloatingActionButton(
            onPressed: toggleVisibility,
            child: Icon(Icons.play_arrow),
            tooltip: 'Toggle Text Visibility',
          ),
          SizedBox(height: 20),

          // Button to control image spinning
          FloatingActionButton(
            onPressed: toggleSpinning,
            child: Icon(_isSpinning ? Icons.pause : Icons.play_arrow),
            tooltip: _isSpinning ? 'Stop Spinning' : 'Start Spinning',
          ),
        ],
      ),
    );
  }
}