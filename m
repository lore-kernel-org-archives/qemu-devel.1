Received: from eggs.gnu.org ([2001:4830:134:3::10]:52347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99w2-0002GL-7I
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99vx-00045a-IP
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1e99vx-00044o-Cd
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:53 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 30 Oct 2017 16:16:29 +0300
Message-id: <1509369390-8285-6-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131650eucas1p11e65153f114fd66677a37751e4e82b2d@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v12 5/6] migration: add blocktime calculation
 into migration-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, quintela@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

This patch just requests blocktime calculation,
and check it in case when UFFD_FEATURE_THREAD_ID feature is set
on the host.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 tests/migration-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index db30b38..3b4d88a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -25,6 +25,7 @@
 const unsigned start_address = 1024 * 1024;
 const unsigned end_address = 100 * 1024 * 1024;
 bool got_stop;
+static bool uffd_feature_thread_id;
 
 #if defined(__linux__)
 #include <sys/syscall.h>
@@ -54,6 +55,7 @@ static bool ufd_version_check(void)
         g_test_message("Skipping test: UFFDIO_API failed");
         return false;
     }
+    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
 
     ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
                  (__u64)1 << _UFFDIO_UNREGISTER;
@@ -266,6 +268,16 @@ static uint64_t get_migration_pass(QTestState *who)
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
     QDict *rsp, *rsp_return;
@@ -540,6 +552,7 @@ static void test_postcopy(void)
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
+    migrate_set_capability(to, "postcopy-blocktime", "true");
 
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
@@ -568,6 +581,9 @@ static void test_postcopy(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
+    if (uffd_feature_thread_id) {
+        read_blocktime(to);
+    }
     g_free(uri);
 
     test_migrate_end(from, to);
-- 
2.7.4
