Received: from eggs.gnu.org ([2001:4830:134:3::10]:40911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub7-0003Ga-LB
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub2-0003PZ-Io
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcub2-0003PH-EX
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E326402315B
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:11 +0100
Message-Id: <20180710153016.131258-11-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] tests: allow migrate() to take extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

For example, we can pass in '"resume": true' to resume a migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-7-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 193c7df94e..0a1e2f0a09 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -337,14 +337,14 @@ static void migrate_set_capability(QTestState *who, const char *capability,
     qobject_unref(rsp);
 }
 
-static void migrate(QTestState *who, const char *uri)
+static void migrate(QTestState *who, const char *uri, const char *extra)
 {
     QDict *rsp;
     gchar *cmd;
 
     cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
+                          "  'arguments': { 'uri': '%s' %s } }",
+                          uri, extra ? extra : "");
     rsp = qtest_qmp(who, cmd);
     g_free(cmd);
     g_assert(qdict_haskey(rsp, "return"));
@@ -540,7 +540,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri);
+    migrate(from, uri, NULL);
     g_free(uri);
 
     wait_for_migration_pass(from);
@@ -586,7 +586,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
         return;
     }
-    migrate(from, "tcp:0:0");
+    migrate(from, "tcp:0:0", NULL);
     do {
         rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
         rsp_return = qdict_get_qdict(rsp, "return");
@@ -630,7 +630,7 @@ static void test_precopy_unix(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate(from, uri);
+    migrate(from, uri, NULL);
 
     wait_for_migration_pass(from);
 
-- 
2.17.1
