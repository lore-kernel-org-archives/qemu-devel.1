Received: from eggs.gnu.org ([2001:4830:134:3::10]:52352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0006eG-AR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBh-0008Pm-Qu
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBh-0008Os-Km
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:48 +0200
Message-Id: <20180808120334.10970-11-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/56] check-qjson: Drop redundant string tests
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

simple_string() and single_quote_string() add nothing to
escaped_string() anymore.  Drop them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 59 ---------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e899e2d361..f0e8967a53 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -117,63 +117,6 @@ static void escaped_string(void)
     }
 }
 
-static void simple_string(void)
-{
-    int i;
-    struct {
-        const char *encoded;
-        const char *decoded;
-    } test_cases[] = {
-        { "\"hello world\"", "hello world" },
-        { "\"the quick brown fox jumped over the fence\"",
-          "the quick brown fox jumped over the fence" },
-        {}
-    };
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
-    int i;
-    struct {
-        const char *encoded;
-        const char *decoded;
-    } test_cases[] = {
-        { "'hello world'", "hello world" },
-        { "'the quick brown fox \\' jumped over the fence'",
-          "the quick brown fox ' jumped over the fence" },
-        {}
-    };
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
-        qobject_unref(str);
-    }
-}
-
 static void utf8_string(void)
 {
     /*
@@ -1512,10 +1455,8 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    g_test_add_func("/literals/string/simple", simple_string);
     g_test_add_func("/literals/string/escaped", escaped_string);
     g_test_add_func("/literals/string/utf8", utf8_string);
-    g_test_add_func("/literals/string/single_quote", single_quote_string);
     g_test_add_func("/literals/string/vararg", vararg_string);
 
     g_test_add_func("/literals/number/simple", simple_number);
-- 
2.17.1
