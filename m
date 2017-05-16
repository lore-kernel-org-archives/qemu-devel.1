Received: from eggs.gnu.org ([2001:4830:134:3::10]:41305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNr-0002o5-UN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNo-0003cz-0k
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:20 -0500
Message-Id: <20170516204724.1617-9-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/12] dirty-bitmap: Change bdrv_get_dirty()
 to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Half the callers were already scaling bytes to sectors; the other
half can eventually be simplified to use byte iteration.  Both
callers were already using the result as a bool, so make that
explicit.  Making the change also makes it easier for a future
dirty-bitmap patch to offload scaling over to the internal hbitmap.

Remember, asking whether a byte is dirty is effectively asking
whether the entire granularity containing the byte is dirty, since
we only track dirtiness by granularity.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: tweak commit message, no code change
---
 include/block/dirty-bitmap.h | 4 ++--
 block/dirty-bitmap.c         | 8 ++++----
 block/mirror.c               | 3 +--
 migration/block.c            | 3 +--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index efcec60..b8434e5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -34,8 +34,8 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
-int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                   int64_t sector);
+bool bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                    int64_t offset);
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index e3c2e34..c8100d2 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -332,13 +332,13 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     return list;
 }

-int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                   int64_t sector)
+bool bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                    int64_t offset)
 {
     if (bitmap) {
-        return hbitmap_get(bitmap->bitmap, sector);
+        return hbitmap_get(bitmap->bitmap, offset >> BDRV_SECTOR_BITS);
     } else {
-        return 0;
+        return false;
     }
 }

diff --git a/block/mirror.c b/block/mirror.c
index b82bdce..8b36ec2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -359,8 +359,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         int64_t next_offset = offset + nb_chunks * s->granularity;
         int64_t next_chunk = next_offset / s->granularity;
         if (next_offset >= s->bdev_length ||
-            !bdrv_get_dirty(source, s->dirty_bitmap,
-                            next_offset >> BDRV_SECTOR_BITS)) {
+            !bdrv_get_dirty(source, s->dirty_bitmap, next_offset)) {
             break;
         }
         if (test_bit(next_chunk, s->in_flight_bitmap)) {
diff --git a/migration/block.c b/migration/block.c
index 5a545cf..3e3dec9 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -537,8 +537,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
         } else {
             blk_mig_unlock();
         }
-        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector)) {
-
+        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector * BDRV_SECTOR_SIZE)) {
             if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
                 nr_sectors = total_sectors - sector;
             } else {
-- 
2.9.4
