Received: from eggs.gnu.org ([2001:4830:134:3::10]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHon-0002KL-2j
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001gV-Ku
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Zu-4R
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FB9A7A7E7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 00E4D2026E18
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:29 +0200
Message-Id: <20180824193206.25475-22-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 21/58] check-qjson: Document we expect invalid
 UTF-8 to be rejected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The JSON parser rejects some invalid sequences, but accepts others
without correcting the problem.

We should either reject all invalid sequences, or minimize overlong
sequences and replace all other invalid sequences by a suitable
replacement character.  A common choice for replacement is U+FFFD.

I'm going to implement the former.  Update the comments in
utf8_string() to expect this.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-22-armbru@redhat.com>
---
 tests/check-qjson.c | 151 +++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 80 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index f1405ad47a..69f5a187c9 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -157,13 +157,7 @@ static void utf8_string(void)
      * They're all marked "bug:" below, and are to be replaced by
      * correct ones as the bugs get fixed.
      *
-     * The JSON parser rejects some invalid sequences, but accepts
-     * others without correcting the problem.
-     *
-     * We should either reject all invalid sequences, or minimize
-     * overlong sequences and replace all other invalid sequences by a
-     * suitable replacement character.  A common choice for
-     * replacement is U+FFFD.
+     * The JSON parser rejects some, but not all invalid sequences.
      *
      * Problem: we can't easily deal with embedded U+0000.  Parsing
      * the JSON string "this \\u0000" is fun" yields "this \0 is fun",
