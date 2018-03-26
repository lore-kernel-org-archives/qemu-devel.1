Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBT-00045Y-Mo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBR-0007Nn-4c
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:20:55 +0300
Message-Id: <20180326112056.8420-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180326112056.8420-1-vsementsov@virtuozzo.com>
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/7] block/dirty-bitmap:
 bdrv_clear_dirty_bitmap: drop unused parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Drop parameter "HBitmap **out" which is unused now, all callers set
it to NULL.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  2 +-
 block/dirty-bitmap.c      | 14 +++++---------
 blockdev.c                |  4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e5af7820ff..b2ef0f472d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1078,7 +1078,7 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
 
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
-void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
+void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 1812e17549..139102f24e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -591,19 +591,15 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
     bdrv_dirty_bitmap_unlock(bitmap);
 }
 
-void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
+void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
+
     bdrv_dirty_bitmap_lock(bitmap);
-    if (!out) {
-        hbitmap_reset_all(bitmap->bitmap);
-    } else {
-        HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(bitmap->size,
-                                       hbitmap_granularity(backup));
-        *out = backup;
-    }
+
+    hbitmap_reset_all(bitmap->bitmap);
+
     bdrv_dirty_bitmap_unlock(bitmap);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 88eae60c1c..54e1ba8f44 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2135,7 +2135,7 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
-    bdrv_clear_dirty_bitmap(state->bitmap, NULL);
+    bdrv_clear_dirty_bitmap(state->bitmap);
 }
 
 static void abort_prepare(BlkActionState *common, Error **errp)
@@ -2906,7 +2906,7 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
         return;
     }
 
-    bdrv_clear_dirty_bitmap(bitmap, NULL);
+    bdrv_clear_dirty_bitmap(bitmap);
 }
 
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
-- 
2.11.1
