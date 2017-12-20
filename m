Received: from eggs.gnu.org ([2001:4830:134:3::10]:56479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyR-0004k9-6b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyP-0007Hm-Sy
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:07 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyP-0007HP-In
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:05 -0500
Received: by mail-wr0-x243.google.com with SMTP id a41so22872028wra.6
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:40 +0100
Message-Id: <1513790098-9815-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/46] block/iscsi: only report an iSCSI Failure
 if we don't handle it gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>

From: Peter Lieven <pl@kamp.de>

we currently report an "iSCSI Failure" in iscsi_co_generic_cb if the task
hasn't completed with SCSI_STATUS_GOOD. However, we expect a failure in
some cases and handle it gracefully. This is the case for misaligned UNMAPs
and WRITESAME10/16 calls without UNMAP. In this case a failure in the
logs can be quite misleading.

While we are at it improve the logging to reveal which operation failed
at what LBA.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1512733868-9009-3-git-send-email-pl@kamp.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index c532ec7..5c0a9e5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -104,6 +104,7 @@ typedef struct IscsiTask {
     IscsiLun *iscsilun;
     QEMUTimer retry_timer;
     int err_code;
+    char *err_str;
 } IscsiTask;
 
 typedef struct IscsiAIOCB {
@@ -265,7 +266,7 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
             }
         }
         iTask->err_code = iscsi_translate_sense(&task->sense);
-        error_report("iSCSI Failure: %s", iscsi_get_error(iscsi));
+        iTask->err_str = g_strdup(iscsi_get_error(iscsi));
     }
 
 out:
@@ -629,6 +630,8 @@ retry:
 
     if (iTask.status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, sector_num, nb_sectors);
+        error_report("iSCSI WRITE10/16 failed at lba %" PRIu64 ": %s", lba,
+                     iTask.err_str);
         r = iTask.err_code;
         goto out_unlock;
     }
@@ -637,6 +640,7 @@ retry:
 
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
     return r;
 }
 
@@ -651,10 +655,9 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
     struct scsi_get_lba_status *lbas = NULL;
     struct scsi_lba_status_descriptor *lbasd = NULL;
     struct IscsiTask iTask;
+    uint64_t lba;
     int64_t ret;
 
-    iscsi_co_init_iscsitask(iscsilun, &iTask);
-
     if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
         ret = -EINVAL;
         goto out;
@@ -670,11 +673,13 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
         goto out;
     }
 
+    lba = sector_qemu2lun(sector_num, iscsilun);
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
-                                  sector_qemu2lun(sector_num, iscsilun),
-                                  8 + 16, iscsi_co_generic_cb,
+                                  lba, 8 + 16, iscsi_co_generic_cb,
                                   &iTask) == NULL) {
         ret = -ENOMEM;
         goto out_unlock;
@@ -701,6 +706,8 @@ retry:
          * because the device is busy or the cmd is not
          * supported) we pretend all blocks are allocated
          * for backwards compatibility */
+        error_report("iSCSI GET_LBA_STATUS failed at lba %" PRIu64 ": %s",
+                     lba, iTask.err_str);
         goto out_unlock;
     }
 
@@ -738,6 +745,7 @@ retry:
     }
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
 out:
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
@@ -756,6 +764,7 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
     struct IscsiTask iTask;
     uint64_t lba;
     uint32_t num_sectors;
+    int r = 0;
 
     if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
         return -EINVAL;
@@ -853,19 +862,23 @@ retry:
         iTask.complete = 0;
         goto retry;
     }
-    qemu_mutex_unlock(&iscsilun->mutex);
 
     if (iTask.status != SCSI_STATUS_GOOD) {
-        return iTask.err_code;
+        error_report("iSCSI READ10/16 failed at lba %" PRIu64 ": %s",
+                     lba, iTask.err_str);
+        r = iTask.err_code;
     }
 
-    return 0;
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    return r;
 }
 
 static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
+    int r = 0;
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
@@ -892,13 +905,15 @@ retry:
         iTask.complete = 0;
         goto retry;
     }
-    qemu_mutex_unlock(&iscsilun->mutex);
 
     if (iTask.status != SCSI_STATUS_GOOD) {
-        return iTask.err_code;
+        error_report("iSCSI SYNCHRONIZECACHE10 failed: %s", iTask.err_str);
+        r = iTask.err_code;
     }
 
-    return 0;
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    return r;
 }
 
 #ifdef __linux__
@@ -1139,12 +1154,15 @@ retry:
     }
 
     if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI UNMAP failed at lba %" PRIu64 ": %s",
+                     list.lba, iTask.err_str);
         r = iTask.err_code;
         goto out_unlock;
     }
 
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
     return r;
 }
 
@@ -1241,6 +1259,8 @@ retry:
     if (iTask.status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
                                    bytes >> BDRV_SECTOR_BITS);
+        error_report("iSCSI WRITESAME10/16 failed at lba %" PRIu64 ": %s",
+                     lba, iTask.err_str);
         r = iTask.err_code;
         goto out_unlock;
     }
@@ -1255,6 +1275,7 @@ retry:
 
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
     return r;
 }
 
-- 
1.8.3.1
