Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGzs-0007r5-Dx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGzo-0007LS-Jv
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:18:28 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:12882)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJGzn-0007LE-QJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:18:24 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri,  9 Jun 2017 13:18:08 +0300
Message-Id: <20170609101808.13506-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

Change the 'int count' parameter in *pwrite_zeros, *pdiscard related
functions (and some others) to 'int bytes', as they both refer to bytes.
This helps with code legibility.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/blkdebug.c               | 36 +++++++++++++++----------------
 block/blkreplay.c              |  8 +++----
 block/block-backend.c          | 22 +++++++++----------
 block/file-posix.c             | 34 +++++++++++++++---------------
 block/io.c                     | 48 +++++++++++++++++++++---------------------
 block/iscsi.c                  | 20 +++++++++---------
 block/mirror.c                 |  8 +++----
 block/nbd-client.c             |  8 +++----
 block/nbd-client.h             |  4 ++--
 block/qcow2.c                  | 28 ++++++++++++------------
 block/qed.c                    |  8 +++----
 block/raw-format.c             |  8 +++----
 block/rbd.c                    |  4 ++--
 block/sheepdog.c               |  6 +++---
 include/block/block.h          |  8 +++----
 include/block/block_int.h      |  6 +++---
 include/sysemu/block-backend.h | 20 +++++++++---------
 qemu-io-cmds.c                 | 46 ++++++++++++++++++++--------------------
 18 files changed, 161 insertions(+), 161 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e8..8bab3ac 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -576,7 +576,7 @@ static int blkdebug_co_flush(BlockDriverState *bs)
 }
 
 static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int count,
+                                                  int64_t offset, int bytes,
                                                   BdrvRequestFlags flags)
 {
     uint32_t align = MAX(bs->bl.request_alignment,
@@ -587,29 +587,29 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
      * preferred alignment (so that we test the fallback to writes on
      * unaligned portions), and check that the block layer never hands
      * us anything unaligned that crosses an alignment boundary.  */
-    if (count < align) {
+    if (bytes < align) {
         assert(QEMU_IS_ALIGNED(offset, align) ||
-               QEMU_IS_ALIGNED(offset + count, align) ||
+               QEMU_IS_ALIGNED(offset + bytes, align) ||
                DIV_ROUND_UP(offset, align) ==
-               DIV_ROUND_UP(offset + count, align));
+               DIV_ROUND_UP(offset + bytes, align));
         return -ENOTSUP;
     }
     assert(QEMU_IS_ALIGNED(offset, align));
-    assert(QEMU_IS_ALIGNED(count, align));
+    assert(QEMU_IS_ALIGNED(bytes, align));
     if (bs->bl.max_pwrite_zeroes) {
-        assert(count <= bs->bl.max_pwrite_zeroes);
+        assert(bytes <= bs->bl.max_pwrite_zeroes);
     }
 
-    err = rule_check(bs, offset, count);
+    err = rule_check(bs, offset, bytes);
     if (err) {
         return err;
     }
 
-    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
 
 static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
-                                             int64_t offset, int count)
+                                             int64_t offset, int bytes)
 {
     uint32_t align = bs->bl.pdiscard_alignment;
     int err;
@@ -617,29 +617,29 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     /* Only pass through requests that are larger than requested
      * minimum alignment, and ensure that unaligned requests do not
      * cross optimum discard boundaries. */
-    if (count < bs->bl.request_alignment) {
+    if (bytes < bs->bl.request_alignment) {
         assert(QEMU_IS_ALIGNED(offset, align) ||
-               QEMU_IS_ALIGNED(offset + count, align) ||
+               QEMU_IS_ALIGNED(offset + bytes, align) ||
                DIV_ROUND_UP(offset, align) ==
-               DIV_ROUND_UP(offset + count, align));
+               DIV_ROUND_UP(offset + bytes, align));
         return -ENOTSUP;
     }
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
-    assert(QEMU_IS_ALIGNED(count, bs->bl.request_alignment));
-    if (align && count >= align) {
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+    if (align && bytes >= align) {
         assert(QEMU_IS_ALIGNED(offset, align));
-        assert(QEMU_IS_ALIGNED(count, align));
+        assert(QEMU_IS_ALIGNED(bytes, align));
     }
     if (bs->bl.max_pdiscard) {
-        assert(count <= bs->bl.max_pdiscard);
+        assert(bytes <= bs->bl.max_pdiscard);
     }
 
-    err = rule_check(bs, offset, count);
+    err = rule_check(bs, offset, bytes);
     if (err) {
         return err;
     }
 
-    return bdrv_co_pdiscard(bs->file->bs, offset, count);
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
 static void blkdebug_close(BlockDriverState *bs)
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 6aa5fd4..61e44a1 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -96,10 +96,10 @@ static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags)
+    int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     uint64_t reqid = blkreplay_next_id();
-    int ret = bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
+    int ret = bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
     block_request_create(reqid, bs, qemu_coroutine_self());
     qemu_coroutine_yield();
 
@@ -107,10 +107,10 @@ static int coroutine_fn blkreplay_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pdiscard(BlockDriverState *bs,
-                                              int64_t offset, int count)
+                                              int64_t offset, int bytes)
 {
     uint64_t reqid = blkreplay_next_id();
-    int ret = bdrv_co_pdiscard(bs->file->bs, offset, count);
+    int ret = bdrv_co_pdiscard(bs->file->bs, offset, bytes);
     block_request_create(reqid, bs, qemu_coroutine_self());
     qemu_coroutine_yield();
 
diff --git a/block/block-backend.c b/block/block-backend.c
index f3a6008..dcd7e43 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1097,9 +1097,9 @@ int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
 }
 
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int count, BdrvRequestFlags flags)
+                      int bytes, BdrvRequestFlags flags)
 {
-    return blk_prw(blk, offset, NULL, count, blk_write_entry,
+    return blk_prw(blk, offset, NULL, bytes, blk_write_entry,
                    flags | BDRV_REQ_ZERO_WRITE);
 }
 
@@ -1309,10 +1309,10 @@ static void blk_aio_pdiscard_entry(void *opaque)
 }
 
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
-                             int64_t offset, int count,
+                             int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, count, NULL, blk_aio_pdiscard_entry, 0,
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, 0,
                         cb, opaque);
 }
 
