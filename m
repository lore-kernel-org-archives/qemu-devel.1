Received: from eggs.gnu.org ([2001:4830:134:3::10]:45185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-00040x-7i
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF24-0002G6-JC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF24-0002Fr-D1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:08 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:45 -0400
Message-Id: <20181029212501.5897-4-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 03/19] dirty-bitmap: rename
 bdrv_undo_clear_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use more generic names to reuse the function for bitmap merge in the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c      | 4 ++--
 blockdev.c                | 2 +-
 include/block/block_int.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index e3398e141a..598ff87519 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2033,7 +2033,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
                                              common, common);
 
     if (state->backup) {
-        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
+        bdrv_restore_dirty_bitmap(state->bitmap, state->backup);
     }
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92ecbd866e..f605622216 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1155,7 +1155,7 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
-void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
+void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
-- 
2.14.5
