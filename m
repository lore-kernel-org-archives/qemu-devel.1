Received: from eggs.gnu.org ([2001:4830:134:3::10]:52580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBq-0006jv-56
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBi-0008Ri-Nl
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBi-0008Qy-Gc
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:50 +0200
Message-Id: <20180808120334.10970-13-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/56] check-qjson: Simplify utf8_string()
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

The previous commit made utf8_string()'s test_cases[].utf8_in
superfluous: we can use .json_in instead.  Except for the case testing
U+0000.  \x00 doesn't work in C strings, so it tests \\u0000 instead.
But testing \\uXXXX is escaped_string()'s job.  It's covered there.
Test U+0001 here, and drop .utf8_in.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 53 ++++++++-------------------------------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 75f0a9f18a..5ba09e5ab6 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -150,8 +150,6 @@ static void utf8_string(void)
         const char *utf8_out;
         /* Expected unparse output, defaults to @json_in */
         const char *json_out;
-        /* Expected parse output for @json_out, defaults to @utf8_out */
-        const char *utf8_in;
     } test_cases[] = {
         /*
          * Bug markers used here:
@@ -160,10 +158,6 @@ static void utf8_string(void)
          * - bug: rejected
          *   JSON parser rejects invalid sequence(s)
          *   We may choose to define this as feature
-         * - bug: want "..."
-         *   JSON parser produces incorrect result, this is the
-         *   correct one, assuming replacement character U+FFFF
-         *   We may choose to reject instead of replace
          */
 
         /* 1  Some correct UTF-8 text */
@@ -184,12 +178,15 @@ static void utf8_string(void)
         },
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
-        /* 2.1.1  1 byte U+0000 */
+        /*
+         * 2.1.1  1 byte U+0001
+         * \x00 is impossible, test \x01 instead.  Other
+         * representations of U+0000 are covered under 4.3.
+         */
         {
-            "\\u0000",
-            "",                 /* bug: want overlong "\xC0\x80" */
-            "\\u0000",
-            "\xC0\x80",
+            "\x01",
+            "\x01",
+            "\\u0001",
         },
         /* 2.1.2  2 bytes U+0080 */
         {
@@ -214,14 +211,12 @@ static void utf8_string(void)
             "\xF8\x88\x80\x80\x80",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xF8\x88\x80\x80\x80",
         },
         /* 2.1.6  6 bytes U+4000000 */
         {
             "\xFC\x84\x80\x80\x80\x80",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xFC\x84\x80\x80\x80\x80",
         },
         /* 2.2  Last possible sequence of a certain length */
         /* 2.2.1  1 byte U+007F */
@@ -255,21 +250,18 @@ static void utf8_string(void)
             "\xF7\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xF7\xBF\xBF\xBF",
         },
         /* 2.2.5  5 bytes U+3FFFFFF */
         {
             "\xFB\xBF\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xFB\xBF\xBF\xBF\xBF",
         },
         /* 2.2.6  6 bytes U+7FFFFFFF */
         {
             "\xFD\xBF\xBF\xBF\xBF\xBF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xFD\xBF\xBF\xBF\xBF\xBF",
         },
         /* 2.3  Other boundary conditions */
         {
@@ -392,10 +384,6 @@ static void utf8_string(void)
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
-            "\xC0 \xC1 \xC2 \xC3 \xC4 \xC5 \xC6 \xC7 "
-            "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
-            "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
-            "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF ",
         },
         /* 3.2.2  All 16 first bytes of 3-byte sequences, followed by space */
         {
@@ -412,21 +400,18 @@ static void utf8_string(void)
             "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
             NULL,               /* bug: rejected */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
-            "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
         },
         /* 3.2.4  All 4 first bytes of 5-byte sequences, followed by space */
         {
             "\xF8 \xF9 \xFA \xFB ",
             NULL,               /* bug: rejected */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
-            "\xF8 \xF9 \xFA \xFB ",
         },
         /* 3.2.5  All 2 first bytes of 6-byte sequences, followed by space */
         {
             "\xFC \xFD ",
             NULL,               /* bug: rejected */
             "\\uFFFD \\uFFFD ",
-            "\xFC \xFD ",
         },
         /* 3.3  Sequences with last continuation byte missing */
         /* 3.3.1  2-byte sequence with last byte missing (U+0000) */
