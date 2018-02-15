Received: from eggs.gnu.org ([2001:4830:134:3::10]:50056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD9-0006Fz-Mz
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000ma-Hw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:25 -0600
Message-Id: <20180215192829.9944-3-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
References: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] file-win32: Switch to byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the file-win32 driver.

Note that the driver was already using byte-based calls for
performing actual I/O, so this just gets rid of a round trip
of scaling; however, the block layer defaults this driver to
use request_alignment of 512, and I did not change that,
because I don't know if Windows is tolerant of non-sector AIO
operations.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Compile-tested via 'make docker-test-mingw@fedora', but I don't
have a sane way to test whether it actually works.
---
 include/block/raw-aio.h |  2 +-
 block/file-win32.c      | 36 ++++++++++++++++++------------------
 block/win32-aio.c       |  5 ++---
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index a4cdbbf1b7a..9e47b8a629d 100644
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
index f24c7bb92c6..7a2e3367946 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -410,32 +410,32 @@ fail:
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
@@ -602,8 +602,8 @@ BlockDriver bdrv_file = {
     .bdrv_create        = raw_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,

-    .bdrv_aio_readv     = raw_aio_readv,
-    .bdrv_aio_writev    = raw_aio_writev,
+    .bdrv_aio_preadv    = raw_aio_preadv,
+    .bdrv_aio_pwritev   = raw_aio_pwritev,
     .bdrv_aio_flush     = raw_aio_flush,

     .bdrv_truncate	= raw_truncate,
@@ -764,8 +764,8 @@ static BlockDriver bdrv_host_device = {
     .bdrv_file_open	= hdev_open,
     .bdrv_close		= raw_close,

-    .bdrv_aio_readv     = raw_aio_readv,
-    .bdrv_aio_writev    = raw_aio_writev,
+    .bdrv_aio_preadv    = raw_aio_preadv,
+    .bdrv_aio_pwritev   = raw_aio_pwritev,
     .bdrv_aio_flush     = raw_aio_flush,

     .bdrv_detach_aio_context = raw_detach_aio_context,
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 3be8f458fab..9cd355d42f8 100644
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
2.14.3
