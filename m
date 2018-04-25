Received: from eggs.gnu.org ([2001:4830:134:3::10]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQde-0003Za-Qy
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdd-00030a-Mh
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdd-00030O-IG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:37 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:15 +0100
Message-Id: <20180425200326.72337-6-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/16] migration: add blocktime calculation into
 migration-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Alexey Perevalov <a.perevalov@samsung.com>

This patch just requests blocktime calculation,
and check it in case when UFFD_FEATURE_THREAD_ID feature is set
on the host.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1521742647-25550-6-git-send-email-a.perevalov@samsung.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 422bf1afdf..dde7c464c3 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -26,6 +26,7 @@
 const unsigned start_address = 1024 * 1024;
 const unsigned end_address = 100 * 1024 * 1024;
 bool got_stop;
+static bool uffd_feature_thread_id;
 
 #if defined(__linux__)
 #include <sys/syscall.h>
@@ -55,6 +56,7 @@ static bool ufd_version_check(void)
         g_test_message("Skipping test: UFFDIO_API failed");
         return false;
     }
+    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
 
     ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
                  (__u64)1 << _UFFDIO_UNREGISTER;
@@ -223,6 +225,16 @@ static uint64_t get_migration_pass(QTestState *who)
     return result;
 }
 
+static void read_blocktime(QTestState *who)
+{
+    QDict *rsp, *rsp_return;
+
+    rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
+    rsp_return = qdict_get_qdict(rsp, "return");
+    g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
+    QDECREF(rsp);
+}
+
 static void wait_for_migration_complete(QTestState *who)
 {
     while (true) {
@@ -533,6 +545,7 @@ static void test_migrate(void)
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
+    migrate_set_capability(to, "postcopy-blocktime", "true");
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
@@ -559,6 +572,9 @@ static void test_migrate(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
+    if (uffd_feature_thread_id) {
+        read_blocktime(to);
+    }
     g_free(uri);
 
     test_migrate_end(from, to, true);
-- 
2.17.0
