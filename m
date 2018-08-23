Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgT-0003T9-Al
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsser-0003Wb-Li
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsser-0003W0-Ef
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:29 +0200
Message-Id: <20180823164025.12553-3-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/58] check-qjson: Cover multiple JSON
 objects in same string
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

qobject_from_json() & friends misbehave when the JSON text has more
than one JSON value.  Add test coverage to demonstrate the bugs.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index eaf5d20663..cc952c56ea 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1418,6 +1418,25 @@ static void limits_nesting(void)
     g_assert(obj == NULL);
 }
 
+static void multiple_values(void)
+{
+    Error *err = NULL;
+    QObject *obj;
+
+    /* BUG this leaks the syntax tree for "false" */
+    obj = qobject_from_json("false true", &err);
+    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
+    g_assert(!err);
+    qobject_unref(obj);
+
+    /* BUG simultaneously succeeds and fails */
+    /* BUG calls json_parser_parse() with errp pointing to non-null */
+    obj = qobject_from_json("} true", &err);
+    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
+    error_free_or_abort(&err);
+    qobject_unref(obj);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1455,6 +1474,7 @@ int main(int argc, char **argv)
     g_test_add_func("/errors/invalid_dict_comma", invalid_dict_comma);
     g_test_add_func("/errors/unterminated/literal", unterminated_literal);
     g_test_add_func("/errors/limits/nesting", limits_nesting);
+    g_test_add_func("/errors/multiple_values", multiple_values);
 
     return g_test_run();
 }
-- 
2.17.1
