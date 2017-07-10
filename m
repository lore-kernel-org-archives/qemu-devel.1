Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba6-0000fJ-0q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba2-0001Nb-Rs
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 10 Jul 2017 19:30:24 +0300
Message-Id: <20170710163029.129912-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-1-vsementsov@virtuozzo.com>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 11/16] block/dirty-bitmap: add
 bdrv_dirty_bitmap_set_frozen
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

Make it possible to set bitmap 'frozen' without a successor.
This is needed to protect the bitmap during outgoing bitmap postcopy
migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 22 ++++++++++++++++++++--
 include/block/dirty-bitmap.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b5678d2d25..d79e29786f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
+    bool frozen;                /* Bitmap is frozen, it can't be modified
+                                   through QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
@@ -183,13 +185,22 @@ const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
 {
-    return bitmap->successor;
+    return bitmap->frozen;
+}
+
+/* Called with BQL taken.  */
+void bdrv_dirty_bitmap_set_frozen(BdrvDirtyBitmap *bitmap, bool frozen)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    assert(bitmap->successor == NULL);
+    bitmap->frozen = frozen;
+    qemu_mutex_unlock(bitmap->mutex);
 }
 
 /* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 {
-    return !(bitmap->disabled || bitmap->successor);
+    return !(bitmap->disabled || (bitmap->successor != NULL));
 }
 
 /* Called with BQL taken.  */
@@ -234,6 +245,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
     /* Install the successor and freeze the parent */
     bitmap->successor = child;
+    bitmap->frozen = true;
     return 0;
 }
 
@@ -266,6 +278,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     name = bitmap->name;
     bitmap->name = NULL;
     successor->name = name;
+    assert(bitmap->frozen);
+    bitmap->frozen = false;
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
@@ -298,6 +312,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
         return NULL;
     }
     bdrv_release_dirty_bitmap(bs, successor);
+    assert(parent->frozen);
+    parent->frozen = false;
     parent->successor = NULL;
 
     return parent;
@@ -311,6 +327,8 @@ void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
 
     if (parent->successor) {
         bdrv_release_dirty_bitmap(bs, parent->successor);
+        assert(parent->frozen);
+        parent->frozen = false;
         parent->successor = NULL;
     }
 
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index fa2f670050..cd831d40de 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -39,6 +39,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_set_frozen(BdrvDirtyBitmap *bitmap, bool frozen);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
-- 
2.11.1
