Received: from eggs.gnu.org ([2001:4830:134:3::10]:33121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHog-0002GM-Me
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001f0-Ge
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Y1-4d
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8A3E8780F
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD1892156701
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:11 +0200
Message-Id: <20180824193206.25475-4-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 03/58] check-qjson: Cover blank and lexically
 erroneous input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_from_json() can return null without setting an error on
lexical errors.  I call that a bug.  Add test coverage to demonstrate
it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-4-armbru@redhat.com>
---
 tests/check-qjson.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index cc952c56ea..4daadc272b 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1307,8 +1307,40 @@ static void simple_varargs(void)
 
 static void empty_input(void)
 {
-    const char *empty = "";
-    QObject *obj = qobject_from_json(empty, &error_abort);
+    QObject *obj = qobject_from_json("", &error_abort);
+    g_assert(obj == NULL);
+}
+
+static void blank_input(void)
+{
+    QObject *obj = qobject_from_json("\n ", &error_abort);
+    g_assert(obj == NULL);
+}
+
+static void junk_input(void)
+{
+    /* Note: junk within strings is covered elsewhere */
+    Error *err = NULL;
+    QObject *obj;
+
+    obj = qobject_from_json("@", &err);
+    g_assert(!err);             /* BUG */
+    g_assert(obj == NULL);
+
+    obj = qobject_from_json("[0\xFF]", &err);
+    error_free_or_abort(&err);
+    g_assert(obj == NULL);
+
+    obj = qobject_from_json("00", &err);
+    g_assert(!err);             /* BUG */
+    g_assert(obj == NULL);
+
+    obj = qobject_from_json("[1e", &err);
+    g_assert(!err);             /* BUG */
+    g_assert(obj == NULL);
+
+    obj = qobject_from_json("truer", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
@@ -1462,7 +1494,9 @@ int main(int argc, char **argv)
 
     g_test_add_func("/varargs/simple_varargs", simple_varargs);
 
-    g_test_add_func("/errors/empty_input", empty_input);
+    g_test_add_func("/errors/empty", empty_input);
+    g_test_add_func("/errors/blank", blank_input);
+    g_test_add_func("/errors/junk", junk_input);
     g_test_add_func("/errors/unterminated/string", unterminated_string);
     g_test_add_func("/errors/unterminated/escape", unterminated_escape);
     g_test_add_func("/errors/unterminated/sq_string", unterminated_sq_string);
-- 
2.17.1
