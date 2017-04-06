Received: from eggs.gnu.org ([2001:4830:134:3::10]:46345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8Mm-0005tT-GF
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8Mj-0001uG-6K
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:26:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Apr 2017 22:25:27 +0800
Message-Id: <20170406142527.25835-6-famz@redhat.com>
In-Reply-To: <20170406142527.25835-1-famz@redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 5/5] coroutine: Explicitly specify
 AioContext when creating coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Coroutine in block layer should always be waken up in bs->aio_context
rather than the "current" context where it is entered. They differ when
the main loop is doing QMP tasks.

Race conditions happen without this patch, because the wrong context is
acquired in co_schedule_bh_cb, while the entered coroutine works on a
different one.

Make the block layer explicitly specify a desired context for each created
coroutine. For the rest, always use qemu_get_aio_context().

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                      |  9 +++++++-
 block/blkverify.c            |  4 ++--
 block/block-backend.c        |  4 ++--
 block/io.c                   | 14 ++++++-------
 block/nbd-client.c           |  2 +-
 block/quorum.c               |  6 +++---
 block/sheepdog.c             |  4 ++--
 blockjob.c                   |  2 +-
 hw/9pfs/9p.c                 |  4 ++--
 include/block/block.h        |  3 +++
 include/qemu/coroutine.h     |  3 ++-
 include/qemu/main-loop.h     |  2 +-
 migration/migration.c        |  3 ++-
 nbd/server.c                 |  6 ++++--
 qemu-img.c                   |  3 ++-
 qemu-io-cmds.c               |  3 ++-
 tests/test-aio-multithread.c | 12 +++++++----
 tests/test-coroutine.c       | 50 ++++++++++++++++++++++++++++++--------------
 tests/test-thread-pool.c     |  3 ++-
 util/qemu-coroutine.c        |  6 ++++--
 20 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/block.c b/block.c
index e70684a..d3598d5 100644
--- a/block.c
+++ b/block.c
@@ -357,7 +357,8 @@ int bdrv_create(BlockDriver *drv, const char* filename,
         /* Fast-path if already in coroutine context */
         bdrv_create_co_entry(&cco);
     } else {
-        co = qemu_coroutine_create(bdrv_create_co_entry, &cco);
+        co = qemu_coroutine_create(qemu_get_aio_context(),
+                                   bdrv_create_co_entry, &cco);
         qemu_coroutine_enter(co);
         while (cco.ret == NOT_DONE) {
             aio_poll(qemu_get_aio_context(), true);
@@ -4323,6 +4324,12 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs->aio_context;
 }
 
+Coroutine *bdrv_coroutine_create(BlockDriverState *bs,
+                                 CoroutineEntry *entry, void *opaque)
+{
+    return qemu_coroutine_create(bdrv_get_aio_context(bs), entry, opaque);
+}
+
 static void bdrv_do_remove_aio_context_notifier(BdrvAioNotifier *ban)
 {
     QLIST_REMOVE(ban, list);
diff --git a/block/blkverify.c b/block/blkverify.c
index 9a1e21c..df761cf 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -204,8 +204,8 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
         .request_fn = is_write ? bdrv_co_pwritev : bdrv_co_preadv,
     };
 
-    co_a = qemu_coroutine_create(blkverify_do_test_req, r);
-    co_b = qemu_coroutine_create(blkverify_do_raw_req, r);
+    co_a = bdrv_coroutine_create(bs, blkverify_do_test_req, r);
+    co_b = bdrv_coroutine_create(bs, blkverify_do_raw_req, r);
 
     qemu_coroutine_enter(co_a);
     qemu_coroutine_enter(co_b);
diff --git a/block/block-backend.c b/block/block-backend.c
index 0b63773..6a91514 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1006,7 +1006,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
         /* Fast-path if already in coroutine context */
         co_entry(&rwco);
     } else {
-        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
+        Coroutine *co = bdrv_coroutine_create(blk_bs(blk), co_entry, &rwco);
         qemu_coroutine_enter(co);
         BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
     }
