Received: from eggs.gnu.org ([2001:4830:134:3::10]:42638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpR-0004j6-0S
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpM-0002vj-Op
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:57 -0500
Received: from [45.249.212.188] (port=2935 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpM-0002rv-4z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:52 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:15 +0800
Message-ID: <1487734936-43472-15-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/15] COLO: Split qemu_savevm_state_begin out
 of checkpoint process
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
 migration/colo.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index b17e8e3..ab2d700 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -313,16 +313,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
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
@@ -410,6 +400,21 @@ static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
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
@@ -429,6 +434,11 @@ static void colo_process_checkpoint(MigrationState *s)
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
@@ -570,6 +580,17 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
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
@@ -610,6 +631,11 @@ void *colo_process_incoming_thread(void *opaque)
     fb = qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
 
+    ret = colo_prepare_before_load(mis->from_src_file);
+    if (ret < 0) {
+        goto out;
+    }
+
     qemu_mutex_lock_iothread();
     bdrv_invalidate_cache_all(&local_err);
     if (local_err) {
@@ -621,7 +647,6 @@ void *colo_process_incoming_thread(void *opaque)
     if (local_err) {
         goto out;
     }
-
     colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_READY,
                       &local_err);
     if (local_err) {
@@ -659,11 +684,6 @@ void *colo_process_incoming_thread(void *opaque)
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