@@ -185,11 +179,8 @@ static void utf8_string(void)
     } test_cases[] = {
         /*
          * Bug markers used here:
-         * - bug: not corrected
-         *   JSON parser fails to correct invalid sequence(s)
-         * - bug: rejected
-         *   JSON parser rejects invalid sequence(s)
-         *   We may choose to define this as feature
+         * - bug: not rejected
+         *   JSON parser fails to reject invalid sequence(s)
          */
 
         /* 0  Control characters */
@@ -257,13 +248,13 @@ static void utf8_string(void)
         /* 2.1.5  5 bytes U+200000 */
         {
             "\xF8\x88\x80\x80\x80",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 2.1.6  6 bytes U+4000000 */
         {
             "\xFC\x84\x80\x80\x80\x80",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 2.2  Last possible sequence of a certain length */
@@ -296,19 +287,19 @@ static void utf8_string(void)
         /* 2.2.4  4 bytes U+1FFFFF */
         {
             "\xF7\xBF\xBF\xBF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 2.2.5  5 bytes U+3FFFFFF */
         {
             "\xFB\xBF\xBF\xBF\xBF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 2.2.6  6 bytes U+7FFFFFFF */
         {
             "\xFD\xBF\xBF\xBF\xBF\xBF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 2.3  Other boundary conditions */
@@ -347,49 +338,49 @@ static void utf8_string(void)
         /* 3.1.1  First continuation byte */
         {
             "\x80",
-            "\x80",             /* bug: not corrected */
+            "\x80",             /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.1.2  Last continuation byte */
         {
             "\xBF",
-            "\xBF",             /* bug: not corrected */
+            "\xBF",             /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.1.3  2 continuation bytes */
         {
             "\x80\xBF",
-            "\x80\xBF",         /* bug: not corrected */
+            "\x80\xBF",         /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         /* 3.1.4  3 continuation bytes */
         {
             "\x80\xBF\x80",
-            "\x80\xBF\x80",     /* bug: not corrected */
+            "\x80\xBF\x80",     /* bug: not rejected */
             "\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.5  4 continuation bytes */
         {
             "\x80\xBF\x80\xBF",
-            "\x80\xBF\x80\xBF", /* bug: not corrected */
+            "\x80\xBF\x80\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.6  5 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80",
-            "\x80\xBF\x80\xBF\x80", /* bug: not corrected */
+            "\x80\xBF\x80\xBF\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.7  6 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80\xBF",
-            "\x80\xBF\x80\xBF\x80\xBF", /* bug: not corrected */
+            "\x80\xBF\x80\xBF\x80\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.8  7 continuation bytes */
         {
             "\x80\xBF\x80\xBF\x80\xBF\x80",
-            "\x80\xBF\x80\xBF\x80\xBF\x80", /* bug: not corrected */
+            "\x80\xBF\x80\xBF\x80\xBF\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.1.9  Sequence of all 64 possible continuation bytes */
@@ -402,7 +393,7 @@ static void utf8_string(void)
             "\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF"
             "\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7"
             "\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF",
-             /* bug: not corrected */
+             /* bug: not rejected */
             "\x80\x81\x82\x83\x84\x85\x86\x87"
             "\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F"
             "\x90\x91\x92\x93\x94\x95\x96\x97"
@@ -427,7 +418,7 @@ static void utf8_string(void)
             "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
             "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
             "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF ",
-            NULL,               /* bug: rejected (partly, see FIXME below) */
+            NULL,               /* bug: accepted partly, see FIXME below */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
@@ -437,7 +428,7 @@ static void utf8_string(void)
         {
             "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
             "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
-            /* bug: not corrected */
+            /* bug: not rejected */
             "\xE0 \xE1 \xE2 \xE3 \xE4 \xE5 \xE6 \xE7 "
             "\xE8 \xE9 \xEA \xEB \xEC \xED \xEE \xEF ",
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
@@ -446,131 +437,131 @@ static void utf8_string(void)
         /* 3.2.3  All 8 first bytes of 4-byte sequences, followed by space */
         {
             "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
-            NULL,               /* bug: rejected (partly, see FIXME below) */
+            NULL,               /* bug: accepted partly, see FIXME below */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.4  All 4 first bytes of 5-byte sequences, followed by space */
         {
             "\xF8 \xF9 \xFA \xFB ",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.5  All 2 first bytes of 6-byte sequences, followed by space */
         {
             "\xFC \xFD ",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD \\uFFFD ",
         },
         /* 3.3  Sequences with last continuation byte missing */
         /* 3.3.1  2-byte sequence with last byte missing (U+0000) */
         {
             "\xC0",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.2  3-byte sequence with last byte missing (U+0000) */
         {
             "\xE0\x80",
-            "\xE0\x80",           /* bug: not corrected */
+            "\xE0\x80",         /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.3.3  4-byte sequence with last byte missing (U+0000) */
         {
             "\xF0\x80\x80",
-            "\xF0\x80\x80",     /* bug: not corrected */
+            "\xF0\x80\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.3.4  5-byte sequence with last byte missing (U+0000) */
         {
             "\xF8\x80\x80\x80",
-            NULL,                   /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.5  6-byte sequence with last byte missing (U+0000) */
         {
             "\xFC\x80\x80\x80\x80",
-            NULL,                        /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.6  2-byte sequence with last byte missing (U+07FF) */
         {
             "\xDF",
-            "\xDF",             /* bug: not corrected */
+            "\xDF",             /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.3.7  3-byte sequence with last byte missing (U+FFFF) */
         {
             "\xEF\xBF",
-            "\xEF\xBF",           /* bug: not corrected */
+            "\xEF\xBF",         /* bug: not rejected */
             "\\uFFFD",
         },
         /* 3.3.8  4-byte sequence with last byte missing (U+1FFFFF) */
         {
             "\xF7\xBF\xBF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.9  5-byte sequence with last byte missing (U+3FFFFFF) */
         {
             "\xFB\xBF\xBF\xBF",
-            NULL,                 /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.3.10  6-byte sequence with last byte missing (U+7FFFFFFF) */
         {
             "\xFD\xBF\xBF\xBF\xBF",
-            NULL,                        /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 3.4  Concatenation of incomplete sequences */
         {
             "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
             "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
-            NULL,               /* bug: rejected (partly, see FIXME below) */
+            NULL,               /* bug: accepted partly, see FIXME below */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 3.5  Impossible bytes */
         {
             "\xFE",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             "\xFF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             "\xFE\xFE\xFF\xFF",
-            NULL,                 /* bug: rejected */
+            NULL,
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
         /* 4  Overlong sequences */
         /* 4.1  Overlong '/' */
         {
             "\xC0\xAF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             "\xE0\x80\xAF",
-            "\xE0\x80\xAF",     /* bug: not corrected */
+            "\xE0\x80\xAF",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             "\xF0\x80\x80\xAF",
-            "\xF0\x80\x80\xAF",  /* bug: not corrected */
+            "\xF0\x80\x80\xAF", /* bug: not rejected */
             "\\uFFFD",
         },
         {
             "\xF8\x80\x80\x80\xAF",
-            NULL,                        /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             "\xFC\x80\x80\x80\x80\xAF",
-            NULL,                               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /*
@@ -582,13 +573,13 @@ static void utf8_string(void)
         {
             /* \U+007F */
             "\xC1\xBF",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+07FF */
             "\xE0\x9F\xBF",
-            "\xE0\x9F\xBF",     /* bug: not corrected */
+            "\xE0\x9F\xBF",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
@@ -599,50 +590,50 @@ static void utf8_string(void)
              * also 2.2.3
              */
             "\xF0\x8F\xBF\xBC",
-            "\xF0\x8F\xBF\xBC",   /* bug: not corrected */
+            "\xF0\x8F\xBF\xBC", /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+1FFFFF */
             "\xF8\x87\xBF\xBF\xBF",
-            NULL,                        /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+3FFFFFF */
             "\xFC\x83\xBF\xBF\xBF\xBF",
-            NULL,                               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 4.3  Overlong representation of the NUL character */
         {
             /* \U+0000 */
             "\xC0\x80",
-            NULL,               /* bug: rejected */
+            NULL,
             "\\u0000",
         },
         {
             /* \U+0000 */
             "\xE0\x80\x80",
-            "\xE0\x80\x80",     /* bug: not corrected */
+            "\xE0\x80\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+0000 */
             "\xF0\x80\x80\x80",
-            "\xF0\x80\x80\x80",   /* bug: not corrected */
+            "\xF0\x80\x80\x80", /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+0000 */
             "\xF8\x80\x80\x80\x80",
-            NULL,                        /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         {
             /* \U+0000 */
             "\xFC\x80\x80\x80\x80\x80",
-            NULL,                               /* bug: rejected */
+            NULL,
             "\\uFFFD",
         },
         /* 5  Illegal code positions */
@@ -650,92 +641,92 @@ static void utf8_string(void)
         {
             /* \U+D800 */
             "\xED\xA0\x80",
-            "\xED\xA0\x80",     /* bug: not corrected */
+            "\xED\xA0\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DB7F */
             "\xED\xAD\xBF",
-            "\xED\xAD\xBF",     /* bug: not corrected */
+            "\xED\xAD\xBF",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DB80 */
             "\xED\xAE\x80",
-            "\xED\xAE\x80",     /* bug: not corrected */
+            "\xED\xAE\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DBFF */
             "\xED\xAF\xBF",
-            "\xED\xAF\xBF",     /* bug: not corrected */
+            "\xED\xAF\xBF",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DC00 */
             "\xED\xB0\x80",
-            "\xED\xB0\x80",     /* bug: not corrected */
+            "\xED\xB0\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DF80 */
             "\xED\xBE\x80",
-            "\xED\xBE\x80",     /* bug: not corrected */
+            "\xED\xBE\x80",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+DFFF */
             "\xED\xBF\xBF",
-            "\xED\xBF\xBF",     /* bug: not corrected */
+            "\xED\xBF\xBF",     /* bug: not rejected */
             "\\uFFFD",
         },
         /* 5.2  Paired UTF-16 surrogates */
         {
             /* \U+D800\U+DC00 */
             "\xED\xA0\x80\xED\xB0\x80",
-            "\xED\xA0\x80\xED\xB0\x80", /* bug: not corrected */
+            "\xED\xA0\x80\xED\xB0\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+D800\U+DFFF */
             "\xED\xA0\x80\xED\xBF\xBF",
-            "\xED\xA0\x80\xED\xBF\xBF", /* bug: not corrected */
+            "\xED\xA0\x80\xED\xBF\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DC00 */
             "\xED\xAD\xBF\xED\xB0\x80",
-            "\xED\xAD\xBF\xED\xB0\x80", /* bug: not corrected */
+            "\xED\xAD\xBF\xED\xB0\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB7F\U+DFFF */
             "\xED\xAD\xBF\xED\xBF\xBF",
-            "\xED\xAD\xBF\xED\xBF\xBF", /* bug: not corrected */
+            "\xED\xAD\xBF\xED\xBF\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DC00 */
             "\xED\xAE\x80\xED\xB0\x80",
-            "\xED\xAE\x80\xED\xB0\x80", /* bug: not corrected */
+            "\xED\xAE\x80\xED\xB0\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DB80\U+DFFF */
             "\xED\xAE\x80\xED\xBF\xBF",
-            "\xED\xAE\x80\xED\xBF\xBF", /* bug: not corrected */
+            "\xED\xAE\x80\xED\xBF\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DC00 */
             "\xED\xAF\xBF\xED\xB0\x80",
-            "\xED\xAF\xBF\xED\xB0\x80", /* bug: not corrected */
+            "\xED\xAF\xBF\xED\xB0\x80", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         {
             /* \U+DBFF\U+DFFF */
             "\xED\xAF\xBF\xED\xBF\xBF",
-            "\xED\xAF\xBF\xED\xBF\xBF", /* bug: not corrected */
+            "\xED\xAF\xBF\xED\xBF\xBF", /* bug: not rejected */
             "\\uFFFD\\uFFFD",
         },
         /* 5.3  Other illegal code positions */
@@ -743,25 +734,25 @@ static void utf8_string(void)
         {
             /* \U+FFFE */
             "\xEF\xBF\xBE",
-            "\xEF\xBF\xBE",     /* bug: not corrected */
+            "\xEF\xBF\xBE",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* \U+FFFF */
             "\xEF\xBF\xBF",
-            "\xEF\xBF\xBF",     /* bug: not corrected */
+            "\xEF\xBF\xBF",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* U+FDD0 */
             "\xEF\xB7\x90",
-            "\xEF\xB7\x90",     /* bug: not corrected */
+            "\xEF\xB7\x90",     /* bug: not rejected */
             "\\uFFFD",
         },
         {
             /* U+FDEF */
             "\xEF\xB7\xAF",
-            "\xEF\xB7\xAF",     /* bug: not corrected */
+            "\xEF\xB7\xAF",     /* bug: not rejected */
             "\\uFFFD",
         },
         /* Plane 1 .. 16 noncharacters */
@@ -783,7 +774,7 @@ static void utf8_string(void)
             "\xF3\xAF\xBF\xBE\xF3\xAF\xBF\xBF"
             "\xF3\xBF\xBF\xBE\xF3\xBF\xBF\xBF"
             "\xF4\x8F\xBF\xBE\xF4\x8F\xBF\xBF",
-            /* bug: not corrected */
+            /* bug: not rejected */
             "\xF0\x9F\xBF\xBE\xF0\x9F\xBF\xBF"
             "\xF0\xAF\xBF\xBE\xF0\xAF\xBF\xBF"
             "\xF0\xBF\xBF\xBE\xF0\xBF\xBF\xBF"
-- 
2.17.1
