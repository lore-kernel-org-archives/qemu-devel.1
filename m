Received: from eggs.gnu.org ([2001:4830:134:3::10]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpO-0004i8-7v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpJ-0002ue-Pa
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:54 -0500
Received: from [45.249.212.187] (port=2543 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpI-0002qZ-Qe
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:49 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:07 +0800
Message-ID: <1487734936-43472-7-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/15] COLO: Add block replication into colo
 process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Make sure master start block replication after slave's block
replication started.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
---
 migration/colo.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index 4626435..1e3e975 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -21,6 +21,9 @@
 #include "migration/failover.h"
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
@@ -132,6 +142,12 @@ static void primary_vm_do_failover(void)
                      FailoverStatus_lookup[old_state]);
         return;
     }
+
+    replication_stop_all(true, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
     /* Notify COLO thread that failover work is finished */
     qemu_sem_post(&s->colo_exit_sem);
 }
@@ -297,6 +313,15 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
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
@@ -403,6 +428,12 @@ static void colo_process_checkpoint(MigrationState *s)
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
@@ -497,6 +528,7 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
     case COLO_MESSAGE_GUEST_SHUTDOWN:
         qemu_mutex_lock_iothread();
         vm_stop_force_state(RUN_STATE_COLO);
+        replication_stop_all(false, NULL);
         qemu_system_shutdown_request_core();
         qemu_mutex_unlock_iothread();
         /*
@@ -544,6 +576,18 @@ void *colo_process_incoming_thread(void *opaque)
     fb = qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
 
+    qemu_mutex_lock_iothread();
+    bdrv_invalidate_cache_all(&local_err);
+    if (local_err) {
+        qemu_mutex_unlock_iothread();
+        goto out;
+    }
+    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
+    qemu_mutex_unlock_iothread();
+    if (local_err) {
+        goto out;
+    }
+
     colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_READY,
                       &local_err);
     if (local_err) {
@@ -620,6 +664,18 @@ void *colo_process_incoming_thread(void *opaque)
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
-- 
1.8.3.1
