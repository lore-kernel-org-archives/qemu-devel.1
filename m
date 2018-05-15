Received: from eggs.gnu.org ([2001:4830:134:3::10]:38530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4I-0006Tl-1u
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4F-0001HF-CZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:39:59 +0200
Message-Id: <20180515154033.19899-4-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/37] file-win32: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the file-win32 driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, as I don't know if Windows is tolerant of
non-sector AIO operations, I went with the conservative approach
of modifying .bdrv_refresh_limits to override the block layer
defaults back to the pre-patch value of 512.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/raw-aio.h |  2 +-
 block/file-win32.c      | 47 +++++++++++++++++++++++++++++------------------
 block/win32-aio.c       |  5 ++---
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index a4cdbbf1b7..9e47b8a629 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -57,7 +57,7 @@ void win32_aio_cleanup(QEMUWin32AIOState *aio);
 int win32_aio_attach(QEMUWin32AIOState *aio, HANDLE hfile);
 BlockAIOCB *win32_aio_submit(BlockDriverState *bs,
         QEMUWin32AIOState *aio, HANDLE hfile,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
         BlockCompletionFunc *cb, void *opaque, int type);
 void win32_aio_detach_aio_context(QEMUWin32AIOState *aio,
                                   AioContext *old_context);
diff --git a/block/file-win32.c b/block/file-win32.c
index 2e2f746bb1..3c67db4336 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -251,7 +251,11 @@ static void raw_probe_alignment(BlockDriverState *bs, Error **errp)
                          &dg.Geometry.BytesPerSector,
                          &freeClusters, &totalClusters);
         bs->bl.request_alignment = dg.Geometry.BytesPerSector;
+        return;
     }
+
+    /* XXX Does Windows support AIO on less than 512-byte alignment? */
+    bs->bl.request_alignment = 512;
 }
 
 static void raw_parse_flags(int flags, bool use_aio, int *access_flags,
@@ -410,32 +414,32 @@ fail:
     return ret;
 }
 
-static BlockAIOCB *raw_aio_readv(BlockDriverState *bs,
-                         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-                         BlockCompletionFunc *cb, void *opaque)
+static BlockAIOCB *raw_aio_preadv(BlockDriverState *bs,
+                                  uint64_t offset, uint64_t bytes,
+                                  QEMUIOVector *qiov, int flags,
+                                  BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
     if (s->aio) {
-        return win32_aio_submit(bs, s->aio, s->hfile, sector_num, qiov,
-                                nb_sectors, cb, opaque, QEMU_AIO_READ);
+        return win32_aio_submit(bs, s->aio, s->hfile, offset, bytes, qiov,
+                                cb, opaque, QEMU_AIO_READ);
     } else {
-        return paio_submit(bs, s->hfile, sector_num << BDRV_SECTOR_BITS, qiov,
-                           nb_sectors << BDRV_SECTOR_BITS,
+        return paio_submit(bs, s->hfile, offset, qiov, bytes,
                            cb, opaque, QEMU_AIO_READ);
     }
 }
 
-static BlockAIOCB *raw_aio_writev(BlockDriverState *bs,
-                          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-                          BlockCompletionFunc *cb, void *opaque)
+static BlockAIOCB *raw_aio_pwritev(BlockDriverState *bs,
+                                   uint64_t offset, uint64_t bytes,
+                                   QEMUIOVector *qiov, int flags,
+                                   BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
     if (s->aio) {
-        return win32_aio_submit(bs, s->aio, s->hfile, sector_num, qiov,
-                                nb_sectors, cb, opaque, QEMU_AIO_WRITE);
+        return win32_aio_submit(bs, s->aio, s->hfile, offset, bytes, qiov,
+                                cb, opaque, QEMU_AIO_WRITE);
     } else {
-        return paio_submit(bs, s->hfile, sector_num << BDRV_SECTOR_BITS, qiov,
-                           nb_sectors << BDRV_SECTOR_BITS,
+        return paio_submit(bs, s->hfile, offset, qiov, bytes,
                            cb, opaque, QEMU_AIO_WRITE);
     }
 }
@@ -632,8 +636,8 @@ BlockDriver bdrv_file = {
     .bdrv_co_create_opts = raw_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
 
-    .bdrv_aio_readv     = raw_aio_readv,
-    .bdrv_aio_writev    = raw_aio_writev,
+    .bdrv_aio_preadv    = raw_aio_preadv,
+    .bdrv_aio_pwritev   = raw_aio_pwritev,
     .bdrv_aio_flush     = raw_aio_flush,
 
     .bdrv_truncate	= raw_truncate,
@@ -708,6 +712,12 @@ static void hdev_parse_filename(const char *filename, QDict *options,
     bdrv_parse_filename_strip_prefix(filename, "host_device:", options);
 }
 
+static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    /* XXX Does Windows support AIO on less than 512-byte alignment? */
+    bs->bl.request_alignment = 512;
+}
+
 static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
@@ -793,9 +803,10 @@ static BlockDriver bdrv_host_device = {
     .bdrv_probe_device	= hdev_probe_device,
     .bdrv_file_open	= hdev_open,
     .bdrv_close		= raw_close,
+    .bdrv_refresh_limits = hdev_refresh_limits,
 
-    .bdrv_aio_readv     = raw_aio_readv,
-    .bdrv_aio_writev    = raw_aio_writev,
+    .bdrv_aio_preadv    = raw_aio_preadv,
+    .bdrv_aio_pwritev   = raw_aio_pwritev,
     .bdrv_aio_flush     = raw_aio_flush,
 
     .bdrv_detach_aio_context = raw_detach_aio_context,
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 3be8f458fa..9cd355d42f 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -112,15 +112,14 @@ static const AIOCBInfo win32_aiocb_info = {
 
 BlockAIOCB *win32_aio_submit(BlockDriverState *bs,
         QEMUWin32AIOState *aio, HANDLE hfile,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
         BlockCompletionFunc *cb, void *opaque, int type)
 {
     struct QEMUWin32AIOCB *waiocb;
-    uint64_t offset = sector_num * 512;
     DWORD rc;
 
     waiocb = qemu_aio_get(&win32_aiocb_info, bs, cb, opaque);
-    waiocb->nbytes = nb_sectors * 512;
+    waiocb->nbytes = bytes;
     waiocb->qiov = qiov;
     waiocb->is_read = (type == QEMU_AIO_READ);
 
-- 
2.13.6
