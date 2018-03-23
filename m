Received: from eggs.gnu.org ([2001:4830:134:3::10]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezPmY-00006u-Rm
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezPmX-0000rF-Tx
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:43:10 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Mar 2018 17:42:53 +0100
Message-Id: <20180323164254.26487-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block: remove bdrv_dirty_bitmap_make_anon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

All this function is doing will be repeated by
bdrv_do_release_matching_dirty_bitmap_locked, except
resetting bm->persistent.  But even that does not matter
because the bitmap will be freed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/dirty-bitmap.c         | 9 ---------
 blockdev.c                   | 1 -
 include/block/dirty-bitmap.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index e27b3096dd..13bb5066a4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -97,15 +97,6 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
     return NULL;
 }
 
-/* Called with BQL taken.  */
-void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
-{
-    assert(!bdrv_dirty_bitmap_frozen(bitmap));
-    g_free(bitmap->name);
-    bitmap->name = NULL;
-    bitmap->persistent = false;
-}
-
 /* Called with BQL taken.  */
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
diff --git a/blockdev.c b/blockdev.c
index c31bf3d98d..6eb18c4ef1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2881,7 +2881,6 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         }
     }
 
-    bdrv_dirty_bitmap_make_anon(bitmap);
     bdrv_release_dirty_bitmap(bs, bitmap);
 }
 
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1ff8949b1b..5a51a78b63 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -24,7 +24,6 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
-void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
 void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs);
-- 
2.16.2
