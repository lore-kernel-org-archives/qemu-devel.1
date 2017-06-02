Received: from eggs.gnu.org ([2001:4830:134:3::10]:36184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGkej-0006Hn-C9
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGkef-0005bV-6s
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:20786 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGkee-0005Xc-SB
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Jun 2017 14:21:58 +0300
Message-Id: <20170602112158.232757-31-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-1-vsementsov@virtuozzo.com>
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v20 30/30] block: release persistent bitmaps on
 inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

We should release them here to reload on invalidate cache.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                      |  4 ++++
 block/dirty-bitmap.c         | 29 +++++++++++++++++++++++------
 include/block/dirty-bitmap.h |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index a1e67759b9..1043e64a19 100644
--- a/block.c
+++ b/block.c
@@ -4110,6 +4110,10 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
         }
     }
 
+    /* At this point persistent bitmaps should be already stored by the format
+     * driver */
+    bdrv_release_persistent_dirty_bitmaps(bs);
+
     return 0;
 }
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6b43ad04fc..45b18dd3f3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -301,13 +301,18 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
     }
 }
 
-static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
-                                                  BdrvDirtyBitmap *bitmap,
-                                                  bool only_named)
+static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
+{
+    return !!bdrv_dirty_bitmap_name(bitmap);
+}
+
+static void bdrv_do_release_matching_dirty_bitmap(
+    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+    bool (*cond)(BdrvDirtyBitmap *bitmap))
 {
     BdrvDirtyBitmap *bm, *next;
     QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
-        if ((!bitmap || bm == bitmap) && (!only_named || bm->name)) {
+        if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
             assert(!bm->active_iterators);
             assert(!bdrv_dirty_bitmap_frozen(bm));
             assert(!bm->meta);
@@ -328,7 +333,7 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
 
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
+    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, NULL);
 }
 
 /**
@@ -338,7 +343,19 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
  */
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
+    bdrv_do_release_matching_dirty_bitmap(bs, NULL, bdrv_dirty_bitmap_has_name);
+}
+
+/**
+ * Release all persistent dirty bitmaps attached to a BDS (for use in
+ * bdrv_inactivate_recurse()).
+ * There must not be any frozen bitmaps attached.
+ * This function does not remove persistent bitmaps from the storage.
+ */
+void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs)
+{
+    bdrv_do_release_matching_dirty_bitmap(bs, NULL,
+                                          bdrv_dirty_bitmap_get_persistance);
 }
 
 /**
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 5fac2d8411..6fec93bdeb 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -25,6 +25,7 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
+void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs);
 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          const char *name,
                                          Error **errp);
-- 
2.11.1
