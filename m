Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgG-0003Sq-KL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsseu-0003aB-6D
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsset-0003Yt-Tm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:49 +0200
Message-Id: <20180823164025.12553-23-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 22/58] json: Reject invalid UTF-8 sequences
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

We reject bytes that can't occur in valid UTF-8 (\xC0..\xC1,
\xF5..\xFF in the lexer.  That's insufficient; there's plenty of
invalid UTF-8 not containing these bytes, as demonstrated by
check-qjson:

* Malformed sequences

  - Unexpected continuation bytes

  - Missing continuation bytes after start bytes other than
    \xC0..\xC1, \xF5..\xFD.

* Overlong sequences with start bytes other than \xC0..\xC1,
  \xF5..\xFD.

* Invalid code points

Fixing this in the lexer would be bothersome.  Fixing it in the parser
is straightforward, so do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/unicode.h |   1 +
 qobject/json-parser.c  |  20 ++++--
 tests/check-qjson.c    | 137 ++++++++++++++---------------------------
 util/unicode.c         |  69 ++++++++++++++++++---
 4 files changed, 122 insertions(+), 105 deletions(-)

diff --git a/include/qemu/unicode.h b/include/qemu/unicode.h
index 71c72db461..7fa10b8e60 100644
--- a/include/qemu/unicode.h
+++ b/include/qemu/unicode.h
@@ -2,5 +2,6 @@
 #define QEMU_UNICODE_H
 
 int mod_utf8_codepoint(const char *s, size_t n, char **end);
+ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint);
 
 #endif
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 164b86769b..0e232ff101 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/unicode.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
@@ -133,6 +134,10 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
     const char *ptr = token->str;
     QString *str;
     char quote;
+    int cp;
+    char *end;
+    ssize_t len;
+    char utf8_buf[5];
 
     assert(*ptr == '"' || *ptr == '\'');
     quote = *ptr++;
