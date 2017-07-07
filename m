Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmM-0006RS-TK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmK-0000iW-CU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:28 +0200
Message-Id: <1499447335-6125-74-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 073/100] qcow2: autoloading dirty bitmaps
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

Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
are loaded when the image is opened and become BdrvDirtyBitmaps for the
corresponding drive.

Extra data in bitmaps is not supported for now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-12-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 389 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  17 ++-
 block/qcow2.h        |   2 +
 3 files changed, 406 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b8e472b..2c7b057 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -44,6 +44,8 @@
 
 /* Bitmap directory entry flags */
 #define BME_RESERVED_FLAGS 0xfffffffcU
+#define BME_FLAG_IN_USE (1U << 0)
+#define BME_FLAG_AUTO   (1U << 1)
 
 /* bits [1, 8] U [56, 63] are reserved */
 #define BME_TABLE_ENTRY_RESERVED_MASK 0xff000000000001feULL
@@ -85,6 +87,23 @@ typedef enum BitmapType {
     BT_DIRTY_TRACKING_BITMAP = 1
 } BitmapType;
 
+static inline bool can_write(BlockDriverState *bs)
+{
+    return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
+}
+
+static int update_header_sync(BlockDriverState *bs)
+{
+    int ret;
+
+    ret = qcow2_update_header(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_flush(bs);
+}
+
 static int check_table_entry(uint64_t entry, int cluster_size)
 {
     uint64_t offset;
@@ -146,6 +165,120 @@ fail:
     return ret;
 }
 
+/* This function returns the number of disk sectors covered by a single qcow2
+ * cluster of bitmap data. */
+static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
+                                                  const BdrvDirtyBitmap *bitmap)
+{
+    uint32_t sector_granularity =
+            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+
+    return (uint64_t)sector_granularity * (s->cluster_size << 3);
+}
+
+/* load_bitmap_data
+ * @bitmap_table entries must satisfy specification constraints.
+ * @bitmap must be cleared */
+static int load_bitmap_data(BlockDriverState *bs,
+                            const uint64_t *bitmap_table,
+                            uint32_t bitmap_table_size,
+                            BdrvDirtyBitmap *bitmap)
+{
+    int ret = 0;
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t sector, sbc;
+    uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
+    uint8_t *buf = NULL;
+    uint64_t i, tab_size =
+            size_to_clusters(s,
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
+
+    if (tab_size != bitmap_table_size || tab_size > BME_MAX_TABLE_SIZE) {
+        return -EINVAL;
+    }
+
+    buf = g_malloc(s->cluster_size);
+    sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
+    for (i = 0, sector = 0; i < tab_size; ++i, sector += sbc) {
+        uint64_t count = MIN(bm_size - sector, sbc);
+        uint64_t entry = bitmap_table[i];
+        uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+
+        assert(check_table_entry(entry, s->cluster_size) == 0);
+
+        if (offset == 0) {
+            if (entry & BME_TABLE_ENTRY_FLAG_ALL_ONES) {
+                bdrv_dirty_bitmap_deserialize_ones(bitmap, sector, count,
+                                                   false);
+            } else {
+                /* No need to deserialize zeros because the dirty bitmap is
+                 * already cleared */
+            }
+        } else {
+            ret = bdrv_pread(bs->file, offset, buf, s->cluster_size);
+            if (ret < 0) {
+                goto finish;
+            }
+            bdrv_dirty_bitmap_deserialize_part(bitmap, buf, sector, count,
+                                               false);
+        }
+    }
+    ret = 0;
+
+    bdrv_dirty_bitmap_deserialize_finish(bitmap);
+
+finish:
+    g_free(buf);
+
+    return ret;
+}
+
+static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
+                                    Qcow2Bitmap *bm, Error **errp)
+{
+    int ret;
+    uint64_t *bitmap_table = NULL;
+    uint32_t granularity;
+    BdrvDirtyBitmap *bitmap = NULL;
+
+    if (bm->flags & BME_FLAG_IN_USE) {
+        error_setg(errp, "Bitmap '%s' is in use", bm->name);
+        goto fail;
+    }
+
+    ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Could not read bitmap_table table from image for "
+                         "bitmap '%s'", bm->name);
+        goto fail;
+    }
+
+    granularity = 1U << bm->granularity_bits;
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
+    if (bitmap == NULL) {
+        goto fail;
+    }
+
+    ret = load_bitmap_data(bs, bitmap_table, bm->table.size, bitmap);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not read bitmap '%s' from image",
+                         bm->name);
+        goto fail;
+    }
+
+    g_free(bitmap_table);
+    return bitmap;
+
+fail:
+    g_free(bitmap_table);
+    if (bitmap != NULL) {
+        bdrv_release_dirty_bitmap(bs, bitmap);
+    }
+
+    return NULL;
+}
+
 /*
  * Bitmap List
  */
