Received: from eggs.gnu.org ([2001:4830:134:3::10]:46361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNo7-0000Kt-N1
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNo4-0004uf-O6
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:55:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  7 Apr 2017 14:54:13 +0800
Message-Id: <20170407065414.9143-6-famz@redhat.com>
In-Reply-To: <20170407065414.9143-1-famz@redhat.com>
References: <20170407065414.9143-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] coroutine: Explicitly specify
 AioContext when entering coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Coroutine in block layer should always be waken up in bs->aio_context
rather than the "current" context where it is entered. They differ when
the main loop is doing QMP tasks.

Race conditions happen without this patch, because the wrong context is
acquired in co_schedule_bh_cb, while the entered coroutine works on a
different one:

  main loop                                iothread
-----------------------------------------------------------------------
  blockdev_snapshot
    aio_context_acquire(bs->ctx)
    bdrv_flush(bs)
      bdrv_co_flush(bs)
        ...
        qemu_coroutine_yield(co)
      BDRV_POLL_WHILE()
        aio_context_release(bs->ctx)
                                            aio_context_acquire(bs->ctx)
                                              ...
                                                aio_co_wake(co)
        aio_poll(qemu_aio_context)              ...
          co_schedule_bh_cb()                   ...
            qemu_coroutine_enter(co)            ...
              /* (A) bdrv_co_flush(bs)              /* (B) I/O on bs */
                      continues... */
                                            aio_context_release(bs->ctx)

Both (A) and (B) can access resources protected by bs->ctx, but (A) is
not thread-safe.

Make the block layer explicitly specify a desired context for the
entered coroutine. For the rest callers, stick to the old behavior,
qemu_get_aio_context() or qemu_get_current_aio_context().

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                    | 15 +++++++++++++--
 block/blkdebug.c           |  4 ++--
 block/blkverify.c          |  8 ++++----
 block/block-backend.c      |  4 ++--
 block/io.c                 | 14 +++++++-------
 block/mirror.c             |  2 +-
 block/quorum.c             | 16 ++++++++--------
 block/sheepdog.c           |  4 ++--
 blockjob.c                 |  4 ++--
 hw/9pfs/9p.c               |  4 ++--
 hw/9pfs/coth.c             |  4 ++--
 include/block/block.h      | 11 +++++++++++
 include/qemu/coroutine.h   | 11 ++++++-----
 include/qemu/main-loop.h   |  2 +-
 migration/colo.c           |  3 ++-
 migration/migration.c      |  2 +-
 nbd/server.c               |  5 +++--
 qemu-img.c                 |  4 ++--
 qemu-io-cmds.c             |  2 +-
 tests/test-coroutine.c     | 41 +++++++++++++++++++++--------------------
 tests/test-thread-pool.c   |  2 +-
 util/async.c               |  4 ++--
 util/qemu-coroutine-io.c   |  3 ++-
 util/qemu-coroutine-lock.c |  6 ++++--
 util/qemu-coroutine.c      | 10 +++++-----
 util/trace-events          |  2 +-
 26 files changed, 108 insertions(+), 79 deletions(-)

diff --git a/block.c b/block.c
index 512515a..6513484 100644
--- a/block.c
+++ b/block.c
@@ -357,10 +357,11 @@ int bdrv_create(BlockDriver *drv, const char* filename,
         /* Fast-path if already in coroutine context */
         bdrv_create_co_entry(&cco);
     } else {
+        AioContext *ctx = qemu_get_aio_context();
         co = qemu_coroutine_create(bdrv_create_co_entry, &cco);
-        qemu_coroutine_enter(co);
+        qemu_coroutine_enter(ctx, co);
         while (cco.ret == NOT_DONE) {
-            aio_poll(qemu_get_aio_context(), true);
+            aio_poll(ctx, true);
         }
     }
 
