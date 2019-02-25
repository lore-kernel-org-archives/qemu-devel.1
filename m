Received: from eggs.gnu.org ([209.51.188.92]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyIXX-0007xi-Di
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyIXW-0006ud-4s
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:51:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 18:51:19 +0300
Message-Id: <20190225155119.21619-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190223002209.23084-2-jsnow@redhat.com>
References: <20190223002209.23084-2-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] dirty-bitmap: introduce inconsistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com

This will be used to show in dirty-bitmaps list inconsistent bitmaps
found in qcow2 image on open. On open, bitmap in qcow2 image considered
inconsistent if it has IN_USE flag already set.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

It's my counter-proposal for
 "[PATCH v2 1/4] block/dirty-bitmaps: add inconsistent bit" by John.

Difference:

Require that we don't have data for such bitmaps, which is more strict
than just not load them in qcow2 code. Just don't allocate HBitmap.
So, we save RAM. And we don't need a lot of assertions on
!bitmap->inconsistent for operations, as we'll crash with segfault.
(of course, we still need checking this, to produce correct errors in
 QAPI, so it's only a counter-proposal to the first patch of John's
 series)

 qapi/block-core.json         |  8 +++++-
 include/block/dirty-bitmap.h |  5 ++++
 block/dirty-bitmap.c         | 56 +++++++++++++++++++++++++++++-------
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6e543594b3..7620653c54 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -470,12 +470,18 @@
 # @persistent: true if the bitmap will eventually be flushed to persistent
 #              storage (since 4.0)
 #
+# @inconsistent: true if the bitmap is inconsistent. Inconsistent bitmaps may
+#                be only removed. Source of inconsistent bitmaps are persistent
+#                bitmaps which were not correctly saved on some point (for
+#                example, due to unexpected Qemu crash)
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
            'recording': 'bool', 'busy': 'bool',
-           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
+           'status': 'DirtyBitmapStatus', 'persistent': 'bool',
+           '*inconsistent': 'bool' } }
 
 ##
 # @Qcow2BitmapInfoFlags:
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index ba8477b73f..f2cce7694d 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -9,6 +9,11 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
                                           Error **errp);
+BdrvDirtyBitmap *bdrv_create_inconsistent_dirty_bitmap(BlockDriverState *bs,
+                                                       uint32_t granularity,
+                                                       const char *name,
+                                                       Error **errp);
+
 void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                                    int chunk_size);
 void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 86c3b87ab9..f3b74d0900 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -30,12 +30,20 @@
 
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
-    HBitmap *bitmap;            /* Dirty bitmap implementation */
+    HBitmap *bitmap;            /*
+                                 * Dirty bitmap implementation.
+                                 * May bu NULL, in which case the bitmap is
+                                 * "inconsistent". Bitmap don't have
+                                 * bitmap data and don't support any operations
+                                 * related to it. The only allowed modifications
+                                 * are remove and truncate.
+                                 */
     HBitmap *meta;              /* Meta dirty bitmap */
     bool busy;                  /* Bitmap is busy, it can't be used via QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
+    uint32_t granularity;       /* Granularity of the bitmap, in bytes */
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
                                    the device */
     int active_iterators;       /* How many iterators are active */
@@ -93,10 +101,11 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
 }
 
 /* Called with BQL taken.  */
-BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
-                                          uint32_t granularity,
-                                          const char *name,
-                                          Error **errp)
+static BdrvDirtyBitmap *do_bdrv_create_dirty_bitmap(BlockDriverState *bs,
+                                                    uint32_t granularity,
+                                                    const char *name,
+                                                    bool inconsistent,
+                                                    Error **errp)
 {
     int64_t bitmap_size;
     BdrvDirtyBitmap *bitmap;
@@ -115,16 +124,34 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
+    bitmap->bitmap =
+        inconsistent ? NULL : hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size = bitmap_size;
+    bitmap->granularity = granularity;
     bitmap->name = g_strdup(name);
-    bitmap->disabled = false;
+    bitmap->disabled = inconsistent;
     bdrv_dirty_bitmaps_lock(bs);
     QLIST_INSERT_HEAD(&bs->dirty_bitmaps, bitmap, list);
     bdrv_dirty_bitmaps_unlock(bs);
     return bitmap;
 }
 
+BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
+                                          uint32_t granularity,
+                                          const char *name,
+                                          Error **errp)
+{
+    return do_bdrv_create_dirty_bitmap(bs, granularity, name, false, errp);
+}
+
+BdrvDirtyBitmap *bdrv_create_inconsistent_dirty_bitmap(BlockDriverState *bs,
+                                                       uint32_t granularity,
+                                                       const char *name,
+                                                       Error **errp)
+{
+    return do_bdrv_create_dirty_bitmap(bs, granularity, name, true, errp);
+}
+
 /* bdrv_create_meta_dirty_bitmap
  *
  * Create a meta dirty bitmap that tracks the changes of bits in @bitmap. I.e.
@@ -269,6 +296,8 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 {
+    assert(bitmap->bitmap);
+
     bitmap->disabled = false;
 }
 
@@ -288,7 +317,9 @@ static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_busy(bitmap));
     assert(!bitmap->meta);
     QLIST_REMOVE(bitmap, list);
-    hbitmap_free(bitmap->bitmap);
+    if (bitmap->bitmap) {
+        hbitmap_free(bitmap->bitmap);
+    }
     g_free(bitmap->name);
     g_free(bitmap);
 }
@@ -380,7 +411,9 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_busy(bitmap));
         assert(!bitmap->active_iterators);
-        hbitmap_truncate(bitmap->bitmap, bytes);
+        if (bitmap->bitmap) {
+            hbitmap_truncate(bitmap->bitmap, bytes);
+        }
         bitmap->size = bytes;
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -455,6 +488,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
         BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
         info->count = bdrv_get_dirty_count(bm);
+        info->has_inconsistent = info->inconsistent = !bm->bitmap;
         info->granularity = bdrv_dirty_bitmap_granularity(bm);
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
@@ -504,7 +538,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
 
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
 {
-    return 1U << hbitmap_granularity(bitmap->bitmap);
+    return bitmap->granularity;
 }
 
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap)
@@ -668,7 +702,7 @@ void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t offset)
 
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_count(bitmap->bitmap);
+    return bitmap->bitmap ? hbitmap_count(bitmap->bitmap) : -1;
 }
 
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
-- 
2.18.0
