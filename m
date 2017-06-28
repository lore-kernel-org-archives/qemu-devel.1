Received: from eggs.gnu.org ([2001:4830:134:3::10]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHCE-0000m9-EH
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHCD-0002US-5X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:56:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:33 -0500
Message-Id: <20170628175534.14295-11-eblake@redhat.com>
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
References: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/11] dirty-bitmap: Switch bdrv_set_dirty()
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Both callers already had bytes available, but were scaling to
sectors.  Move the scaling to internal code.  In the case of
bdrv_aligned_pwritev(), we are now passing the exact offset
rather than a rounded sector-aligned value, but that's okay
as long as dirty bitmap widens start/bytes to granularity
boundaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v3: rebase to lock context changes, R-b kept
v2: no change
---
 include/block/block_int.h | 2 +-
 block/dirty-bitmap.c      | 7 ++++---
 block/io.c                | 6 ++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602..36b2153 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -953,7 +953,7 @@ void blk_dev_eject_request(BlockBackend *blk, bool force);
 bool blk_dev_is_tray_open(BlockBackend *blk);
 bool blk_dev_is_medium_locked(BlockBackend *blk);

-void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector, int64_t nr_sect);
+void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 bool bdrv_requests_pending(BlockDriverState *bs);

 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 95716be..e353b69 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -550,10 +550,10 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
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
@@ -564,7 +564,8 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
-        hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
+        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
+                    end_sector - (offset >> BDRV_SECTOR_BITS));
     }
     bdrv_dirty_bitmaps_unlock(bs);
 }
diff --git a/block/io.c b/block/io.c
index 061a162..c7ffa95 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1310,7 +1310,6 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bool waited;
     int ret;

-    int64_t start_sector = offset >> BDRV_SECTOR_BITS;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     uint64_t bytes_remaining = bytes;
     int max_transfer;
@@ -1381,7 +1380,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);

     atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, start_sector, end_sector - start_sector);
+    bdrv_set_dirty(bs, offset, bytes);

     stat64_max(&bs->wr_highest_offset, offset + bytes);

@@ -2362,8 +2361,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
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
2.9.4
