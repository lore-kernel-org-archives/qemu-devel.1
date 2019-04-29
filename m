Received: from eggs.gnu.org ([209.51.188.92]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hf-18
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF0-0002Qg-Th
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 20:42:39 +0200
Message-Id: <1e84aa54bf7ac50636308384ac13ee89c4a1c850.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 4/5] block: Remove bdrv_read() and bdrv_write()
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
 block/io.c            | 36 ------------------------------------
 include/block/block.h |  4 ----
 2 files changed, 40 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b8d8..adf759171a 100644
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