@@ -4324,6 +4325,16 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs->aio_context;
 }
 
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *coroutine)
+{
+    qemu_coroutine_enter(bdrv_get_aio_context(bs), coroutine);
+}
+
+void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co)
+{
+    qemu_coroutine_enter_if_inactive(bdrv_get_aio_context(bs), co);
+}
+
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     QLIST_REMOVE(ban, list);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 67e8024..2370f73 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -610,7 +610,7 @@ static int blkdebug_debug_resume(BlockDriverState *bs, const char *tag)
 
     QLIST_FOREACH_SAFE(r, &s->suspended_reqs, next, next) {
         if (!strcmp(r->tag, tag)) {
-            qemu_coroutine_enter(r->co);
+            bdrv_coroutine_enter(bs, r->co);
             return 0;
         }
     }
@@ -636,7 +636,7 @@ static int blkdebug_debug_remove_breakpoint(BlockDriverState *bs,
     }
     QLIST_FOREACH_SAFE(r, &s->suspended_reqs, next, r_next) {
         if (!strcmp(r->tag, tag)) {
-            qemu_coroutine_enter(r->co);
+            bdrv_coroutine_enter(bs, r->co);
             ret = 0;
         }
     }
diff --git a/block/blkverify.c b/block/blkverify.c
index 9a1e21c..c11a636 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -172,7 +172,7 @@ static void coroutine_fn blkverify_do_test_req(void *opaque)
     r->ret = r->request_fn(s->test_file, r->offset, r->bytes, r->qiov,
                            r->flags);
     r->done++;
-    qemu_coroutine_enter_if_inactive(r->co);
+    bdrv_coroutine_enter_if_inactive(r->bs, r->co);
 }
 
 static void coroutine_fn blkverify_do_raw_req(void *opaque)
@@ -182,7 +182,7 @@ static void coroutine_fn blkverify_do_raw_req(void *opaque)
     r->raw_ret = r->request_fn(r->bs->file, r->offset, r->bytes, r->raw_qiov,
                                r->flags);
     r->done++;
-    qemu_coroutine_enter_if_inactive(r->co);
+    bdrv_coroutine_enter_if_inactive(r->bs, r->co);
 }
 
 static int coroutine_fn
@@ -207,8 +207,8 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
     co_a = qemu_coroutine_create(blkverify_do_test_req, r);
     co_b = qemu_coroutine_create(blkverify_do_raw_req, r);
 
-    qemu_coroutine_enter(co_a);
-    qemu_coroutine_enter(co_b);
+    bdrv_coroutine_enter(bs, co_a);
+    bdrv_coroutine_enter(bs, co_b);
 
     while (r->done < 2) {
         qemu_coroutine_yield();
diff --git a/block/block-backend.c b/block/block-backend.c
index 0b63773..5eeaad1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1007,7 +1007,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
         co_entry(&rwco);
     } else {
         Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(blk_bs(blk), co);
         BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
     }
 
@@ -1114,7 +1114,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(blk_bs(blk), co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
diff --git a/block/io.c b/block/io.c
index 2709a70..30083a7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -616,7 +616,7 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
         bdrv_rw_co_entry(&rwco);
     } else {
         co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(child->bs, co);
         BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
     return rwco.ret;
@@ -1873,7 +1873,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
     } else {
         co = qemu_coroutine_create(bdrv_get_block_status_above_co_entry,
                                    &data);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
     return data.ret;
@@ -1999,7 +1999,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         };
         Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
 
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         while (data.ret == -EINPROGRESS) {
             aio_poll(bdrv_get_aio_context(bs), true);
         }
@@ -2216,7 +2216,7 @@ static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
     acb->is_write = is_write;
 
     co = qemu_coroutine_create(bdrv_co_do_rw, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(child->bs, co);
 
     bdrv_co_maybe_schedule_bh(acb);
     return &acb->common;
@@ -2247,7 +2247,7 @@ BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
     acb->req.error = -EINPROGRESS;
 
     co = qemu_coroutine_create(bdrv_aio_flush_co_entry, acb);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(bs, co);
 
     bdrv_co_maybe_schedule_bh(acb);
     return &acb->common;
@@ -2380,7 +2380,7 @@ int bdrv_flush(BlockDriverState *bs)
         bdrv_flush_co_entry(&flush_co);
     } else {
         co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
     }
 
