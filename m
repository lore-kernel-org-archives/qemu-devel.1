Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oV-0003NW-BL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oR-0008Kq-1d
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:55 +0200
Message-Id: <20180730150958.14607-11-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] file-posix: Fix write_zeroes with unmap
 on block devices
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

The BLKDISCARD ioctl doesn't guarantee that the discarded blocks read as
all-zero afterwards, so don't try to abuse it for zero writing. We try
to only use this if BLKDISCARDZEROES tells us that it is safe, but this
is unreliable on older kernels and a constant 0 in newer kernels. In
other words, this code path is never actually used with newer kernels,
so we don't even try to unmap while writing zeros.

This patch removes the abuse of discard for writing zeroes from
file-posix and instead adds a new function that uses interfaces that are
actually meant to deallocate and zero out at the same time. Only if
those fail, it falls back to zeroing out without unmap. We never fall
back to a discard operation any more that may or may not result in
zeros.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 59 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 928b863ced..fe83cbf0eb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -648,7 +648,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
+    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
     ret = 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
@@ -1487,6 +1487,35 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
     return -ENOTSUP;
 }
 
+static ssize_t handle_aiocb_write_zeroes_unmap(RawPosixAIOData *aiocb)
+{
+    BDRVRawState *s G_GNUC_UNUSED = aiocb->bs->opaque;
+    int ret;
+
+    /* First try to write zeros and unmap at the same time */
+
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                       aiocb->aio_offset, aiocb->aio_nbytes);
+    if (ret != -ENOTSUP) {
+        return ret;
+    }
+#endif
+
+#ifdef CONFIG_XFS
+    if (s->is_xfs) {
+        /* xfs_discard() guarantees that the discarded area reads as all-zero
+         * afterwards, so we can use it here. */
+        return xfs_discard(s, aiocb->aio_offset, aiocb->aio_nbytes);
+    }
+#endif
+
+    /* If we couldn't manage to unmap while guaranteed that the area reads as
+     * all-zero afterwards, just write zeroes without unmapping */
+    ret = handle_aiocb_write_zeroes(aiocb);
+    return ret;
+}
+
 #ifndef HAVE_COPY_FILE_RANGE
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                              off_t *out_off, size_t len, unsigned int flags)
@@ -1732,6 +1761,9 @@ static int aio_worker(void *arg)
     case QEMU_AIO_WRITE_ZEROES:
         ret = handle_aiocb_write_zeroes(aiocb);
         break;
+    case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
+        ret = handle_aiocb_write_zeroes_unmap(aiocb);
+        break;
     case QEMU_AIO_COPY_RANGE:
         ret = handle_aiocb_copy_range(aiocb);
         break;
@@ -2556,15 +2588,13 @@ static int coroutine_fn raw_co_pwrite_zeroes(
     int bytes, BdrvRequestFlags flags)
 {
     BDRVRawState *s = bs->opaque;
+    int operation = QEMU_AIO_WRITE_ZEROES;
 
-    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
-        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                              QEMU_AIO_WRITE_ZEROES);
-    } else if (s->discard_zeroes) {
-        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                              QEMU_AIO_DISCARD);
+    if (flags & BDRV_REQ_MAY_UNMAP) {
+        operation |= QEMU_AIO_DISCARD;
     }
-    return -ENOTSUP;
+
+    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
 }
 
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
@@ -3057,20 +3087,19 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     BDRVRawState *s = bs->opaque;
+    int operation = QEMU_AIO_WRITE_ZEROES | QEMU_AIO_BLKDEV;
     int rc;
 
     rc = fd_open(bs);
     if (rc < 0) {
         return rc;
     }
-    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
-        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                              QEMU_AIO_WRITE_ZEROES|QEMU_AIO_BLKDEV);
-    } else if (s->discard_zeroes) {
-        return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                              QEMU_AIO_DISCARD|QEMU_AIO_BLKDEV);
+
+    if (flags & BDRV_REQ_MAY_UNMAP) {
+        operation |= QEMU_AIO_DISCARD;
     }
-    return -ENOTSUP;
+
+    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
 }
 
 static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOpts *opts,
-- 
2.13.6
