Received: from eggs.gnu.org ([2001:4830:134:3::10]:33114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLfkm-0006wZ-F2
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLfkk-00027E-7Q
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dLfkj-00026L-UT
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:08:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 16 Jun 2017 09:08:27 +0800
Message-Id: <20170616010827.32307-2-famz@redhat.com>
In-Reply-To: <20170616010827.32307-1-famz@redhat.com>
References: <20170616010827.32307-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v4 18/23] block: introduce dirty_bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

It protects only the list of dirty bitmaps; in the next patch we will
also protect their content.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170605123908.18777-15-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   |  1 +
 block/dirty-bitmap.c      | 44 +++++++++++++++++++++++++++++++++++++++++++-
 block/mirror.c            |  3 ++-
 blockdev.c                | 44 +++++++-------------------------------------
 include/block/block_int.h |  5 +++++
 migration/block.c         |  6 ------
 6 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/block.c b/block.c
index a5cbd45..6943962 100644
--- a/block.c
+++ b/block.c
@@ -321,6 +321,7 @@ BlockDriverState *bdrv_new(void)
     }
     notifier_with_return_list_init(&bs->before_write_notifiers);
     qemu_co_mutex_init(&bs->reqs_lock);
+    qemu_mutex_init(&bs->dirty_bitmap_mutex);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
 
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c..fa78109 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -52,6 +52,17 @@ struct BdrvDirtyBitmapIter {
     BdrvDirtyBitmap *bitmap;
 };
 
+static inline void bdrv_dirty_bitmaps_lock(BlockDriverState *bs)
+{
+    qemu_mutex_lock(&bs->dirty_bitmap_mutex);
+}
+
+static inline void bdrv_dirty_bitmaps_unlock(BlockDriverState *bs)
+{
+    qemu_mutex_unlock(&bs->dirty_bitmap_mutex);
+}
+
+/* Called with BQL or dirty_bitmap lock taken.  */
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
 {
     BdrvDirtyBitmap *bm;
@@ -65,6 +76,7 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
     return NULL;
 }
 
+/* Called with BQL taken.  */
 void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
 {
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
@@ -72,6 +84,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     bitmap->name = NULL;
 }
 
+/* Called with BQL taken.  */
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
@@ -100,7 +113,9 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
+    bdrv_dirty_bitmaps_lock(bs);
     QLIST_INSERT_HEAD(&bs->dirty_bitmaps, bitmap, list);
+    bdrv_dirty_bitmaps_unlock(bs);
     return bitmap;
 }
 
@@ -164,16 +179,19 @@ const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
     return bitmap->name;
 }
 
+/* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
 {
     return bitmap->successor;
 }
 
+/* Called with BQL taken.  */
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 {
     return !(bitmap->disabled || bitmap->successor);
 }
 
+/* Called with BQL taken.  */
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_frozen(bitmap)) {
@@ -188,6 +206,7 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
  * Requires that the bitmap is not frozen and has no successor.
+ * Called with BQL taken.
  */
 int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
                                        BdrvDirtyBitmap *bitmap, Error **errp)
@@ -220,6 +239,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 /**
  * For a bitmap with a successor, yield our name to the successor,
  * delete the old bitmap, and return a handle to the new bitmap.
+ * Called with BQL taken.
  */
 BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
                                             BdrvDirtyBitmap *bitmap,
@@ -247,6 +267,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
  * In cases of failure where we can no longer safely delete the parent,
  * we may wish to re-join the parent and child/successor.
  * The merged parent will be un-frozen, but not explicitly re-enabled.
+ * Called with BQL taken.
  */
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *parent,
@@ -271,25 +292,30 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
 
 /**
  * Truncates _all_ bitmaps attached to a BDS.
+ * Called with BQL taken.
  */
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bitmap;
     uint64_t size = bdrv_nb_sectors(bs);
 
+    bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
         assert(!bitmap->active_iterators);
         hbitmap_truncate(bitmap->bitmap, size);
         bitmap->size = size;
     }
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
+/* Called with BQL taken.  */
 static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   bool only_named)
 {
     BdrvDirtyBitmap *bm, *next;
+    bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
         if ((!bitmap || bm == bitmap) && (!only_named || bm->name)) {
             assert(!bm->active_iterators);
@@ -301,15 +327,19 @@ static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs,
             g_free(bm);
 
             if (bitmap) {
-                return;
+                goto out;
             }
         }
     }
     if (bitmap) {
         abort();
     }
+
+out:
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
+/* Called with BQL taken.  */
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
     bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
@@ -318,18 +348,21 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 /**
  * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
  * There must not be any frozen bitmaps attached.
+ * Called with BQL taken.
  */
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
 {
     bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
 }
 
+/* Called with BQL taken.  */
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = true;
 }
 
+/* Called with BQL taken.  */
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
@@ -342,6 +375,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     BlockDirtyInfoList *list = NULL;
     BlockDirtyInfoList **plist = &list;
 
+    bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
         BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
         BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
@@ -354,6 +388,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         *plist = entry;
         plist = &entry->next;
     }
+    bdrv_dirty_bitmaps_unlock(bs);
 
     return list;
 }