@@ -164,6 +297,15 @@ static inline void bitmap_dir_entry_to_cpu(Qcow2BitmapDirEntry *entry)
     be32_to_cpus(&entry->extra_data_size);
 }
 
+static inline void bitmap_dir_entry_to_be(Qcow2BitmapDirEntry *entry)
+{
+    cpu_to_be64s(&entry->bitmap_table_offset);
+    cpu_to_be32s(&entry->bitmap_table_size);
+    cpu_to_be32s(&entry->flags);
+    cpu_to_be16s(&entry->name_size);
+    cpu_to_be32s(&entry->extra_data_size);
+}
+
 static inline int calc_dir_entry_size(size_t name_size, size_t extra_data_size)
 {
     return align_offset(sizeof(Qcow2BitmapDirEntry) +
@@ -224,6 +366,17 @@ static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
     return fail ? -EINVAL : 0;
 }
 
+static inline void bitmap_directory_to_be(uint8_t *dir, size_t size)
+{
+    uint8_t *end = dir + size;
+    while (dir < end) {
+        Qcow2BitmapDirEntry *e = (Qcow2BitmapDirEntry *)dir;
+        dir += dir_entry_size(e);
+
+        bitmap_dir_entry_to_be(e);
+    }
+}
+
 /*
  * Bitmap List public functions
  */
@@ -258,6 +411,18 @@ static Qcow2BitmapList *bitmap_list_new(void)
     return bm_list;
 }
 
