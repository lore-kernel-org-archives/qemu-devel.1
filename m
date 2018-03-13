Received: from eggs.gnu.org ([2001:4830:134:3::10]:34635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lK-99
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFu-0005kx-PQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFu-0005km-K5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:31 -0400
Message-Id: <20180313211441.5179-4-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] block/dirty-bitmap: add _locked version
 of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180207155837.92351-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 30 +++++++++++++++++++-----------
 include/block/dirty-bitmap.h |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

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
@@ -344,11 +340,23 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     bdrv_release_dirty_bitmap_locked(bs, successor);
     parent->successor = NULL;
 
-    qemu_mutex_unlock(parent->mutex);
-
     return parent;
 }
 
+/* Called with BQL taken. */
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
+                                           BdrvDirtyBitmap *parent,
+                                           Error **errp)
+{
+    BdrvDirtyBitmap *ret;
+
+    qemu_mutex_lock(parent->mutex);
+    ret = bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
+    qemu_mutex_unlock(parent->mutex);
+
+    return ret;
+}
+
 /**
  * Truncates _all_ bitmaps attached to a BDS.
  * Called with BQL taken.
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index e0ebc96b01..5c239be74d 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -93,5 +93,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
+                                                  BdrvDirtyBitmap *bitmap,
+                                                  Error **errp);
 
 #endif
-- 
2.14.3
