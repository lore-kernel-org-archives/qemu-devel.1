Received: from eggs.gnu.org ([2001:4830:134:3::10]:42643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpR-0004jP-Aj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpN-0002vu-0H
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:57 -0500
Received: from [45.249.212.188] (port=2934 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpM-0002ru-4m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:52 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:14 +0800
Message-ID: <1487734936-43472-14-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 13/15] COLO: Separate the process of
 saving/loading ram and device state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>

We separate the process of saving/loading ram and device state when do
checkpoint. We add new helpers for save/load ram/device. With this change,
we can directly transfer RAM from primary side to secondary side without
using channel-buffer as assistant, which also reduce the size of extra memory
was used during checkpoint.

Besides, we move the colo_flush_ram_cache to the proper position after the
above change.

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c   | 48 ++++++++++++++++++++++++++++++++++++++----------
 migration/ram.c    |  5 -----
 migration/savevm.c |  4 ++++
 3 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 65d0802..b17e8e3 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -308,11 +308,20 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     /* Disable block migration */
     s->params.blk = 0;
     s->params.shared = 0;
-    qemu_savevm_state_header(fb);
-    qemu_savevm_state_begin(fb, &s->params);
+    qemu_savevm_state_begin(s->to_dst_file, &s->params);
+    ret = qemu_file_get_error(s->to_dst_file);
+    if (ret < 0) {
+        error_report("Save VM state begin error");
+        goto out;
+    }
 
     /* We call this API although this may do nothing on primary side. */
     qemu_mutex_lock_iothread();
@@ -323,15 +332,21 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     }
 
     qemu_mutex_lock_iothread();
-    qemu_savevm_state_complete_precopy(fb, false);
+    /*
+     * Only save VM's live state, which not including device state.
+     * TODO: We may need a timeout mechanism to prevent COLO process
+     * to be blocked here.
+     */
+    qemu_savevm_live_state(s->to_dst_file);
+    /* Note: device state is saved into buffer */
+    ret = qemu_save_device_state(fb);
     qemu_mutex_unlock_iothread();
-
-    qemu_fflush(fb);
-
-    colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &local_err);
-    if (local_err) {
+    if (ret < 0) {
+        error_report("Save device state error");
         goto out;
     }
+    qemu_fflush(fb);
+
     /*
      * We need the size of the VMstate data in Secondary side,
      * With which we can decide how much data should be read.
@@ -644,6 +659,17 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        ret = qemu_loadvm_state_begin(mis->from_src_file);
+        if (ret < 0) {
+            error_report("Load vm state begin error, ret=%d", ret);
+            goto out;
+        }
+        ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+        if (ret < 0) {
+            error_report("Load VM's live state (ram) error");
+            goto out;
+        }
+
         value = colo_receive_message_value(mis->from_src_file,
                                  COLO_MESSAGE_VMSTATE_SIZE, &local_err);
         if (local_err) {
@@ -677,8 +703,10 @@ void *colo_process_incoming_thread(void *opaque)
         qemu_mutex_lock_iothread();
         qemu_system_reset(VMRESET_SILENT);
         vmstate_loading = true;
-        if (qemu_loadvm_state(fb) < 0) {
-            error_report("COLO: loadvm failed");
+        colo_flush_ram_cache();
+        ret = qemu_load_device_state(fb);
+        if (ret < 0) {
+            error_report("COLO: load device state failed");
             qemu_mutex_unlock_iothread();
             goto out;
         }
diff --git a/migration/ram.c b/migration/ram.c
index 3f57fe0..6227b94 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2540,7 +2540,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      * be atomic
      */
     bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
-    bool need_flush = false;
 
     seq_iter++;
 
@@ -2575,7 +2574,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             /* After going into COLO, we should load the Page into colo_cache */
             if (ram_cache_enable) {
                 host = colo_cache_from_block_offset(block, addr);
-                need_flush = true;
             } else {
                 host = host_from_ram_block_offset(block, addr);
             }
@@ -2671,9 +2669,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
 
-    if (!ret  && ram_cache_enable && need_flush) {
-        colo_flush_ram_cache();
-    }
     return ret;
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index dac478b..67e4306 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1002,6 +1002,10 @@ void qemu_savevm_state_begin(QEMUFile *f,
             break;
         }
     }
+    if (migration_in_colo_state()) {
+        qemu_put_byte(f, QEMU_VM_EOF);
+        qemu_fflush(f);
+    }
 }
 
 /*
-- 
1.8.3.1
