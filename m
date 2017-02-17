Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOP-0000Rs-A8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoON-0002vs-6S
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:33 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Feb 2017 20:40:28 +0100
Message-Id: <20170217194028.8398-4-pbonzini@redhat.com>
In-Reply-To: <20170217194028.8398-1-pbonzini@redhat.com>
References: <20170217194028.8398-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iscsi: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com

Now that all bottom halves and callbacks take care of taking the
AioContext lock, we can migrate some users away from it and to a
specific QemuMutex or CoMutex.

Protect libiscsi calls with a QemuMutex.  Callbacks are invoked
using bottom halves, so we don't even have to drop it around
callback invocations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2561be9..e483f6d 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -58,6 +58,7 @@ typedef struct IscsiLun {
     int events;
     QEMUTimer *nop_timer;
     QEMUTimer *event_timer;
+    QemuMutex mutex;
     struct scsi_inquiry_logical_block_provisioning lbp;
     struct scsi_inquiry_block_limits bl;
     unsigned char *zeroblock;
@@ -252,6 +253,7 @@ static int iscsi_translate_sense(struct scsi_sense *sense)
     return ret;
 }
 
+/* Called (via iscsi_service) with QemuMutex held.  */
 static void
 iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                         void *command_data, void *opaque)
@@ -352,6 +354,7 @@ static const AIOCBInfo iscsi_aiocb_info = {
 static void iscsi_process_read(void *arg);
 static void iscsi_process_write(void *arg);
 
+/* Called with QemuMutex held.  */
 static void
 iscsi_set_events(IscsiLun *iscsilun)
 {
@@ -395,10 +398,10 @@ iscsi_process_read(void *arg)
     IscsiLun *iscsilun = arg;
     struct iscsi_context *iscsi = iscsilun->iscsi;
 
-    aio_context_acquire(iscsilun->aio_context);
+    qemu_mutex_lock(&iscsilun->mutex);
     iscsi_service(iscsi, POLLIN);
     iscsi_set_events(iscsilun);
-    aio_context_release(iscsilun->aio_context);
+    qemu_mutex_unlock(&iscsilun->mutex);
 }
 
 static void
@@ -407,10 +410,10 @@ iscsi_process_write(void *arg)
     IscsiLun *iscsilun = arg;
     struct iscsi_context *iscsi = iscsilun->iscsi;
 
-    aio_context_acquire(iscsilun->aio_context);
+    qemu_mutex_lock(&iscsilun->mutex);
     iscsi_service(iscsi, POLLOUT);
     iscsi_set_events(iscsilun);
-    aio_context_release(iscsilun->aio_context);
+    qemu_mutex_unlock(&iscsilun->mutex);
 }
 
 static int64_t sector_lun2qemu(int64_t sector, IscsiLun *iscsilun)
@@ -589,6 +592,7 @@ iscsi_co_writev_flags(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     uint64_t lba;
     uint32_t num_sectors;
     bool fua = flags & BDRV_REQ_FUA;
+    int r = 0;
 
     if (fua) {
         assert(iscsilun->dpofua);
@@ -604,6 +608,7 @@ iscsi_co_writev_flags(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     lba = sector_qemu2lun(sector_num, iscsilun);
     num_sectors = sector_qemu2lun(nb_sectors, iscsilun);
     iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -640,7 +645,9 @@ retry:
 #endif
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.task != NULL) {
@@ -655,12 +662,15 @@ retry:
 
     if (iTask.status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, sector_num, nb_sectors);
-        return iTask.err_code;
+        r = iTask.err_code;
+        goto out_unlock;
     }
 
     iscsi_allocmap_set_allocated(iscsilun, sector_num, nb_sectors);
 
-    return 0;
+out_unlock:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    return r;
 }
 
 
@@ -693,18 +703,21 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
         goto out;
     }
 
+    qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
                                   sector_qemu2lun(sector_num, iscsilun),
                                   8 + 16, iscsi_co_generic_cb,
                                   &iTask) == NULL) {
         ret = -ENOMEM;
-        goto out;
+        goto out_unlock;
     }
 
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.do_retry) {
@@ -721,20 +734,20 @@ retry:
          * because the device is busy or the cmd is not
          * supported) we pretend all blocks are allocated
          * for backwards compatibility */
-        goto out;
+        goto out_unlock;
     }
 
     lbas = scsi_datain_unmarshall(iTask.task);
     if (lbas == NULL) {
         ret = -EIO;
-        goto out;
+        goto out_unlock;
     }
 
     lbasd = &lbas->descriptors[0];
 
     if (sector_qemu2lun(sector_num, iscsilun) != lbasd->lba) {
         ret = -EIO;
-        goto out;
+        goto out_unlock;
     }
 
     *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
@@ -756,6 +769,8 @@ retry:
     if (*pnum > nb_sectors) {
         *pnum = nb_sectors;
     }
+out_unlock:
+    qemu_mutex_unlock(&iscsilun->mutex);
 out:
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
@@ -818,6 +833,7 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
     num_sectors = sector_qemu2lun(nb_sectors, iscsilun);
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -855,7 +871,9 @@ retry:
 #endif
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.task != NULL) {
@@ -867,6 +885,7 @@ retry:
         iTask.complete = 0;
         goto retry;
     }
+    qemu_mutex_unlock(&iscsilun->mutex);
 
     if (iTask.status != SCSI_STATUS_GOOD) {
         return iTask.err_code;
@@ -881,6 +900,7 @@ static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
     struct IscsiTask iTask;
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0, 0, 0,
                                       0, iscsi_co_generic_cb, &iTask) == NULL) {
@@ -889,7 +909,9 @@ retry:
 
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.task != NULL) {
@@ -901,6 +923,7 @@ retry:
         iTask.complete = 0;
         goto retry;
     }