@@ -508,12 +543,19 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
                     int64_t nr_sectors)
 {
     BdrvDirtyBitmap *bitmap;
+
+    if (QLIST_EMPTY(&bs->dirty_bitmaps)) {
+        return;
+    }
+
+    bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
         hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
     }
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
 /**
diff --git a/block/mirror.c b/block/mirror.c
index a2a9703..88ae882 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -506,6 +506,8 @@ static void mirror_exit(BlockJob *job, void *opaque)
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
 
+    bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
+
     /* Make sure that the source BDS doesn't go away before we called
      * block_job_completed(). */
     bdrv_ref(src);
@@ -904,7 +906,6 @@ immediate_exit:
     g_free(s->cow_bitmap);
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);
-    bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
 
     data = g_malloc(sizeof(*data));
     data->ret = ret;
diff --git a/blockdev.c b/blockdev.c
index ceea976..39f289b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1362,12 +1362,10 @@ out_aio_context:
 static BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
                                                   const char *name,
                                                   BlockDriverState **pbs,
-                                                  AioContext **paio,
                                                   Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context;
 
     if (!node) {
         error_setg(errp, "Node cannot be NULL");
@@ -1383,29 +1381,17 @@ static BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
         return NULL;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     bitmap = bdrv_find_dirty_bitmap(bs, name);
     if (!bitmap) {
         error_setg(errp, "Dirty bitmap '%s' not found", name);
-        goto fail;
+        return NULL;
     }
 
     if (pbs) {
         *pbs = bs;
     }
-    if (paio) {
-        *paio = aio_context;
-    } else {
-        aio_context_release(aio_context);
-    }
 
     return bitmap;
-
- fail:
-    aio_context_release(aio_context);
-    return NULL;
 }
 
 /* New and old BlockDriverState structs for atomic group operations */
@@ -2025,7 +2011,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               &state->bs,
-                                              &state->aio_context,
                                               errp);
     if (!state->bitmap) {
         return;
@@ -2733,7 +2718,6 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 Error **errp)
 {
-    AioContext *aio_context;
     BlockDriverState *bs;
 
     if (!name || name[0] == '\0') {
@@ -2746,14 +2730,11 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (has_granularity) {
         if (granularity < 512 || !is_power_of_2(granularity)) {
             error_setg(errp, "Granularity must be power of 2 "
                              "and at least 512");
-            goto out;
+            return;
         }
     } else {
         /* Default to cluster size, if available: */
@@ -2761,19 +2742,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_create_dirty_bitmap(bs, granularity, name, errp);
-
- out:
-    aio_context_release(aio_context);
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                                    Error **errp)
 {
-    AioContext *aio_context;
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
 
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
         return;
     }
@@ -2782,13 +2759,10 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         error_setg(errp,
                    "Bitmap '%s' is currently frozen and cannot be removed",
                    name);
-        goto out;
+        return;
     }
     bdrv_dirty_bitmap_make_anon(bitmap);
     bdrv_release_dirty_bitmap(bs, bitmap);
-
- out:
-    aio_context_release(aio_context);
 }
 
 /**
@@ -2798,11 +2772,10 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
 void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                                   Error **errp)
 {
-    AioContext *aio_context;
     BdrvDirtyBitmap *bitmap;
     BlockDriverState *bs;
 
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
         return;
     }
@@ -2811,18 +2784,15 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
         error_setg(errp,
                    "Bitmap '%s' is currently frozen and cannot be modified",
                    name);
-        goto out;
+        return;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         error_setg(errp,
                    "Bitmap '%s' is currently disabled and cannot be cleared",
                    name);
-        goto out;
+        return;
     }
 
     bdrv_clear_dirty_bitmap(bitmap, NULL);
-
- out:
-    aio_context_release(aio_context);
 }
 
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ae74df9..21cb65b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -609,6 +609,11 @@ struct BlockDriverState {
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
 
+    /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
+     * Reading from the list can be done with either the BQL or the
+     * dirty_bitmap_mutex.  Modifying a bitmap requires the AioContext
+     * lock.  */
+    QemuMutex dirty_bitmap_mutex;
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
     /* Offset after the highest byte written to */
diff --git a/migration/block.c b/migration/block.c
index 3aae5a3..9e20926 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -341,10 +341,8 @@ static int set_dirty_tracking(void)
     int ret;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        aio_context_acquire(blk_get_aio_context(bmds->blk));
         bmds->dirty_bitmap = bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
                                                       BLOCK_SIZE, NULL, NULL);
-        aio_context_release(blk_get_aio_context(bmds->blk));
         if (!bmds->dirty_bitmap) {
             ret = -errno;
             goto fail;
@@ -355,9 +353,7 @@ static int set_dirty_tracking(void)
 fail:
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
         if (bmds->dirty_bitmap) {
-            aio_context_acquire(blk_get_aio_context(bmds->blk));
             bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitmap);
-            aio_context_release(blk_get_aio_context(bmds->blk));
         }
     }
     return ret;
@@ -370,9 +366,7 @@ static void unset_dirty_tracking(void)
     BlkMigDevState *bmds;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        aio_context_acquire(blk_get_aio_context(bmds->blk));
         bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitmap);
-        aio_context_release(blk_get_aio_context(bmds->blk));
     }
 }
 
-- 
2.9.4
