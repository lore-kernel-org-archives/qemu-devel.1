Received: from eggs.gnu.org ([2001:4830:134:3::10]:53566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCt-0006mC-8v
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCs-0002QJ-00
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:16 +0200
Message-Id: <1497634636-20230-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 31/31] block: Remove
 bdrv_aio_readv/writev/flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

These functions are unused now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c            | 171 --------------------------------------------------
 block/trace-events    |   3 -
 include/block/block.h |   8 ---
 3 files changed, 182 deletions(-)

diff --git a/block/io.c b/block/io.c
index faca3fa..eab72b6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -34,14 +34,6 @@
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
-static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
-                                          int64_t offset,
-                                          QEMUIOVector *qiov,
-                                          BdrvRequestFlags flags,
-                                          BlockCompletionFunc *cb,
-                                          void *opaque,
-                                          bool is_write);
-static void coroutine_fn bdrv_co_do_rw(void *opaque);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int count, BdrvRequestFlags flags);
 
@@ -2075,28 +2067,6 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 /**************************************************************/
 /* async I/Os */
 
-BlockAIOCB *bdrv_aio_readv(BdrvChild *child, int64_t sector_num,
-                           QEMUIOVector *qiov, int nb_sectors,
-                           BlockCompletionFunc *cb, void *opaque)
-{
-    trace_bdrv_aio_readv(child->bs, sector_num, nb_sectors, opaque);
-
-    assert(nb_sectors << BDRV_SECTOR_BITS == qiov->size);
-    return bdrv_co_aio_prw_vector(child, sector_num << BDRV_SECTOR_BITS, qiov,
-                                  0, cb, opaque, false);
-}
-
-BlockAIOCB *bdrv_aio_writev(BdrvChild *child, int64_t sector_num,
-                            QEMUIOVector *qiov, int nb_sectors,
-                            BlockCompletionFunc *cb, void *opaque)
-{
-    trace_bdrv_aio_writev(child->bs, sector_num, nb_sectors, opaque);
-
-    assert(nb_sectors << BDRV_SECTOR_BITS == qiov->size);
-    return bdrv_co_aio_prw_vector(child, sector_num << BDRV_SECTOR_BITS, qiov,
-                                  0, cb, opaque, true);
-}
-
 void bdrv_aio_cancel(BlockAIOCB *acb)
 {
     qemu_aio_ref(acb);
@@ -2129,147 +2099,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 }
 
 /**************************************************************/
