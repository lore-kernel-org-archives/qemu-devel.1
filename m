Received: from eggs.gnu.org ([2001:4830:134:3::10]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybJ-0003cD-Eb
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybI-000470-7W
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:01 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybH-00046f-Ut
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:00 -0500
Received: by mail-pl0-x244.google.com with SMTP id b12so521050plm.3
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:01:59 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:04 +0800
Message-Id: <1515045675-6993-6-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 05/16] COLO: Add block replication
 into colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>

Make sure master start block replication after slave's block
replication started.

Besides, we need to activate VM's blocks before goes into
COLO state.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
---
 migration/colo.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c |  9 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index c513805..0e689df 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -26,6 +26,9 @@
 #include "qmp-commands.h"
 #include "net/colo-compare.h"
 #include "net/colo.h"
+#include "qapi-event.h"
+#include "block/block.h"
+#include "replication.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -55,6 +58,7 @@ static void secondary_vm_do_failover(void)
 {
     int old_state;
     MigrationIncomingState *mis = migration_incoming_get_current();
+    Error *local_err = NULL;
 
     /* Can not do failover during the process of VM's loading VMstate, Or
      * it will break the secondary VM.
@@ -72,6 +76,11 @@ static void secondary_vm_do_failover(void)
     migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
 
+    replication_stop_all(true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
     if (!autostart) {
         error_report("\"-S\" qemu option will be ignored in secondary side");
         /* recover runstate to normal migration finish state */
@@ -109,6 +118,7 @@ static void primary_vm_do_failover(void)
 {
     MigrationState *s = migrate_get_current();
     int old_state;
+    Error *local_err = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
@@ -132,6 +142,13 @@ static void primary_vm_do_failover(void)
                      FailoverStatus_str(old_state));
         return;
     }
+
+    replication_stop_all(true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        local_err = NULL;
+    }
+
     /* Notify COLO thread that failover work is finished */
     qemu_sem_post(&s->colo_exit_sem);
 }
@@ -355,6 +372,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     qemu_savevm_state_header(fb);
     qemu_savevm_state_setup(fb);
     qemu_mutex_lock_iothread();
+    replication_do_checkpoint_all(&local_err);
+    if (local_err) {
+        qemu_mutex_unlock_iothread();
+        goto out;
+    }
     qemu_savevm_state_complete_precopy(fb, false, false);
     qemu_mutex_unlock_iothread();
 
@@ -396,6 +418,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     ret = 0;
 
     qemu_mutex_lock_iothread();
+
     vm_start();
     qemu_mutex_unlock_iothread();
     trace_colo_vm_state_change("stop", "run");
@@ -445,6 +468,12 @@ static void colo_process_checkpoint(MigrationState *s)
     object_unref(OBJECT(bioc));
 
     qemu_mutex_lock_iothread();
+    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
+    if (local_err) {
+        qemu_mutex_unlock_iothread();
+        goto out;
+    }
+
     vm_start();
     qemu_mutex_unlock_iothread();
     trace_colo_vm_state_change("stop", "run");
@@ -584,6 +613,11 @@ void *colo_process_incoming_thread(void *opaque)
     object_unref(OBJECT(bioc));
 
     qemu_mutex_lock_iothread();
+    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
+    if (local_err) {
+        qemu_mutex_unlock_iothread();
+        goto out;
+    }
     vm_start();
     trace_colo_vm_state_change("stop", "run");
     qemu_mutex_unlock_iothread();
@@ -664,6 +698,18 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        replication_get_error_all(&local_err);
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+        /* discard colo disk buffer */
+        replication_do_checkpoint_all(&local_err);
+        if (local_err) {
+            qemu_mutex_unlock_iothread();
+            goto out;
+        }
+
         vmstate_loading = false;
         vm_start();
         trace_colo_vm_state_change("stop", "run");
diff --git a/migration/migration.c b/migration/migration.c
index ced463c..3410145 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -318,6 +318,7 @@ static void process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
     mis->largest_page_size = qemu_ram_pagesize_largest();
@@ -349,6 +350,14 @@ static void process_incoming_migration_co(void *opaque)
 
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
+        /* Make sure all file formats flush their mutable metadata */
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                    MIGRATION_STATUS_FAILED);
+            error_report_err(local_err);
+            exit(EXIT_FAILURE);
+        }
         mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
-- 
2.7.4
