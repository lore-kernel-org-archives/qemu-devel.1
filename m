Received: from eggs.gnu.org ([2001:4830:134:3::10]:45458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcI0-0003Ik-Pt
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHv-0003Fb-0J
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHu-0003F6-Ns
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:42 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D90E5C04BD20
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:18 +0100
Message-Id: <20170120164322.21851-14-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/17] block: explicitly acquire aiocontext in
 bottom halves that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/archipelago.c   |  3 +++
 block/blkdebug.c      |  9 +--------
 block/blkreplay.c     |  2 +-
 block/block-backend.c |  6 ++++++
 block/curl.c          | 26 ++++++++++++++++++--------
 block/gluster.c       |  9 +--------
 block/io.c            |  6 +++++-
 block/iscsi.c         |  6 +++++-
 block/linux-aio.c     | 15 +++++++++------
 block/nfs.c           |  3 ++-
 block/null.c          |  4 ++++
 block/qed.c           |  3 +++
 block/rbd.c           |  4 ++++
 dma-helpers.c         |  2 ++
 hw/block/virtio-blk.c |  2 ++
 hw/scsi/scsi-bus.c    |  2 ++
 util/async.c          |  4 ++--
 util/thread-pool.c    |  2 ++
 18 files changed, 72 insertions(+), 36 deletions(-)

diff --git a/block/archipelago.c b/block/archipelago.c
index 2449cfc..a624390 100644
--- a/block/archipelago.c
+++ b/block/archipelago.c
@@ -310,8 +310,11 @@ static void qemu_archipelago_complete_aio(void *opaque)
 {
     AIORequestData *reqdata = (AIORequestData *) opaque;
     ArchipelagoAIOCB *aio_cb = (ArchipelagoAIOCB *) reqdata->aio_cb;
+    AioContext *ctx = bdrv_get_aio_context(aio_cb->common.bs);
 
+    aio_context_acquire(ctx);
     aio_cb->common.cb(aio_cb->common.opaque, aio_cb->ret);
+    aio_context_release(ctx);
     aio_cb->status = 0;
 
     qemu_aio_unref(aio_cb);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index acccf85..259369d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -405,12 +405,6 @@ out:
     return ret;
 }
 
-static void error_callback_bh(void *opaque)
-{
-    Coroutine *co = opaque;
-    qemu_coroutine_enter(co);
-}
-
 static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -423,8 +417,7 @@ static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
     }
 
     if (!immediately) {
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), error_callback_bh,
-                                qemu_coroutine_self());
+        aio_co_schedule(bdrv_get_aio_context(bs), qemu_coroutine_self());
         qemu_coroutine_yield();
     }
 
diff --git a/block/blkreplay.c b/block/blkreplay.c
index a741654..cfc8c5b 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -60,7 +60,7 @@ static int64_t blkreplay_getlength(BlockDriverState *bs)
 static void blkreplay_bh_cb(void *opaque)
 {
     Request *req = opaque;
-    qemu_coroutine_enter(req->co);
+    aio_co_wake(req->co);
     qemu_bh_delete(req->bh);
     g_free(req);
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index 1177598..bfc0e6b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -939,9 +939,12 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
 static void error_callback_bh(void *opaque)
 {
     struct BlockBackendAIOCB *acb = opaque;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
 
     bdrv_dec_in_flight(acb->common.bs);
+    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, acb->ret);
+    aio_context_release(ctx);
     qemu_aio_unref(acb);
 }
 
@@ -983,9 +986,12 @@ static void blk_aio_complete(BlkAioEmAIOCB *acb)
 static void blk_aio_complete_bh(void *opaque)
 {
     BlkAioEmAIOCB *acb = opaque;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
 
     assert(acb->has_returned);
+    aio_context_acquire(ctx);
     blk_aio_complete(acb);
+    aio_context_release(ctx);
 }
 
 static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
