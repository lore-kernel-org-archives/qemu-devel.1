Received: from eggs.gnu.org ([2001:4830:134:3::10]:41365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNx-0002rI-KL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNw-0003fH-ML
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:48:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:23 -0500
Message-Id: <20170516204724.1617-12-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/12] dirty-bitmap: Switch bdrv_set_dirty()
 to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Both callers already had bytes available, but were scaling to
sectors.  Move the scaling to internal code.  In the case of
bdrv_aligned_pwritev(), we are now passing the exact offset
rather than a rounded sector-aligned value, but that's okay
as long as dirty bitmap widens start/bytes to granularity
boundaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 include/block/block_int.h | 2 +-
 block/dirty-bitmap.c      | 8 +++++---
 block/io.c                | 6 ++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724c..eec9835 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -931,7 +931,7 @@ void blk_dev_eject_request(BlockBackend *blk, bool force);
 bool blk_dev_is_tray_open(BlockBackend *blk);
 bool blk_dev_is_medium_locked(BlockBackend *blk);

-void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector, int64_t nr_sect);
+void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 bool bdrv_requests_pending(BlockDriverState *bs);

 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8e7822c..ef165eb 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -478,15 +478,17 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
     hbitmap_deserialize_finish(bitmap->bitmap);
 }

-void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
-                    int64_t nr_sectors)
+void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
-        hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                    end_sector - (offset >> BDRV_SECTOR_BITS));
     }
 }

diff --git a/block/io.c b/block/io.c
index d4f1925..e86a546 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1324,7 +1324,6 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bool waited;
     int ret;

-    int64_t start_sector = offset >> BDRV_SECTOR_BITS;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     uint64_t bytes_remaining = bytes;
     int max_transfer;
@@ -1395,7 +1394,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);

     ++bs->write_gen;
-    bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
+    bdrv_set_dirty(bs, offset, bytes);

     if (bs->wr_highest_offset < offset + bytes) {
         bs->wr_highest_offset = offset + bytes;
@@ -2529,8 +2528,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     ret = 0;
 out:
     ++bs->write_gen;
-    bdrv_set_dirty(bs, req.offset >> BDRV_SECTOR_BITS,
-                   req.bytes >> BDRV_SECTOR_BITS);
+    bdrv_set_dirty(bs, req.offset, req.bytes);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
     return ret;
-- 
2.9.4
