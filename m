Received: from eggs.gnu.org ([2001:4830:134:3::10]:43745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duP13-0006ha-0L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duP11-0005lX-HG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:21:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 15:19:03 -0500
Message-Id: <20170919201910.25656-14-eblake@redhat.com>
In-Reply-To: <20170919201910.25656-1-eblake@redhat.com>
References: <20170919201910.25656-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 13/20] dirty-bitmap: Change
 bdrv_get_dirty_locked() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v4: only context change
v3: rebase to _locked rename was straightforward enough that R-b kept
v2: tweak commit message, no code change
---
 include/block/dirty-bitmap.h | 4 ++--
 block/dirty-bitmap.c         | 8 ++++----
 block/mirror.c               | 3 +--
 migration/block.c            | 3 ++-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 757fc4c5b8..9e39537e4b 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -72,8 +72,8 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap);
-int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                          int64_t sector);
+bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                           int64_t offset);
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t cur_sector, int64_t nr_sectors);
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8322e23f0d..ad559c62b1 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -438,13 +438,13 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
 }

 /* Called within bdrv_dirty_bitmap_lock..unlock */
-int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-                          int64_t sector)
+bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                           int64_t offset)
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
index 7113d47db4..e36fc81df3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -361,8 +361,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         int64_t next_offset = offset + nb_chunks * s->granularity;
         int64_t next_chunk = next_offset / s->granularity;
         if (next_offset >= s->bdev_length ||
-            !bdrv_get_dirty_locked(source, s->dirty_bitmap,
-                                   next_offset >> BDRV_SECTOR_BITS)) {
+            !bdrv_get_dirty_locked(source, s->dirty_bitmap, next_offset)) {
             break;
         }
         if (test_bit(next_chunk, s->in_flight_bitmap)) {
diff --git a/migration/block.c b/migration/block.c
index a3512945da..b618869661 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -530,7 +530,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             blk_mig_unlock();
         }
         bdrv_dirty_bitmap_lock(bmds->dirty_bitmap);
-        if (bdrv_get_dirty_locked(bs, bmds->dirty_bitmap, sector)) {
+        if (bdrv_get_dirty_locked(bs, bmds->dirty_bitmap,
+                                  sector * BDRV_SECTOR_SIZE)) {
             if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
                 nr_sectors = total_sectors - sector;
             } else {
-- 
2.13.5
