Received: from eggs.gnu.org ([2001:4830:134:3::10]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXe-0001WA-TL
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXd-00049K-IY
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3851
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXc-00046R-Tx
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:37:17 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:16 +0800
Message-ID: <1492850128-17472-7-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 06/18] COLO: Add block replication
 into colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max
	Reitz <mreitz@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>

Make sure master start block replication after slave's block
replication started.

Besides, we need to activate VM's blocks before goes into
COLO state.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
---
 migration/colo.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c | 16 ++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index c4fc865..9949293 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -23,6 +23,9 @@
 #include "qmp-commands.h"
 #include "net/colo-compare.h"
 #include "net/colo.h"
+#include "qapi-event.h"
+#include "block/block.h"
+#include "replication.h"
 
 static bool vmstate_loading;
 static Notifier packets_compare_notifier;
@@ -57,6 +60,7 @@ static void secondary_vm_do_failover(void)
 {
     int old_state;
     MigrationIncomingState *mis = migration_incoming_get_current();
+    Error *local_err = NULL;
 
     /* Can not do failover during the process of VM's loading VMstate, Or
      * it will break the secondary VM.
@@ -74,6 +78,11 @@ static void secondary_vm_do_failover(void)
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
@@ -111,6 +120,7 @@ static void primary_vm_do_failover(void)
 {
     MigrationState *s = migrate_get_current();
     int old_state;
+    Error *local_err = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
                       MIGRATION_STATUS_COMPLETED);
@@ -134,6 +144,13 @@ static void primary_vm_do_failover(void)
                      FailoverStatus_lookup[old_state]);
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
@@ -345,6 +362,15 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     s->params.shared = 0;
     qemu_savevm_state_header(fb);
     qemu_savevm_state_begin(fb, &s->params);
+
+    /* We call this API although this may do nothing on primary side. */
+    qemu_mutex_lock_iothread();
+    replication_do_checkpoint_all(&local_err);
+    qemu_mutex_unlock_iothread();
+    if (local_err) {
+        goto out;
+    }
+
     qemu_mutex_lock_iothread();
     qemu_savevm_state_complete_precopy(fb, false);
     qemu_mutex_unlock_iothread();
@@ -451,6 +477,12 @@ static void colo_process_checkpoint(MigrationState *s)
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
@@ -554,6 +586,7 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
     case COLO_MESSAGE_GUEST_SHUTDOWN:
         qemu_mutex_lock_iothread();
         vm_stop_force_state(RUN_STATE_COLO);
+        replication_stop_all(false, NULL);
         qemu_system_shutdown_request_core();
         qemu_mutex_unlock_iothread();
         /*
@@ -602,6 +635,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -682,6 +720,18 @@ void *colo_process_incoming_thread(void *opaque)
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
index 2ade2aa..755ea54 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -394,6 +394,7 @@ static void process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     mis->from_src_file = f;
     mis->largest_page_size = qemu_ram_pagesize_largest();
@@ -425,6 +426,21 @@ static void process_incoming_migration_co(void *opaque)
 
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
+        /* Make sure all file formats flush their mutable metadata */
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                    MIGRATION_STATUS_FAILED);
+            error_report_err(local_err);
+            migrate_decompress_threads_join();
+            exit(EXIT_FAILURE);
+        }
+        /* If we get an error here, just exit qemu. */
+        blk_resume_after_migration(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            exit(EXIT_FAILURE);
+        }
         mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
-- 
1.8.3.1