@@ -1372,14 +1372,14 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
     return blk_aio_prwv(blk, req, 0, &qiov, blk_aio_ioctl_entry, 0, cb, opaque);
 }
 
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int count)
+int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
-    int ret = blk_check_byte_request(blk, offset, count);
+    int ret = blk_check_byte_request(blk, offset, bytes);
     if (ret < 0) {
         return ret;
     }
 
-    return bdrv_co_pdiscard(blk_bs(blk), offset, count);
+    return bdrv_co_pdiscard(blk_bs(blk), offset, bytes);
 }
 
 int blk_co_flush(BlockBackend *blk)
@@ -1758,9 +1758,9 @@ void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
 }
 
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int count, BdrvRequestFlags flags)
+                                      int bytes, BdrvRequestFlags flags)
 {
-    return blk_co_pwritev(blk, offset, count, NULL,
+    return blk_co_pwritev(blk, offset, bytes, NULL,
                           flags | BDRV_REQ_ZERO_WRITE);
 }
 
@@ -1787,9 +1787,9 @@ static void blk_pdiscard_entry(void *opaque)
     rwco->ret = blk_co_pdiscard(rwco->blk, rwco->offset, rwco->qiov->size);
 }
 
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int count)
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
-    return blk_prw(blk, offset, NULL, count, blk_pdiscard_entry, 0);
+    return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
 
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
diff --git a/block/file-posix.c b/block/file-posix.c
index de2d3a2..3927fab 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1485,7 +1485,7 @@ static int aio_worker(void *arg)
 
 static int paio_submit_co(BlockDriverState *bs, int fd,
                           int64_t offset, QEMUIOVector *qiov,
-                          int count, int type)
+                          int bytes, int type)
 {
     RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
     ThreadPool *pool;
@@ -1494,22 +1494,22 @@ static int paio_submit_co(BlockDriverState *bs, int fd,
     acb->aio_type = type;
     acb->aio_fildes = fd;
 
-    acb->aio_nbytes = count;
+    acb->aio_nbytes = bytes;
     acb->aio_offset = offset;
 
     if (qiov) {
         acb->aio_iov = qiov->iov;
         acb->aio_niov = qiov->niov;
-        assert(qiov->size == count);
+        assert(qiov->size == bytes);
     }
 
-    trace_paio_submit_co(offset, count, type);
+    trace_paio_submit_co(offset, bytes, type);
     pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     return thread_pool_submit_co(pool, aio_worker, acb);
 }
 
 static BlockAIOCB *paio_submit(BlockDriverState *bs, int fd,
-        int64_t offset, QEMUIOVector *qiov, int count,
+        int64_t offset, QEMUIOVector *qiov, int bytes,
         BlockCompletionFunc *cb, void *opaque, int type)
 {
     RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
@@ -1519,7 +1519,7 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, int fd,
     acb->aio_type = type;
     acb->aio_fildes = fd;
 
-    acb->aio_nbytes = count;
+    acb->aio_nbytes = bytes;
     acb->aio_offset = offset;
 
     if (qiov) {
@@ -1528,7 +1528,7 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, int fd,
         assert(qiov->size == acb->aio_nbytes);
     }
 
-    trace_paio_submit(acb, opaque, offset, count, type);
+    trace_paio_submit(acb, opaque, offset, bytes, type);
     pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     return thread_pool_submit_aio(pool, aio_worker, acb, cb, opaque);
 }
@@ -2109,26 +2109,26 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
 }
 
 static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
