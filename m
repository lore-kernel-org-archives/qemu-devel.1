Received: from eggs.gnu.org ([2001:4830:134:3::10]:48586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejS7V-00075N-Uk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejS7U-0000yv-AC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:58:49 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  7 Feb 2018 18:58:28 +0300
Message-Id: <20180207155837.92351-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180207155837.92351-1-vsementsov@virtuozzo.com>
References: <20180207155837.92351-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v10 03/12] block/dirty-bitmap: add _locked
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
 block/dirty-bitmap.c         | 28 ++++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 93e128f81b..b2e1fd913a 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -92,5 +92,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
+                                                  BdrvDirtyBitmap *bitmap,
+                                                  Error **errp);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 75435f6c2f..ce00ff3474 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -320,17 +320,13 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
  * In cases of failure where we can no longer safely delete the parent,
  * we may wish to re-join the parent and child/successor.
  * The merged parent will be un-frozen, but not explicitly re-enabled.
- * Called with BQL taken.
+ * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
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
@@ -344,9 +340,21 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     bdrv_release_dirty_bitmap_locked(bs, successor);
     parent->successor = NULL;
 
+    return parent;
+}
+
+/* Called with BQL taken. */
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
