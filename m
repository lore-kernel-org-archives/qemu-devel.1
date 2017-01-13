Received: from eggs.gnu.org ([2001:4830:134:3::10]:41220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jq-0007dz-Bd
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jn-0002ba-Vr
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:50 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jn-0002bR-KX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:47 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so11633833wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:28 +0100
Message-Id: <20170113131731.1246-14-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/16] block: explicitly acquire aiocontext in
 aio callbacks that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/archipelago.c    |  3 ---
 block/block-backend.c  |  7 -------
 block/curl.c           |  2 +-
 block/io.c             |  6 +-----
 block/iscsi.c          |  3 ---
 block/linux-aio.c      |  5 +----
 block/mirror.c         | 12 +++++++++---
 block/null.c           |  8 --------
 block/qed-cluster.c    |  2 ++
 block/qed-table.c      | 12 ++++++++++--
 block/qed.c            |  4 ++--
 block/rbd.c            |  4 ----
 block/win32-aio.c      |  3 ---
 hw/block/virtio-blk.c  | 12 +++++++++++-
 hw/scsi/scsi-disk.c    | 15 +++++++++++++++
 hw/scsi/scsi-generic.c | 20 +++++++++++++++++---
 thread-pool.c          |  4 +++-
 17 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/block/archipelago.c b/block/archipelago.c
index a624390..2449cfc 100644
--- a/block/archipelago.c
+++ b/block/archipelago.c
@@ -310,11 +310,8 @@ static void qemu_archipelago_complete_aio(void *opaque)
 {
     AIORequestData *reqdata = (AIORequestData *) opaque;
     ArchipelagoAIOCB *aio_cb = (ArchipelagoAIOCB *) reqdata->aio_cb;
-    AioContext *ctx = bdrv_get_aio_context(aio_cb->common.bs);
 
-    aio_context_acquire(ctx);
     aio_cb->common.cb(aio_cb->common.opaque, aio_cb->ret);
-    aio_context_release(ctx);
     aio_cb->status = 0;
 
     qemu_aio_unref(aio_cb);
diff --git a/block/block-backend.c b/block/block-backend.c
index bfc0e6b..819f272 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -939,12 +939,9 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
 static void error_callback_bh(void *opaque)
 {
     struct BlockBackendAIOCB *acb = opaque;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
 
     bdrv_dec_in_flight(acb->common.bs);
-    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, acb->ret);
-    aio_context_release(ctx);
     qemu_aio_unref(acb);
 }
 
@@ -986,12 +983,8 @@ static void blk_aio_complete(BlkAioEmAIOCB *acb)
 static void blk_aio_complete_bh(void *opaque)
 {
     BlkAioEmAIOCB *acb = opaque;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
-
     assert(acb->has_returned);
-    aio_context_acquire(ctx);
     blk_aio_complete(acb);
-    aio_context_release(ctx);
 }
 
 static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
diff --git a/block/curl.c b/block/curl.c
index f3f063b..2939cc7 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -854,11 +854,11 @@ static void curl_readv_bh_cb(void *p)
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
 
 out:
+    aio_context_release(ctx);
     if (ret != -EINPROGRESS) {
         acb->common.cb(acb->common.opaque, ret);
         qemu_aio_unref(acb);
     }
-    aio_context_release(ctx);
 }
 
 static BlockAIOCB *curl_aio_readv(BlockDriverState *bs,
diff --git a/block/io.c b/block/io.c
index 800fcf8..3a879cc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -813,7 +813,7 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
     CoroutineIOCompletion *co = opaque;
 
     co->ret = ret;
-    qemu_coroutine_enter(co->coroutine);
+    aio_co_wake(co->coroutine);
 }
 
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
@@ -2147,13 +2147,9 @@ static void bdrv_co_complete(BlockAIOCBCoroutine *acb)
 static void bdrv_co_em_bh(void *opaque)
 {
     BlockAIOCBCoroutine *acb = opaque;
-    BlockDriverState *bs = acb->common.bs;
-    AioContext *ctx = bdrv_get_aio_context(bs);
 
     assert(!acb->need_bh);
-    aio_context_acquire(ctx);
     bdrv_co_complete(acb);
-    aio_context_release(ctx);
 }
 
 static void bdrv_co_maybe_schedule_bh(BlockAIOCBCoroutine *acb)
