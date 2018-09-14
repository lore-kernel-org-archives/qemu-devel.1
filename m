Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0poe-0004ka-TV
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g0poZ-0001TR-DA
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:15:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Sep 2018 18:15:12 +0300
Message-Id: <20180914151515.21242-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180914151515.21242-1-vsementsov@virtuozzo.com>
References: <20180914151515.21242-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/5] dirty-bitmap: rename
 bdrv_undo_clear_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Use more generic names to reuse the function for bitmap merge in the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 2 +-
 block/dirty-bitmap.c      | 4 ++--
 blockdev.c                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 903b9c1034..677065ae30 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1149,7 +1149,7 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
-void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
+void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6c8761e027..017ee9db46 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -633,12 +633,12 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
     bdrv_dirty_bitmap_unlock(bitmap);
 }
 
-void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
+void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
 {
     HBitmap *tmp = bitmap->bitmap;
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    bitmap->bitmap = in;
+    bitmap->bitmap = backup;
     hbitmap_free(tmp);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 902338e815..f133e87414 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2032,7 +2032,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
                                              common, common);
 
     if (state->backup) {
-        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
+        bdrv_restore_dirty_bitmap(state->bitmap, state->backup);
     }
 }
 
-- 
2.18.0
