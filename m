Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkl-0000XU-9C
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkk-0006YA-CQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:11 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:29 +0200
Message-Id: <20170711160814.20941-41-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 40/85] block/dirty-bitmap: add
 bdrv_dirty_bitmap_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-19-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h | 2 ++
 block/dirty-bitmap.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index bdf43df..c8b3110 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -95,5 +95,7 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 3c17c45..d146941 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -718,3 +718,10 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
 
     return false;
 }
+
+BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap)
+{
+    return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
+                            QLIST_NEXT(bitmap, list);
+}
-- 
2.9.4
