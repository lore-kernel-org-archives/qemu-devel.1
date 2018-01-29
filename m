Received: from eggs.gnu.org ([2001:4830:134:3::10]:41500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GN-0005v6-Cv
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GM-0001o0-5T
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8GL-0001mL-QM
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D2D285545
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:10:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:31 +0100
Message-Id: <20180129120932.12874-13-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] tests: Create migrate-start-postcopy
 command
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

This way, it is like the rest of commands

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 84f5bcf00a..d191f6e03b 100644
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
@@ -564,7 +573,6 @@ static void test_postcopy(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
-    QDict *rsp;
 
     test_migrate_start(&from, &to, uri);
 
@@ -585,9 +593,7 @@ static void test_postcopy(void)
 
     wait_for_migration_pass(from);
 
-    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    migrate_start_postcopy(from);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.14.3