-    int64_t offset, int count,
+    int64_t offset, int bytes,
     BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
 
-    return paio_submit(bs, s->fd, offset, NULL, count,
+    return paio_submit(bs, s->fd, offset, NULL, bytes,
                        cb, opaque, QEMU_AIO_DISCARD);
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(
     BlockDriverState *bs, int64_t offset,
-    int count, BdrvRequestFlags flags)
+    int bytes, BdrvRequestFlags flags)
 {
     BDRVRawState *s = bs->opaque;
 
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
-        return paio_submit_co(bs, s->fd, offset, NULL, count,
+        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
                               QEMU_AIO_WRITE_ZEROES);
     } else if (s->discard_zeroes) {
-        return paio_submit_co(bs, s->fd, offset, NULL, count,
+        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
                               QEMU_AIO_DISCARD);
     }
     return -ENOTSUP;
@@ -2560,7 +2560,7 @@ static int fd_open(BlockDriverState *bs)
 }
 
 static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,
-    int64_t offset, int count,
+    int64_t offset, int bytes,
     BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
@@ -2568,12 +2568,12 @@ static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,
     if (fd_open(bs) < 0) {
         return NULL;
     }
-    return paio_submit(bs, s->fd, offset, NULL, count,
+    return paio_submit(bs, s->fd, offset, NULL, bytes,
                        cb, opaque, QEMU_AIO_DISCARD|QEMU_AIO_BLKDEV);
 }
 
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags)
+    int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     BDRVRawState *s = bs->opaque;
     int rc;
@@ -2583,10 +2583,10 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
         return rc;
     }
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
-        return paio_submit_co(bs, s->fd, offset, NULL, count,
+        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
                               QEMU_AIO_WRITE_ZEROES|QEMU_AIO_BLKDEV);
     } else if (s->discard_zeroes) {
-        return paio_submit_co(bs, s->fd, offset, NULL, count,
+        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
                               QEMU_AIO_DISCARD|QEMU_AIO_BLKDEV);
     }
     return -ENOTSUP;
diff --git a/block/io.c b/block/io.c
index ed31810..87639c6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -43,7 +43,7 @@ static BlockAIOCB *bdrv_co_aio_prw_vector(BdrvChild *child,
                                           bool is_write);
 static void coroutine_fn bdrv_co_do_rw(void *opaque);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags);