diff --git a/block/curl.c b/block/curl.c
index 05b9ca3..f3f063b 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -796,13 +796,18 @@ static void curl_readv_bh_cb(void *p)
 {
     CURLState *state;
     int running;
+    int ret = -EINPROGRESS;
 
     CURLAIOCB *acb = p;
-    BDRVCURLState *s = acb->common.bs->opaque;
+    BlockDriverState *bs = acb->common.bs;
+    BDRVCURLState *s = bs->opaque;
+    AioContext *ctx = bdrv_get_aio_context(bs);
 
     size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
     size_t end;
 
+    aio_context_acquire(ctx);
+
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
     switch (curl_find_buf(s, start, acb->nb_sectors * BDRV_SECTOR_SIZE, acb)) {
@@ -810,7 +815,7 @@ static void curl_readv_bh_cb(void *p)
             qemu_aio_unref(acb);
             // fall through
         case FIND_RET_WAIT:
-            return;
+            goto out;
         default:
             break;
     }
@@ -818,9 +823,8 @@ static void curl_readv_bh_cb(void *p)
     // No cache found, so let's start a new request
     state = curl_init_state(acb->common.bs, s);
     if (!state) {
-        acb->common.cb(acb->common.opaque, -EIO);
-        qemu_aio_unref(acb);
-        return;
+        ret = -EIO;
+        goto out;
     }
 
     acb->start = 0;
@@ -834,9 +838,8 @@ static void curl_readv_bh_cb(void *p)
     state->orig_buf = g_try_malloc(state->buf_len);
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
-        acb->common.cb(acb->common.opaque, -ENOMEM);
-        qemu_aio_unref(acb);
-        return;
+        ret = -ENOMEM;
+        goto out;
     }
     state->acb[0] = acb;
 
@@ -849,6 +852,13 @@ static void curl_readv_bh_cb(void *p)
 
     /* Tell curl it needs to kick things off */
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
+
+out:
+    if (ret != -EINPROGRESS) {
+        acb->common.cb(acb->common.opaque, ret);
+        qemu_aio_unref(acb);
+    }
+    aio_context_release(ctx);
 }
 
 static BlockAIOCB *curl_aio_readv(BlockDriverState *bs,
diff --git a/block/gluster.c b/block/gluster.c
index 1a22f29..56b4abe 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -698,13 +698,6 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
     return qemu_gluster_glfs_init(gconf, errp);
 }
 
-static void qemu_gluster_complete_aio(void *opaque)
-{
-    GlusterAIOCB *acb = (GlusterAIOCB *)opaque;
-
-    qemu_coroutine_enter(acb->coroutine);
-}
-
 /*
  * AIO callback routine called from GlusterFS thread.
  */
@@ -720,7 +713,7 @@ static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret, void *arg)
         acb->ret = -EIO; /* Partial read/write - fail it */
     }
 
-    aio_bh_schedule_oneshot(acb->aio_context, qemu_gluster_complete_aio, acb);
+    aio_co_schedule(acb->aio_context, acb->coroutine);
 }
 
 static void qemu_gluster_parse_flags(int bdrv_flags, int *open_flags)
diff --git a/block/io.c b/block/io.c
index 76dfaf4..b7dc4f8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -189,7 +189,7 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     bdrv_dec_in_flight(bs);
     bdrv_drained_begin(bs);
     data->done = true;
-    qemu_coroutine_enter(co);
+    aio_co_wake(co);
 }
 
 static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
@@ -2147,9 +2147,13 @@ static void bdrv_co_complete(BlockAIOCBCoroutine *acb)
 static void bdrv_co_em_bh(void *opaque)
 {
     BlockAIOCBCoroutine *acb = opaque;
+    BlockDriverState *bs = acb->common.bs;
+    AioContext *ctx = bdrv_get_aio_context(bs);
 
     assert(!acb->need_bh);
+    aio_context_acquire(ctx);
     bdrv_co_complete(acb);
+    aio_context_release(ctx);
 }
 
 static void bdrv_co_maybe_schedule_bh(BlockAIOCBCoroutine *acb)
