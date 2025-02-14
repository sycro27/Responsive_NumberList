import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive UI Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NumberListPage(),
    );
  }
}

class NumberListPage extends StatelessWidget {
  final List<int> numbers =
      List.generate(20, (index) => index + 1); // List of numbers 1 to 20

  @override
  Widget build(BuildContext context) {
    // Get the width and height of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    // Check if the orientation is portrait or landscape
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Define column count based on screen width
    int columnCount = (screenWidth > 600)
        ? 2
        : 1; // More than 600px width = 2 columns (Landscape or large screens)

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Number List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (columnCount == 1)
            // Portrait mode (Single Column or smaller screens)
            ? ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return CustomNumberItem(number: numbers[index]);
                },
              )
            // Landscape mode or large screens (Two Columns)
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns in landscape mode
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  // Adjust the size of the boxes in landscape mode
                  childAspectRatio:
                      1.5, // Adjust this value to make the boxes smaller
                ),
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return CustomNumberItem(number: numbers[index]);
                },
              ),
      ),
    );
  }
}

class CustomNumberItem extends StatelessWidget {
  final int number;

  const CustomNumberItem({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