+    int64_t offset, int bytes, BdrvRequestFlags flags);
 
 void bdrv_parent_drained_begin(BlockDriverState *bs)
 {
@@ -667,12 +667,12 @@ int bdrv_write(BdrvChild *child, int64_t sector_num,
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int count, BdrvRequestFlags flags)
+                       int bytes, BdrvRequestFlags flags)
 {
     QEMUIOVector qiov;
     struct iovec iov = {
         .iov_base = NULL,
-        .iov_len = count,
+        .iov_len = bytes,
     };
 
     qemu_iovec_init_external(&qiov, &iov, 1);
@@ -1213,7 +1213,7 @@ int coroutine_fn bdrv_co_readv(BdrvChild *child, int64_t sector_num,
 #define MAX_WRITE_ZEROES_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags)
+    int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     BlockDriver *drv = bs->drv;
     QEMUIOVector qiov;
@@ -1231,12 +1231,12 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
     assert(alignment % bs->bl.request_alignment == 0);
     head = offset % alignment;
-    tail = (offset + count) % alignment;
+    tail = (offset + bytes) % alignment;
     max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
     assert(max_write_zeroes >= bs->bl.request_alignment);
 
-    while (count > 0 && !ret) {
-        int num = count;
+    while (bytes > 0 && !ret) {
+        int num = bytes;
 
         /* Align request.  Block drivers can expect the "bulk" of the request
          * to be aligned, and that unaligned requests do not cross cluster
@@ -1246,7 +1246,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             /* Make a small request up to the first aligned sector. For
              * convenience, limit this request to max_transfer even if
              * we don't need to fall back to writes.  */
-            num = MIN(MIN(count, max_transfer), alignment - head);
+            num = MIN(MIN(bytes, max_transfer), alignment - head);
             head = (head + num) % alignment;
             assert(num < max_write_zeroes);
         } else if (tail && num > alignment) {
@@ -1307,7 +1307,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         }
 
         offset += num;
-        count -= num;
+        bytes -= num;
     }
 
 fail:
@@ -1661,15 +1661,15 @@ int coroutine_fn bdrv_co_writev(BdrvChild *child, int64_t sector_num,
 }
 
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int count, BdrvRequestFlags flags)
+                                       int bytes, BdrvRequestFlags flags)
 {
-    trace_bdrv_co_pwrite_zeroes(child->bs, offset, count, flags);
+    trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
     if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
 
-    return bdrv_co_pwritev(child, offset, count, NULL,
+    return bdrv_co_pwritev(child, offset, bytes, NULL,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
@@ -2403,18 +2403,18 @@ int bdrv_flush(BlockDriverState *bs)
 typedef struct DiscardCo {
     BlockDriverState *bs;
     int64_t offset;
-    int count;
+    int bytes;
     int ret;
 } DiscardCo;
 static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
 {
     DiscardCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_pdiscard(rwco->bs, rwco->offset, rwco->count);
+    rwco->ret = bdrv_co_pdiscard(rwco->bs, rwco->offset, rwco->bytes);
 }
 
 int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                  int count)
+                                  int bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
@@ -2424,7 +2424,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
         return -ENOMEDIUM;
     }
 
-    ret = bdrv_check_byte_request(bs, offset, count);
+    ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
         return ret;
     } else if (bs->read_only) {
@@ -2449,10 +2449,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     align = MAX(bs->bl.pdiscard_alignment, bs->bl.request_alignment);
     assert(align % bs->bl.request_alignment == 0);
     head = offset % align;
-    tail = (offset + count) % align;
+    tail = (offset + bytes) % align;
 
     bdrv_inc_in_flight(bs);
-    tracked_request_begin(&req, bs, offset, count, BDRV_TRACKED_DISCARD);
+    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, &req);
     if (ret < 0) {
@@ -2463,13 +2463,13 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
                                    align);
     assert(max_pdiscard >= bs->bl.request_alignment);
 
-    while (count > 0) {
+    while (bytes > 0) {
         int ret;
-        int num = count;
+        int num = bytes;
 
         if (head) {
             /* Make small requests to get to alignment boundaries. */
-            num = MIN(count, align - head);
+            num = MIN(bytes, align - head);
             if (!QEMU_IS_ALIGNED(num, bs->bl.request_alignment)) {
                 num %= bs->bl.request_alignment;
             }
@@ -2513,7 +2513,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
         }
 
         offset += num;
-        count -= num;
+        bytes -= num;
     }
     ret = 0;
 out:
@@ -2525,13 +2525,13 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     Coroutine *co;
     DiscardCo rwco = {
         .bs = bs,
         .offset = offset,
-        .count = count,
+        .bytes = bytes,
         .ret = NOT_DONE,
     };
 
diff --git a/block/iscsi.c b/block/iscsi.c
index 5daa201..8e00853 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1116,14 +1116,14 @@ iscsi_getlength(BlockDriverState *bs)
 }
 
 static int
-coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
     struct unmap_list list;
     int r = 0;
 
-    if (!is_byte_request_lun_aligned(offset, count, iscsilun)) {
+    if (!is_byte_request_lun_aligned(offset, bytes, iscsilun)) {
         return -ENOTSUP;
     }
 
@@ -1133,7 +1133,7 @@ coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     }
 
     list.lba = offset / iscsilun->block_size;
-    list.num = count / iscsilun->block_size;
+    list.num = bytes / iscsilun->block_size;
 
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
@@ -1174,7 +1174,7 @@ retry:
     }
 
     iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
