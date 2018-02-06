Received: from eggs.gnu.org ([2001:4830:134:3::10]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Z7-0005VU-Bi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Z1-0008Eu-HD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5Z1-0008DQ-BV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:43 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:33 +0000
Message-Id: <20180206154936.13565-12-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 11/14] tests: Adjust sleeps for migration test
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

Also reorder code to not sleep when event already happened.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 26a792c3aa..9efad95749 100644
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