@@ -1113,7 +1113,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     acb->bytes = bytes;
     acb->has_returned = false;
 
-    co = qemu_coroutine_create(co_entry, acb);
+    co = bdrv_coroutine_create(blk_bs(blk), co_entry, acb);
     qemu_coroutine_enter(co);
 
     acb->has_returned = true;
diff --git a/block/io.c b/block/io.c
index b9cfd18..41d7d7b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -620,7 +620,7 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
         /* Fast-path if already in coroutine context */
         bdrv_rw_co_entry(&rwco);
     } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
+        co = bdrv_coroutine_create(child->bs, bdrv_rw_co_entry, &rwco);
         qemu_coroutine_enter(co);
         BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
@@ -1876,7 +1876,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
         /* Fast-path if already in coroutine context */
         bdrv_get_block_status_above_co_entry(&data);
     } else {
-        co = qemu_coroutine_create(bdrv_get_block_status_above_co_entry,
+        co = bdrv_coroutine_create(bs, bdrv_get_block_status_above_co_entry,
                                    &data);
         qemu_coroutine_enter(co);
         BDRV_POLL_WHILE(bs, !data.done);
@@ -2002,7 +2002,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
             .is_read    = is_read,
             .ret        = -EINPROGRESS,
         };
-        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
+        Coroutine *co = bdrv_coroutine_create(bs, bdrv_co_rw_vmstate_entry, &data);
 
         qemu_coroutine_enter(co);
         while (data.ret == -EINPROGRESS) {
@@ -2220,7 +2220,7 @@ static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
     acb->req.flags = flags;
     acb->is_write = is_write;
 
-    co = qemu_coroutine_create(bdrv_co_do_rw, acb);
+    co = bdrv_coroutine_create(child->bs, bdrv_co_do_rw, acb);
     qemu_coroutine_enter(co);
 
     bdrv_co_maybe_schedule_bh(acb);
@@ -2251,7 +2251,7 @@ BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
     acb->need_bh = true;
     acb->req.error = -EINPROGRESS;
 
-    co = qemu_coroutine_create(bdrv_aio_flush_co_entry, acb);
+    co = bdrv_coroutine_create(bs, bdrv_aio_flush_co_entry, acb);
     qemu_coroutine_enter(co);
 
     bdrv_co_maybe_schedule_bh(acb);
@@ -2384,7 +2384,7 @@ int bdrv_flush(BlockDriverState *bs)
         /* Fast-path if already in coroutine context */
         bdrv_flush_co_entry(&flush_co);
     } else {
-        co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
+        co = bdrv_coroutine_create(bs, bdrv_flush_co_entry, &flush_co);
         qemu_coroutine_enter(co);
         BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
     }
@@ -2531,7 +2531,7 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int count)
         /* Fast-path if already in coroutine context */
         bdrv_pdiscard_co_entry(&rwco);
     } else {
-        co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
+        co = bdrv_coroutine_create(bs, bdrv_pdiscard_co_entry, &rwco);
         qemu_coroutine_enter(co);
         BDRV_POLL_WHILE(bs, rwco.ret == NOT_DONE);
     }
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e2952f..526e56b 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -421,7 +421,7 @@ int nbd_client_init(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
+    client->read_reply_co = bdrv_coroutine_create(bs, nbd_read_reply_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     logout("Established connection with NBD server\n");
diff --git a/block/quorum.c b/block/quorum.c
index 40205fb..b34e7eb 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -317,7 +317,7 @@ static bool quorum_rewrite_bad_versions(QuorumAIOCB *acb,
                 .idx = item->index,
             };
 
-            co = qemu_coroutine_create(quorum_rewrite_entry, &data);
+            co = bdrv_coroutine_create(acb->bs, quorum_rewrite_entry, &data);
             qemu_coroutine_enter(co);
         }
     }
