Received: from eggs.gnu.org ([2001:4830:134:3::10]:41563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GV-00062C-1M
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GQ-0001si-1r
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8GP-0001rM-Mn
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BEA8461C5
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:10:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:32 +0100
Message-Id: <20180129120932.12874-14-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] tests: Adjust sleeps for migration test
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

Also reorder code to not sleep when event already happened.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index d191f6e03b..fcad2ed460 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -268,10 +268,9 @@ static uint64_t get_migration_pass(QTestState *who)
 
 static void wait_for_migration_complete(QTestState *who)
 {
-    QDict *rsp, *rsp_return;
-    bool completed;
-
-    do {
+    while (true) {
+        QDict *rsp, *rsp_return;
+        bool completed;
         const char *status;
 
         rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
@@ -280,8 +279,11 @@ static void wait_for_migration_complete(QTestState *who)
         completed = strcmp(status, "completed") == 0;
         g_assert_cmpstr(status, !=,  "failed");
         QDECREF(rsp);
-        usleep(1000 * 100);
-    } while (!completed);
+        if (completed) {
+            return;
+        }
+        usleep(1000);
+    }
 }
 
 static void wait_for_migration_pass(QTestState *who)
@@ -290,16 +292,13 @@ static void wait_for_migration_pass(QTestState *who)
     uint64_t pass;
 
     /* Wait for the 1st sync */
-    do {
+    while (!got_stop && !initial_pass) {
+        usleep(1000);
         initial_pass = get_migration_pass(who);
-        if (got_stop || initial_pass) {
-            break;
-        }
-        usleep(1000 * 100);
-    } while (true);
+    }
 
     do {
-        usleep(1000 * 100);
+        usleep(1000);
         pass = get_migration_pass(who);
     } while (pass == initial_pass && !got_stop);
 }
@@ -489,13 +488,13 @@ static void test_migrate_end(QTestState *from, QTestState *to)
     /* Destination still running, wait for a byte to change */
     do {
         qtest_memread(to, start_address, &dest_byte_b, 1);
-        usleep(10 * 1000);
+        usleep(1000 * 10);
     } while (dest_byte_a == dest_byte_b);
 
     qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
-    sleep(1);
+    usleep(1000 * 200);
     qtest_memread(to, start_address, &dest_byte_d, 1);
     g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
 
-- 
2.14.3