@@ -2527,7 +2527,7 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int count)
         bdrv_pdiscard_co_entry(&rwco);
     } else {
         co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, rwco.ret == NOT_DONE);
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index e904fef..a68855c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -130,7 +130,7 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
     g_free(op);
 
     if (s->waiting_for_io) {
-        qemu_coroutine_enter(s->common.co);
+        bdrv_coroutine_enter(s->source, s->common.co);
     }
 }
 
diff --git a/block/quorum.c b/block/quorum.c
index 40205fb..4d42e4a 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -270,16 +270,16 @@ static void quorum_rewrite_entry(void *opaque)
     QuorumCo *co = opaque;
     QuorumAIOCB *acb = co->acb;
     BDRVQuorumState *s = acb->bs->opaque;
+    BdrvChild *child = s->children[co->idx];
 
     /* Ignore any errors, it's just a correction attempt for already
      * corrupted data. */
-    bdrv_co_pwritev(s->children[co->idx], acb->offset, acb->bytes,
-                    acb->qiov, 0);
+    bdrv_co_pwritev(child, acb->offset, acb->bytes, acb->qiov, 0);
 
     /* Wake up the caller after the last rewrite */
     acb->rewrite_count--;
     if (!acb->rewrite_count) {
-        qemu_coroutine_enter_if_inactive(acb->co);
+        bdrv_coroutine_enter_if_inactive(child->bs, acb->co);
     }
 }
 
@@ -318,7 +318,7 @@ static bool quorum_rewrite_bad_versions(QuorumAIOCB *acb,
             };
 
             co = qemu_coroutine_create(quorum_rewrite_entry, &data);
-            qemu_coroutine_enter(co);
+            bdrv_coroutine_enter(acb->bs, co);
         }
     }
 
@@ -602,7 +602,7 @@ static void read_quorum_children_entry(void *opaque)
 
     /* Wake up the caller after the last read */
     if (acb->count == s->num_children) {
-        qemu_coroutine_enter_if_inactive(acb->co);
+        bdrv_coroutine_enter_if_inactive(sacb->bs, acb->co);
     }
 }
 
@@ -626,7 +626,7 @@ static int read_quorum_children(QuorumAIOCB *acb)
         };
 
         co = qemu_coroutine_create(read_quorum_children_entry, &data);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(acb->bs, co);
     }
 
     while (acb->count < s->num_children) {
@@ -712,7 +712,7 @@ static void write_quorum_entry(void *opaque)
 
     /* Wake up the caller after the last write */
     if (acb->count == s->num_children) {
-        qemu_coroutine_enter_if_inactive(acb->co);
+        bdrv_coroutine_enter_if_inactive(sacb->bs, acb->co);
     }
 }
 
@@ -731,7 +731,7 @@ static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
         };
 
         co = qemu_coroutine_create(write_quorum_entry, &data);