-                               count >> BDRV_SECTOR_BITS);
+                               bytes >> BDRV_SECTOR_BITS);
 
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
@@ -1183,7 +1183,7 @@ out_unlock:
 
 static int
 coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                    int count, BdrvRequestFlags flags)
+                                    int bytes, BdrvRequestFlags flags)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
@@ -1192,7 +1192,7 @@ coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     bool use_16_for_ws = iscsilun->use_16_for_rw;
     int r = 0;
 
-    if (!is_byte_request_lun_aligned(offset, count, iscsilun)) {
+    if (!is_byte_request_lun_aligned(offset, bytes, iscsilun)) {
         return -ENOTSUP;
     }
 
@@ -1215,7 +1215,7 @@ coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     }
 
     lba = offset / iscsilun->block_size;
-    nb_blocks = count / iscsilun->block_size;
+    nb_blocks = bytes / iscsilun->block_size;
 
     if (iscsilun->zeroblock == NULL) {
         iscsilun->zeroblock = g_try_malloc0(iscsilun->block_size);
@@ -1273,17 +1273,17 @@ retry:
 
     if (iTask.status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
-                                   count >> BDRV_SECTOR_BITS);
+                                   bytes >> BDRV_SECTOR_BITS);
         r = iTask.err_code;
         goto out_unlock;
     }
 
     if (flags & BDRV_REQ_MAY_UNMAP) {
         iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
-                                   count >> BDRV_SECTOR_BITS);
+                                   bytes >> BDRV_SECTOR_BITS);
     } else {
         iscsi_allocmap_set_allocated(iscsilun, offset >> BDRV_SECTOR_BITS,
-                                     count >> BDRV_SECTOR_BITS);
+                                     bytes >> BDRV_SECTOR_BITS);
     }
 
 out_unlock:
diff --git a/block/mirror.c b/block/mirror.c
index a2a9703..4618853 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1057,15 +1057,15 @@ static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
 }
 
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags)
+    int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    return bdrv_co_pwrite_zeroes(bs->backing, offset, count, flags);
+    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
 }
 
 static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
-    int64_t offset, int count)
+    int64_t offset, int bytes)
 {
-    return bdrv_co_pdiscard(bs->backing->bs, offset, count);
+    return bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
 }
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e2952f..6955d83 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -263,14 +263,14 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 }
 
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                int count, BdrvRequestFlags flags)
+                                int bytes, BdrvRequestFlags flags)
 {
     ssize_t ret;
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
         .from = offset,
-        .len = count,
+        .len = bytes,
     };
     NBDReply reply;
 
@@ -322,13 +322,13 @@ int nbd_client_co_flush(BlockDriverState *bs)
     return -reply.error;
 }
 
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_TRIM,
         .from = offset,
-        .len = count,
+        .len = bytes,
     };
     NBDReply reply;
     ssize_t ret;
diff --git a/block/nbd-client.h b/block/nbd-client.h
index 891ba44..49636bc 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -42,12 +42,12 @@ int nbd_client_init(BlockDriverState *bs,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count);
+int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
 int nbd_client_co_flush(BlockDriverState *bs);
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, QEMUIOVector *qiov, int flags);
 int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                int count, BdrvRequestFlags flags);
+                                int bytes, BdrvRequestFlags flags);
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index b3ba5da..f9a8ab2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2464,16 +2464,16 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int count, BdrvRequestFlags flags)
+    int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
     uint32_t head = offset % s->cluster_size;
-    uint32_t tail = (offset + count) % s->cluster_size;
+    uint32_t tail = (offset + bytes) % s->cluster_size;
 
-    trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, count);
-    if (offset + count == bs->total_sectors * BDRV_SECTOR_SIZE) {
+    trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, bytes);
+    if (offset + bytes == bs->total_sectors * BDRV_SECTOR_SIZE) {
         tail = 0;
     }
 
@@ -2482,12 +2482,12 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         uint64_t off;
         unsigned int nr;
 
