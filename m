Received: from eggs.gnu.org ([2001:4830:134:3::10]:44189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5YM-0004n3-1t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5YL-0006kd-4n
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5YK-0006k2-Ul
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:01 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:32 +0000
Message-Id: <20180206154936.13565-11-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] tests: Create migrate-start-postcopy
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Juan Quintela <quintela@redhat.com>

This way, it is like the rest of commands

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 2a0b651cd1..26a792c3aa 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -416,6 +416,15 @@ static void migrate(QTestState *who, const char *uri)
     QDECREF(rsp);
 }
 
+static void migrate_start_postcopy(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who, "{ 'execute': 'migrate-start-postcopy' }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
 static void test_migrate_start(QTestState **from, QTestState **to,
                                const char *uri)
 {
@@ -549,7 +558,6 @@ static void test_migrate(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
-    QDict *rsp;
 
     test_migrate_start(&from, &to, uri);
 
@@ -570,9 +578,7 @@ static void test_migrate(void)
 
     wait_for_migration_pass(from);
 
-    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    migrate_start_postcopy(from);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.14.3
