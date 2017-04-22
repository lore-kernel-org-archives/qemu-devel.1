Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNR-0001jI-2V
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNN-0000h8-SJ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3466
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNN-0000ga-8n
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:26:41 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:54 +0800
Message-ID: <1492849558-17540-15-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 14/18] COLO: Split qemu_savevm_state_begin
 out of checkpoint process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

It is unnecessary to call qemu_savevm_state_begin() in every checkpoint process.
It mainly sets up devices and does the first device state pass. These data will
not change during the later checkpoint process. So, we split it out of
colo_do_checkpoint_transaction(), in this way, we can reduce these data
transferring in the subsequent checkpoint.

Cc: Juan Quintela <quintela@redhat.com>
Sgned-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 8e27a4c..66bb5b2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -362,16 +362,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
-    /* Disable block migration */
-    s->params.blk = 0;
-    s->params.shared = 0;
-    qemu_savevm_state_begin(s->to_dst_file, &s->params);
-    ret = qemu_file_get_error(s->to_dst_file);
-    if (ret < 0) {
-        error_report("Save VM state begin error");
-        goto out;
-    }
-
     /* We call this API although this may do nothing on primary side. */
     qemu_mutex_lock_iothread();
     replication_do_checkpoint_all(&local_err);
@@ -459,6 +449,21 @@ static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
     colo_checkpoint_notify(data);
 }
 
+static int colo_prepare_before_save(MigrationState *s)
+{
+    int ret;
+
+    /* Disable block migration */
+    s->params.blk = 0;
+    s->params.shared = 0;
+    qemu_savevm_state_begin(s->to_dst_file, &s->params);
+    ret = qemu_file_get_error(s->to_dst_file);
+    if (ret < 0) {
+        error_report("Save VM state begin error");
+    }
+    return ret;
+}
+
 static void colo_process_checkpoint(MigrationState *s)
 {
     QIOChannelBuffer *bioc;
@@ -478,6 +483,11 @@ static void colo_process_checkpoint(MigrationState *s)
     packets_compare_notifier.notify = colo_compare_notify_checkpoint;
     colo_compare_register_notifier(&packets_compare_notifier);
 
+    ret = colo_prepare_before_save(s);
+    if (ret < 0) {
+        goto out;
+    }
+
     /*
      * Wait for Secondary finish loading VM states and enter COLO
      * restore.
@@ -628,6 +638,17 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
     }
 }
 
+static int colo_prepare_before_load(QEMUFile *f)
+{
+    int ret;
+
+    ret = qemu_loadvm_state_begin(f);
+    if (ret < 0) {
+        error_report("Load VM state begin error, ret = %d", ret);
+    }
+    return ret;
+}
+
 void *colo_process_incoming_thread(void *opaque)
 {
     MigrationIncomingState *mis = opaque;
@@ -662,6 +683,11 @@ void *colo_process_incoming_thread(void *opaque)
     fb = qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
 
+    ret = colo_prepare_before_load(mis->from_src_file);
+    if (ret < 0) {
+        goto out;
+    }
+
     qemu_mutex_lock_iothread();
     replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
     if (local_err) {
@@ -709,11 +735,6 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
-        ret = qemu_loadvm_state_begin(mis->from_src_file);
-        if (ret < 0) {
-            error_report("Load vm state begin error, ret=%d", ret);
-            goto out;
-        }
         ret = qemu_loadvm_state_main(mis->from_src_file, mis);
         if (ret < 0) {
             error_report("Load VM's live state (ram) error");
-- 
1.8.3.1
