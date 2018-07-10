Received: from eggs.gnu.org ([2001:4830:134:3::10]:44593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunn-0005N3-4I
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunm-0001lv-8c
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:43:00 +0200
Message-Id: <20180710154304.18304-21-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/24] block: Fix handling of image enlarging
 write
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

From: Fam Zheng <famz@redhat.com>

Two problems exist when a write request that enlarges the image (i.e.
write beyond EOF) finishes:

1) parent is not notified about size change;
2) dirty bitmap is not resized although we try to set the dirty bits;

Fix them just like how bdrv_co_truncate works.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 313fe0776c..c88b2b48d7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -40,6 +40,7 @@
 
 static AioWait drain_all_aio_wait;
 
+static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -1621,13 +1622,16 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
     BlockDriverState *bs = child->bs;
 
     atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, offset, bytes);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
 
-    if (ret == 0) {
-        bs->total_sectors = MAX(bs->total_sectors, end_sector);
+    if (ret == 0 &&
+        end_sector > bs->total_sectors) {
+        bs->total_sectors = end_sector;
+        bdrv_parent_cb_resize(bs);
+        bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
+    bdrv_set_dirty(bs, offset, bytes);
 }
 
 /*
-- 
2.13.6