-        qemu_coroutine_enter(co);
+        bdrv_coroutine_enter(bs, co);
     }
 
     while (acb->count < s->num_children) {
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 1b71fc8..ac6d32a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -736,10 +736,10 @@ static int do_req(int sockfd, BlockDriverState *bs, SheepdogReq *hdr,
     } else {
         co = qemu_coroutine_create(do_co_req, &srco);
         if (bs) {
-            qemu_coroutine_enter(co);
+            bdrv_coroutine_enter(bs, co);
             BDRV_POLL_WHILE(bs, !srco.finished);
         } else {
-            qemu_coroutine_enter(co);
+            bdrv_coroutine_enter(bs, co);
             while (!srco.finished) {
                 aio_poll(qemu_get_aio_context(), true);
             }
diff --git a/blockjob.c b/blockjob.c
index 9b619f385..6e48932 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -290,7 +290,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
-    qemu_coroutine_enter(job->co);
+    bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
 void block_job_ref(BlockJob *job)
@@ -532,7 +532,7 @@ void block_job_user_resume(BlockJob *job)
 void block_job_enter(BlockJob *job)
 {
     if (job->co && !job->busy) {
-        qemu_coroutine_enter(job->co);
+        bdrv_coroutine_enter(blk_bs(job->blk), job->co);
     }
 }
 
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c80ba67..af4acb4 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3463,7 +3463,7 @@ void pdu_submit(V9fsPDU *pdu)
         handler = v9fs_fs_ro;
     }
     co = qemu_coroutine_create(handler, pdu);
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
 }
 
 /* Returns 0 on success, 1 on failure. */
@@ -3596,7 +3596,7 @@ void v9fs_reset(V9fsState *s)
     }
 
     co = qemu_coroutine_create(virtfs_co_reset, &data);
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
 
     while (!data.done) {
         aio_poll(qemu_get_aio_context(), true);
diff --git a/hw/9pfs/coth.c b/hw/9pfs/coth.c
index 89018de..70e2667 100644
--- a/hw/9pfs/coth.c
+++ b/hw/9pfs/coth.c
@@ -22,14 +22,14 @@
 static void coroutine_enter_cb(void *opaque, int ret)
 {
     Coroutine *co = opaque;
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
 }
 
 /* Called from worker thread.  */
 static int coroutine_enter_func(void *arg)
 {
     Coroutine *co = arg;
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
     return 0;
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..00db53f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -556,6 +556,17 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
 /**
+ * Transfer control to @co in the aio context of @bs
+ */
+void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co);
+
+/**
+ * Transfer control to @co in the aio context of @bs if it's not active (i.e.
+ * part of the call stack of the running coroutine). Otherwise, do nothing.
+ */
+void bdrv_coroutine_enter_if_inactive(BlockDriverState *bs, Coroutine *co);
+
+/**
  * bdrv_set_aio_context:
  *
  * Changes the #AioContext used for fd handlers, timers, and BHs by this
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e60beaf..77f2de1 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -66,15 +66,16 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
 Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
 
 /**
- * Transfer control to a coroutine
+ * Transfer control to a coroutine and associate it to @ctx
  */
-void qemu_coroutine_enter(Coroutine *coroutine);
+void qemu_coroutine_enter(AioContext *ctx, Coroutine *coroutine);
 
 /**
- * Transfer control to a coroutine if it's not active (i.e. part of the call
- * stack of the running coroutine). Otherwise, do nothing.
+ * Transfer control to a coroutine and associate it to @ctx, if it's not active
+ * (i.e. part of the call stack of the running coroutine). Otherwise, do
+ * nothing.
  */
-void qemu_coroutine_enter_if_inactive(Coroutine *co);
+void qemu_coroutine_enter_if_inactive(AioContext *ctx, Coroutine *co);
 
 /**
  * Transfer control back to a coroutine's caller
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index d7e24af..8a19e10 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -64,7 +64,7 @@ int qemu_init_main_loop(Error **errp);
  *
  *     void enter_co_bh(void *opaque) {
  *         QEMUCoroutine *co = opaque;
- *         qemu_coroutine_enter(co);
+ *         qemu_coroutine_enter(ctx, co);
  *     }
  *
  *     ...
diff --git a/migration/colo.c b/migration/colo.c
index c19eb3f..7167ce7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -100,7 +100,8 @@ static void secondary_vm_do_failover(void)
     qemu_sem_post(&mis->colo_incoming_sem);
     /* For Secondary VM, jump to incoming co */
     if (mis->migration_incoming_co) {
-        qemu_coroutine_enter(mis->migration_incoming_co);
+        qemu_coroutine_enter(qemu_get_aio_context(),
+                             mis->migration_incoming_co);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..82ed7e4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -449,7 +449,7 @@ void migration_fd_process_incoming(QEMUFile *f)
 
     migrate_decompress_threads_create();
     qemu_file_set_blocking(f, false);
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
 }
 
 
diff --git a/nbd/server.c b/nbd/server.c
index 924a1fe..a2635d2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -108,7 +108,7 @@ static gboolean nbd_negotiate_continue(QIOChannel *ioc,
                                        GIOCondition condition,
                                        void *opaque)
 {
-    qemu_coroutine_enter(opaque);
+    qemu_coroutine_enter(ioc->ctx, opaque);
     return TRUE;
 }
 
@@ -1418,5 +1418,6 @@ void nbd_client_new(NBDExport *exp,
 
     data->client = client;
     data->co = qemu_coroutine_create(nbd_co_client_start, data);
-    qemu_coroutine_enter(data->co);
+    qemu_coroutine_enter(exp ? exp->ctx : qemu_get_aio_context(),
+                         data->co);
 }
diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..ffb09f7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1830,7 +1830,7 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
                      * s->wait_sector_num[i] == -1 during A -> B.  Therefore
                      * B will never enter A during this time window.
                      */
-                    qemu_coroutine_enter(s->co[i]);
+                    qemu_coroutine_enter(qemu_get_aio_context(), s->co[i]);
                     break;
                 }
             }
