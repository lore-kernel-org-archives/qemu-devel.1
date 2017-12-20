Received: from eggs.gnu.org ([208.118.235.92]:35028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003ub-PR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005dD-8b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:35 +0300
Message-Id: <20171220154945.88410-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  3 +++
 block/dirty-bitmap.c         | 25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 93d4336505..caf1f3d861 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -92,5 +92,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
+                                                  BdrvDirtyBitmap *bitmap,
+                                                  Error **errp);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d83da077d5..fe27ddfb83 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -327,15 +327,11 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
  * The merged parent will be un-frozen, but not explicitly re-enabled.
  * Called with BQL taken.
  */
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
-                                           BdrvDirtyBitmap *parent,
-                                           Error **errp)
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
+                                                  BdrvDirtyBitmap *parent,
+                                                  Error **errp)
 {
-    BdrvDirtyBitmap *successor;
-
-    qemu_mutex_lock(parent->mutex);
-
-    successor = parent->successor;
+    BdrvDirtyBitmap *successor = parent->successor;
 
     if (!successor) {
         error_setg(errp, "Cannot reclaim a successor when none is present");
@@ -349,9 +345,20 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     bdrv_release_dirty_bitmap_locked(bs, successor);
     parent->successor = NULL;
 
+    return parent;
+}
+
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
+                                           BdrvDirtyBitmap *parent,
+                                           Error **errp)
+{
+    BdrvDirtyBitmap *ret;
+
+    qemu_mutex_lock(parent->mutex);
+    ret = bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
     qemu_mutex_unlock(parent->mutex);
 
-    return parent;
+    return ret;
 }
 
 /**
-- 
2.11.1
