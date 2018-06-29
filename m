Received: from eggs.gnu.org ([2001:4830:134:3::10]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6c-00045j-6z
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-0004Cm-8w
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:48 +0200
Message-Id: <20180629140959.6690-19-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/29] file-posix: Implement co versions of
 discard/flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This simplifies file-posix by implementing the coroutine variants of
the discard and flush BlockDriver callbacks. These were the last
remaining users of paio_submit(), which can be removed now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 72 ++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 639265d53b..e3f1b045d1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1754,31 +1754,6 @@ static inline int paio_submit_co(BlockDriverState *bs, int fd,
     return paio_submit_co_full(bs, fd, offset, -1, 0, qiov, bytes, type);
 }
 
-static BlockAIOCB *paio_submit(BlockDriverState *bs, int fd,
-        int64_t offset, QEMUIOVector *qiov, int bytes,
-        BlockCompletionFunc *cb, void *opaque, int type)
-{
-    RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
-    ThreadPool *pool;
-
-    acb->bs = bs;
-    acb->aio_type = type;
-    acb->aio_fildes = fd;
-
-    acb->aio_nbytes = bytes;
-    acb->aio_offset = offset;
-
-    if (qiov) {
-        acb->aio_iov = qiov->iov;
-        acb->aio_niov = qiov->niov;
-        assert(qiov->size == acb->aio_nbytes);
-    }
-
-    trace_paio_submit(acb, opaque, offset, bytes, type);
-    pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
-    return thread_pool_submit_aio(pool, aio_worker, acb, cb, opaque);
-}
-
 static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
                                    uint64_t bytes, QEMUIOVector *qiov, int type)
 {
@@ -1845,15 +1820,17 @@ static void raw_aio_unplug(BlockDriverState *bs)
 #endif
 }
 
-static BlockAIOCB *raw_aio_flush(BlockDriverState *bs,
-        BlockCompletionFunc *cb, void *opaque)
+static int raw_co_flush_to_disk(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
-    if (fd_open(bs) < 0)
-        return NULL;
+    ret = fd_open(bs);
+    if (ret < 0) {
+        return ret;
+    }
 
-    return paio_submit(bs, s->fd, 0, NULL, 0, cb, opaque, QEMU_AIO_FLUSH);
+    return paio_submit_co(bs, s->fd, 0, NULL, 0, QEMU_AIO_FLUSH);
 }
 
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
@@ -2526,14 +2503,12 @@ static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
 #endif /* !__linux__ */
 }
 
-static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
-    int64_t offset, int bytes,
-    BlockCompletionFunc *cb, void *opaque)
+static coroutine_fn int
+raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     BDRVRawState *s = bs->opaque;
 
-    return paio_submit(bs, s->fd, offset, NULL, bytes,
-                       cb, opaque, QEMU_AIO_DISCARD);
+    return paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCARD);
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(
@@ -2652,8 +2627,8 @@ BlockDriver bdrv_file = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
-    .bdrv_aio_flush = raw_aio_flush,
-    .bdrv_aio_pdiscard = raw_aio_pdiscard,
+    .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
+    .bdrv_co_pdiscard       = raw_co_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -3019,17 +2994,18 @@ static int fd_open(BlockDriverState *bs)
     return -EIO;
 }
 
-static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,
-    int64_t offset, int bytes,
-    BlockCompletionFunc *cb, void *opaque)
+static coroutine_fn int
+hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
-    if (fd_open(bs) < 0) {
-        return NULL;
+    ret = fd_open(bs);
+    if (ret < 0) {
+        return ret;
     }
-    return paio_submit(bs, s->fd, offset, NULL, bytes,
-                       cb, opaque, QEMU_AIO_DISCARD|QEMU_AIO_BLKDEV);
+    return paio_submit_co(bs, s->fd, offset, NULL, bytes,
+                          QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
 }
 
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
@@ -3133,8 +3109,8 @@ static BlockDriver bdrv_host_device = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
-    .bdrv_aio_flush	= raw_aio_flush,
-    .bdrv_aio_pdiscard   = hdev_aio_pdiscard,
+    .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
+    .bdrv_co_pdiscard       = hdev_co_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -3258,7 +3234,7 @@ static BlockDriver bdrv_host_cdrom = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
-    .bdrv_aio_flush	= raw_aio_flush,
+    .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
@@ -3388,7 +3364,7 @@ static BlockDriver bdrv_host_cdrom = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
-    .bdrv_aio_flush	= raw_aio_flush,
+    .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
-- 
2.13.6
