Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssg9-0003Sq-J8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssev-0003cD-Fw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsseu-0003aT-Us
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:39 +0200
Message-Id: <20180823164025.12553-13-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/58] check-qjson: Cover UTF-8 in single
 quoted strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

utf8_string() tests only double quoted strings.  Cover single quoted
strings, too: store the strings to test without quotes, then wrap them
in either kind of quote.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 427 ++++++++++++++++++++++----------------------
 1 file changed, 214 insertions(+), 213 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index c67ac72858..b229bfabac 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -175,10 +175,14 @@ static void utf8_string(void)
      * http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt
      */
     static const struct {
+        /* Content of JSON string to parse with qobject_from_json() */
         const char *json_in;
+        /* Expected parse output */
         const char *utf8_out;
-        const char *json_out;   /* defaults to @json_in */
-        const char *utf8_in;    /* defaults to @utf8_out */
+        /* Expected unparse output, defaults to @json_in */
+        const char *json_out;
+        /* Expected parse output for @json_out, defaults to @utf8_out */
+        const char *utf8_in;
     } test_cases[] = {
         /*
          * Bug markers used here:
@@ -196,72 +200,72 @@ static void utf8_string(void)
         /* 1  Some correct UTF-8 text */
         {
             /* a bit of German */
-            "\"Falsches \xC3\x9C" "ben von Xylophonmusik qu\xC3\xA4lt"
-            " jeden gr\xC3\xB6\xC3\x9F" "eren Zwerg.\"",
             "Falsches \xC3\x9C" "ben von Xylophonmusik qu\xC3\xA4lt"
             " jeden gr\xC3\xB6\xC3\x9F" "eren Zwerg.",
-            "\"Falsches \\u00DCben von Xylophonmusik qu\\u00E4lt"
-            " jeden gr\\u00F6\\u00DFeren Zwerg.\"",
+            "Falsches \xC3\x9C" "ben von Xylophonmusik qu\xC3\xA4lt"
+            " jeden gr\xC3\xB6\xC3\x9F" "eren Zwerg.",
+            "Falsches \\u00DCben von Xylophonmusik qu\\u00E4lt"
+            " jeden gr\\u00F6\\u00DFeren Zwerg.",
         },
         {
             /* a bit of Greek */
-            "\"\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5\"",
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
-            "\"\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5\"",
+            "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
+            "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
         },
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
         /* 2.1.1  1 byte U+0000 */
         {
-            "\"\\u0000\"",
+            "\\u0000",
             "",                 /* bug: want overlong "\xC0\x80" */
-            "\"\\u0000\"",
+            "\\u0000",
             "\xC0\x80",
         },
         /* 2.1.2  2 bytes U+0080 */
         {
-            "\"\xC2\x80\"",
             "\xC2\x80",
-            "\"\\u0080\"",
+            "\xC2\x80",
+            "\\u0080",
         },
         /* 2.1.3  3 bytes U+0800 */
         {
-            "\"\xE0\xA0\x80\"",
             "\xE0\xA0\x80",
-            "\"\\u0800\"",
+            "\xE0\xA0\x80",
+            "\\u0800",
         },
         /* 2.1.4  4 bytes U+10000 */
         {
-            "\"\xF0\x90\x80\x80\"",
             "\xF0\x90\x80\x80",
-            "\"\\uD800\\uDC00\"",
+            "\xF0\x90\x80\x80",
+            "\\uD800\\uDC00",
         },
         /* 2.1.5  5 bytes U+200000 */
         {
-            "\"\xF8\x88\x80\x80\x80\"",
+            "\xF8\x88\x80\x80\x80",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF8\x88\x80\x80\x80",
         },
         /* 2.1.6  6 bytes U+4000000 */
         {
-            "\"\xFC\x84\x80\x80\x80\x80\"",
+            "\xFC\x84\x80\x80\x80\x80",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFC\x84\x80\x80\x80\x80",
         },
         /* 2.2  Last possible sequence of a certain length */
         /* 2.2.1  1 byte U+007F */
         {
-            "\"\x7F\"",
             "\x7F",
-            "\"\\u007F\"",
+            "\x7F",
+            "\\u007F",
         },
         /* 2.2.2  2 bytes U+07FF */
         {
-            "\"\xDF\xBF\"",
             "\xDF\xBF",
-            "\"\\u07FF\"",
+            "\xDF\xBF",
+            "\\u07FF",
         },
         /*
          * 2.2.3  3 bytes U+FFFC
@@ -273,122 +277,122 @@ static void utf8_string(void)
          * U+FFFC here.
          */
         {
-            "\"\xEF\xBF\xBC\"",
             "\xEF\xBF\xBC",
-            "\"\\uFFFC\"",
+            "\xEF\xBF\xBC",
+            "\\uFFFC",
         },
         /* 2.2.4  4 bytes U+1FFFFF */
         {
-            "\"\xF7\xBF\xBF\xBF\"",
+            "\xF7\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF7\xBF\xBF\xBF",
         },
         /* 2.2.5  5 bytes U+3FFFFFF */
         {
-            "\"\xFB\xBF\xBF\xBF\xBF\"",
+            "\xFB\xBF\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFB\xBF\xBF\xBF\xBF",
         },
         /* 2.2.6  6 bytes U+7FFFFFFF */
         {
-            "\"\xFD\xBF\xBF\xBF\xBF\xBF\"",
+            "\xFD\xBF\xBF\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFD\xBF\xBF\xBF\xBF\xBF",
         },
         /* 2.3  Other boundary conditions */
         {
             /* last one before surrogate range: U+D7FF */
-            "\"\xED\x9F\xBF\"",
             "\xED\x9F\xBF",
-            "\"\\uD7FF\"",
+            "\xED\x9F\xBF",
+            "\\uD7FF",
         },
         {
             /* first one after surrogate range: U+E000 */
-            "\"\xEE\x80\x80\"",
             "\xEE\x80\x80",
-            "\"\\uE000\"",
+            "\xEE\x80\x80",
+            "\\uE000",
         },
         {
             /* last one in BMP: U+FFFD */
-            "\"\xEF\xBF\xBD\"",
             "\xEF\xBF\xBD",
-            "\"\\uFFFD\"",
+            "\xEF\xBF\xBD",
+            "\\uFFFD",
         },
         {
             /* last one in last plane: U+10FFFD */
-            "\"\xF4\x8F\xBF\xBD\"",
             "\xF4\x8F\xBF\xBD",
-            "\"\\uDBFF\\uDFFD\""
+            "\xF4\x8F\xBF\xBD",
+            "\\uDBFF\\uDFFD"
         },
         {
             /* first one beyond Unicode range: U+110000 */
-            "\"\xF4\x90\x80\x80\"",
             "\xF4\x90\x80\x80",
-            "\"\\uFFFD\"",
+            "\xF4\x90\x80\x80",
+            "\\uFFFD",
         },
         /* 3  Malformed sequences */
         /* 3.1  Unexpected continuation bytes */
         /* 3.1.1  First continuation byte */
         {
-            "\"\x80\"",
+            "\x80",
             "\x80",             /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.1.2  Last continuation byte */
         {
-            "\"\xBF\"",
+            "\xBF",
             "\xBF",             /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.1.3  2 continuation bytes */
         {
-            "\"\x80\xBF\"",
+            "\x80\xBF",
             "\x80\xBF",         /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         /* 3.1.4  3 continuation bytes */
         {
-            "\"\x80\xBF\x80\"",
+            "\x80\xBF\x80",
             "\x80\xBF\x80",     /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.5  4 continuation bytes */
         {
-            "\"\x80\xBF\x80\xBF\"",
+            "\x80\xBF\x80\xBF",
             "\x80\xBF\x80\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.6  5 continuation bytes */
         {
-            "\"\x80\xBF\x80\xBF\x80\"",
+            "\x80\xBF\x80\xBF\x80",
             "\x80\xBF\x80\xBF\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.7  6 continuation bytes */
         {
-            "\"\x80\xBF\x80\xBF\x80\xBF\"",
+            "\x80\xBF\x80\xBF\x80\xBF",
             "\x80\xBF\x80\xBF\x80\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.8  7 continuation bytes */
         {
-            "\"\x80\xBF\x80\xBF\x80\xBF\x80\"",
+            "\x80\xBF\x80\xBF\x80\xBF\x80",
             "\x80\xBF\x80\xBF\x80\xBF\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.9  Sequence of all 64 possible continuation bytes */
         {
-            "\"\x80\x81\x82\x83\x84\x85\x86\x87"
+            "\x80\x81\x82\x83\x84\x85\x86\x87"
             "\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F"
             "\x90\x91\x92\x93\x94\x95\x96\x97"
             "\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F"
             "\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7"
             "\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
             "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7"
-            "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF\"",
+            "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF",
              /* bug: not corrected */
             "\x80\x81\x82\x83\x84\x85\x86\x87"
             "\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F"
@@ -398,27 +402,27 @@ static void utf8_string(void)
             "\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
             "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7"
             "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF",
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
-            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\""
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
         },
         /* 3.2  Lonely start characters */
         /* 3.2.1  All 32 first bytes of 2-byte sequences, followed by space */
         {
-            "\"\xC0 \xC1 \xC2 \xC3 \xC4 \xC5 \xC6 \xC7 "
+            "\xC0 \xC1 \xC2 \xC3 \xC4 \xC5 \xC6 \xC7 "
             "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
             "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
-            "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF \"",
+            "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF ",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
-            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \"",
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
             "\xC0 \xC1 \xC2 \xC3 \xC4 \xC5 \xC6 \xC7 "
             "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
             "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
@@ -426,159 +430,159 @@ static void utf8_string(void)
         },
         /* 3.2.2  All 16 first bytes of 3-byte sequences, followed by space */
         {
-            "\"\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
-            "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF \"",
+            "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
+            "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
             /* bug: not corrected */
             "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
             "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
-            "\"\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
-            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \"",
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.3  All 8 first bytes of 4-byte sequences, followed by space */
         {
-            "\"\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 \"",
+            "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \"",
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
             "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
         },
         /* 3.2.4  All 4 first bytes of 5-byte sequences, followed by space */
         {
-            "\"\xF8 \xF9 \xFA \xFB \"",
+            "\xF8 \xF9 \xFA \xFB ",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD \\uFFFD \\uFFFD \\uFFFD \"",
+            "\\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
             "\xF8 \xF9 \xFA \xFB ",
         },
         /* 3.2.5  All 2 first bytes of 6-byte sequences, followed by space */
         {
-            "\"\xFC \xFD \"",
+            "\xFC \xFD ",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD \\uFFFD \"",
+            "\\uFFFD \\uFFFD ",
             "\xFC \xFD ",
         },
         /* 3.3  Sequences with last continuation byte missing */
         /* 3.3.1  2-byte sequence with last byte missing (U+0000) */
         {
-            "\"\xC0\"",
+            "\xC0",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xC0",
         },
         /* 3.3.2  3-byte sequence with last byte missing (U+0000) */
         {
-            "\"\xE0\x80\"",
+            "\xE0\x80",
             "\xE0\x80",           /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.3.3  4-byte sequence with last byte missing (U+0000) */
         {
-            "\"\xF0\x80\x80\"",
+            "\xF0\x80\x80",
             "\xF0\x80\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.3.4  5-byte sequence with last byte missing (U+0000) */
         {
-            "\"\xF8\x80\x80\x80\"",
+            "\xF8\x80\x80\x80",
             NULL,                   /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF8\x80\x80\x80",
         },
         /* 3.3.5  6-byte sequence with last byte missing (U+0000) */
         {
-            "\"\xFC\x80\x80\x80\x80\"",
+            "\xFC\x80\x80\x80\x80",
             NULL,                        /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFC\x80\x80\x80\x80",
         },
         /* 3.3.6  2-byte sequence with last byte missing (U+07FF) */
         {
-            "\"\xDF\"",
+            "\xDF",
             "\xDF",             /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.3.7  3-byte sequence with last byte missing (U+FFFF) */
         {
-            "\"\xEF\xBF\"",
+            "\xEF\xBF",
             "\xEF\xBF",           /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 3.3.8  4-byte sequence with last byte missing (U+1FFFFF) */
         {
-            "\"\xF7\xBF\xBF\"",
+            "\xF7\xBF\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF7\xBF\xBF",
         },
         /* 3.3.9  5-byte sequence with last byte missing (U+3FFFFFF) */
         {
-            "\"\xFB\xBF\xBF\xBF\"",
+            "\xFB\xBF\xBF\xBF",
             NULL,                 /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFB\xBF\xBF\xBF",
         },
         /* 3.3.10  6-byte sequence with last byte missing (U+7FFFFFFF) */
         {
-            "\"\xFD\xBF\xBF\xBF\xBF\"",
+            "\xFD\xBF\xBF\xBF\xBF",
             NULL,                        /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFD\xBF\xBF\xBF\xBF",
         },
         /* 3.4  Concatenation of incomplete sequences */
         {
-            "\"\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
-            "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF\"",
+            "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
+            "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
-            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
             "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
             "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
         },
         /* 3.5  Impossible bytes */
         {
-            "\"\xFE\"",
+            "\xFE",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFE",
         },
         {
-            "\"\xFF\"",
+            "\xFF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFF",
         },
         {
-            "\"\xFE\xFE\xFF\xFF\"",
+            "\xFE\xFE\xFF\xFF",
             NULL,                 /* bug: rejected */
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
             "\xFE\xFE\xFF\xFF",
         },
         /* 4  Overlong sequences */
         /* 4.1  Overlong '/' */
         {
-            "\"\xC0\xAF\"",
+            "\xC0\xAF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xC0\xAF",
         },
         {
-            "\"\xE0\x80\xAF\"",
+            "\xE0\x80\xAF",
             "\xE0\x80\xAF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
-            "\"\xF0\x80\x80\xAF\"",
+            "\xF0\x80\x80\xAF",
             "\xF0\x80\x80\xAF",  /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
-            "\"\xF8\x80\x80\x80\xAF\"",
+            "\xF8\x80\x80\x80\xAF",
             NULL,                        /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF8\x80\x80\x80\xAF",
         },
         {
-            "\"\xFC\x80\x80\x80\x80\xAF\"",
+            "\xFC\x80\x80\x80\x80\xAF",
             NULL,                               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFC\x80\x80\x80\x80\xAF",
         },
         /*
@@ -589,16 +593,16 @@ static void utf8_string(void)
          */
         {
             /* \U+007F */
-            "\"\xC1\xBF\"",
+            "\xC1\xBF",
             NULL,               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xC1\xBF",
         },
         {
             /* \U+07FF */
-            "\"\xE0\x9F\xBF\"",
+            "\xE0\x9F\xBF",
             "\xE0\x9F\xBF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /*
@@ -607,181 +611,181 @@ static void utf8_string(void)
              * noncharacter.  Testing U+FFFC seems more useful.  See
              * also 2.2.3
              */
-            "\"\xF0\x8F\xBF\xBC\"",
+            "\xF0\x8F\xBF\xBC",
             "\xF0\x8F\xBF\xBC",   /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+1FFFFF */
-            "\"\xF8\x87\xBF\xBF\xBF\"",
+            "\xF8\x87\xBF\xBF\xBF",
             NULL,                        /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF8\x87\xBF\xBF\xBF",
         },
         {
             /* \U+3FFFFFF */
-            "\"\xFC\x83\xBF\xBF\xBF\xBF\"",
+            "\xFC\x83\xBF\xBF\xBF\xBF",
             NULL,                               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFC\x83\xBF\xBF\xBF\xBF",
         },
         /* 4.3  Overlong representation of the NUL character */
         {
             /* \U+0000 */
-            "\"\xC0\x80\"",
+            "\xC0\x80",
             NULL,               /* bug: rejected */
-            "\"\\u0000\"",
+            "\\u0000",
             "\xC0\x80",
         },
         {
             /* \U+0000 */
-            "\"\xE0\x80\x80\"",
+            "\xE0\x80\x80",
             "\xE0\x80\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+0000 */
-            "\"\xF0\x80\x80\x80\"",
+            "\xF0\x80\x80\x80",
             "\xF0\x80\x80\x80",   /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+0000 */
-            "\"\xF8\x80\x80\x80\x80\"",
+            "\xF8\x80\x80\x80\x80",
             NULL,                        /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xF8\x80\x80\x80\x80",
         },
         {
             /* \U+0000 */
-            "\"\xFC\x80\x80\x80\x80\x80\"",
+            "\xFC\x80\x80\x80\x80\x80",
             NULL,                               /* bug: rejected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
             "\xFC\x80\x80\x80\x80\x80",
         },
         /* 5  Illegal code positions */
         /* 5.1  Single UTF-16 surrogates */
         {
             /* \U+D800 */
-            "\"\xED\xA0\x80\"",
+            "\xED\xA0\x80",
             "\xED\xA0\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DB7F */
-            "\"\xED\xAD\xBF\"",
+            "\xED\xAD\xBF",
             "\xED\xAD\xBF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DB80 */
-            "\"\xED\xAE\x80\"",
+            "\xED\xAE\x80",
             "\xED\xAE\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DBFF */
-            "\"\xED\xAF\xBF\"",
+            "\xED\xAF\xBF",
             "\xED\xAF\xBF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DC00 */
-            "\"\xED\xB0\x80\"",
+            "\xED\xB0\x80",
             "\xED\xB0\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DF80 */
-            "\"\xED\xBE\x80\"",
+            "\xED\xBE\x80",
             "\xED\xBE\x80",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+DFFF */
-            "\"\xED\xBF\xBF\"",
+            "\xED\xBF\xBF",
             "\xED\xBF\xBF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* 5.2  Paired UTF-16 surrogates */
         {
             /* \U+D800\U+DC00 */
-            "\"\xED\xA0\x80\xED\xB0\x80\"",
+            "\xED\xA0\x80\xED\xB0\x80",
             "\xED\xA0\x80\xED\xB0\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+D800\U+DFFF */
-            "\"\xED\xA0\x80\xED\xBF\xBF\"",
+            "\xED\xA0\x80\xED\xBF\xBF",
             "\xED\xA0\x80\xED\xBF\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DC00 */
-            "\"\xED\xAD\xBF\xED\xB0\x80\"",
+            "\xED\xAD\xBF\xED\xB0\x80",
             "\xED\xAD\xBF\xED\xB0\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DFFF */
-            "\"\xED\xAD\xBF\xED\xBF\xBF\"",
+            "\xED\xAD\xBF\xED\xBF\xBF",
             "\xED\xAD\xBF\xED\xBF\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DC00 */
-            "\"\xED\xAE\x80\xED\xB0\x80\"",
+            "\xED\xAE\x80\xED\xB0\x80",
             "\xED\xAE\x80\xED\xB0\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DFFF */
-            "\"\xED\xAE\x80\xED\xBF\xBF\"",
+            "\xED\xAE\x80\xED\xBF\xBF",
             "\xED\xAE\x80\xED\xBF\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DC00 */
-            "\"\xED\xAF\xBF\xED\xB0\x80\"",
+            "\xED\xAF\xBF\xED\xB0\x80",
             "\xED\xAF\xBF\xED\xB0\x80", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DFFF */
-            "\"\xED\xAF\xBF\xED\xBF\xBF\"",
+            "\xED\xAF\xBF\xED\xBF\xBF",
             "\xED\xAF\xBF\xED\xBF\xBF", /* bug: not corrected */
-            "\"\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD",
         },
         /* 5.3  Other illegal code positions */
         /* BMP noncharacters */
         {
             /* \U+FFFE */
-            "\"\xEF\xBF\xBE\"",
+            "\xEF\xBF\xBE",
             "\xEF\xBF\xBE",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* \U+FFFF */
-            "\"\xEF\xBF\xBF\"",
+            "\xEF\xBF\xBF",
             "\xEF\xBF\xBF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* U+FDD0 */
-            "\"\xEF\xB7\x90\"",
+            "\xEF\xB7\x90",
             "\xEF\xB7\x90",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         {
             /* U+FDEF */
-            "\"\xEF\xB7\xAF\"",
+            "\xEF\xB7\xAF",
             "\xEF\xB7\xAF",     /* bug: not corrected */
-            "\"\\uFFFD\"",
+            "\\uFFFD",
         },
         /* Plane 1 .. 16 noncharacters */
         {
             /* U+1FFFE U+1FFFF U+2FFFE U+2FFFF ... U+10FFFE U+10FFFF */
-            "\"\xF0\x9F\xBF\xBE\xF0\x9F\xBF\xBF"
+            "\xF0\x9F\xBF\xBE\xF0\x9F\xBF\xBF"
             "\xF0\xAF\xBF\xBE\xF0\xAF\xBF\xBF"
             "\xF0\xBF\xBF\xBE\xF0\xBF\xBF\xBF"
             "\xF1\x8F\xBF\xBE\xF1\x8F\xBF\xBF"
@@ -796,7 +800,7 @@ static void utf8_string(void)
             "\xF3\x9F\xBF\xBE\xF3\x9F\xBF\xBF"
             "\xF3\xAF\xBF\xBE\xF3\xAF\xBF\xBF"
             "\xF3\xBF\xBF\xBE\xF3\xBF\xBF\xBF"
-            "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF\"",
+            "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF",
             /* bug: not corrected */
             "\xF0\x9F\xBF\xBE\xF0\x9F\xBF\xBF"
             "\xF0\xAF\xBF\xBE\xF0\xAF\xBF\xBF"
@@ -814,55 +818,52 @@ static void utf8_string(void)
             "\xF3\xAF\xBF\xBE\xF3\xAF\xBF\xBF"
             "\xF3\xBF\xBF\xBE\xF3\xBF\xBF\xBF"
             "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF",
-            "\"\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
-            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\"",
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         {}
     };
-    int i;
-    QObject *obj;
+    int i, j;
     QString *str;
     const char *json_in, *utf8_out, *utf8_in, *json_out;
+    char *jstr;
 
     for (i = 0; test_cases[i].json_in; i++) {
-        json_in = test_cases[i].json_in;
-        utf8_out = test_cases[i].utf8_out;
-        utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
-        json_out = test_cases[i].json_out ?: test_cases[i].json_in;
+        for (j = 0; j < 2; j++) {
+            json_in = test_cases[i].json_in;
+            utf8_out = test_cases[i].utf8_out;
+            utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
+            json_out = test_cases[i].json_out ?: test_cases[i].json_in;
 
-        obj = qobject_from_json(json_in, utf8_out ? &error_abort : NULL);
-        if (utf8_out) {
-            str = qobject_to(QString, obj);
-            g_assert(str);
-            g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
-        } else {
-            g_assert(!obj);
-        }
-        qobject_unref(obj);
+            /* Parse @json_in, expect @utf8_out */
+            if (utf8_out) {
+                str = from_json_str(json_in, j, &error_abort);
+                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
+                qobject_unref(str);
+            } else {
+                str = from_json_str(json_in, j, NULL);
+                g_assert(!str);
+            }
 
-        obj = QOBJECT(qstring_from_str(utf8_in));
-        str = qobject_to_json(obj);
-        if (json_out) {
-            g_assert(str);
-            g_assert_cmpstr(qstring_get_str(str), ==, json_out);
-        } else {
-            g_assert(!str);
-        }
-        qobject_unref(str);
-        qobject_unref(obj);
+            /* Unparse @utf8_in, expect @json_out */
+            str = qstring_from_str(utf8_in);
+            jstr = to_json_str(str);
+            g_assert_cmpstr(jstr, ==, json_out);
+            qobject_unref(str);
+            g_free(jstr);
 
-        /*
-         * Disabled, because qobject_from_json() is buggy, and I can't
-         * be bothered to add the expected incorrect results.
-         * FIXME Enable once these bugs have been fixed.
-         */
-        if (0 && json_out != json_in) {
-            obj = qobject_from_json(json_out, &error_abort);
-            str = qobject_to(QString, obj);
-            g_assert(str);
-            g_assert_cmpstr(qstring_get_str(str), ==, utf8_out);
+            /*
+             * Parse @json_out right back
+             * Disabled, because qobject_from_json() is buggy, and I can't
+             * be bothered to add the expected incorrect results.
+             * FIXME Enable once these bugs have been fixed.
+             */
+            if (0 && json_out != json_in) {
+                str = from_json_str(json_out, j, &error_abort);
+                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
+            }
         }
     }
 }
-- 
2.17.1
