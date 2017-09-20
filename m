Received: from eggs.gnu.org ([2001:4830:134:3::10]:41569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAP-0001xs-1n
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAO-0000yz-5j
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:53 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 14:43:10 +0300
Message-Id: <20170920114310.13080-3-el13635@mail.ntua.gr>
In-Reply-To: <20170920114310.13080-1-el13635@mail.ntua.gr>
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 2/2] block/block-backend.c: remove
 blk_pread_unthrottled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

blk_pread_unthrottled was used to bypass I/O throttling on the BlockBackend in
the case of async I/O. This is not needed anymore and we can just call
blk_pread() directly.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/sysemu/block-backend.h |  2 --
 block/block-backend.c          | 16 ----------------
 hw/block/hd-geometry.c         |  7 +------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index c4e52a5fa3..c881bfdfe4 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -117,8 +117,6 @@ char *blk_get_attached_dev_id(BlockBackend *blk);
 BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
-int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
-                          int bytes);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
diff --git a/block/block-backend.c b/block/block-backend.c
index 110a52d5b1..83329fce15 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1145,22 +1145,6 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
     return rwco.ret;
 }
 
-int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
-                          int count)
-{
-    int ret;
-
-    ret = blk_check_byte_request(blk, offset, count);
-    if (ret < 0) {
-        return ret;
-    }
-
-    blk_root_drained_begin(blk->root);
-    ret = blk_pread(blk, offset, buf, count);
-    blk_root_drained_end(blk->root);
-    return ret;
-}
-
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                       int bytes, BdrvRequestFlags flags)
 {
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 57ad5012a7..211307f73f 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -62,12 +62,7 @@ static int guess_disk_lchs(BlockBackend *blk,
 
     blk_get_geometry(blk, &nb_sectors);
 
-    /**
-     * The function will be invoked during startup not only in sync I/O mode,
-     * but also in async I/O mode. So the I/O throttling function has to
-     * be disabled temporarily here, not permanently.
-     */
-    if (blk_pread_unthrottled(blk, 0, buf, BDRV_SECTOR_SIZE) < 0) {
+    if (blk_pread(blk, 0, buf, BDRV_SECTOR_SIZE) < 0) {
         return -1;
     }
     /* test msdos magic */
-- 
2.11.0