-/* async block device emulation */
-
-typedef struct BlockRequest {
-    union {
-        /* Used during read, write, trim */
-        struct {
-            int64_t offset;
-            int bytes;
-            int flags;
-            QEMUIOVector *qiov;
-        };
-        /* Used during ioctl */
-        struct {
-            int req;
-            void *buf;
-        };
-    };
-    BlockCompletionFunc *cb;
-    void *opaque;
-
-    int error;
-} BlockRequest;
-
-typedef struct BlockAIOCBCoroutine {
-    BlockAIOCB common;
-    BdrvChild *child;
-    BlockRequest req;
-    bool is_write;
-    bool need_bh;
-    bool *done;
-} BlockAIOCBCoroutine;
-
-static const AIOCBInfo bdrv_em_co_aiocb_info = {
-    .aiocb_size         = sizeof(BlockAIOCBCoroutine),
-};
-
-static void bdrv_co_complete(BlockAIOCBCoroutine *acb)
-{
-    if (!acb->need_bh) {
-        bdrv_dec_in_flight(acb->common.bs);
-        acb->common.cb(acb->common.opaque, acb->req.error);
-        qemu_aio_unref(acb);
-    }
-}
-
-static void bdrv_co_em_bh(void *opaque)
-{
-    BlockAIOCBCoroutine *acb = opaque;
-
-    assert(!acb->need_bh);
-    bdrv_co_complete(acb);
-}
-
-static void bdrv_co_maybe_schedule_bh(BlockAIOCBCoroutine *acb)
-{
-    acb->need_bh = false;
-    if (acb->req.error != -EINPROGRESS) {
-        BlockDriverState *bs = acb->common.bs;
-
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), bdrv_co_em_bh, acb);
-    }
-}
-
-/* Invoke bdrv_co_do_readv/bdrv_co_do_writev */
-static void coroutine_fn bdrv_co_do_rw(void *opaque)
-{
-    BlockAIOCBCoroutine *acb = opaque;
-
-    if (!acb->is_write) {
-        acb->req.error = bdrv_co_preadv(acb->child, acb->req.offset,
-            acb->req.qiov->size, acb->req.qiov, acb->req.flags);
-    } else {
-        acb->req.error = bdrv_co_pwritev(acb->child, acb->req.offset,
-            acb->req.qiov->size, acb->req.qiov, acb->req.flags);
-    }
-
-    bdrv_co_complete(acb);
-}
-
-static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
-                                          int64_t offset,
-                                          QEMUIOVector *qiov,
-                                          BdrvRequestFlags flags,
-                                          BlockCompletionFunc *cb,
-                                          void *opaque,
-                                          bool is_write)
-{
-    Coroutine *co;
-    BlockAIOCBCoroutine *acb;
-
-    /* Matched by bdrv_co_complete's bdrv_dec_in_flight.  */
-    bdrv_inc_in_flight(child->bs);
-
-    acb = qemu_aio_get(&bdrv_em_co_aiocb_info, child->bs, cb, opaque);
-    acb->child = child;
-    acb->need_bh = true;
-    acb->req.error = -EINPROGRESS;
-    acb->req.offset = offset;
-    acb->req.qiov = qiov;
-    acb->req.flags = flags;
-    acb->is_write = is_write;
-
-    co = qemu_coroutine_create(bdrv_co_do_rw, acb);
-    bdrv_coroutine_enter(child->bs, co);
-
-    bdrv_co_maybe_schedule_bh(acb);
-    return &acb->common;
-}
-
-static void coroutine_fn bdrv_aio_flush_co_entry(void *opaque)
-{
-    BlockAIOCBCoroutine *acb = opaque;
-    BlockDriverState *bs = acb->common.bs;
-
-    acb->req.error = bdrv_co_flush(bs);
-    bdrv_co_complete(acb);
-}
-
-BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
-        BlockCompletionFunc *cb, void *opaque)
-{
-    trace_bdrv_aio_flush(bs, opaque);
-
-    Coroutine *co;
-    BlockAIOCBCoroutine *acb;
-
-    /* Matched by bdrv_co_complete's bdrv_dec_in_flight.  */
-    bdrv_inc_in_flight(bs);
-
-    acb = qemu_aio_get(&bdrv_em_co_aiocb_info, bs, cb, opaque);
-    acb->need_bh = true;
-    acb->req.error = -EINPROGRESS;
-
-    co = qemu_coroutine_create(bdrv_aio_flush_co_entry, acb);
-    bdrv_coroutine_enter(bs, co);
-
-    bdrv_co_maybe_schedule_bh(acb);
-    return &acb->common;
-}
-
-/**************************************************************/
 /* Coroutine block device emulation */
 
 typedef struct FlushCo {
diff --git a/block/trace-events b/block/trace-events
index 9a71c7f..752de6a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -9,9 +9,6 @@ blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
 
 # block/io.c
-bdrv_aio_flush(void *bs, void *opaque) "bs %p opaque %p"
-bdrv_aio_readv(void *bs, int64_t sector_num, int nb_sectors, void *opaque) "bs %p sector_num %"PRId64" nb_sectors %d opaque %p"
-bdrv_aio_writev(void *bs, int64_t sector_num, int nb_sectors, void *opaque) "bs %p sector_num %"PRId64" nb_sectors %d opaque %p"
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e9..c2dc243 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -353,14 +353,6 @@ BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **errp);
 
 /* async block I/O */
-BlockAIOCB *bdrv_aio_readv(BdrvChild *child, int64_t sector_num,
-                           QEMUIOVector *iov, int nb_sectors,
-                           BlockCompletionFunc *cb, void *opaque);
-BlockAIOCB *bdrv_aio_writev(BdrvChild *child, int64_t sector_num,
-                            QEMUIOVector *iov, int nb_sectors,
-                            BlockCompletionFunc *cb, void *opaque);
-BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
-                           BlockCompletionFunc *cb, void *opaque);
 void bdrv_aio_cancel(BlockAIOCB *acb);
 void bdrv_aio_cancel_async(BlockAIOCB *acb);
 
-- 
1.8.3.1