@@ -1896,7 +1896,7 @@ static int convert_do_copy(ImgConvertState *s)
     for (i = 0; i < s->num_coroutines; i++) {
         s->co[i] = qemu_coroutine_create(convert_co_do_copy, s);
         s->wait_sector_num[i] = -1;
-        qemu_coroutine_enter(s->co[i]);
+        qemu_coroutine_enter(qemu_get_aio_context(), s->co[i]);
     }
 
     while (s->ret == -EINPROGRESS) {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 883f53b..312fc6d 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -521,7 +521,7 @@ static int do_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
     }
 
     co = qemu_coroutine_create(co_pwrite_zeroes_entry, &data);
-    qemu_coroutine_enter(co);
+    bdrv_coroutine_enter(blk_bs(blk), co);
     while (!data.done) {
         aio_poll(blk_get_aio_context(blk), true);
     }
diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index abd97c2..64f2563 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/main-loop.h"
 
 /*
  * Check that qemu_in_coroutine() works
@@ -31,7 +32,7 @@ static void test_in_coroutine(void)
     g_assert(!qemu_in_coroutine());
 
     coroutine = qemu_coroutine_create(verify_in_coroutine, NULL);
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
 }
 
 /*
@@ -49,7 +50,7 @@ static void test_self(void)
     Coroutine *coroutine;
 
     coroutine = qemu_coroutine_create(verify_self, &coroutine);
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
 }
 
 /*
@@ -79,9 +80,9 @@ static void coroutine_fn verify_entered_step_1(void *opaque)
 
     coroutine = qemu_coroutine_create(verify_entered_step_2, self);
     g_assert(!qemu_coroutine_entered(coroutine));
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
     g_assert(!qemu_coroutine_entered(coroutine));
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
 }
 
 static void test_entered(void)
@@ -90,7 +91,7 @@ static void test_entered(void)
 
     coroutine = qemu_coroutine_create(verify_entered_step_1, NULL);
     g_assert(!qemu_coroutine_entered(coroutine));
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
 }
 
 /*
@@ -113,7 +114,7 @@ static void coroutine_fn nest(void *opaque)
         Coroutine *child;
 
         child = qemu_coroutine_create(nest, nd);
-        qemu_coroutine_enter(child);
+        qemu_coroutine_enter(qemu_get_aio_context(), child);
     }
 
     nd->n_return++;
@@ -129,7 +130,7 @@ static void test_nesting(void)
     };
 
     root = qemu_coroutine_create(nest, &nd);
-    qemu_coroutine_enter(root);
+    qemu_coroutine_enter(qemu_get_aio_context(), root);
 
     /* Must enter and return from max nesting level */
     g_assert_cmpint(nd.n_enter, ==, nd.max);
@@ -159,7 +160,7 @@ static void test_yield(void)
 
     coroutine = qemu_coroutine_create(yield_5_times, &done);
     while (!done) {
-        qemu_coroutine_enter(coroutine);
+        qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
         i++;
     }
     g_assert_cmpint(i, ==, 5); /* coroutine must yield 5 times */
