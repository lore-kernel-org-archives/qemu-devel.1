Received: from eggs.gnu.org ([2001:4830:134:3::10]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L9-0000W5-LC
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L4-00078h-Dx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:28 +0300
Message-Id: <1486479940-163258-6-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 05/17] block: add bdrv_next_dirty_bitmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Like bdrv_next()  - bdrv_next_dirty_bitmap() is a function to provide
access to private dirty bitmaps list.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 10 ++++++++++
 include/block/dirty-bitmap.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c..7547c78 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -533,3 +533,13 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
+
+BdrvDirtyBitmap *bdrv_next_dirty_bitmap(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap)
+{
+    if (bitmap == NULL) {
+        return QLIST_FIRST(&bs->dirty_bitmaps);
+    }
+
+    return QLIST_NEXT(bitmap, list);
+}
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 9dea14b..1a457d5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -72,4 +72,7 @@ void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+BdrvDirtyBitmap *bdrv_next_dirty_bitmap(BlockDriverState *bs,
+                                        BdrvDirtyBitmap *bitmap);
+
 #endif
-- 
1.8.3.1