+static uint32_t bitmap_list_count(Qcow2BitmapList *bm_list)
+{
+    Qcow2Bitmap *bm;
+    uint32_t nb_bitmaps = 0;
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        nb_bitmaps++;
+    }
+
+    return nb_bitmaps;
+}
+
 /* bitmap_list_load
  * Get bitmap list from qcow2 image. Actually reads bitmap directory,
  * checks it and convert to bitmap list.
@@ -437,3 +602,227 @@ out:
 
     return ret;
 }
+
+/* bitmap_list_store
+ * Store bitmap list to qcow2 image as a bitmap directory.
+ * Everything is checked.
+ */
+static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
+                             uint64_t *offset, uint64_t *size, bool in_place)
+{
+    int ret;
+    uint8_t *dir;
+    int64_t dir_offset = 0;
+    uint64_t dir_size = 0;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapDirEntry *e;
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        dir_size += calc_dir_entry_size(strlen(bm->name), 0);
+    }
+
+    if (dir_size == 0 || dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
+        return -EINVAL;
+    }
+
+    if (in_place) {
+        if (*size != dir_size || *offset == 0) {
+            return -EINVAL;
+        }
+
+        dir_offset = *offset;
+    }
+
+    dir = g_try_malloc(dir_size);
+    if (dir == NULL) {
+        return -ENOMEM;
+    }
+
+    e = (Qcow2BitmapDirEntry *)dir;
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        e->bitmap_table_offset = bm->table.offset;
+        e->bitmap_table_size = bm->table.size;
+        e->flags = bm->flags;
+        e->type = BT_DIRTY_TRACKING_BITMAP;
+        e->granularity_bits = bm->granularity_bits;
+        e->name_size = strlen(bm->name);
+        e->extra_data_size = 0;
+        memcpy(e + 1, bm->name, e->name_size);
+
+        if (check_dir_entry(bs, e) < 0) {
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        e = next_dir_entry(e);
+    }
+
+    bitmap_directory_to_be(dir, dir_size);
+
+    if (!in_place) {
+        dir_offset = qcow2_alloc_clusters(bs, dir_size);
+        if (dir_offset < 0) {
+            ret = dir_offset;
+            goto fail;
+        }
+    }
+
+    ret = qcow2_pre_write_overlap_check(bs, 0, dir_offset, dir_size);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = bdrv_pwrite(bs->file, dir_offset, dir, dir_size);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    g_free(dir);
+
+    if (!in_place) {
+        *size = dir_size;
+        *offset = dir_offset;
+    }
+
+    return 0;
+
+fail:
+    g_free(dir);
+
+    if (!in_place && dir_offset > 0) {
+        qcow2_free_clusters(bs, dir_offset, dir_size, QCOW2_DISCARD_OTHER);
+    }
+
+    return ret;
+}
+
+/*
+ * Bitmap List end
+ */
+
+static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
+                                              Qcow2BitmapList *bm_list)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS) ||
+        bm_list == NULL || QSIMPLEQ_EMPTY(bm_list) ||
+        bitmap_list_count(bm_list) != s->nb_bitmaps)
+    {
+        return -EINVAL;
+    }
+
+    s->autoclear_features &= ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
+    ret = update_header_sync(bs);
+    if (ret < 0) {
+        /* Two variants are possible here:
+         * 1. Autoclear flag is dropped, all bitmaps will be lost.
+         * 2. Autoclear flag is not dropped, old state is left.
+         */
+        return ret;
+    }
+
+    /* autoclear bit is not set, so we can safely update bitmap directory */
+
+    ret = bitmap_list_store(bs, bm_list, &s->bitmap_directory_offset,
+                            &s->bitmap_directory_size, true);
+    if (ret < 0) {
+        /* autoclear bit is cleared, so all leaked clusters would be removed on
+         * qemu-img check */
+        return ret;
+    }
+
+    ret = update_header_sync(bs);
+    if (ret < 0) {
+        /* autoclear bit is cleared, so all leaked clusters would be removed on
+         * qemu-img check */
+        return ret;
+    }
+
+    s->autoclear_features |= QCOW2_AUTOCLEAR_BITMAPS;
+    return update_header_sync(bs);
+    /* If final update_header_sync() fails, two variants are possible:
+     * 1. Autoclear flag is not set, all bitmaps will be lost.
+     * 2. Autoclear flag is set, header and directory are successfully updated.
+     */
+}
+
+/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
+static void release_dirty_bitmap_helper(gpointer bitmap,
+                                        gpointer bs)
+{
+    bdrv_release_dirty_bitmap(bs, bitmap);
+}
+
+/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
+static void set_readonly_helper(gpointer bitmap, gpointer value)
+{
+    bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
+}
+
+/* qcow2_load_autoloading_dirty_bitmaps()
+ * Return value is a hint for caller: true means that the Qcow2 header was
+ * updated. (false doesn't mean that the header should be updated by the
+ * caller, it just means that updating was not needed or the image cannot be
+ * written to).
+ * On failure the function returns false.
+ */
+bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    GSList *created_dirty_bitmaps = NULL;
+    bool header_updated = false;
+
+    if (s->nb_bitmaps == 0) {
+        /* No bitmaps - nothing to do */
+        return false;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return false;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if ((bm->flags & BME_FLAG_AUTO) && !(bm->flags & BME_FLAG_IN_USE)) {
+            BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
+            if (bitmap == NULL) {
+                goto fail;
+            }
+            bm->flags |= BME_FLAG_IN_USE;
+            created_dirty_bitmaps =
+                    g_slist_append(created_dirty_bitmaps, bitmap);
+        }
+    }
+
+    if (created_dirty_bitmaps != NULL) {
+        if (can_write(bs)) {
+            /* in_use flags must be updated */
+            int ret = update_ext_header_and_dir_in_place(bs, bm_list);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Can't update bitmap directory");
+                goto fail;
+            }
+            header_updated = true;
+        } else {
+            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
+                            (gpointer)true);
+        }
+    }
+
+    g_slist_free(created_dirty_bitmaps);
+    bitmap_list_free(bm_list);
+
+    return header_updated;
+
+fail:
+    g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
+    g_slist_free(created_dirty_bitmaps);
+    bitmap_list_free(bm_list);
+
+    return false;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 8688fdd..8645b08 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1445,9 +1445,22 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Clear unknown autoclear feature bits */
     update_header |= s->autoclear_features & ~QCOW2_AUTOCLEAR_MASK;
-
-    if (update_header && !bs->read_only && !(flags & BDRV_O_INACTIVE)) {
+    update_header =
+        update_header && !bs->read_only && !(flags & BDRV_O_INACTIVE);
+    if (update_header) {
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
+    }
+
+    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
+        update_header = false;
+    }
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    if (update_header) {
         ret = qcow2_update_header(bs);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not update qcow2 header");
diff --git a/block/qcow2.h b/block/qcow2.h
index 3488648..886480b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -645,4 +645,6 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
+bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+
 #endif
-- 
1.8.3.1
