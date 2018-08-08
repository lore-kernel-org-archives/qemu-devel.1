Received: from eggs.gnu.org ([2001:4830:134:3::10]:52349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0006eD-9A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBi-0008Qi-4S
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBh-0008PM-UN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:45 +0200
Message-Id: <20180808120334.10970-8-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/56] check-qjson: Cover escaped characters
 more thoroughly, part 1
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

escaped_string() first tests double quoted strings, then repeats a few
tests with single quotes.  Repeat all of them: store the strings to
test without quotes, and wrap them in either kind of quote for
testing.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 94 ++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 0a9a054c7b..1c7f24bc4d 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -22,55 +22,71 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu-common.h"
 
+static QString *from_json_str(const char *jstr, Error **errp, bool single)
+{
+    char quote = single ? '\'' : '"';
+    char *qjstr = g_strdup_printf("%c%s%c", quote, jstr, quote);
+
+    return qobject_to(QString, qobject_from_json(qjstr, errp));
+}
+
+static char *to_json_str(QString *str)
+{
+    QString *json = qobject_to_json(QOBJECT(str));
+    char *jstr;
+
+    if (!json) {
+        return NULL;
+    }
+    /* peel off double quotes */
+    jstr = g_strndup(qstring_get_str(json) + 1,
+                     qstring_get_length(json) - 2);
+    qobject_unref(json);
+    return jstr;
+}
+
 static void escaped_string(void)
 {
-    int i;
     struct {
-        const char *encoded;
-        const char *decoded;
+        /* Content of JSON string to parse with qobject_from_json() */
+        const char *json_in;
+        /* Expected parse output; to unparse with qobject_to_json() */
+        const char *utf8_out;
         int skip;
     } test_cases[] = {
-        { "\"\\b\"", "\b" },
-        { "\"\\f\"", "\f" },
-        { "\"\\n\"", "\n" },
-        { "\"\\r\"", "\r" },
-        { "\"\\t\"", "\t" },
-        { "\"/\"", "/" },
-        { "\"\\/\"", "/", .skip = 1 },
-        { "\"\\\\\"", "\\" },
-        { "\"\\\"\"", "\"" },
-        { "\"hello world \\\"embedded string\\\"\"",
+        { "\\b", "\b" },
+        { "\\f", "\f" },
+        { "\\n", "\n" },
+        { "\\r", "\r" },
+        { "\\t", "\t" },
+        { "/", "/" },
+        { "\\/", "/", .skip = 1 },
+        { "\\\\", "\\" },
+        { "\\\"", "\"" },
+        { "hello world \\\"embedded string\\\"",
           "hello world \"embedded string\"" },
-        { "\"hello world\\nwith new line\"", "hello world\nwith new line" },
-        { "\"single byte utf-8 \\u0020\"", "single byte utf-8  ", .skip = 1 },
-        { "\"double byte utf-8 \\u00A2\"", "double byte utf-8 \xc2\xa2" },
-        { "\"triple byte utf-8 \\u20AC\"", "triple byte utf-8 \xe2\x82\xac" },
-        { "'\\b'", "\b", .skip = 1 },
-        { "'\\f'", "\f", .skip = 1 },
-        { "'\\n'", "\n", .skip = 1 },
-        { "'\\r'", "\r", .skip = 1 },
-        { "'\\t'", "\t", .skip = 1 },
-        { "'\\/'", "/", .skip = 1 },
-        { "'\\\\'", "\\", .skip = 1 },
+        { "hello world\\nwith new line", "hello world\nwith new line" },
+        { "single byte utf-8 \\u0020", "single byte utf-8  ", .skip = 1 },
+        { "double byte utf-8 \\u00A2", "double byte utf-8 \xc2\xa2" },
+        { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
         {}
     };
+    int i, j;
+    QString *cstr;
+    char *jstr;
 
-    for (i = 0; test_cases[i].encoded; i++) {
-        QObject *obj;
-        QString *str;
-
-        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to(QString, obj);
-        g_assert(str);
-        g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].decoded);
-
-        if (test_cases[i].skip == 0) {
-            str = qobject_to_json(obj);
-            g_assert_cmpstr(qstring_get_str(str), ==, test_cases[i].encoded);
-            qobject_unref(obj);
+    for (i = 0; test_cases[i].json_in; i++) {
+        for (j = 0; j < 2; j++) {
+            cstr = from_json_str(test_cases[i].json_in, &error_abort, j);
+            g_assert_cmpstr(qstring_get_try_str(cstr),
+                            ==, test_cases[i].utf8_out);
+            if (test_cases[i].skip == 0) {
+                jstr = to_json_str(cstr);
+                g_assert_cmpstr(jstr, ==, test_cases[i].json_in);
+                g_free(jstr);
+            }
+            qobject_unref(cstr);
         }
-
-        qobject_unref(str);
     }
 }
 
-- 
2.17.1
