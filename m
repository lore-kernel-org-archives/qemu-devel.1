Received: from eggs.gnu.org ([2001:4830:134:3::10]:55960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxy-0000d6-4G
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxu-0003Ey-5S
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:48 +0200
Message-Id: <20171006155422.10135-21-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/54] dirty-bitmap: Switch bdrv_set_dirty() to
 bytes
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

Both callers already had bytes available, but were scaling to
sectors.  Move the scaling to internal code.  In the case of
bdrv_aligned_pwritev(), we are now passing the exact offset
rather than a rounded sector-aligned value, but that's okay
as long as dirty bitmap widens start/bytes to granularity
boundaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 2 +-
 block/dirty-bitmap.c      | 7 ++++---
 block/io.c                | 6 ++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 99abe2ce74..79366b94b5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1028,7 +1028,7 @@ void blk_dev_eject_request(BlockBackend *blk, bool force);
 bool blk_dev_is_tray_open(BlockBackend *blk);
 bool blk_dev_is_medium_locked(BlockBackend *blk);
 
-void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector, int64_t nr_sect);
+void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 bool bdrv_requests_pending(BlockDriverState *bs);
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 117837b3cc..58a3f330a9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -628,10 +628,10 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
     hbitmap_deserialize_finish(bitmap->bitmap);
 }
 
-void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
-                    int64_t nr_sectors)
+void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
 
     if (QLIST_EMPTY(&bs->dirty_bitmaps)) {
         return;
@@ -643,7 +643,8 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
             continue;
         }
         assert(!bdrv_dirty_bitmap_readonly(bitmap));
-        hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                    end_sector - (offset >> BDRV_SECTOR_BITS));
     }
     bdrv_dirty_bitmaps_unlock(bs);
 }
diff --git a/block/io.c b/block/io.c
index d633b0f851..e0f904583f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1334,7 +1334,6 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bool waited;
     int ret;
 
-    int64_t start_sector = offset >> BDRV_SECTOR_BITS;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     uint64_t bytes_remaining = bytes;
     int max_transfer;
@@ -1409,7 +1408,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
 
     atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
+    bdrv_set_dirty(bs, offset, bytes);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
 
@@ -2438,8 +2437,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     ret = 0;
 out:
     atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
-                   req.bytes >> BDRV_SECTOR_BITS);
+    bdrv_set_dirty(bs, req.offset, req.bytes);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
     return ret;
-- 
2.13.6
