Received: from eggs.gnu.org ([209.51.188.92]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtka-0007MY-Vy
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkZ-0002bD-WA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:36 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 May 2019 21:13:58 +0300
Message-Id: <39b2f01f936e47e24a28657c00a1110b5df6111e.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 4/5] block: Remove bdrv_read() and
 bdrv_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

No one is using these functions anymore, all callers have switched to
the byte-based bdrv_pread() and bdrv_pwrite()

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c            | 43 +++++++------------------------------------
 include/block/block.h |  4 ----
 2 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b8d8..396d5364ba 100644
--- a/block/io.c
+++ b/block/io.c
@@ -837,42 +837,6 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
     return rwco.ret;
 }
 
-/*
- * Process a synchronous request using coroutines
- */
-static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
-                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
-{
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf,
-                                            nb_sectors * BDRV_SECTOR_SIZE);
-
-    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
-        return -EINVAL;
-    }
-
-    return bdrv_prwv_co(child, sector_num << BDRV_SECTOR_BITS,
-                        &qiov, is_write, flags);
-}
-
-/* return < 0 if error. See bdrv_write() for the return codes */
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, buf, nb_sectors, false, 0);
-}
-
-/* Return < 0 if error. Important errors are:
-  -EIO         generic I/O error (may happen for all errors)
-  -ENOMEDIUM   No media inserted.
-  -EINVAL      Invalid sector number or nb_sectors
-  -EACCES      Trying to write a read-only device
-*/
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, (uint8_t *)buf, nb_sectors, true, 0);
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
@@ -935,6 +899,7 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
     return qiov->size;
 }
 
+/* See bdrv_pwrite() for the return codes */
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
@@ -958,6 +923,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
     return qiov->size;
 }
 
+/* Return no. of bytes on success or < 0 on error. Important errors are:
+  -EIO         generic I/O error (may happen for all errors)
+  -ENOMEDIUM   No media inserted.
+  -EINVAL      Invalid offset or number of bytes
+  -EACCES      Trying to write a read-only device
+*/
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..5e2b98b0ee 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -316,10 +316,6 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
 void bdrv_reopen_abort(BDRVReopenState *reopen_state);
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors);
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
-- 
2.11.0
