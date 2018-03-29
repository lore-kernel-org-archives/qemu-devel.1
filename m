Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRK-0001he-UX
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRJ-0003H1-NQ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:10 +0800
Message-Id: <20180329110914.20888-5-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/8] file-posix: Implement
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
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

With copy_file_range(2), we can implement the bdrv_co_copy_range
semantics.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c      | 77 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/block/raw-aio.h | 10 +++++--
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d7fb772c14..b13bc89423 100644
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
@@ -1421,6 +1424,41 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
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
+        if (ret < 0) {
+            return -errno;
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
@@ -1501,6 +1539,9 @@ static int aio_worker(void *arg)
     case QEMU_AIO_WRITE_ZEROES:
         ret = handle_aiocb_write_zeroes(aiocb);
         break;
+    case QEMU_AIO_COPY_RANGE:
+        ret = handle_aiocb_copy_range(aiocb);
+        break;
     default:
         fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
         ret = -EINVAL;
@@ -1511,9 +1552,10 @@ static int aio_worker(void *arg)
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
@@ -1521,6 +1563,8 @@ static int paio_submit_co(BlockDriverState *bs, int fd,
     acb->bs = bs;
     acb->aio_type = type;
     acb->aio_fildes = fd;
+    acb->fd2 = fd2;
+    acb->offset2 = offset2;
 
     acb->aio_nbytes = bytes;
     acb->aio_offset = offset;
@@ -1536,6 +1580,13 @@ static int paio_submit_co(BlockDriverState *bs, int fd,
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
@@ -1605,6 +1656,22 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
+static int raw_co_copy_range(BlockDriverState *bs, int64_t off_in,
+                             BlockDriverState *out, int64_t off_out,
+                             int bytes)
+{
+    BDRVRawState *s = bs->opaque;
+    BDRVRawState *out_s;
+
+    assert(out->drv->bdrv_co_copy_range == raw_co_copy_range);
+    out_s = out->opaque;
+    if (fd_open(bs) < 0 || fd_open(out) < 0) {
+        return -EIO;
+    }
+    return paio_submit_co_full(bs, s->fd, off_in, out_s->fd, off_out,
+                               NULL, bytes, QEMU_AIO_COPY_RANGE);
+}
+
 static void raw_aio_plug(BlockDriverState *bs)
 {
 #ifdef CONFIG_LINUX_AIO
@@ -2321,6 +2388,7 @@ BlockDriver bdrv_file = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
+    .bdrv_co_copy_range     = raw_co_copy_range,
     .bdrv_aio_flush = raw_aio_flush,
     .bdrv_aio_pdiscard = raw_aio_pdiscard,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -2798,6 +2866,7 @@ static BlockDriver bdrv_host_device = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
+    .bdrv_co_copy_range     = raw_co_copy_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_aio_pdiscard   = hdev_aio_pdiscard,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -2920,6 +2989,7 @@ static BlockDriver bdrv_host_cdrom = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
+    .bdrv_co_copy_range     = raw_co_copy_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
@@ -3050,6 +3120,7 @@ static BlockDriver bdrv_host_cdrom = {
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
+    .bdrv_co_copy_range     = raw_co_copy_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
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