@@ -625,7 +625,7 @@ static int read_quorum_children(QuorumAIOCB *acb)
             .idx = i,
         };
 
-        co = qemu_coroutine_create(read_quorum_children_entry, &data);
+        co = bdrv_coroutine_create(acb->bs, read_quorum_children_entry, &data);
         qemu_coroutine_enter(co);
     }
 
@@ -730,7 +730,7 @@ static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
             .idx = i,
         };
 
-        co = qemu_coroutine_create(write_quorum_entry, &data);
+        co = bdrv_coroutine_create(bs, write_quorum_entry, &data);
         qemu_coroutine_enter(co);
     }
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 1b71fc8..bb2feca 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -734,7 +734,7 @@ static int do_req(int sockfd, BlockDriverState *bs, SheepdogReq *hdr,
     if (qemu_in_coroutine()) {
         do_co_req(&srco);
     } else {
-        co = qemu_coroutine_create(do_co_req, &srco);
+        co = bdrv_coroutine_create(bs, do_co_req, &srco);
         if (bs) {
             qemu_coroutine_enter(co);
             BDRV_POLL_WHILE(bs, !srco.finished);
@@ -939,7 +939,7 @@ static void co_read_response(void *opaque)
     BDRVSheepdogState *s = opaque;
 
     if (!s->co_recv) {
-        s->co_recv = qemu_coroutine_create(aio_read_response, opaque);
+        s->co_recv = bdrv_coroutine_create(s->bs, aio_read_response, opaque);
     }
 
     aio_co_wake(s->co_recv);
diff --git a/blockjob.c b/blockjob.c
index 9b619f385..487920f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -286,7 +286,7 @@ void block_job_start(BlockJob *job)
 {
     assert(job && !block_job_started(job) && job->paused &&
            job->driver && job->driver->start);
-    job->co = qemu_coroutine_create(block_job_co_entry, job);
+    job->co = bdrv_coroutine_create(blk_bs(job->blk), block_job_co_entry, job);
     job->pause_count--;
     job->busy = true;
     job->paused = false;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c80ba67..5ad4bc7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3462,7 +3462,7 @@ void pdu_submit(V9fsPDU *pdu)
     if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
         handler = v9fs_fs_ro;
     }
-    co = qemu_coroutine_create(handler, pdu);
+    co = qemu_coroutine_create(qemu_get_aio_context(), handler, pdu);
     qemu_coroutine_enter(co);
 }
 
@@ -3595,7 +3595,7 @@ void v9fs_reset(V9fsState *s)
         aio_poll(qemu_get_aio_context(), true);
     }
 
-    co = qemu_coroutine_create(virtfs_co_reset, &data);
+    co = qemu_coroutine_create(qemu_get_aio_context(), virtfs_co_reset, &data);
     qemu_coroutine_enter(co);
 
     while (!data.done) {
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..5dc06bf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -555,6 +555,9 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
  */
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
+Coroutine *bdrv_coroutine_create(BlockDriverState *bs,
+                                 CoroutineEntry *entry, void *opaque);
+
 /**
  * bdrv_set_aio_context:
  *
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e60beaf..57ee53d 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -63,7 +63,8 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
  * Use qemu_coroutine_enter() to actually transfer control to the coroutine.
  * The opaque argument is passed as the argument to the entry point.
  */
-Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
+Coroutine *qemu_coroutine_create(AioContext *ctx,
+                                 CoroutineEntry *entry, void *opaque);
 
 /**
  * Transfer control to a coroutine
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index d7e24af..6680823 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -68,7 +68,7 @@ int qemu_init_main_loop(Error **errp);
  *     }
  *
  *     ...
- *     QEMUCoroutine *co = qemu_coroutine_create(coroutine_entry, NULL);
+ *     QEMUCoroutine *co = qemu_coroutine_create(ctx, coroutine_entry, NULL);
  *     QEMUBH *start_bh = qemu_bh_new(enter_co_bh, co);
  *     qemu_bh_schedule(start_bh);
  *     while (...) {
diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..7a9a1c6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -445,7 +445,8 @@ static void process_incoming_migration_co(void *opaque)
 
 void migration_fd_process_incoming(QEMUFile *f)
 {
-    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
+    Coroutine *co = qemu_coroutine_create(qemu_get_aio_context(),
+                                          process_incoming_migration_co, f);
 
     migrate_decompress_threads_create();
     qemu_file_set_blocking(f, false);
diff --git a/nbd/server.c b/nbd/server.c
index 924a1fe..ee639ab 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1363,7 +1363,8 @@ static void nbd_client_receive_next_request(NBDClient *client)
 {
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS) {
         nbd_client_get(client);
-        client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
+        client->recv_coroutine = qemu_coroutine_create(client->exp->ctx,
+                                                       nbd_trip, client);
         aio_co_schedule(client->exp->ctx, client->recv_coroutine);
     }
 }
@@ -1417,6 +1418,7 @@ void nbd_client_new(NBDExport *exp,
     client->close = close_fn;
 
     data->client = client;
-    data->co = qemu_coroutine_create(nbd_co_client_start, data);
+    data->co = qemu_coroutine_create(exp ? exp->ctx : qemu_get_aio_context(),
+                                     nbd_co_client_start, data);
     qemu_coroutine_enter(data->co);
 }
diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..9b3dd98 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1894,7 +1894,8 @@ static int convert_do_copy(ImgConvertState *s)
 
     qemu_co_mutex_init(&s->lock);
     for (i = 0; i < s->num_coroutines; i++) {
-        s->co[i] = qemu_coroutine_create(convert_co_do_copy, s);
+        s->co[i] = qemu_coroutine_create(qemu_get_aio_context(),
+                                         convert_co_do_copy, s);
         s->wait_sector_num[i] = -1;
         qemu_coroutine_enter(s->co[i]);
     }
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 883f53b..31944bb 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -520,7 +520,8 @@ static int do_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
         return -ERANGE;
     }
 
-    co = qemu_coroutine_create(co_pwrite_zeroes_entry, &data);
+    co = qemu_coroutine_create(qemu_get_aio_context(),
+                               co_pwrite_zeroes_entry, &data);
     qemu_coroutine_enter(co);
     while (!data.done) {
         aio_poll(blk_get_aio_context(blk), true);
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index 549d784..325dded 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -168,7 +168,8 @@ static void test_multi_co_schedule(int seconds)
 
     create_aio_contexts();
     for (i = 0; i < NUM_CONTEXTS; i++) {
-        Coroutine *co1 = qemu_coroutine_create(test_multi_co_schedule_entry, NULL);
+        Coroutine *co1 = qemu_coroutine_create(ctx[i],
+                                               test_multi_co_schedule_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
 
@@ -233,7 +234,8 @@ static void test_multi_co_mutex(int threads, int seconds)
     assert(threads <= NUM_CONTEXTS);
     running = threads;
     for (i = 0; i < threads; i++) {
-        Coroutine *co1 = qemu_coroutine_create(test_multi_co_mutex_entry, NULL);
+        Coroutine *co1 = qemu_coroutine_create(ctx[i],
+                                               test_multi_co_mutex_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
 
@@ -352,7 +354,8 @@ static void test_multi_fair_mutex(int threads, int seconds)
     assert(threads <= NUM_CONTEXTS);
     running = threads;
     for (i = 0; i < threads; i++) {
-        Coroutine *co1 = qemu_coroutine_create(test_multi_fair_mutex_entry, NULL);
+        Coroutine *co1 = qemu_coroutine_create(ctx[i],
+                                               test_multi_fair_mutex_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
 
@@ -408,7 +411,8 @@ static void test_multi_mutex(int threads, int seconds)
     assert(threads <= NUM_CONTEXTS);
     running = threads;
     for (i = 0; i < threads; i++) {
-        Coroutine *co1 = qemu_coroutine_create(test_multi_mutex_entry, NULL);
+        Coroutine *co1 = qemu_coroutine_create(ctx[i],
+                                               test_multi_mutex_entry, NULL);
         aio_co_schedule(ctx[i], co1);
     }
 
diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index abd97c2..12a6575 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/main-loop.h"
 
 /*
  * Check that qemu_in_coroutine() works
@@ -30,7 +31,8 @@ static void test_in_coroutine(void)
 
     g_assert(!qemu_in_coroutine());
 
-    coroutine = qemu_coroutine_create(verify_in_coroutine, NULL);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      verify_in_coroutine, NULL);
     qemu_coroutine_enter(coroutine);
 }
 
@@ -48,7 +50,8 @@ static void test_self(void)
 {
     Coroutine *coroutine;
 
-    coroutine = qemu_coroutine_create(verify_self, &coroutine);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      verify_self, &coroutine);
     qemu_coroutine_enter(coroutine);
 }
 
@@ -77,7 +80,8 @@ static void coroutine_fn verify_entered_step_1(void *opaque)
 
     g_assert(qemu_coroutine_entered(self));
 
-    coroutine = qemu_coroutine_create(verify_entered_step_2, self);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      verify_entered_step_2, self);
     g_assert(!qemu_coroutine_entered(coroutine));
     qemu_coroutine_enter(coroutine);
     g_assert(!qemu_coroutine_entered(coroutine));
@@ -88,7 +92,8 @@ static void test_entered(void)
 {
     Coroutine *coroutine;
 
-    coroutine = qemu_coroutine_create(verify_entered_step_1, NULL);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      verify_entered_step_1, NULL);
     g_assert(!qemu_coroutine_entered(coroutine));
     qemu_coroutine_enter(coroutine);
 }
@@ -112,7 +117,8 @@ static void coroutine_fn nest(void *opaque)
     if (nd->n_enter < nd->max) {
         Coroutine *child;
 
-        child = qemu_coroutine_create(nest, nd);
+        child = qemu_coroutine_create(qemu_get_aio_context(),
+                                      nest, nd);
         qemu_coroutine_enter(child);
     }
 
@@ -128,7 +134,8 @@ static void test_nesting(void)
         .max      = 128,
     };
 
-    root = qemu_coroutine_create(nest, &nd);
+    root = qemu_coroutine_create(qemu_get_aio_context(),
+                                 nest, &nd);
     qemu_coroutine_enter(root);
 
     /* Must enter and return from max nesting level */
@@ -157,7 +164,8 @@ static void test_yield(void)
     bool done = false;
     int i = -1; /* one extra time to return from coroutine */
 
-    coroutine = qemu_coroutine_create(yield_5_times, &done);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      yield_5_times, &done);
     while (!done) {
         qemu_coroutine_enter(coroutine);
         i++;
@@ -182,8 +190,11 @@ static void test_co_queue(void)
     Coroutine *c2;
     Coroutine tmp;
 
-    c2 = qemu_coroutine_create(c2_fn, NULL);
-    c1 = qemu_coroutine_create(c1_fn, c2);
+    qemu_init_main_loop(NULL);
+    c2 = qemu_coroutine_create(qemu_get_aio_context(),
+                               c2_fn, NULL);
+    c1 = qemu_coroutine_create(qemu_get_aio_context(),
+                               c1_fn, c2);
 
     qemu_coroutine_enter(c1);
 
@@ -213,13 +224,15 @@ static void test_lifecycle(void)
     bool done = false;
 
     /* Create, enter, and return from coroutine */
-    coroutine = qemu_coroutine_create(set_and_exit, &done);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      set_and_exit, &done);
     qemu_coroutine_enter(coroutine);
     g_assert(done); /* expect done to be true (first time) */
 
     /* Repeat to check that no state affects this test */
     done = false;
-    coroutine = qemu_coroutine_create(set_and_exit, &done);
+    coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                      set_and_exit, &done);
     qemu_coroutine_enter(coroutine);
     g_assert(done); /* expect done to be true (second time) */
 }
