Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-000344-6k
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKC-0001hg-Tr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKC-0001gg-Jy
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:09 +0200
Message-Id: <20180817150559.16243-11-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/60] check-qjson: Consolidate partly
 redundant string tests
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

simple_string() and single_quote_string() have become redundant with
escaped_string(), except fot embedded single and double quotes.
Replace them by a test that covers just that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 64 ++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 50 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index ce843283eb..e35942d922 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -126,59 +126,24 @@ static void escaped_string(void)
     }
 }
 
-static void simple_string(void)
+static void string_with_quotes(void)
 {
-    int i;
-    struct {
-        const char *encoded;
-        const char *decoded;
-    } test_cases[] = {
-        { "\"hello world\"", "hello world" },
-        { "\"the quick brown fox jumped over the fence\"",
-          "the quick brown fox jumped over the fence" },
-        {}
+    const char *test_cases[] = {
+        "\"the bee's knees\"",
+        "'double quote \"'",
+        NULL
     };
-
-    for (i = 0; test_cases[i].encoded; i++) {
-        QObject *obj;
-        QString *str;
-
-        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to(QString, obj);
-        g_assert(str);
-        g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
-
-        str = qobject_to_json(obj);
-        g_assert(strcmp(qstring_get_str(str), test_cases[i].encoded) == 0);
-
-        qobject_unref(obj);
-        
-        qobject_unref(str);
-    }
-}
-
-static void single_quote_string(void)
-{
     int i;
-    struct {
-        const char *encoded;
-        const char *decoded;
-    } test_cases[] = {
-        { "'hello world'", "hello world" },
-        { "'the quick brown fox \\' jumped over the fence'",
-          "the quick brown fox ' jumped over the fence" },
-        {}
-    };
+    QString *str;
+    char *cstr;
 
-    for (i = 0; test_cases[i].encoded; i++) {
-        QObject *obj;
-        QString *str;
-
-        obj = qobject_from_json(test_cases[i].encoded, &error_abort);
-        str = qobject_to(QString, obj);
+    for (i = 0; test_cases[i]; i++) {
+        str = qobject_to(QString,
+                         qobject_from_json(test_cases[i], &error_abort));
         g_assert(str);
-        g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
-
+        cstr = g_strndup(test_cases[i] + 1, strlen(test_cases[i]) - 2);
+        g_assert_cmpstr(qstring_get_str(str), ==, cstr);
+        g_free(cstr);
         qobject_unref(str);
     }
 }
@@ -1525,10 +1490,9 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    g_test_add_func("/literals/string/simple", simple_string);
     g_test_add_func("/literals/string/escaped", escaped_string);
+    g_test_add_func("/literals/string/quotes", string_with_quotes);
     g_test_add_func("/literals/string/utf8", utf8_string);
-    g_test_add_func("/literals/string/single_quote", single_quote_string);
     g_test_add_func("/literals/string/vararg", vararg_string);
 
     g_test_add_func("/literals/number/simple", simple_number);
-- 
2.17.1
