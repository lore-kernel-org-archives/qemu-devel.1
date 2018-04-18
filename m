Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8dPH-0002RC-4O
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 23:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8dPF-0002X5-S4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 23:05:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 18 Apr 2018 11:04:21 +0800
Message-Id: <20180418030424.28980-5-famz@redhat.com>
In-Reply-To: <20180418030424.28980-1-famz@redhat.com>
References: <20180418030424.28980-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 4/7] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

With copy_file_range(2), we can implement the bdrv_co_copy_range
semantics.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c      | 99 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/block/raw-aio.h | 10 ++++-
 2 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3794c0007a..45ad543481 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -100,6 +100,7 @@
 #ifdef CONFIG_XFS
 #include <xfs/xfs.h>
 #endif
+#include <sys/syscall.h>
 
 //#define DEBUG_BLOCK
 
@@ -185,6 +186,8 @@ typedef struct RawPosixAIOData {
 #define aio_ioctl_cmd   aio_nbytes /* for QEMU_AIO_IOCTL */
     off_t aio_offset;
     int aio_type;
+    int fd2;
+    off_t offset2;
 } RawPosixAIOData;
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -1421,6 +1424,48 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
     return -ENOTSUP;
 }
 
+#ifdef __NR_copy_file_range
+#define HAS_COPY_FILE_RANGE
+#endif
+
+#ifdef HAS_COPY_FILE_RANGE
+static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                             off_t *out_off, size_t len, unsigned int flags)
+{
+    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
+                   out_off, len, flags);
+}
+#endif
+
+static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
+{
+#ifndef HAS_COPY_FILE_RANGE
+    return -ENOTSUP;
+#else
+    uint64_t bytes = aiocb->aio_nbytes;
+    off_t in_off = aiocb->aio_offset;
+    off_t out_off = aiocb->offset2;
+
+    while (bytes) {
+        ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
+                                      aiocb->fd2, &out_off,
+                                      bytes, 0);
+        if (ret == -EINTR) {
+            continue;
+        }
+        if (ret < 0) {
+            return -errno;
+        }
+        if (!ret) {
+            /* No progress (e.g. when beyond EOF), fall back to buffer I/O. */
+            return -ENOTSUP;
+        }
+        bytes -= ret;
+    }
+    return 0;
+#endif
+}
+
 static ssize_t handle_aiocb_discard(RawPosixAIOData *aiocb)
 {
     int ret = -EOPNOTSUPP;
@@ -1501,6 +1546,9 @@ static int aio_worker(void *arg)
     case QEMU_AIO_WRITE_ZEROES:
         ret = handle_aiocb_write_zeroes(aiocb);
         break;
+    case QEMU_AIO_COPY_RANGE:
+        ret = handle_aiocb_copy_range(aiocb);
+        break;
     default:
         fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
         ret = -EINVAL;
@@ -1511,9 +1559,10 @@ static int aio_worker(void *arg)
     return ret;
 }
 
-static int paio_submit_co(BlockDriverState *bs, int fd,
-                          int64_t offset, QEMUIOVector *qiov,
-                          int bytes, int type)
+static int paio_submit_co_full(BlockDriverState *bs, int fd,
+                               int64_t offset, int fd2, int64_t offset2,
+                               QEMUIOVector *qiov,
+                               int bytes, int type)
 {
     RawPosixAIOData *acb = g_new(RawPosixAIOData, 1);
     ThreadPool *pool;
@@ -1521,6 +1570,8 @@ static int paio_submit_co(BlockDriverState *bs, int fd,
     acb->bs = bs;
     acb->aio_type = type;
     acb->aio_fildes = fd;
+    acb->fd2 = fd2;
+    acb->offset2 = offset2;
 
     acb->aio_nbytes = bytes;
     acb->aio_offset = offset;
@@ -1536,6 +1587,13 @@ static int paio_submit_co(BlockDriverState *bs, int fd,
     return thread_pool_submit_co(pool, aio_worker, acb);
 }
 
+static inline int paio_submit_co(BlockDriverState *bs, int fd,
+                                 int64_t offset, QEMUIOVector *qiov,
+                                 int bytes, int type)
+{
+    return paio_submit_co_full(bs, fd, offset, -1, 0, qiov, bytes, type);
+}
+
 static BlockAIOCB *paio_submit(BlockDriverState *bs, int fd,
         int64_t offset, QEMUIOVector *qiov, int bytes,
         BlockCompletionFunc *cb, void *opaque, int type)
@@ -2312,6 +2370,35 @@ static void raw_abort_perm_update(BlockDriverState *bs)
     raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
 }
 
+static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
+                                  BdrvChild *src, uint64_t src_offset,
+                                  BdrvChild *dst, uint64_t dst_offset,
+                                  uint64_t bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes, flags);
+}
+
+static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
+                                             BdrvChild *src, uint64_t src_offset,
+                                             BdrvChild *dst, uint64_t dst_offset,
+                                             uint64_t bytes, BdrvRequestFlags flags)
+{
+    BDRVRawState *s = bs->opaque;
+    BDRVRawState *src_s;
+
+    assert(dst->bs == bs);
+    if (src->bs->drv->bdrv_co_copy_range_to != raw_co_copy_range_to) {
+        return -ENOTSUP;
+    }
+
+    src_s = src->opaque;
+    if (fd_open(bs) < 0 || fd_open(bs) < 0) {
+        return -EIO;
+    }
+    return paio_submit_co_full(bs, src_s->fd, src_offset, s->fd, dst_offset,
+                               NULL, bytes, QEMU_AIO_COPY_RANGE);
+}
+
 BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
@@ -2334,6 +2421,8 @@ BlockDriver bdrv_file = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_aio_flush = raw_aio_flush,
     .bdrv_aio_pdiscard = raw_aio_pdiscard,
+    .bdrv_co_copy_range_from = raw_co_copy_range_from,
+    .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
@@ -2811,6 +2900,10 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_aio_pdiscard   = hdev_aio_pdiscard,
+    .bdrv_co_copy_range_from = raw_co_copy_range_from,
+    .bdrv_co_copy_range_to  = raw_co_copy_range_to,
+    .bdrv_co_copy_range_from = raw_co_copy_range_from,
+    .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index a4cdbbf1b7..324053020b 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -25,9 +25,15 @@
 #define QEMU_AIO_FLUSH        0x0008
 #define QEMU_AIO_DISCARD      0x0010
 #define QEMU_AIO_WRITE_ZEROES 0x0020
+#define QEMU_AIO_COPY_RANGE   0x0040
 #define QEMU_AIO_TYPE_MASK \
-        (QEMU_AIO_READ|QEMU_AIO_WRITE|QEMU_AIO_IOCTL|QEMU_AIO_FLUSH| \
-         QEMU_AIO_DISCARD|QEMU_AIO_WRITE_ZEROES)
+        (QEMU_AIO_READ | \
+         QEMU_AIO_WRITE | \
+         QEMU_AIO_IOCTL | \
+         QEMU_AIO_FLUSH | \
+         QEMU_AIO_DISCARD | \
+         QEMU_AIO_WRITE_ZEROES | \
+         QEMU_AIO_COPY_RANGE)
 
 /* AIO flags */
 #define QEMU_AIO_MISALIGNED   0x1000
-- 
2.14.3