@@ -194,12 +199,15 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
                 goto out;
             }
         } else {
-            char dummy[2];
-
-            dummy[0] = *ptr++;
-            dummy[1] = 0;
-
-            qstring_append(str, dummy);
+            cp = mod_utf8_codepoint(ptr, 6, &end);
+            if (cp <= 0) {
+                parse_error(ctxt, token, "invalid UTF-8 sequence in string");
+                goto out;
+            }
+            ptr = end;
+            len = mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp);
+            assert(len >= 0);
+            qstring_append(str, utf8_buf);
         }
     }
 
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 69f5a187c9..71c77d2f70 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -152,13 +152,6 @@ static void string_with_quotes(void)
 static void utf8_string(void)
 {
     /*
-     * FIXME Current behavior for invalid UTF-8 sequences is
-     * incorrect.  This test expects current, incorrect results.
-     * They're all marked "bug:" below, and are to be replaced by
-     * correct ones as the bugs get fixed.
-     *
-     * The JSON parser rejects some, but not all invalid sequences.
-     *
      * Problem: we can't easily deal with embedded U+0000.  Parsing
      * the JSON string "this \\u0000" is fun" yields "this \0 is fun",
      * which gets misinterpreted as NUL-terminated "this ".  We should
@@ -177,12 +170,6 @@ static void utf8_string(void)
         /* Expected unparse output, defaults to @json_in */
         const char *json_out;
     } test_cases[] = {
-        /*
-         * Bug markers used here:
-         * - bug: not rejected
-         *   JSON parser fails to reject invalid sequence(s)
-         */
-
         /* 0  Control characters */
         {
             /*
@@ -330,7 +317,7 @@ static void utf8_string(void)
         {
             /* first one beyond Unicode range: U+110000 */
             "\xF4\x90\x80\x80",
-            "\xF4\x90\x80\x80",
+            NULL,
             "\\uFFFD",
         },
         /* 3  Malformed sequences */
@@ -338,49 +325,49 @@ static void utf8_string(void)
         /* 3.1.1  First continuation byte */
         {
             "\x80",
-            "\x80",             /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.1.2  Last continuation byte */
         {
             "\xBF",
-            "\xBF",             /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.1.3  2 continuation bytes */
         {
             "\x80\xBF",
-            "\x80\xBF",         /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         /* 3.1.4  3 continuation bytes */
         {
             "\x80\xBF\x80",
-            "\x80\xBF\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.5  4 continuation bytes */
         {
             "\x80\xBF\x80\xBF",
-            "\x80\xBF\x80\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.6  5 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80",
-            "\x80\xBF\x80\xBF\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.7  6 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80\xBF",
-            "\x80\xBF\x80\xBF\x80\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.8  7 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80\xBF\x80",
-            "\x80\xBF\x80\xBF\x80\xBF\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.9  Sequence of all 64 possible continuation bytes */
@@ -393,16 +380,7 @@ static void utf8_string(void)
             "\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
             "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7"
             "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF",
-             /* bug: not rejected */
-            "\x80\x81\x82\x83\x84\x85\x86\x87"
-            "\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F"
-            "\x90\x91\x92\x93\x94\x95\x96\x97"
-            "\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F"
-            "\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7"
-            "\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
-            "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7"
-            "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF",
-            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
@@ -410,6 +388,7 @@ static void utf8_string(void)
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
+            "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.2  Lonely start characters */
         /* 3.2.1  All 32 first bytes of 2-byte sequences, followed by space */
@@ -418,7 +397,7 @@ static void utf8_string(void)
             "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
             "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
             "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF ",
-            NULL,               /* bug: accepted partly, see FIXME below */
+            NULL,
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
@@ -428,16 +407,14 @@ static void utf8_string(void)
         {
             "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
             "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
-            /* bug: not rejected */
-            "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
-            "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
+            NULL,
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.3  All 8 first bytes of 4-byte sequences, followed by space */
         {
             "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
-            NULL,               /* bug: accepted partly, see FIXME below */
+            NULL,
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.4  All 4 first bytes of 5-byte sequences, followed by space */
@@ -462,13 +439,13 @@ static void utf8_string(void)
         /* 3.3.2  3-byte sequence with last byte missing (U+0000) */
         {
             "\xE0\x80",
-            "\xE0\x80",         /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.3  4-byte sequence with last byte missing (U+0000) */
         {
             "\xF0\x80\x80",
-            "\xF0\x80\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.4  5-byte sequence with last byte missing (U+0000) */
@@ -486,13 +463,13 @@ static void utf8_string(void)
         /* 3.3.6  2-byte sequence with last byte missing (U+07FF) */
         {
             "\xDF",
-            "\xDF",             /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.7  3-byte sequence with last byte missing (U+FFFF) */
         {
             "\xEF\xBF",
-            "\xEF\xBF",         /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.8  4-byte sequence with last byte missing (U+1FFFFF) */
@@ -517,7 +494,7 @@ static void utf8_string(void)
         {
             "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
             "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
-            NULL,               /* bug: accepted partly, see FIXME below */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
@@ -546,12 +523,12 @@ static void utf8_string(void)
         },
         {
             "\xE0\x80\xAF",
-            "\xE0\x80\xAF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             "\xF0\x80\x80\xAF",
-            "\xF0\x80\x80\xAF", /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
@@ -579,7 +556,7 @@ static void utf8_string(void)
         {
             /* \U+07FF */
             "\xE0\x9F\xBF",
-            "\xE0\x9F\xBF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
@@ -590,7 +567,7 @@ static void utf8_string(void)
              * also 2.2.3
              */
             "\xF0\x8F\xBF\xBC",
-            "\xF0\x8F\xBF\xBC", /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
@@ -615,13 +592,13 @@ static void utf8_string(void)
         {
             /* \U+0000 */
             "\xE0\x80\x80",
-            "\xE0\x80\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+0000 */
             "\xF0\x80\x80\x80",
-            "\xF0\x80\x80\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
@@ -641,92 +618,92 @@ static void utf8_string(void)
         {
             /* \U+D800 */
             "\xED\xA0\x80",
-            "\xED\xA0\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DB7F */
             "\xED\xAD\xBF",
-            "\xED\xAD\xBF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DB80 */
             "\xED\xAE\x80",
-            "\xED\xAE\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DBFF */
             "\xED\xAF\xBF",
-            "\xED\xAF\xBF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DC00 */
             "\xED\xB0\x80",
-            "\xED\xB0\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DF80 */
             "\xED\xBE\x80",
-            "\xED\xBE\x80",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+DFFF */
             "\xED\xBF\xBF",
-            "\xED\xBF\xBF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 5.2  Paired UTF-16 surrogates */
         {
             /* \U+D800\U+DC00 */
             "\xED\xA0\x80\xED\xB0\x80",
-            "\xED\xA0\x80\xED\xB0\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+D800\U+DFFF */
             "\xED\xA0\x80\xED\xBF\xBF",
-            "\xED\xA0\x80\xED\xBF\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DC00 */
             "\xED\xAD\xBF\xED\xB0\x80",
-            "\xED\xAD\xBF\xED\xB0\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DFFF */
             "\xED\xAD\xBF\xED\xBF\xBF",
-            "\xED\xAD\xBF\xED\xBF\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DC00 */
             "\xED\xAE\x80\xED\xB0\x80",
-            "\xED\xAE\x80\xED\xB0\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DFFF */
             "\xED\xAE\x80\xED\xBF\xBF",
-            "\xED\xAE\x80\xED\xBF\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DC00 */
             "\xED\xAF\xBF\xED\xB0\x80",
-            "\xED\xAF\xBF\xED\xB0\x80", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DFFF */
             "\xED\xAF\xBF\xED\xBF\xBF",
-            "\xED\xAF\xBF\xED\xBF\xBF", /* bug: not rejected */
+            NULL,
             "\\uFFFD\\uFFFD",
         },
         /* 5.3  Other illegal code positions */
@@ -734,25 +711,25 @@ static void utf8_string(void)
         {
             /* \U+FFFE */
             "\xEF\xBF\xBE",
-            "\xEF\xBF\xBE",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+FFFF */
             "\xEF\xBF\xBF",
-            "\xEF\xBF\xBF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* U+FDD0 */
             "\xEF\xB7\x90",
-            "\xEF\xB7\x90",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* U+FDEF */
             "\xEF\xB7\xAF",
-            "\xEF\xB7\xAF",     /* bug: not rejected */
+            NULL,
             "\\uFFFD",
         },
         /* Plane 1 .. 16 noncharacters */
@@ -774,23 +751,7 @@ static void utf8_string(void)
             "\xF3\xAF\xBF\xBE\xF3\xAF\xBF\xBF"
             "\xF3\xBF\xBF\xBE\xF3\xBF\xBF\xBF"
             "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF",
-            /* bug: not rejected */
-            "\xF0\x9F\xBF\xBE\xF0\x9F\xBF\xBF"
-            "\xF0\xAF\xBF\xBE\xF0\xAF\xBF\xBF"
-            "\xF0\xBF\xBF\xBE\xF0\xBF\xBF\xBF"
-            "\xF1\x8F\xBF\xBE\xF1\x8F\xBF\xBF"
-            "\xF1\x9F\xBF\xBE\xF1\x9F\xBF\xBF"
-            "\xF1\xAF\xBF\xBE\xF1\xAF\xBF\xBF"
-            "\xF1\xBF\xBF\xBE\xF1\xBF\xBF\xBF"
-            "\xF2\x8F\xBF\xBE\xF2\x8F\xBF\xBF"
-            "\xF2\x9F\xBF\xBE\xF2\x9F\xBF\xBF"
-            "\xF2\xAF\xBF\xBE\xF2\xAF\xBF\xBF"
-            "\xF2\xBF\xBF\xBE\xF2\xBF\xBF\xBF"
-            "\xF3\x8F\xBF\xBE\xF3\x8F\xBF\xBF"
-            "\xF3\x9F\xBF\xBE\xF3\x9F\xBF\xBF"
-            "\xF3\xAF\xBF\xBE\xF3\xAF\xBF\xBF"
-            "\xF3\xBF\xBF\xBE\xF3\xBF\xBF\xBF"
-            "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF",
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
@@ -829,14 +790,6 @@ static void utf8_string(void)
                     }
                     in = strndup(tail, end - tail);
                     str = from_json_str(in, j, NULL);
-                    /*
-                     * FIXME JSON parser accepts invalid sequence
-                     * starting with \xC2..\xF4
-                     */
-                    if (*in >= '\xC2' && *in <= '\xF4') {
-                        g_free(str);
-                        str = NULL;
-                    }
                     g_assert(!str);
                     g_free(in);
                 }
diff --git a/util/unicode.c b/util/unicode.c
index a812a35171..8580bc598b 100644
--- a/util/unicode.c
+++ b/util/unicode.c
@@ -13,6 +13,21 @@
 #include "qemu/osdep.h"
 #include "qemu/unicode.h"
 
+static bool is_valid_codepoint(int codepoint)
+{
+    if (codepoint > 0x10FFFFu) {
+        return false;            /* beyond Unicode range */
+    }
+    if ((codepoint >= 0xFDD0 && codepoint <= 0xFDEF)
+        || (codepoint & 0xFFFE) == 0xFFFE) {
+        return false;            /* noncharacter */
+    }
+    if (codepoint >= 0xD800 && codepoint <= 0xDFFF) {
+        return false;            /* surrogate code point */
+    }
+    return true;
+}
+
 /**
  * mod_utf8_codepoint:
  * @s: string encoded in modified UTF-8
@@ -83,13 +98,8 @@ int mod_utf8_codepoint(const char *s, size_t n, char **end)
             cp <<= 6;
             cp |= byte & 0x3F;
         }
-        if (cp > 0x10FFFF) {
-            cp = -1;            /* beyond Unicode range */
-        } else if ((cp >= 0xFDD0 && cp <= 0xFDEF)
-                   || (cp & 0xFFFE) == 0xFFFE) {
-            cp = -1;            /* noncharacter */
-        } else if (cp >= 0xD800 && cp <= 0xDFFF) {
-            cp = -1;            /* surrogate code point */
+        if (!is_valid_codepoint(cp)) {
+            cp = -1;
         } else if (cp < min_cp[len - 2] && !(cp == 0 && len == 2)) {
             cp = -1;            /* overlong, not \xC0\x80 */
         }
@@ -99,3 +109,48 @@ out:
     *end = (char *)p;
     return cp;
 }
+
+/**
+ * mod_utf8_encode:
+ * @buf: Destination buffer
+ * @bufsz: size of @buf, at least 5.
+ * @codepoint: Unicode codepoint to encode
+ *
+ * Convert Unicode codepoint @codepoint to modified UTF-8.
+ *
+ * Returns: the length of the UTF-8 sequence on success, -1 when
+ * @codepoint is invalid.
+ */
+ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint)
+{
+    assert(bufsz >= 5);
+
+    if (!is_valid_codepoint(codepoint)) {
+        return -1;
+    }
+
+    if (codepoint > 0 && codepoint <= 0x7F) {
+        buf[0] = codepoint & 0x7F;
+        buf[1] = 0;
+        return 1;
+    }
+    if (codepoint <= 0x7FF) {
+        buf[0] = 0xC0 | ((codepoint >> 6) & 0x1F);
+        buf[1] = 0x80 | (codepoint & 0x3F);
+        buf[2] = 0;
+        return 2;
+    }
+    if (codepoint <= 0xFFFF) {
+        buf[0] = 0xE0 | ((codepoint >> 12) & 0x0F);
+        buf[1] = 0x80 | ((codepoint >> 6) & 0x3F);
+        buf[2] = 0x80 | (codepoint & 0x3F);
+        buf[3] = 0;
+        return 3;
+    }
+    buf[0] = 0xF0 | ((codepoint >> 18) & 0x07);
+    buf[1] = 0x80 | ((codepoint >> 12) & 0x3F);
+    buf[2] = 0x80 | ((codepoint >> 6) & 0x3F);
+    buf[3] = 0x80 | (codepoint & 0x3F);
+    buf[4] = 0;
+    return 4;
+}
-- 
2.17.1
