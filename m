Received: from eggs.gnu.org ([2001:4830:134:3::10]:60960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLy-0005z6-8Q
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLx-0004m5-4A
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:30 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <c.pinto@virtualopensystems.com>)
	id 1clwLw-0004lv-UB
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:29 -0500
Received: by mail-wm0-x244.google.com with SMTP id u132so10439319wmg.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:35:28 -0800 (PST)
From: Christian Pinto <c.pinto@virtualopensystems.com>
Date: Thu,  9 Mar 2017 12:34:36 +0100
Message-Id: <20170309113437.9667-4-c.pinto@virtualopensystems.com>
In-Reply-To: <20170309113437.9667-1-c.pinto@virtualopensystems.com>
References: <57B7F948.9040701@huawei.com>
	<20170309113437.9667-1-c.pinto@virtualopensystems.com>
Subject: [Qemu-devel] [RFC PATCH 3/4] migration: snapshot thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com
Cc: b.reynal@virtualopensystems.com, aarcange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, amit.shah@redhat.com, peter.huangpeng@huawei.com, hanweidong@huawei.com, qemu-devel@nongnu.org, tech@virtualopensystems.com, Christian Pinto <c.pinto@virtualopensystems.com>

VM execution was resumed while migration was still in setup.
This was causing a bus error because the userfault thread was
waking up VM too early during migration setup.

Signed-off-by: Christian Pinto <c.pinto@virtualopensystems.com>
Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 migration/migration.c    |  9 +++++----
 migration/postcopy-ram.c | 14 --------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f6d68ca020..19e8da1f84 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1894,15 +1894,16 @@ static void *snapshot_thread(void *opaque)
     postcopy_ram_enable_notify(&ms->userfault_state, UFFDIO_REGISTER_MODE_WP);
     buffer = qemu_save_device_buffer();
 
+    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
+            MIGRATION_STATUS_ACTIVE);
+
+    trace_snapshot_thread_setup_complete();
+
     if (old_vm_running) {
         vm_start();
     }
     qemu_mutex_unlock_iothread();
 
-    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, MIGRATION_STATUS_ACTIVE);
-
-    trace_snapshot_thread_setup_complete();
-
     while (qemu_file_get_error(ms->to_dst_file) == 0) {
         if (qemu_savevm_state_iterate(ms->to_dst_file, false) > 0) {
             break;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 97382067b3..6252eb379a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -551,20 +551,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
                 break;
             }
 
-            /* Note: In the setup process, snapshot_thread may modify VM's
-            * write-protected pages, we should not block it there, or there
-            * will be an deadlock error.
-            */
-            if (migration_in_setup(ms)) {
-                ram_addr_t host = msg.arg.pagefault.address;
-
-                host &= ~(hostpagesize - 1);
-                ret = ram_set_pages_wp(host, hostpagesize, true,
-                                       us->userfault_fd);
-                if (ret < 0) {
-                    error_report("Remove page's write-protect failed");
-                }
-            }
         }
     }
     trace_postcopy_ram_fault_thread_exit();
-- 
2.11.0