diff --git a/block/iscsi.c b/block/iscsi.c
index 5de5d93..c19c838 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -136,16 +136,13 @@ static void
 iscsi_bh_cb(void *p)
 {
     IscsiAIOCB *acb = p;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
 
     qemu_bh_delete(acb->bh);
 
     g_free(acb->buf);
     acb->buf = NULL;
 
-    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, acb->status);
-    aio_context_release(ctx);
 
     if (acb->task != NULL) {
         scsi_free_scsi_task(acb->task);
diff --git a/block/linux-aio.c b/block/linux-aio.c
index f7ae38a..88b8d55 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -75,7 +75,6 @@ static inline ssize_t io_event_ret(struct io_event *ev)
  */
 static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
 {
-    LinuxAioState *s = laiocb->ctx;
     int ret;
 
     ret = laiocb->ret;
@@ -94,7 +93,6 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
     }
 
     laiocb->ret = ret;
-    aio_context_acquire(s->aio_context);
     if (laiocb->co) {
         /* If the coroutine is already entered it must be in ioq_submit() and
          * will notice laio->ret has been filled in when it eventually runs
@@ -102,13 +100,12 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
          * that!
          */
         if (!qemu_coroutine_entered(laiocb->co)) {
-            qemu_coroutine_enter(laiocb->co);
+            aio_co_wake(laiocb->co);
         }
     } else {
         laiocb->common.cb(laiocb->common.opaque, ret);
         qemu_aio_unref(laiocb);
     }
-    aio_context_release(s->aio_context);
 }
 
 /**
diff --git a/block/mirror.c b/block/mirror.c
index 301ba92..698a54e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -132,6 +132,8 @@ static void mirror_write_complete(void *opaque, int ret)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
+
+    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -142,12 +144,15 @@ static void mirror_write_complete(void *opaque, int ret)
         }
     }
     mirror_iteration_done(op, ret);
+    aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
 static void mirror_read_complete(void *opaque, int ret)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
+
+    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -158,10 +163,11 @@ static void mirror_read_complete(void *opaque, int ret)
         }
 
         mirror_iteration_done(op, ret);
-        return;
+    } else {
+        blk_aio_pwritev(s->target, op->sector_num * BDRV_SECTOR_SIZE, &op->qiov,
+                        0, mirror_write_complete, op);
     }
-    blk_aio_pwritev(s->target, op->sector_num * BDRV_SECTOR_SIZE, &op->qiov,
-                    0, mirror_write_complete, op);
+    aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
 static inline void mirror_clip_sectors(MirrorBlockJob *s,
diff --git a/block/null.c b/block/null.c
index 5eb2038..b300390 100644
--- a/block/null.c
+++ b/block/null.c
@@ -134,22 +134,14 @@ static const AIOCBInfo null_aiocb_info = {
 static void null_bh_cb(void *opaque)
 {
     NullAIOCB *acb = opaque;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
-
-    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, 0);
-    aio_context_release(ctx);
     qemu_aio_unref(acb);
 }
 
 static void null_timer_cb(void *opaque)
 {
     NullAIOCB *acb = opaque;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
-
-    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, 0);
-    aio_context_release(ctx);
     timer_deinit(&acb->timer);
     qemu_aio_unref(acb);
 }
diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index c24e756..8f5da74 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -83,6 +83,7 @@ static void qed_find_cluster_cb(void *opaque, int ret)
     unsigned int index;
     unsigned int n;
 
+    qed_acquire(s);
     if (ret) {
         goto out;
     }
@@ -109,6 +110,7 @@ static void qed_find_cluster_cb(void *opaque, int ret)
 
 out:
     find_cluster_cb->cb(find_cluster_cb->opaque, ret, offset, len);
+    qed_release(s);
     g_free(find_cluster_cb);
 }
 
diff --git a/block/qed-table.c b/block/qed-table.c
index ed443e2..b12c298 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -31,6 +31,7 @@ static void qed_read_table_cb(void *opaque, int ret)
 {
     QEDReadTableCB *read_table_cb = opaque;
     QEDTable *table = read_table_cb->table;
+    BDRVQEDState *s = read_table_cb->s;
     int noffsets = read_table_cb->qiov.size / sizeof(uint64_t);
     int i;
 
@@ -40,13 +41,15 @@ static void qed_read_table_cb(void *opaque, int ret)
     }
 
     /* Byteswap offsets */
+    qed_acquire(s);
     for (i = 0; i < noffsets; i++) {
         table->offsets[i] = le64_to_cpu(table->offsets[i]);
     }
+    qed_release(s);
 
 out:
     /* Completion */
-    trace_qed_read_table_cb(read_table_cb->s, read_table_cb->table, ret);
+    trace_qed_read_table_cb(s, read_table_cb->table, ret);
     gencb_complete(&read_table_cb->gencb, ret);
 }
 