@@ -173,7 +174,7 @@ static void coroutine_fn c2_fn(void *opaque)
 static void coroutine_fn c1_fn(void *opaque)
 {
     Coroutine *c2 = opaque;
-    qemu_coroutine_enter(c2);
+    qemu_coroutine_enter(qemu_get_aio_context(), c2);
 }
 
 static void test_co_queue(void)
@@ -185,12 +186,12 @@ static void test_co_queue(void)
     c2 = qemu_coroutine_create(c2_fn, NULL);
     c1 = qemu_coroutine_create(c1_fn, c2);
 
-    qemu_coroutine_enter(c1);
+    qemu_coroutine_enter(qemu_get_aio_context(), c1);
 
     /* c1 shouldn't be used any more now; make sure we segfault if it is */
     tmp = *c1;
     memset(c1, 0xff, sizeof(Coroutine));
-    qemu_coroutine_enter(c2);
+    qemu_coroutine_enter(qemu_get_aio_context(), c2);
 
     /* Must restore the coroutine now to avoid corrupted pool */
     *c1 = tmp;
@@ -214,13 +215,13 @@ static void test_lifecycle(void)
 
     /* Create, enter, and return from coroutine */
     coroutine = qemu_coroutine_create(set_and_exit, &done);
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
     g_assert(done); /* expect done to be true (first time) */
 
     /* Repeat to check that no state affects this test */
     done = false;
     coroutine = qemu_coroutine_create(set_and_exit, &done);
-    qemu_coroutine_enter(coroutine);
+    qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
     g_assert(done); /* expect done to be true (second time) */
 }
 
@@ -256,10 +257,10 @@ static void do_order_test(void)
 
     co = qemu_coroutine_create(co_order_test, NULL);
     record_push(1, 1);
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
     record_push(1, 2);
     g_assert(!qemu_in_coroutine());
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
     record_push(1, 3);
     g_assert(!qemu_in_coroutine());
 }
@@ -297,7 +298,7 @@ static void perf_lifecycle(void)
     g_test_timer_start();
     for (i = 0; i < max; i++) {
         coroutine = qemu_coroutine_create(empty_coroutine, NULL);
-        qemu_coroutine_enter(coroutine);
+        qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
     }
     duration = g_test_timer_elapsed();
 
@@ -321,7 +322,7 @@ static void perf_nesting(void)
             .max      = maxnesting,
         };
         root = qemu_coroutine_create(nest, &nd);
-        qemu_coroutine_enter(root);
+        qemu_coroutine_enter(qemu_get_aio_context(), root);
     }
     duration = g_test_timer_elapsed();
 
@@ -354,7 +355,7 @@ static void perf_yield(void)
 
     g_test_timer_start();
     while (i > 0) {
-        qemu_coroutine_enter(coroutine);
+        qemu_coroutine_enter(qemu_get_aio_context(), coroutine);
     }
     duration = g_test_timer_elapsed();
 
@@ -401,8 +402,8 @@ static void perf_cost(void)
     g_test_timer_start();
     while (i++ < maxcycles) {
         co = qemu_coroutine_create(perf_cost_func, &i);
-        qemu_coroutine_enter(co);
-        qemu_coroutine_enter(co);
+        qemu_coroutine_enter(qemu_get_aio_context(), co);
+        qemu_coroutine_enter(qemu_get_aio_context(), co);
     }
     duration = g_test_timer_elapsed();
     ops = (long)(maxcycles / (duration * 1000));
diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
index 91b4ec5..ba4fee4 100644
--- a/tests/test-thread-pool.c
+++ b/tests/test-thread-pool.c
@@ -94,7 +94,7 @@ static void test_submit_co(void)
     WorkerTestData data;
     Coroutine *co = qemu_coroutine_create(co_test_cb, &data);
 
-    qemu_coroutine_enter(co);
+    qemu_coroutine_enter(qemu_get_aio_context(), co);
 
     /* Back here once the worker has started.  */
 
