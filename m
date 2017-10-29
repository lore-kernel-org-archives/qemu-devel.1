Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLe-0003Ck-RY
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLd-00022y-Rs
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLd-00022W-IQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD04261462
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:31 +0100
Message-Id: <20171029130934.4555-7-quintela@redhat.com>
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] tests: Refactor setting of
 parameters/capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

So we can use them in future tests

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 101 +++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 55c4aed719..19a1445076 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -351,12 +351,69 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
+static void migrate_set_downtime(QTestState *who, const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
+                          "'arguments': { 'value': %s } }", value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
+static void migrate_set_speed(QTestState *who, const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate_set_speed',"
+                          "'arguments': { 'value': %s } }", value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
+static void migrate_set_capability(QTestState *who, const char *capability,
+                                   const char *value)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate-set-capabilities',"
+                          "'arguments': { "
+                          "'capabilities': [ { "
+                          "'capability': '%s', 'state': %s } ] } }",
+                          capability, value);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
+static void migrate(QTestState *who, const char *uri)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate',"
+                          "'arguments': { 'uri': '%s' } }",
+                          uri);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
 static void test_migrate(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *global = global_qtest, *from, *to;
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-    gchar *cmd, *cmd_src, *cmd_dst;
+    gchar *cmd_src, *cmd_dst;
     QDict *rsp;
 
     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -405,52 +462,22 @@ static void test_migrate(void)
     to = qtest_init(cmd_dst);
     g_free(cmd_dst);
 
-    global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
-                      "'capabilities': [ {"
-                          "'capability': 'postcopy-ram',"
-                          "'state': true } ] } }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
-
-    global_qtest = to;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
-                      "'capabilities': [ {"
-                          "'capability': 'postcopy-ram',"
-                          "'state': true } ] } }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    migrate_set_capability(from, "postcopy-ram", "true");
+    migrate_set_capability(to, "postcopy-ram", "true");
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 100000000 } }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
-
-    /* 1ms downtime - it should never finish precopy */
-    rsp = qmp("{ 'execute': 'migrate_set_downtime',"
-              "'arguments': { 'value': 0.001 } }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
-
+    migrate_set_speed(from, "100000000");
+    migrate_set_downtime(from, "0.001");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    migrate(from, uri);
 
+    global_qtest = from;
     wait_for_migration_pass();
 
     rsp = return_or_event(qmp("{ 'execute': 'migrate-start-postcopy' }"));
-- 
2.13.6
