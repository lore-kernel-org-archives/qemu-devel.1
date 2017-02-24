Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxW-0006IC-JH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxV-0004un-J3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:10 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 24 Feb 2017 12:46:58 -0500
Message-Id: <20170224174700.30816-2-jcody@redhat.com>
In-Reply-To: <20170224174700.30816-1-jcody@redhat.com>
References: <20170224174700.30816-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] block/nfs: convert to preadv / pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 1487349541-10201-2-git-send-email-pl@kamp.de
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/nfs.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0cf115e..c11c4c9 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -263,9 +263,9 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
                             nfs_co_generic_bh_cb, task);
 }
 
-static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
-                                     int64_t sector_num, int nb_sectors,
-                                     QEMUIOVector *iov)
+static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
+                                      uint64_t bytes, QEMUIOVector *iov,
+                                      int flags)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task;
@@ -274,9 +274,7 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
     task.iov = iov;
 
     if (nfs_pread_async(client->context, client->fh,
-                        sector_num * BDRV_SECTOR_SIZE,
-                        nb_sectors * BDRV_SECTOR_SIZE,
-                        nfs_co_generic_cb, &task) != 0) {
+                        offset, bytes, nfs_co_generic_cb, &task) != 0) {
         return -ENOMEM;
     }
 
@@ -297,9 +295,9 @@ static int coroutine_fn nfs_co_readv(BlockDriverState *bs,
     return 0;
 }
 
-static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
-                                        int64_t sector_num, int nb_sectors,
-                                        QEMUIOVector *iov)
+static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes, QEMUIOVector *iov,
+                                       int flags)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task;
@@ -307,17 +305,16 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
 
     nfs_co_init_task(bs, &task);
 
-    buf = g_try_malloc(nb_sectors * BDRV_SECTOR_SIZE);
-    if (nb_sectors && buf == NULL) {
+    buf = g_try_malloc(bytes);
+    if (bytes && buf == NULL) {
         return -ENOMEM;
     }
 
-    qemu_iovec_to_buf(iov, 0, buf, nb_sectors * BDRV_SECTOR_SIZE);
+    qemu_iovec_to_buf(iov, 0, buf, bytes);
 
     if (nfs_pwrite_async(client->context, client->fh,
-                         sector_num * BDRV_SECTOR_SIZE,
-                         nb_sectors * BDRV_SECTOR_SIZE,
-                         buf, nfs_co_generic_cb, &task) != 0) {
+                         offset, bytes, buf,
+                         nfs_co_generic_cb, &task) != 0) {
         g_free(buf);
         return -ENOMEM;
     }
@@ -329,7 +326,7 @@ static int coroutine_fn nfs_co_writev(BlockDriverState *bs,
 
     g_free(buf);
 
-    if (task.ret != nb_sectors * BDRV_SECTOR_SIZE) {
+    if (task.ret != bytes) {
         return task.ret < 0 ? task.ret : -EIO;
     }
 
@@ -861,8 +858,8 @@ static BlockDriver bdrv_nfs = {
     .bdrv_create                    = nfs_file_create,
     .bdrv_reopen_prepare            = nfs_reopen_prepare,
 
-    .bdrv_co_readv                  = nfs_co_readv,
-    .bdrv_co_writev                 = nfs_co_writev,
+    .bdrv_co_preadv                 = nfs_co_preadv,
+    .bdrv_co_pwritev                = nfs_co_pwritev,
     .bdrv_co_flush_to_disk          = nfs_co_flush,
 
     .bdrv_detach_aio_context        = nfs_detach_aio_context,
-- 
2.9.3