@@ -434,7 +419,6 @@ static void utf8_string(void)
             "\xC0",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xC0",
         },
         /* 3.3.2  3-byte sequence with last byte missing (U+0000) */
         {
@@ -453,14 +437,12 @@ static void utf8_string(void)
             "\xF8\x80\x80\x80",
             NULL,                   /* bug: rejected */
             "\\uFFFD",
-            "\xF8\x80\x80\x80",
         },
         /* 3.3.5  6-byte sequence with last byte missing (U+0000) */
         {
             "\xFC\x80\x80\x80\x80",
             NULL,                        /* bug: rejected */
             "\\uFFFD",
-            "\xFC\x80\x80\x80\x80",
         },
         /* 3.3.6  2-byte sequence with last byte missing (U+07FF) */
         {
@@ -479,21 +461,18 @@ static void utf8_string(void)
             "\xF7\xBF\xBF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xF7\xBF\xBF",
         },
         /* 3.3.9  5-byte sequence with last byte missing (U+3FFFFFF) */
         {
             "\xFB\xBF\xBF\xBF",
             NULL,                 /* bug: rejected */
             "\\uFFFD",
-            "\xFB\xBF\xBF\xBF",
         },
         /* 3.3.10  6-byte sequence with last byte missing (U+7FFFFFFF) */
         {
             "\xFD\xBF\xBF\xBF\xBF",
             NULL,                        /* bug: rejected */
             "\\uFFFD",
-            "\xFD\xBF\xBF\xBF\xBF",
         },
         /* 3.4  Concatenation of incomplete sequences */
         {
@@ -502,27 +481,22 @@ static void utf8_string(void)
             NULL,               /* bug: rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
-            "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
-            "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
         },
         /* 3.5  Impossible bytes */
         {
             "\xFE",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xFE",
         },
         {
             "\xFF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xFF",
         },
         {
             "\xFE\xFE\xFF\xFF",
             NULL,                 /* bug: rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
-            "\xFE\xFE\xFF\xFF",
         },
         /* 4  Overlong sequences */
         /* 4.1  Overlong '/' */
@@ -530,7 +504,6 @@ static void utf8_string(void)
             "\xC0\xAF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xC0\xAF",
         },
         {
             "\xE0\x80\xAF",
@@ -546,13 +519,11 @@ static void utf8_string(void)
             "\xF8\x80\x80\x80\xAF",
             NULL,                        /* bug: rejected */
             "\\uFFFD",
-            "\xF8\x80\x80\x80\xAF",
         },
         {
             "\xFC\x80\x80\x80\x80\xAF",
             NULL,                               /* bug: rejected */
             "\\uFFFD",
-            "\xFC\x80\x80\x80\x80\xAF",
         },
         /*
          * 4.2  Maximum overlong sequences
@@ -565,7 +536,6 @@ static void utf8_string(void)
             "\xC1\xBF",
             NULL,               /* bug: rejected */
             "\\uFFFD",
-            "\xC1\xBF",
         },
         {
             /* \U+07FF */
@@ -589,14 +559,12 @@ static void utf8_string(void)
             "\xF8\x87\xBF\xBF\xBF",
             NULL,                        /* bug: rejected */
             "\\uFFFD",
-            "\xF8\x87\xBF\xBF\xBF",
         },
         {
             /* \U+3FFFFFF */
             "\xFC\x83\xBF\xBF\xBF\xBF",
             NULL,                               /* bug: rejected */
             "\\uFFFD",
-            "\xFC\x83\xBF\xBF\xBF\xBF",
         },
         /* 4.3  Overlong representation of the NUL character */
         {
@@ -604,7 +572,6 @@ static void utf8_string(void)
             "\xC0\x80",
             NULL,               /* bug: rejected */
             "\\u0000",
-            "\xC0\x80",
         },
         {
             /* \U+0000 */
@@ -623,14 +590,12 @@ static void utf8_string(void)
             "\xF8\x80\x80\x80\x80",
             NULL,                        /* bug: rejected */
             "\\uFFFD",
-            "\xF8\x80\x80\x80\x80",
         },
         {
             /* \U+0000 */
             "\xFC\x80\x80\x80\x80\x80",
             NULL,                               /* bug: rejected */
             "\\uFFFD",
-            "\xFC\x80\x80\x80\x80\x80",
         },
         /* 5  Illegal code positions */
         /* 5.1  Single UTF-16 surrogates */
@@ -803,7 +768,7 @@ static void utf8_string(void)
         for (j = 0; j < 2; j++) {
             json_in = test_cases[i].json_in;
             utf8_out = test_cases[i].utf8_out;
-            utf8_in = test_cases[i].utf8_in ?: test_cases[i].utf8_out;
+            utf8_in = test_cases[i].utf8_out ?: test_cases[i].json_in;
             json_out = test_cases[i].json_out ?: test_cases[i].json_in;
 
             /* Parse @json_in, expect @utf8_out */
-- 
2.17.1
