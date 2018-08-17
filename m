Received: from eggs.gnu.org ([2001:4830:134:3::10]:46216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-00034T-Jm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKD-0001id-Je
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKC-0001gu-SJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:08 +0200
Message-Id: <20180817150559.16243-10-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/60] check-qjson: Cover escaped characters
 more thoroughly, part 2
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

Cover escaped single quote, surrogates, invalid escapes, and
noncharacters.  This demonstrates that valid surrogate pairs are
misinterpreted, and invalid surrogates and noncharacters aren't
rejected.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 62 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 730de46815..ce843283eb 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -57,10 +57,49 @@ static void escaped_string(void)
         int skip;
     } test_cases[] = {
         { "\\b\\f\\n\\r\\t\\\\\\\"", "\b\f\n\r\t\\\"" },
-        { "\\/", "/", .skip = 1 },
+        { "\\/\\'", "/'", .skip = 1 },
         { "single byte utf-8 \\u0020", "single byte utf-8  ", .skip = 1 },
         { "double byte utf-8 \\u00A2", "double byte utf-8 \xc2\xa2" },
         { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
+        { "quadruple byte utf-8 \\uD834\\uDD1E", /* U+1D11E */
+          /* bug: want \xF0\x9D\x84\x9E */
+          "quadruple byte utf-8 \xED\xA0\xB4\xED\xB4\x9E", .skip = 1 },
+        { "\\", NULL },
+        { "\\z", NULL },
+        { "\\ux", NULL },
+        { "\\u1x", NULL },
+        { "\\u12x", NULL },
+        { "\\u123x", NULL },
+        { "\\u12345", "\341\210\2645" },
+        { "\\u0000x", "x", .skip = 1}, /* bug: want \xC0\x80x */
+        { "unpaired leading surrogate \\uD800",
+          /* bug: not rejected */
+          "unpaired leading surrogate \355\240\200", .skip = 1 },
+        { "unpaired leading surrogate \\uD800\\uCAFE",
+          /* bug: not rejected */
+          "unpaired leading surrogate \355\240\200\354\253\276", .skip = 1 },
+        { "unpaired leading surrogate \\uD800\\uD801\\uDC02",
+          /* bug: not rejected */
+          "unpaired leading surrogate \355\240\200\355\240\201\355\260\202",
+          .skip = 1 },
+        { "unpaired trailing surrogate \\uDC00",
+          /* bug: not rejected */
+          "unpaired trailing surrogate \355\260\200", .skip = 1},
+        { "backward surrogate pair \\uDC00\\uD800",
+          /* bug: not rejected */
+          "backward surrogate pair \355\260\200\355\240\200", .skip = 1},
+        { "noncharacter U+FDD0 \\uFDD0",
+          /* bug: not rejected */
+          "noncharacter U+FDD0 \xEF\xB7\x90", .skip = 1},
+        { "noncharacter U+FDEF \\uFDEF",
+          /* bug: not rejected */
+          "noncharacter U+FDEF \xEF\xB7\xAF", .skip = 1},
+        { "noncharacter U+1FFFE \\uD87F\\uDFFE",
+          /* bug: not rejected */
+          "noncharacter U+1FFFE \xED\xA1\xBF\xED\xBF\xBE", .skip = 1},
+        { "noncharacter U+10FFFF \\uDC3F\\uDFFF",
+          /* bug: not rejected */
+          "noncharacter U+10FFFF \xED\xB0\xBF\xED\xBF\xBF", .skip = 1},
         {}
     };
     int i, j;
@@ -69,15 +108,20 @@ static void escaped_string(void)
 
     for (i = 0; test_cases[i].json_in; i++) {
         for (j = 0; j < 2; j++) {
-            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
-            g_assert_cmpstr(qstring_get_try_str(cstr),
-                            ==, test_cases[i].utf8_out);
-            if (test_cases[i].skip == 0) {
-                jstr = to_json_str(cstr);
-                g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
-                g_free(jstr);
+            if (test_cases[i].utf8_out) {
+                cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
+                g_assert_cmpstr(qstring_get_try_str(cstr),
+                                ==, test_cases[i].utf8_out);
+                if (!test_cases[i].skip) {
+                    jstr = to_json_str(cstr);
+                    g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
+                    g_free(jstr);
+                }
+                qobject_unref(cstr);
+            } else {
+                cstr = from_json_str(test_cases[i].json_in, NULL, j);
+                g_assert(!cstr);
             }
-            qobject_unref(cstr);
         }
     }
 }
-- 
2.17.1