+    qemu_mutex_unlock(&iscsilun->mutex);
 
     if (iTask.status != SCSI_STATUS_GOOD) {
         return iTask.err_code;
@@ -910,6 +933,7 @@ retry:
 }
 
 #ifdef __linux__
+/* Called (via iscsi_service) with QemuMutex held.  */
 static void
 iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
                      void *command_data, void *opaque)
@@ -1034,6 +1058,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb->task->expxferlen = acb->ioh->dxfer_len;
 
     data.size = 0;
+    qemu_mutex_lock(&iscsilun->mutex);
     if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
         if (acb->ioh->iovec_count == 0) {
             data.data = acb->ioh->dxferp;
@@ -1049,6 +1074,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
                                  iscsi_aio_ioctl_cb,
                                  (data.size > 0) ? &data : NULL,
                                  acb) != 0) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         scsi_free_scsi_task(acb->task);
         qemu_aio_unref(acb);
         return NULL;
@@ -1068,6 +1094,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     }
 
     iscsi_set_events(iscsilun);
+    qemu_mutex_unlock(&iscsilun->mutex);
 
     return &acb->common;
 }
@@ -1092,6 +1119,7 @@ coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
     struct unmap_list list;
+    int r = 0;
 
     if (!is_byte_request_lun_aligned(offset, count, iscsilun)) {
         return -ENOTSUP;
@@ -1106,15 +1134,19 @@ coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     list.num = count / iscsilun->block_size;
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_unmap_task(iscsilun->iscsi, iscsilun->lun, 0, 0, &list, 1,
                          iscsi_co_generic_cb, &iTask) == NULL) {
-        return -ENOMEM;
+        r = -ENOMEM;
+        goto out_unlock;
     }
 
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.task != NULL) {
@@ -1131,17 +1163,20 @@ retry:
         /* the target might fail with a check condition if it
            is not happy with the alignment of the UNMAP request
            we silently fail in this case */
-        return 0;
+        goto out_unlock;
     }
 
     if (iTask.status != SCSI_STATUS_GOOD) {
-        return iTask.err_code;
+        r = iTask.err_code;
+        goto out_unlock;
     }
 
     iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
                                count >> BDRV_SECTOR_BITS);
 
-    return 0;
+out_unlock:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    return r;
 }
 
 static int
@@ -1153,6 +1188,7 @@ coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     uint64_t lba;
     uint32_t nb_blocks;
     bool use_16_for_ws = iscsilun->use_16_for_rw;
+    int r = 0;
 
     if (!is_byte_request_lun_aligned(offset, count, iscsilun)) {
         return -ENOTSUP;
@@ -1186,6 +1222,7 @@ coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         }
     }
 
+    qemu_mutex_lock(&iscsilun->mutex);
     iscsi_co_init_iscsitask(iscsilun, &iTask);
 retry:
     if (use_16_for_ws) {
@@ -1205,7 +1242,9 @@ retry:
 
     while (!iTask.complete) {
         iscsi_set_events(iscsilun);
+        qemu_mutex_unlock(&iscsilun->mutex);
         qemu_coroutine_yield();
+        qemu_mutex_lock(&iscsilun->mutex);
     }
 
     if (iTask.status == SCSI_STATUS_CHECK_CONDITION &&
@@ -1215,7 +1254,8 @@ retry:
         /* WRITE SAME is not supported by the target */
         iscsilun->has_write_same = false;
         scsi_free_scsi_task(iTask.task);
-        return -ENOTSUP;
+        r = -ENOTSUP;
+        goto out_unlock;
     }
 
     if (iTask.task != NULL) {
@@ -1231,7 +1271,8 @@ retry:
     if (iTask.status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
                                    count >> BDRV_SECTOR_BITS);
-        return iTask.err_code;
+        r = iTask.err_code;
+        goto out_unlock;
     }
 
     if (flags & BDRV_REQ_MAY_UNMAP) {
@@ -1242,7 +1283,9 @@ retry:
                                      count >> BDRV_SECTOR_BITS);
     }
 
-    return 0;
+out_unlock:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    return r;
 }
 
 static void parse_chap(struct iscsi_context *iscsi, const char *target,
@@ -1397,7 +1440,7 @@ static void iscsi_nop_timed_event(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
-    aio_context_acquire(iscsilun->aio_context);
+    qemu_mutex_lock(&iscsilun->mutex);
     if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
@@ -1410,7 +1453,7 @@ static void iscsi_nop_timed_event(void *opaque)
     iscsi_set_events(iscsilun);
 
 out:
-    aio_context_release(iscsilun->aio_context);
+    qemu_mutex_unlock(&iscsilun->mutex);
 }
 
 static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
@@ -1812,6 +1855,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     scsi_free_scsi_task(task);
     task = NULL;
 
+    qemu_mutex_init(&iscsilun->mutex);
     iscsi_attach_aio_context(bs, iscsilun->aio_context);
 
     /* Guess the internal cluster (page) size of the iscsi target by the means
@@ -1860,6 +1904,7 @@ static void iscsi_close(BlockDriverState *bs)
     iscsi_destroy_context(iscsi);
     g_free(iscsilun->zeroblock);
     iscsi_allocmap_free(iscsilun);
+    qemu_mutex_destroy(&iscsilun->mutex);
     memset(iscsilun, 0, sizeof(IscsiLun));
 }
 
-- 
2.9.3