diff --git a/util/async.c b/util/async.c
index 663e297..3289a36 100644
--- a/util/async.c
+++ b/util/async.c
@@ -388,7 +388,7 @@ static void co_schedule_bh_cb(void *opaque)
         QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
         trace_aio_co_schedule_bh_cb(ctx, co);
         aio_context_acquire(ctx);
-        qemu_coroutine_enter(co);
+        qemu_coroutine_enter(ctx, co);
         aio_context_release(ctx);
     }
 }
@@ -464,7 +464,7 @@ void aio_co_wake(struct Coroutine *co)
         QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
     } else {
         aio_context_acquire(ctx);
-        qemu_coroutine_enter(co);
+        qemu_coroutine_enter(ctx, co);
         aio_context_release(ctx);
     }
 }
diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 44a8969..26818af 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -75,7 +75,8 @@ static void fd_coroutine_enter(void *opaque)
 {
     FDYieldUntilData *data = opaque;
     qemu_set_fd_handler(data->fd, NULL, NULL, NULL);
-    qemu_coroutine_enter(data->co);
+    /* XXX: do we need an explicit ctx? */
+    qemu_coroutine_enter(qemu_get_current_aio_context(), data->co);
 }
 
 void coroutine_fn yield_until_fd_readable(int fd)
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 6328eed..42c18d8 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -81,7 +81,8 @@ void qemu_co_queue_run_restart(Coroutine *co)
     trace_qemu_co_queue_run_restart(co);
     while ((next = QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
         QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
-        qemu_coroutine_enter(next);
+        assert(next->ctx);
+        qemu_coroutine_enter(next->ctx, next);
     }
 }
 
@@ -125,7 +126,8 @@ bool qemu_co_enter_next(CoQueue *queue)
     }
 
     QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
-    qemu_coroutine_enter(next);
+    assert(next->ctx);
+    qemu_coroutine_enter(next->ctx, next);
     return true;
 }
 
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 72412e5..47329a0 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -102,12 +102,12 @@ static void coroutine_delete(Coroutine *co)
     qemu_coroutine_delete(co);
 }
 
-void qemu_coroutine_enter(Coroutine *co)
+void qemu_coroutine_enter(AioContext *ctx, Coroutine *co)
 {
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
 
-    trace_qemu_coroutine_enter(self, co, co->entry_arg);
+    trace_qemu_coroutine_enter(self, ctx, co, co->entry_arg);
 
     if (co->caller) {
         fprintf(stderr, "Co-routine re-entered recursively\n");
@@ -115,7 +115,7 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 
     co->caller = self;
-    co->ctx = qemu_get_current_aio_context();
+    co->ctx = ctx;
 
     /* Store co->ctx before anything that stores co.  Matches
      * barrier in aio_co_wake and qemu_co_mutex_wake.
@@ -139,10 +139,10 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 }
 
-void qemu_coroutine_enter_if_inactive(Coroutine *co)
+void qemu_coroutine_enter_if_inactive(AioContext *ctx, Coroutine *co)
 {
     if (!qemu_coroutine_entered(co)) {
-        qemu_coroutine_enter(co);
+        qemu_coroutine_enter(ctx, co);
     }
 }
 
diff --git a/util/trace-events b/util/trace-events
index ac27d94..d3c39a6 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -22,7 +22,7 @@ buffer_move(const char *buf, size_t len, const char *from) "%s: %zd bytes from %
 buffer_free(const char *buf, size_t len) "%s: capacity %zd"
 
 # util/qemu-coroutine.c
-qemu_coroutine_enter(void *from, void *to, void *opaque) "from %p to %p opaque %p"
+qemu_coroutine_enter(void *ctx, void *from, void *to, void *opaque) "ctx %p from %p to %p opaque %p"
 qemu_coroutine_yield(void *from, void *to) "from %p to %p"
 qemu_coroutine_terminate(void *co) "self %p"
 
-- 
2.9.3
