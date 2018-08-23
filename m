Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgR-0003T9-Ds
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsset-0003YG-2Y
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsses-0003XP-Oq
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:41 +0200
Message-Id: <20180823164025.12553-15-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/58] check-qjson: Fix utf8_string() to
 test all invalid sequences
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

Some of utf8_string()'s test_cases[] contain multiple invalid
sequences.  Testing that qobject_from_json() fails only tests we
reject at least one invalid sequence.  That's incomplete.

Additionally test each non-space sequence in isolation.

This demonstrates that the JSON parser accepts invalid sequences
starting with \xC2..\xF4.  Add a FIXME comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 8d0fe4c8a7..40a573eb21 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -20,6 +20,7 @@
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/unicode.h"
 #include "qemu-common.h"
 
 static QString *from_json_str(const char *jstr, bool single, Error **errp)
@@ -410,7 +411,7 @@ static void utf8_string(void)
             "\xC8 \xC9 \xCA \xCB \xCC \xCD \xCE \xCF "
             "\xD0 \xD1 \xD2 \xD3 \xD4 \xD5 \xD6 \xD7 "
             "\xD8 \xD9 \xDA \xDB \xDC \xDD \xDE \xDF ",
-            NULL,               /* bug: rejected */
+            NULL,               /* bug: rejected (partly, see FIXME below) */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD "
@@ -429,7 +430,7 @@ static void utf8_string(void)
         /* 3.2.3  All 8 first bytes of 4-byte sequences, followed by space */
         {
             "\xF0 \xF1 \xF2 \xF3 \xF4 \xF5 \xF6 \xF7 ",
-            NULL,               /* bug: rejected */
+            NULL,               /* bug: rejected (partly, see FIXME below) */
             "\\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD \\uFFFD ",
         },
         /* 3.2.4  All 4 first bytes of 5-byte sequences, followed by space */
@@ -509,7 +510,7 @@ static void utf8_string(void)
         {
             "\xC0\xE0\x80\xF0\x80\x80\xF8\x80\x80\x80\xFC\x80\x80\x80\x80"
             "\xDF\xEF\xBF\xF7\xBF\xBF\xFB\xBF\xBF\xBF\xFD\xBF\xBF\xBF\xBF",
-            NULL,               /* bug: rejected */
+            NULL,               /* bug: rejected (partly, see FIXME below) */
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD"
             "\\uFFFD\\uFFFD\\uFFFD\\uFFFD\\uFFFD",
         },
@@ -792,8 +793,8 @@ static void utf8_string(void)
     };
     int i, j;
     QString *str;
-    const char *json_in, *utf8_out, *utf8_in, *json_out;
-    char *jstr;
+    const char *json_in, *utf8_out, *utf8_in, *json_out, *tail;
+    char *end, *in, *jstr;
 
     for (i = 0; test_cases[i].json_in; i++) {
         for (j = 0; j < 2; j++) {
@@ -810,6 +811,28 @@ static void utf8_string(void)
             } else {
                 str = from_json_str(json_in, j, NULL);
                 g_assert(!str);
+                /*
+                 * Failure may be due to any sequence, but *all* sequences
+                 * are expected to fail.  Test each one in isolation.
+                 */
+                for (tail = json_in; *tail; tail = end) {
+                    mod_utf8_codepoint(tail, 6, &end);
+                    if (*end == ' ') {
+                        end++;
+                    }
+                    in = strndup(tail, end - tail);
+                    str = from_json_str(in, j, NULL);
+                    /*
+                     * FIXME JSON parser accepts invalid sequence
+                     * starting with \xC2..\xF4
+                     */
+                    if (*in >= '\xC2' && *in <= '\xF4') {
+                        g_free(str);
+                        str = NULL;
+                    }
+                    g_assert(!str);
+                    g_free(in);
+                }
             }
 
             /* Unparse @utf8_in, expect @json_out */
-- 
2.17.1
