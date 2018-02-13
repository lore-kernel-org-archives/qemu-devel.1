Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1u-0003A1-DD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1p-0005Rv-Ig
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:50 +0100
Message-Id: <20180213170529.10858-17-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/55] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

To maintain load/store disabled bitmap there is new approach:

 - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
 - store enabled bitmaps as "auto" to qcow2
 - store disabled bitmaps without "auto" flag to qcow2
 - on qcow2 open load "auto" bitmaps as enabled and others
   as disabled (except in_use bitmaps)

Also, adjust iotests 165 and 176 appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180202160752.143796-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json         |  6 +++---
 block/qcow2.h                |  2 +-
 include/block/dirty-bitmap.h |  1 -
 block/dirty-bitmap.c         | 18 ------------------
 block/qcow2-bitmap.c         | 12 +++++++-----
 block/qcow2.c                |  2 +-
 blockdev.c                   | 10 ++--------
 qemu-doc.texi                |  7 +++++++
 tests/qemu-iotests/165       |  2 +-
 tests/qemu-iotests/176       |  2 +-
 10 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8046c2da23..2c107823fe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1593,9 +1593,9 @@
 #              Qcow2 disks support persistent bitmaps. Default is false for
 #              block-dirty-bitmap-add. (Since: 2.10)
 #
-# @autoload: the bitmap will be automatically loaded when the image it is stored
-#            in is opened. This flag may only be specified for persistent
-#            bitmaps. Default is false for block-dirty-bitmap-add. (Since: 2.10)
+# @autoload: ignored and deprecated since 2.12.
+#            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
+#            open.
 #
 # Since: 2.4
 ##
diff --git a/block/qcow2.h b/block/qcow2.h
index 46c8cf44ec..016e87c81a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -663,7 +663,7 @@ void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
-bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 3da8486ab1..e3f4bbf51d 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -66,7 +66,6 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
-void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 7879d13ddb..909f0517f8 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -52,8 +52,6 @@ struct BdrvDirtyBitmap {
                                    Such operations must fail and both the image
                                    and this bitmap must remain unchanged while
                                    this flag is set. */
-    bool autoload;              /* For persistent bitmaps: bitmap must be
-                                   autoloaded on image opening */
     bool persistent;            /* bitmap must be saved to owner disk image */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
@@ -104,7 +102,6 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     g_free(bitmap->name);
     bitmap->name = NULL;
     bitmap->persistent = false;
-    bitmap->autoload = false;
 }
 
 /* Called with BQL taken.  */
@@ -261,8 +258,6 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
-    successor->autoload = bitmap->autoload;
-    bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
 }
 
 /* Called with BQL taken. */
-void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
-{
-    qemu_mutex_lock(bitmap->mutex);
-    bitmap->autoload = autoload;
-    qemu_mutex_unlock(bitmap->mutex);
-}
-
-bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
-{
-    return bitmap->autoload;
-}
-
-/* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
 {
     qemu_mutex_lock(bitmap->mutex);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index efa10c6663..4f6fd863ea 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -933,14 +933,14 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
-/* qcow2_load_autoloading_dirty_bitmaps()
+/* qcow2_load_dirty_bitmaps()
  * Return value is a hint for caller: true means that the Qcow2 header was
  * updated. (false doesn't mean that the header should be updated by the
  * caller, it just means that updating was not needed or the image cannot be
  * written to).
  * On failure the function returns false.
  */
-bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
@@ -960,14 +960,16 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if ((bm->flags & BME_FLAG_AUTO) && !(bm->flags & BME_FLAG_IN_USE)) {
+        if (!(bm->flags & BME_FLAG_IN_USE)) {
             BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
             if (bitmap == NULL) {
                 goto fail;
             }
 
+            if (!(bm->flags & BME_FLAG_AUTO)) {
+                bdrv_disable_dirty_bitmap(bitmap);
+            }
             bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
                     g_slist_append(created_dirty_bitmaps, bitmap);
@@ -1369,7 +1371,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             bm->table.size = 0;
             QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
         }
-        bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
+        bm->flags = bdrv_dirty_bitmap_enabled(bitmap) ? BME_FLAG_AUTO : 0;
         bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
         bm->dirty_bitmap = bitmap;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 801e29fc56..80774aacf6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1460,7 +1460,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
+    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
         update_header = false;
     }
     if (local_err != NULL) {
diff --git a/blockdev.c b/blockdev.c
index 7423c5317b..3fb1ca803c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2825,14 +2825,9 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     if (!has_persistent) {
         persistent = false;
     }
-    if (!has_autoload) {
-        autoload = false;
-    }
 
-    if (has_autoload && !persistent) {
-        error_setg(errp, "Autoload flag must be used only for persistent "
-                         "bitmaps");
-        return;
+    if (has_autoload) {
+        warn_report("Autoload option is deprecated and its value is ignored");
     }
 
     if (persistent &&
@@ -2847,7 +2842,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
-    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 769968aba4..137f5814a8 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2757,6 +2757,13 @@ used and it will be removed with no replacement.
 The ``convert -s snapshot_id_or_name'' argument is obsoleted
 by the ``convert -l snapshot_param'' argument instead.
 
+@section QEMU Machine Protocol (QMP) commands
+
+@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
+
+"autoload" parameter is now ignored. All bitmaps are automatically loaded
+from qcow2 images.
+
 @section System emulator human monitor commands
 
 @subsection host_net_add (since 2.10.0)
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index a3932db3de..2936929627 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -64,7 +64,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def qmpAddBitmap(self):
         self.vm.qmp('block-dirty-bitmap-add', node='drive0',
-                    name='bitmap0', persistent=True, autoload=True)
+                    name='bitmap0', persistent=True)
 
     def test_persistent(self):
         self.vm = self.mkVm()
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index d38b3aeb91..32baa116dd 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -95,7 +95,7 @@ case $reason in
      "file": { "driver": "file", "filename": "$TEST_IMG" } } }
 { "execute": "block-dirty-bitmap-add",
   "arguments": { "node": "drive0", "name": "bitmap0",
-     "persistent": true, "autoload": true } }
+     "persistent": true } }
 { "execute": "quit" }
 EOF
 	;;
-- 
2.13.6
