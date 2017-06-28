Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj5-0006QE-2X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj2-00031d-J9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:42 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:41998 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002w2-5C
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:15 +0300
Message-Id: <20170628120530.31251-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 15/30] block/dirty-bitmap: add autoload
 field to BdrvDirtyBitmap
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

Mirror AUTO flag from Qcow2 bitmap in BdrvDirtyBitmap. This will be
needed in future, to save this flag back to Qcow2 for persistent
bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 18 ++++++++++++++++++
 block/qcow2-bitmap.c         |  2 ++
 include/block/dirty-bitmap.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 17d3068336..06dc7a3ac9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -52,6 +52,8 @@ struct BdrvDirtyBitmap {
                                    Such operations must fail and both the image
                                    and this bitmap must remain unchanged while
                                    this flag is set. */
+    bool autoload;              /* For persistent bitmaps: bitmap must be
+                                   autoloaded on image opening */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -100,6 +102,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     g_free(bitmap->name);
     bitmap->name = NULL;
+    bitmap->autoload = false;
 }
 
 /* Called with BQL taken.  */
@@ -296,6 +299,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->autoload = bitmap->autoload;
+    bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -671,3 +676,16 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
 
     return false;
 }
+
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->autoload = autoload;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->autoload;
+}
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index a21fab8ce8..ee6d8f75a9 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -793,6 +793,8 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             if (bitmap == NULL) {
                 goto fail;
             }
+
+            bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
                     g_slist_append(created_dirty_bitmaps, bitmap);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index cb43fa37e2..e2fea12b94 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -72,6 +72,7 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
+void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
@@ -89,5 +90,6 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
+bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 
 #endif
-- 
2.11.1
