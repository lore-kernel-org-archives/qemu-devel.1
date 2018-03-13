Received: from eggs.gnu.org ([2001:4830:134:3::10]:59136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJV-0003N0-AS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJU-0001N9-F8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evlJU-0001Md-7n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:04 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Mar 2018 17:53:43 +0300
Message-id: <1520952824-3172-6-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
References: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180313145401eucas1p2c8318df482b41e0c9d075b9b65d19b68@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 5/6] migration: add blocktime calculation
 into migration-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

This patch just requests blocktime calculation,
and check it in case when UFFD_FEATURE_THREAD_ID feature is set
on the host.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 74f9361..259acfb 100644
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
@@ -522,6 +534,7 @@ static void test_migrate(void)
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
+    migrate_set_capability(to, "postcopy-blocktime", "true");
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
@@ -548,6 +561,9 @@ static void test_migrate(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
+    if (uffd_feature_thread_id) {
+        read_blocktime(to);
+    }
     g_free(uri);
 
     test_migrate_end(from, to, true);
-- 
2.7.4
