Received: from eggs.gnu.org ([2001:4830:134:3::10]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaO-0001ua-K3
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaK-0003Ut-OE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaK-0003UN-KR
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:36 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:28 -0400
Message-Id: <20180611193434.19004-2-jsnow@redhat.com>
In-Reply-To: <20180611193434.19004-1-jsnow@redhat.com>
References: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] block: remove bdrv_dirty_bitmap_make_anon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

All this function is doing will be repeated by
bdrv_do_release_matching_dirty_bitmap_locked, except
resetting bm->persistent.  But even that does not matter
because the bitmap will be freed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180323164254.26487-1-pbonzini@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 9 ---------
 blockdev.c                   | 1 -
 include/block/dirty-bitmap.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 967159479d..ea82c06f07 100644
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
index 8de95be8f4..266ecc06cc 100644
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
2.14.3