@@ -84,8 +87,9 @@ typedef struct {
 static void qed_write_table_cb(void *opaque, int ret)
 {
     QEDWriteTableCB *write_table_cb = opaque;
+    BDRVQEDState *s = write_table_cb->s;
 
-    trace_qed_write_table_cb(write_table_cb->s,
+    trace_qed_write_table_cb(s,
                              write_table_cb->orig_table,
                              write_table_cb->flush,
                              ret);
@@ -97,8 +101,10 @@ static void qed_write_table_cb(void *opaque, int ret)
     if (write_table_cb->flush) {
         /* We still need to flush first */
         write_table_cb->flush = false;
+        qed_acquire(s);
         bdrv_aio_flush(write_table_cb->s->bs, qed_write_table_cb,
                        write_table_cb);
+        qed_release(s);
         return;
     }
 
@@ -213,6 +219,7 @@ static void qed_read_l2_table_cb(void *opaque, int ret)
     CachedL2Table *l2_table = request->l2_table;
     uint64_t l2_offset = read_l2_table_cb->l2_offset;
 
+    qed_acquire(s);
     if (ret) {
         /* can't trust loaded L2 table anymore */
         qed_unref_l2_cache_entry(l2_table);
@@ -228,6 +235,7 @@ static void qed_read_l2_table_cb(void *opaque, int ret)
         request->l2_table = qed_find_l2_cache_entry(&s->l2_cache, l2_offset);
         assert(request->l2_table != NULL);
     }
+    qed_release(s);
 
     gencb_complete(&read_l2_table_cb->gencb, ret);
 }
diff --git a/block/qed.c b/block/qed.c
index db8295d..0b62c77 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -745,7 +745,7 @@ static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t l
     }
 
     if (cb->co) {
-        qemu_coroutine_enter(cb->co);
+        aio_co_wake(cb->co);
     }
 }
 
@@ -1462,7 +1462,7 @@ static void coroutine_fn qed_co_pwrite_zeroes_cb(void *opaque, int ret)
     cb->done = true;
     cb->ret = ret;
     if (cb->co) {
-        qemu_coroutine_enter(cb->co);
+        aio_co_wake(cb->co);
     }
 }
 
diff --git a/block/rbd.c b/block/rbd.c
index 2cb2cb4..a57b3e3 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -413,7 +413,6 @@ shutdown:
 static void qemu_rbd_complete_aio(RADOSCB *rcb)
 {
     RBDAIOCB *acb = rcb->acb;
-    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
     int64_t r;
 
     r = rcb->ret;
@@ -446,10 +445,7 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
         qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
     }
     qemu_vfree(acb->bounce);
-
-    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
-    aio_context_release(ctx);
 
     qemu_aio_unref(acb);
 }
diff --git a/block/win32-aio.c b/block/win32-aio.c
index c3f8f1a..3be8f45 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -87,10 +87,7 @@ static void win32_aio_process_completion(QEMUWin32AIOState *s,
         qemu_vfree(waiocb->buf);
     }
 
-
-    aio_context_acquire(s->aio_ctx);
     waiocb->common.cb(waiocb->common.opaque, ret);
-    aio_context_release(s->aio_ctx);
     qemu_aio_unref(waiocb);
 }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index af652f3..39516e8 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -89,7 +89,9 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
 static void virtio_blk_rw_complete(void *opaque, int ret)
 {
     VirtIOBlockReq *next = opaque;
+    VirtIOBlock *s = next->dev;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (next) {
         VirtIOBlockReq *req = next;
         next = req->mr_next;
@@ -122,21 +124,27 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
         block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
         virtio_blk_free_request(req);
     }
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static void virtio_blk_flush_complete(void *opaque, int ret)
 {
     VirtIOBlockReq *req = opaque;
+    VirtIOBlock *s = req->dev;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     if (ret) {
         if (virtio_blk_handle_rw_error(req, -ret, 0)) {
-            return;
+            goto out;
         }
     }
 
     virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
     block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
     virtio_blk_free_request(req);
+
+out:
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 #ifdef __linux__
@@ -183,8 +191,10 @@ static void virtio_blk_ioctl_complete(void *opaque, int status)
     virtio_stl_p(vdev, &scsi->data_len, hdr->dxfer_len);
 
 out:
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     virtio_blk_req_complete(req, status);
     virtio_blk_free_request(req);
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
     g_free(ioctl_req);
 }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index bdd1e5f..baf66b5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -207,6 +207,7 @@ static void scsi_aio_complete(void *opaque, int ret)
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (scsi_disk_req_check_error(r, ret, true)) {
         goto done;
     }
@@ -215,6 +216,7 @@ static void scsi_aio_complete(void *opaque, int ret)
     scsi_req_complete(&r->req, GOOD);
 
 done:
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
     scsi_req_unref(&r->req);
 }
 