-        assert(head + count <= s->cluster_size);
+        assert(head + bytes <= s->cluster_size);
 
         /* check whether remainder of cluster already reads as zero */
         if (!(is_zero_sectors(bs, cl_start,
                               DIV_ROUND_UP(head, BDRV_SECTOR_SIZE)) &&
-              is_zero_sectors(bs, (offset + count) >> BDRV_SECTOR_BITS,
+              is_zero_sectors(bs, (offset + bytes) >> BDRV_SECTOR_BITS,
                               DIV_ROUND_UP(-tail & (s->cluster_size - 1),
                                            BDRV_SECTOR_SIZE)))) {
             return -ENOTSUP;
@@ -2496,7 +2496,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         qemu_co_mutex_lock(&s->lock);
         /* We can have new write after previous check */
         offset = cl_start << BDRV_SECTOR_BITS;
-        count = s->cluster_size;
+        bytes = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
@@ -2509,33 +2509,33 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         qemu_co_mutex_lock(&s->lock);
     }
 
-    trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, count);
+    trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, bytes);
 
     /* Whatever is left can use real zero clusters */
-    ret = qcow2_cluster_zeroize(bs, offset, count, flags);
+    ret = qcow2_cluster_zeroize(bs, offset, bytes, flags);
     qemu_co_mutex_unlock(&s->lock);
 
     return ret;
 }
 
 static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
-                                          int64_t offset, int count)
+                                          int64_t offset, int bytes)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
-    if (!QEMU_IS_ALIGNED(offset | count, s->cluster_size)) {
-        assert(count < s->cluster_size);
+    if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
+        assert(bytes < s->cluster_size);
         /* Ignore partial clusters, except for the special case of the
          * complete partial cluster at the end of an unaligned file */
         if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
-            offset + count != bs->total_sectors * BDRV_SECTOR_SIZE) {
+            offset + bytes != bs->total_sectors * BDRV_SECTOR_SIZE) {
             return -ENOTSUP;
         }
     }
 
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_cluster_discard(bs, offset, count, QCOW2_DISCARD_REQUEST,
+    ret = qcow2_cluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST,
                                 false);
     qemu_co_mutex_unlock(&s->lock);
     return ret;
diff --git a/block/qed.c b/block/qed.c
index 8d899fd..5fd07d2 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1480,7 +1480,7 @@ static void coroutine_fn qed_co_pwrite_zeroes_cb(void *opaque, int ret)
 
 static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                                                   int64_t offset,
-                                                  int count,
+                                                  int bytes,
                                                   BdrvRequestFlags flags)
 {
     BlockAIOCB *blockacb;
@@ -1491,7 +1491,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
 
     /* Fall back if the request is not aligned */
     if (qed_offset_into_cluster(s, offset) ||
-        qed_offset_into_cluster(s, count)) {
+        qed_offset_into_cluster(s, bytes)) {
         return -ENOTSUP;
     }
 
@@ -1499,11 +1499,11 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
      * then it will be allocated during request processing.
      */
     iov.iov_base = NULL;
-    iov.iov_len = count;
+    iov.iov_len = bytes;
 
     qemu_iovec_init_external(&qiov, &iov, 1);
     blockacb = qed_aio_setup(bs, offset >> BDRV_SECTOR_BITS, &qiov,
-                             count >> BDRV_SECTOR_BITS,
+                             bytes >> BDRV_SECTOR_BITS,
                              qed_co_pwrite_zeroes_cb, &cb,
                              QED_AIOCB_WRITE | QED_AIOCB_ZERO);
     if (!blockacb) {
diff --git a/block/raw-format.c b/block/raw-format.c
index 36e6503..0d185fe 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -264,7 +264,7 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
-                                             int64_t offset, int count,
+                                             int64_t offset, int bytes,
                                              BdrvRequestFlags flags)
 {
     BDRVRawState *s = bs->opaque;
@@ -272,18 +272,18 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
         return -EINVAL;
     }
     offset += s->offset;
-    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
 
 static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
-                                        int64_t offset, int count)
+                                        int64_t offset, int bytes)
 {
     BDRVRawState *s = bs->opaque;
     if (offset > UINT64_MAX - s->offset) {
         return -EINVAL;
     }
     offset += s->offset;
-    return bdrv_co_pdiscard(bs->file->bs, offset, count);
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
 static int64_t raw_getlength(BlockDriverState *bs)
diff --git a/block/rbd.c b/block/rbd.c
index e551639..972361c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1045,11 +1045,11 @@ static int qemu_rbd_snap_list(BlockDriverState *bs,
 #ifdef LIBRBD_SUPPORTS_DISCARD
 static BlockAIOCB *qemu_rbd_aio_pdiscard(BlockDriverState *bs,
                                          int64_t offset,
-                                         int count,
+                                         int bytes,
                                          BlockCompletionFunc *cb,
                                          void *opaque)
 {
-    return rbd_start_aio(bs, offset, NULL, count, cb, opaque,
+    return rbd_start_aio(bs, offset, NULL, bytes, cb, opaque,
                          RBD_AIO_DISCARD);
 }
 #endif
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a..9ddbe00 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2935,7 +2935,7 @@ static int sd_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
 
 
 static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                      int count)
+                                      int bytes)
 {
     SheepdogAIOCB acb;
     BDRVSheepdogState *s = bs->opaque;
@@ -2953,11 +2953,11 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     iov.iov_len = sizeof(zero);
     discard_iov.iov = &iov;
     discard_iov.niov = 1;
-    if (!QEMU_IS_ALIGNED(offset | count, BDRV_SECTOR_SIZE)) {
+    if (!QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE)) {
         return -ENOTSUP;
     }
     sd_aio_setup(&acb, s, &discard_iov, offset >> BDRV_SECTOR_BITS,
-                 count >> BDRV_SECTOR_BITS, AIOCB_DISCARD_OBJ);
+                 bytes >> BDRV_SECTOR_BITS, AIOCB_DISCARD_OBJ);
     sd_co_rw_vector(&acb);
     sd_aio_complete(&acb);
 
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e9..5bebff4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -276,7 +276,7 @@ int bdrv_read(BdrvChild *child, int64_t sector_num,
 int bdrv_write(BdrvChild *child, int64_t sector_num,
                const uint8_t *buf, int nb_sectors);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int count, BdrvRequestFlags flags);
+                       int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
@@ -295,7 +295,7 @@ int coroutine_fn bdrv_co_writev(BdrvChild *child, int64_t sector_num,
  * because it may allocate memory for the entire region.
  */
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int count, BdrvRequestFlags flags);
+                                       int bytes, BdrvRequestFlags flags);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 int bdrv_get_backing_file_depth(BlockDriverState *bs);
@@ -418,8 +418,8 @@ void bdrv_drain_all(void);
     }                                                      \
     waited_; })
 
