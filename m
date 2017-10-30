Received: from eggs.gnu.org ([2001:4830:134:3::10]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D08-0006LI-JK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006bZ-Dq
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:32:57 +0300
Message-Id: <20171030163309.75770-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 02/14] block/dirty-bitmap: add locked
 version of bdrv_release_dirty_bitmap
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

It is needed to realize bdrv_dirty_bitmap_release_successor in
the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 81adbeb6d4..981f99d362 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -326,13 +326,13 @@ static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
     return !!bdrv_dirty_bitmap_name(bitmap);
 }
 
-/* Called with BQL taken.  */
-static void bdrv_do_release_matching_dirty_bitmap(
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+static void bdrv_do_release_matching_dirty_bitmap_locked(
     BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
     bool (*cond)(BdrvDirtyBitmap *bitmap))
 {
     BdrvDirtyBitmap *bm, *next;
-    bdrv_dirty_bitmaps_lock(bs);
+
     QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
         if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
             assert(!bm->active_iterators);
@@ -344,18 +344,33 @@ static void bdrv_do_release_matching_dirty_bitmap(
             g_free(bm);
 
             if (bitmap) {
-                goto out;
+                return;
             }
         }
     }
+
     if (bitmap) {
         abort();
     }
+}
 
-out:
+/* Called with BQL taken.  */
+static void bdrv_do_release_matching_dirty_bitmap(
+    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+    bool (*cond)(BdrvDirtyBitmap *bitmap))
+{
+    bdrv_dirty_bitmaps_lock(bs);
+    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, cond);
     bdrv_dirty_bitmaps_unlock(bs);
 }
 
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
+                                             BdrvDirtyBitmap *bitmap)
+{
+    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, NULL);
+}
+
 /* Called with BQL taken.  */
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
-- 
2.11.1