@@ -254,7 +267,8 @@ static void do_order_test(void)
 {
     Coroutine *co;
 
-    co = qemu_coroutine_create(co_order_test, NULL);
+    co = qemu_coroutine_create(qemu_get_aio_context(),
+                               co_order_test, NULL);
     record_push(1, 1);
     qemu_coroutine_enter(co);
     record_push(1, 2);
@@ -296,7 +310,8 @@ static void perf_lifecycle(void)
 
     g_test_timer_start();
     for (i = 0; i < max; i++) {
-        coroutine = qemu_coroutine_create(empty_coroutine, NULL);
+        coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                          empty_coroutine, NULL);
         qemu_coroutine_enter(coroutine);
     }
     duration = g_test_timer_elapsed();
@@ -320,7 +335,8 @@ static void perf_nesting(void)
             .n_return = 0,
             .max      = maxnesting,
         };
-        root = qemu_coroutine_create(nest, &nd);
+        root = qemu_coroutine_create(qemu_get_aio_context(),
+                                     nest, &nd);
         qemu_coroutine_enter(root);
     }
     duration = g_test_timer_elapsed();
@@ -350,7 +366,8 @@ static void perf_yield(void)
 
     maxcycles = 100000000;
     i = maxcycles;
-    Coroutine *coroutine = qemu_coroutine_create(yield_loop, &i);
+    Coroutine *coroutine = qemu_coroutine_create(qemu_get_aio_context(),
+                                                 yield_loop, &i);
 
     g_test_timer_start();
     while (i > 0) {
@@ -400,7 +417,8 @@ static void perf_cost(void)
 
     g_test_timer_start();
     while (i++ < maxcycles) {
-        co = qemu_coroutine_create(perf_cost_func, &i);
+        co = qemu_coroutine_create(qemu_get_aio_context(),
+                                   perf_cost_func, &i);
         qemu_coroutine_enter(co);
         qemu_coroutine_enter(co);
     }
diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
index 91b4ec5..86d993a 100644
--- a/tests/test-thread-pool.c
+++ b/tests/test-thread-pool.c
@@ -92,7 +92,8 @@ static void co_test_cb(void *opaque)
 static void test_submit_co(void)
 {
     WorkerTestData data;
-    Coroutine *co = qemu_coroutine_create(co_test_cb, &data);
+    Coroutine *co = qemu_coroutine_create(qemu_get_aio_context(),
+                                          co_test_cb, &data);
 
     qemu_coroutine_enter(co);
 
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 72412e5..690d5a4 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -43,7 +43,8 @@ static void coroutine_pool_cleanup(Notifier *n, void *value)
     }
 }
 
-Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
+Coroutine *qemu_coroutine_create(AioContext *ctx,
+                                 CoroutineEntry *entry, void *opaque)
 {
     Coroutine *co = NULL;
 
@@ -78,6 +79,7 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
 
     co->entry = entry;
     co->entry_arg = opaque;
+    co->ctx = ctx;
     QSIMPLEQ_INIT(&co->co_queue_wakeup);
     return co;
 }
@@ -107,6 +109,7 @@ void qemu_coroutine_enter(Coroutine *co)
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
 
+    assert(co->ctx);
     trace_qemu_coroutine_enter(self, co, co->entry_arg);
 
     if (co->caller) {
@@ -115,7 +118,6 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 
     co->caller = self;
-    co->ctx = qemu_get_current_aio_context();
 
     /* Store co->ctx before anything that stores co.  Matches
      * barrier in aio_co_wake and qemu_co_mutex_wake.
-- 
2.9.3
