import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app_test/model/api_adapter.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Quiz> quizs = [];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse('https://drf-quiz-app.herokuapp.com/quiz/1/'));
    if (response.statusCode == 200) {
      setState(() {
        quizs = parseQuizs(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception('failed to load data');
    }
  }


  /*List<Quiz> quizs = [
    Quiz.fromMap({
    'title': 'test',
    'candidates': ['a','b','c','d'],
    'answer': 0
    }),
    Quiz.fromMap({
    'title': 'test',
    'candidates': ['a','b','c','d'],
    'answer': 0
    }),
    Quiz.fromMap({
    'title': 'test',
    'candidates': ['a','b','c','d'],
    'answer': 0
    }),
  ];*/


  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      '64','63','62','61','60','59','58','57','56','55'
      ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: Container(),
          centerTitle: true,
        title: const Text('한국사능력검정시험 기본'),
      ),
      body: ListView.builder(
        itemCount:entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child:ListTile(
              title: Text(
                '한국사능력검정시험 기본 ${entries[index]}',
                style: TextStyle(
                  fontSize:27
                ),
              ),
            onTap: () {
              _fetchQuizs().whenComplete(() {
                return Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(
                            quizs:quizs,
                          ),
                )
                );
              }
                      );
                    },
            ),
            color: Colors.white
          );
        },
    ),
    );
  }
}