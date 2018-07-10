Received: from eggs.gnu.org ([2001:4830:134:3::10]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcooD-0003Jb-4Z
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcooC-00035V-8D
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fcooC-00035M-3F
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Jul 2018 17:19:00 +0800
Message-Id: <20180710091902.28780-9-peterx@redhat.com>
In-Reply-To: <20180710091902.28780-1-peterx@redhat.com>
References: <20180710091902.28780-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 v2 08/10] tests: introduce
 wait_for_migration_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Balamuruhan S <bala24@linux.vnet.ibm.com>

It's generalized from wait_for_migration_complete() to allow us to wait
for any migration status besides failure.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 1d85ccbef1..761bf62ffe 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -231,14 +231,15 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
-static void wait_for_migration_complete(QTestState *who)
+static void wait_for_migration_status(QTestState *who,
+                                      const char *goal)
 {
     while (true) {
         bool completed;
         char *status;
 
         status = migrate_query_status(who);
-        completed = strcmp(status, "completed") == 0;
+        completed = strcmp(status, goal) == 0;
         g_assert_cmpstr(status, !=,  "failed");
         g_free(status);
         if (completed) {
@@ -248,6 +249,11 @@ static void wait_for_migration_complete(QTestState *who)
     }
 }
 
+static void wait_for_migration_complete(QTestState *who)
+{
+    wait_for_migration_status(who, "completed");
+}
+
 static void wait_for_migration_pass(QTestState *who)
 {
     uint64_t initial_pass = get_migration_pass(who);
-- 
2.17.1