-int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int count);
-int bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset, int count);
+int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
+int bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index cb78c4f..6820027 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -141,7 +141,7 @@ struct BlockDriver {
     BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
-        int64_t offset, int count,
+        int64_t offset, int bytes,
         BlockCompletionFunc *cb, void *opaque);
 
     int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
@@ -162,9 +162,9 @@ struct BlockDriver {
      * will be called instead.
      */
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
-        int64_t offset, int count, BdrvRequestFlags flags);
+        int64_t offset, int bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
-        int64_t offset, int count);
+        int64_t offset, int bytes);
 
     /*
      * Building block for bdrv_block_status[_above]. The driver should
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 840ad61..d241851 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -132,7 +132,7 @@ BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
-                          int count);
+                          int bytes);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
@@ -140,13 +140,13 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int count, BdrvRequestFlags flags);
+                      int bytes, BdrvRequestFlags flags);
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                  int count, BdrvRequestFlags flags,
+                                  int bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
-int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count);
-int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int count,
+int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
+int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
                BdrvRequestFlags flags);
 int64_t blk_getlength(BlockBackend *blk);
 void blk_get_geometry(BlockBackend *blk, uint64_t *nb_sectors_ptr);
@@ -159,7 +159,7 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
                             BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
-BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int count,
+BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
@@ -167,7 +167,7 @@ int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
                           BlockCompletionFunc *cb, void *opaque);
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int count);
+int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
 int blk_commit_all(void);
@@ -222,11 +222,11 @@ int blk_get_open_flags_from_root_state(BlockBackend *blk);
 void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
                   BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int count, BdrvRequestFlags flags);
+                                      int bytes, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
-                          int count);
+                          int bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, Error **errp);
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int count);
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 4b2278f..b0ea327 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -451,13 +451,13 @@ fail:
 }
 
 static int do_pread(BlockBackend *blk, char *buf, int64_t offset,
-                    int64_t count, int64_t *total)
+                    int64_t bytes, int64_t *total)
 {
-    if (count > INT_MAX) {
+    if (bytes > INT_MAX) {
         return -ERANGE;
     }
 
-    *total = blk_pread(blk, offset, (uint8_t *)buf, count);
+    *total = blk_pread(blk, offset, (uint8_t *)buf, bytes);
     if (*total < 0) {
         return *total;
     }
@@ -465,13 +465,13 @@ static int do_pread(BlockBackend *blk, char *buf, int64_t offset,
 }
 
 static int do_pwrite(BlockBackend *blk, char *buf, int64_t offset,
-                     int64_t count, int flags, int64_t *total)
+                     int64_t bytes, int flags, int64_t *total)
 {
-    if (count > INT_MAX) {
+    if (bytes > INT_MAX) {
         return -ERANGE;
     }
 
-    *total = blk_pwrite(blk, offset, (uint8_t *)buf, count, flags);
+    *total = blk_pwrite(blk, offset, (uint8_t *)buf, bytes, flags);
     if (*total < 0) {
         return *total;
     }
@@ -481,7 +481,7 @@ static int do_pwrite(BlockBackend *blk, char *buf, int64_t offset,
 typedef struct {
     BlockBackend *blk;
     int64_t offset;
-    int64_t count;
+    int64_t bytes;
     int64_t *total;
     int flags;
     int ret;
@@ -492,7 +492,7 @@ static void coroutine_fn co_pwrite_zeroes_entry(void *opaque)
 {
     CoWriteZeroes *data = opaque;
 
-    data->ret = blk_co_pwrite_zeroes(data->blk, data->offset, data->count,
+    data->ret = blk_co_pwrite_zeroes(data->blk, data->offset, data->bytes,
                                      data->flags);
     data->done = true;
     if (data->ret < 0) {
@@ -500,23 +500,23 @@ static void coroutine_fn co_pwrite_zeroes_entry(void *opaque)
         return;
     }
 
-    *data->total = data->count;
+    *data->total = data->bytes;
 }
 
 static int do_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                               int64_t count, int flags, int64_t *total)
+                               int64_t bytes, int flags, int64_t *total)
 {
     Coroutine *co;
     CoWriteZeroes data = {
         .blk    = blk,
         .offset = offset,
-        .count  = count,
+        .bytes  = bytes,
         .total  = total,
         .flags  = flags,
         .done   = false,
     };
 
-    if (count > INT_MAX) {
+    if (bytes > INT_MAX) {
         return -ERANGE;
     }
 
@@ -533,19 +533,19 @@ static int do_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
 }
 
 static int do_write_compressed(BlockBackend *blk, char *buf, int64_t offset,
-                               int64_t count, int64_t *total)
+                               int64_t bytes, int64_t *total)
 {
     int ret;
 
-    if (count >> 9 > BDRV_REQUEST_MAX_SECTORS) {
+    if (bytes >> 9 > BDRV_REQUEST_MAX_SECTORS) {
         return -ERANGE;
     }
 
-    ret = blk_pwrite_compressed(blk, offset, buf, count);
+    ret = blk_pwrite_compressed(blk, offset, buf, bytes);
     if (ret < 0) {
         return ret;
     }
-    *total = count;
+    *total = bytes;
     return 1;
 }
 
@@ -1701,7 +1701,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     struct timeval t1, t2;
     bool Cflag = false, qflag = false;
     int c, ret;
-    int64_t offset, count;
+    int64_t offset, bytes;
 
     while ((c = getopt(argc, argv, "Cq")) != -1) {
         switch (c) {
@@ -1727,11 +1727,11 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     }
 
     optind++;
-    count = cvtnum(argv[optind]);
-    if (count < 0) {
-        print_cvtnum_err(count, argv[optind]);
+    bytes = cvtnum(argv[optind]);
+    if (bytes < 0) {
+        print_cvtnum_err(bytes, argv[optind]);
         return 0;
-    } else if (count >> BDRV_SECTOR_BITS > BDRV_REQUEST_MAX_SECTORS) {
+    } else if (bytes >> BDRV_SECTOR_BITS > BDRV_REQUEST_MAX_SECTORS) {
         printf("length cannot exceed %"PRIu64", given %s\n",
                (uint64_t)BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS,
                argv[optind]);
@@ -1739,7 +1739,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     }
 
     gettimeofday(&t1, NULL);
-    ret = blk_pdiscard(blk, offset, count);
+    ret = blk_pdiscard(blk, offset, bytes);
     gettimeofday(&t2, NULL);
 
     if (ret < 0) {
@@ -1750,7 +1750,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     /* Finally, report back -- -C gives a parsable format */
     if (!qflag) {
         t2 = tsub(t2, t1);
-        print_report("discard", &t2, offset, count, count, 1, Cflag);
+        print_report("discard", &t2, offset, bytes, bytes, 1, Cflag);
     }
 
 out:
-- 
2.11.0