diff --git a/block/iscsi.c b/block/iscsi.c
index 54d1381..5de5d93 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -136,13 +136,16 @@ static void
 iscsi_bh_cb(void *p)
 {
     IscsiAIOCB *acb = p;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
 
     qemu_bh_delete(acb->bh);
 
     g_free(acb->buf);
     acb->buf = NULL;
 
+    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, acb->status);
+    aio_context_release(ctx);
 
     if (acb->task != NULL) {
         scsi_free_scsi_task(acb->task);
@@ -165,8 +168,9 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
 static void iscsi_co_generic_bh_cb(void *opaque)
 {
     struct IscsiTask *iTask = opaque;
+
     iTask->complete = 1;
-    qemu_coroutine_enter(iTask->co);
+    aio_co_wake(iTask->co);
 }
 
 static void iscsi_retry_timer_expired(void *opaque)
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 277c016..f7ae38a 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -54,10 +54,10 @@ struct LinuxAioState {
     io_context_t ctx;
     EventNotifier e;
 
-    /* io queue for submit at batch */
+    /* io queue for submit at batch.  Protected by AioContext lock. */
     LaioQueue io_q;
 
-    /* I/O completion processing */
+    /* I/O completion processing.  Only runs in I/O thread.  */
     QEMUBH *completion_bh;
     int event_idx;
     int event_max;
@@ -75,6 +75,7 @@ static inline ssize_t io_event_ret(struct io_event *ev)
  */
 static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
 {
+    LinuxAioState *s = laiocb->ctx;
     int ret;
 
     ret = laiocb->ret;
@@ -93,6 +94,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
     }
 
     laiocb->ret = ret;
+    aio_context_acquire(s->aio_context);
     if (laiocb->co) {
         /* If the coroutine is already entered it must be in ioq_submit() and
          * will notice laio->ret has been filled in when it eventually runs
@@ -106,6 +108,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
         laiocb->common.cb(laiocb->common.opaque, ret);
         qemu_aio_unref(laiocb);
     }
+    aio_context_release(s->aio_context);
 }
 
 /**
@@ -234,9 +237,12 @@ static void qemu_laio_process_completions(LinuxAioState *s)
 static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
 {
     qemu_laio_process_completions(s);
+
+    aio_context_acquire(s->aio_context);
     if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
         ioq_submit(s);
     }
+    aio_context_release(s->aio_context);
 }
 
 static void qemu_laio_completion_bh(void *opaque)
@@ -251,9 +257,7 @@ static void qemu_laio_completion_cb(EventNotifier *e)
     LinuxAioState *s = container_of(e, LinuxAioState, e);
 
     if (event_notifier_test_and_clear(&s->e)) {
-        aio_context_acquire(s->aio_context);
         qemu_laio_process_completions_and_submit(s);
-        aio_context_release(s->aio_context);
     }
 }
 
@@ -267,9 +271,7 @@ static bool qemu_laio_poll_cb(void *opaque)
         return false;
     }
 
-    aio_context_acquire(s->aio_context);
     qemu_laio_process_completions_and_submit(s);
-    aio_context_release(s->aio_context);
     return true;
 }
 
@@ -459,6 +461,7 @@ void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
 {
     aio_set_event_notifier(old_context, &s->e, false, NULL, NULL);
     qemu_bh_delete(s->completion_bh);
+    s->aio_context = NULL;
 }
 
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
diff --git a/block/nfs.c b/block/nfs.c
index 803faf9..32631bb 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -236,8 +236,9 @@ static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
 static void nfs_co_generic_bh_cb(void *opaque)
 {
     NFSRPC *task = opaque;
+
     task->complete = 1;
-    qemu_coroutine_enter(task->co);
+    aio_co_wake(task->co);
 }
 
 static void
diff --git a/block/null.c b/block/null.c
index 356209a..5eb2038 100644
--- a/block/null.c
+++ b/block/null.c
@@ -134,7 +134,11 @@ static const AIOCBInfo null_aiocb_info = {
 static void null_bh_cb(void *opaque)
 {
     NullAIOCB *acb = opaque;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
+
+    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, 0);
+    aio_context_release(ctx);
     qemu_aio_unref(acb);
 }
 
diff --git a/block/qed.c b/block/qed.c
index a21d025..db8295d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -942,6 +942,7 @@ static void qed_update_l2_table(BDRVQEDState *s, QEDTable *table, int index,
 static void qed_aio_complete_bh(void *opaque)
 {
     QEDAIOCB *acb = opaque;
+    BDRVQEDState *s = acb_to_s(acb);
     BlockCompletionFunc *cb = acb->common.cb;
     void *user_opaque = acb->common.opaque;
     int ret = acb->bh_ret;
@@ -949,7 +950,9 @@ static void qed_aio_complete_bh(void *opaque)
     qemu_aio_unref(acb);
 
     /* Invoke callback */
+    qed_acquire(s);
     cb(user_opaque, ret);
+    qed_release(s);
 }
 
 static void qed_aio_complete(QEDAIOCB *acb, int ret)
diff --git a/block/rbd.c b/block/rbd.c
index a57b3e3..2cb2cb4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -413,6 +413,7 @@ shutdown:
 static void qemu_rbd_complete_aio(RADOSCB *rcb)
 {
     RBDAIOCB *acb = rcb->acb;
+    AioContext *ctx = bdrv_get_aio_context(acb->common.bs);
     int64_t r;
 
     r = rcb->ret;
@@ -445,7 +446,10 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
         qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
     }
     qemu_vfree(acb->bounce);
+
+    aio_context_acquire(ctx);
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
+    aio_context_release(ctx);
 
     qemu_aio_unref(acb);
 }
diff --git a/dma-helpers.c b/dma-helpers.c
index 6f9d47c..39d4802 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -166,8 +166,10 @@ static void dma_blk_cb(void *opaque, int ret)
                                 QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
     }
 
