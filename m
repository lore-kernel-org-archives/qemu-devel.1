Received: from eggs.gnu.org ([2001:4830:134:3::10]:38466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvP-0002X9-0v
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvL-0003R2-Qv
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZvL-0003QB-Eq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8634A861A
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:53:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:44 +0100
Message-Id: <20180105215246.908-10-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/11] tests: Create migrate-start-postcopy
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
---
 tests/migration-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index c25c9dd7b1..70b3c0870b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -436,6 +436,15 @@ static void migrate(QTestState *who, const char *uri)
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
@@ -598,7 +607,6 @@ static void test_postcopy(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
-    QDict *rsp;
 
     test_migrate_start(&from, &to, uri);
 
@@ -620,9 +628,7 @@ static void test_postcopy(void)
 
     wait_for_migration_pass(from);
 
-    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
-    g_assert(qdict_haskey(rsp, "return"));
-    QDECREF(rsp);
+    migrate_start_postcopy(from);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.14.3
