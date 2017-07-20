Received: from eggs.gnu.org ([2001:4830:134:3::10]:41760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dY2UK-0006eK-D8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dY2UH-0003Y3-Aj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:50:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dY2UG-0003Uq-N7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:50:53 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Thu, 20 Jul 2017 11:49:29 +0800
Message-ID: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, Jay Zhou <jianjay.zhou@huawei.com>

Qemu_savevm_state_cleanup() takes about 300ms in my ram migration tests
with a 8U24G vm(20G is really occupied), the main cost comes from
KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
kvm_set_user_memory_region(). In kmod, the main cost is
kvm_zap_obsolete_pages(), which traverses the active_mmu_pages list to
zap the unsync sptes.

I think it can be optimized:
(1) source vm will be destroyed if the migration is successfully done,
    so the resources will be cleanuped automatically by the system
(2) delay the cleanup if the migration failed

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 migration/migration.c | 16 +++++++++-------
 qmp.c                 | 10 ++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a0db40d..72832be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1877,6 +1877,15 @@ static void *migration_thread(void *opaque)
         if (qemu_file_get_error(s->to_dst_file)) {
             migrate_set_state(&s->state, current_active_state,
                               MIGRATION_STATUS_FAILED);
+            /*
+             * The resource has been allocated by migration will be reused in
+             * COLO process, so don't release them.
+             */
+            if (!enable_colo) {
+                qemu_mutex_lock_iothread();
+                qemu_savevm_state_cleanup();
+                qemu_mutex_unlock_iothread();
+            }
             trace_migration_thread_file_err();
             break;
         }
@@ -1916,13 +1925,6 @@ static void *migration_thread(void *opaque)
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     qemu_mutex_lock_iothread();
-    /*
-     * The resource has been allocated by migration will be reused in COLO
-     * process, so don't release them.
-     */
-    if (!enable_colo) {
-        qemu_savevm_state_cleanup();
-    }
     if (s->state == MIGRATION_STATUS_COMPLETED) {
         uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
         s->total_time = end_time - s->total_time;
diff --git a/qmp.c b/qmp.c
index b86201e..0e68eaa 100644
--- a/qmp.c
+++ b/qmp.c
@@ -37,6 +37,8 @@
 #include "qom/object_interfaces.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "migration/migration.h"
+#include "migration/savevm.h"
 
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -200,6 +202,14 @@ void qmp_cont(Error **errp)
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart = 1;
     } else {
+        /*
+         * Delay the cleanup to reduce the downtime of migration.
+         * The resource has been allocated by migration will be reused
+         * in COLO process, so don't release them.
+         */
+        if (runstate_check(RUN_STATE_POSTMIGRATE) && !migrate_colo_enabled()) {
+            qemu_savevm_state_cleanup();
+        }
         vm_start();
     }
 }
-- 
1.8.3.1