+    aio_context_acquire(dbs->ctx);
     dbs->acb = dbs->io_func(dbs->offset, &dbs->iov,
                             dma_blk_cb, dbs, dbs->io_func_opaque);
+    aio_context_release(dbs->ctx);
     assert(dbs->acb);
 }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a00ee38..af652f3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -639,6 +639,7 @@ static void virtio_blk_dma_restart_bh(void *opaque)
 
     s->rq = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (req) {
         VirtIOBlockReq *next = req->next;
         if (virtio_blk_handle_request(req, &mrb)) {
@@ -659,6 +660,7 @@ static void virtio_blk_dma_restart_bh(void *opaque)
     if (mrb.num_reqs) {
         virtio_blk_submit_multireq(s->blk, &mrb);
     }
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
 static void virtio_blk_dma_restart_cb(void *opaque, int running,
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 297216d..dddeee3 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -105,6 +105,7 @@ static void scsi_dma_restart_bh(void *opaque)
     qemu_bh_delete(s->bh);
     s->bh = NULL;
 
+    aio_context_acquire(blk_get_aio_context(s->conf.blk));
     QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
         scsi_req_ref(req);
         if (req->retry) {
@@ -122,6 +123,7 @@ static void scsi_dma_restart_bh(void *opaque)
         }
         scsi_req_unref(req);
     }
+    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 void scsi_req_retry(SCSIRequest *req)
diff --git a/util/async.c b/util/async.c
index 8e65e4b..99b9d7e 100644
--- a/util/async.c
+++ b/util/async.c
@@ -114,9 +114,7 @@ int aio_bh_poll(AioContext *ctx)
                 ret = 1;
             }
             bh->idle = 0;
-            aio_context_acquire(ctx);
             aio_bh_call(bh);
-            aio_context_release(ctx);
         }
         if (bh->deleted) {
             deleted = true;
@@ -389,7 +387,9 @@ static void co_schedule_bh_cb(void *opaque)
         Coroutine *co = QSLIST_FIRST(&straight);
         QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
         trace_aio_co_schedule_bh_cb(ctx, co);
+        aio_context_acquire(ctx);
         qemu_coroutine_enter(co);
+        aio_context_release(ctx);
     }
 }
 
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 6fba913..7c9cec5 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -165,6 +165,7 @@ static void thread_pool_completion_bh(void *opaque)
     ThreadPool *pool = opaque;
     ThreadPoolElement *elem, *next;
 
+    aio_context_acquire(pool->ctx);
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
         if (elem->state != THREAD_DONE) {
@@ -191,6 +192,7 @@ restart:
             qemu_aio_unref(elem);
         }
     }
+    aio_context_release(pool->ctx);
 }
 
 static void thread_pool_cancel(BlockAIOCB *acb)
-- 
2.9.3