@@ -290,12 +292,14 @@ static void scsi_dma_complete(void *opaque, int ret)
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
     } else {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_dma_complete_noio(r, ret);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_read_complete(void * opaque, int ret)
@@ -306,6 +310,7 @@ static void scsi_read_complete(void * opaque, int ret)
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (scsi_disk_req_check_error(r, ret, true)) {
         goto done;
     }
@@ -320,6 +325,7 @@ static void scsi_read_complete(void * opaque, int ret)
 
 done:
     scsi_req_unref(&r->req);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 /* Actually issue a read to the block device.  */
@@ -364,12 +370,14 @@ static void scsi_do_read_cb(void *opaque, int ret)
     assert (r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
     } else {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_do_read(opaque, ret);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 /* Read more data from scsi device into buffer.  */
@@ -489,12 +497,14 @@ static void scsi_write_complete(void * opaque, int ret)
     assert (r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
     } else {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_write_complete_noio(r, ret);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_write_data(SCSIRequest *req)
@@ -1625,11 +1635,14 @@ static void scsi_unmap_complete(void *opaque, int ret)
 {
     UnmapCBData *data = opaque;
     SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     scsi_unmap_complete_noio(data, ret);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
@@ -1696,6 +1709,7 @@ static void scsi_write_same_complete(void *opaque, int ret)
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
     if (scsi_disk_req_check_error(r, ret, true)) {
         goto done;
     }
@@ -1724,6 +1738,7 @@ done:
     scsi_req_unref(&r->req);
     qemu_vfree(data->iov.iov_base);
     g_free(data);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7a588a7..fdf9168 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -143,10 +143,14 @@ done:
 static void scsi_command_complete(void *opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
+    SCSIDevice *s = r->req.dev;
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
+
+    aio_context_acquire(blk_get_aio_context(s->conf.blk));
     scsi_command_complete_noio(r, ret);
+    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 static int execute_command(BlockBackend *blk,
@@ -182,9 +186,11 @@ static void scsi_read_complete(void * opaque, int ret)
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.blk));
+
     if (ret || r->req.io_canceled) {
         scsi_command_complete_noio(r, ret);
-        return;
+        goto done;
     }
 
     len = r->io_header.dxfer_len - r->io_header.resid;
@@ -193,7 +199,7 @@ static void scsi_read_complete(void * opaque, int ret)
     r->len = -1;
     if (len == 0) {
         scsi_command_complete_noio(r, 0);
-        return;
+        goto done;
     }
 
     /* Snoop READ CAPACITY output to set the blocksize.  */
@@ -237,6 +243,9 @@ static void scsi_read_complete(void * opaque, int ret)
     }
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
+
+done:
+    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 /* Read more data from scsi device into buffer.  */
@@ -272,9 +281,11 @@ static void scsi_write_complete(void * opaque, int ret)
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.blk));
+
     if (ret || r->req.io_canceled) {
         scsi_command_complete_noio(r, ret);
-        return;
+        goto done;
     }
 
     if (r->req.cmd.buf[0] == MODE_SELECT && r->req.cmd.buf[4] == 12 &&
@@ -284,6 +295,9 @@ static void scsi_write_complete(void * opaque, int ret)
     }
 
     scsi_command_complete_noio(r, ret);
+
+done:
+    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 /* Write data to a scsi device.  Returns nonzero on failure.
diff --git a/thread-pool.c b/thread-pool.c
index 7c9cec5..ce6cd30 100644
--- a/thread-pool.c
+++ b/thread-pool.c
@@ -185,7 +185,9 @@ restart:
              */
             qemu_bh_schedule(pool->completion_bh);
 
+            aio_context_release(pool->ctx);
             elem->common.cb(elem->common.opaque, elem->ret);
+            aio_context_acquire(pool->ctx);
             qemu_aio_unref(elem);
             goto restart;
         } else {
@@ -269,7 +271,7 @@ static void thread_pool_co_cb(void *opaque, int ret)
     ThreadPoolCo *co = opaque;
 
     co->ret = ret;
-    qemu_coroutine_enter(co->co);
+    aio_co_wake(co->co);
 }
 
 int coroutine_fn thread_pool_submit_co(ThreadPool *pool, ThreadPoolFunc *func,
-- 
2.9.3
