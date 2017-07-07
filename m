Received: from eggs.gnu.org ([2001:4830:134:3::10]:43480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmX-0006dq-5a
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmV-00010f-1V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:36 +0200
Message-Id: <1499447335-6125-82-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 081/100] qcow2: add persistent dirty bitmaps
 support
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

Store persistent dirty bitmaps in qcow2 image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-20-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 475 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |   9 +
 block/qcow2.h        |   1 +
 3 files changed, 485 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 52e4616..5f53486 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 
 #include "block/block_int.h"
 #include "block/qcow2.h"
@@ -42,6 +43,10 @@
 #define BME_MIN_GRANULARITY_BITS 9
 #define BME_MAX_NAME_SIZE 1023
 
+#if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
+#error In the code bitmap table physical size assumed to fit into int
+#endif
+
 /* Bitmap directory entry flags */
 #define BME_RESERVED_FLAGS 0xfffffffcU
 #define BME_FLAG_IN_USE (1U << 0)
@@ -72,6 +77,8 @@ typedef struct Qcow2BitmapTable {
     uint32_t size; /* number of 64bit entries */
     QSIMPLEQ_ENTRY(Qcow2BitmapTable) entry;
 } Qcow2BitmapTable;
+typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable)
+    Qcow2BitmapTableList;
 
 typedef struct Qcow2Bitmap {
     Qcow2BitmapTable table;
@@ -79,6 +86,8 @@ typedef struct Qcow2Bitmap {
     uint8_t granularity_bits;
     char *name;
 
+    BdrvDirtyBitmap *dirty_bitmap;
+
     QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
 } Qcow2Bitmap;
 typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
@@ -104,6 +113,15 @@ static int update_header_sync(BlockDriverState *bs)
     return bdrv_flush(bs);
 }
 
+static inline void bitmap_table_to_be(uint64_t *bitmap_table, size_t size)
+{
+    size_t i;
+
+    for (i = 0; i < size; ++i) {
+        cpu_to_be64s(&bitmap_table[i]);
+    }
+}
+
 static int check_table_entry(uint64_t entry, int cluster_size)
 {
     uint64_t offset;
@@ -127,6 +145,70 @@ static int check_table_entry(uint64_t entry, int cluster_size)
     return 0;
 }
 
+static int check_constraints_on_bitmap(BlockDriverState *bs,
+                                       const char *name,
+                                       uint32_t granularity,
+                                       Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int granularity_bits = ctz32(granularity);
+    int64_t len = bdrv_getlength(bs);
+
+    assert(granularity > 0);
+    assert((granularity & (granularity - 1)) == 0);
+
+    if (len < 0) {
+        error_setg_errno(errp, -len, "Failed to get size of '%s'",
+                         bdrv_get_device_or_node_name(bs));
+        return len;
+    }
+
+    if (granularity_bits > BME_MAX_GRANULARITY_BITS) {
+        error_setg(errp, "Granularity exceeds maximum (%llu bytes)",
+                   1ULL << BME_MAX_GRANULARITY_BITS);
+        return -EINVAL;
+    }
+    if (granularity_bits < BME_MIN_GRANULARITY_BITS) {
+        error_setg(errp, "Granularity is under minimum (%llu bytes)",
+                   1ULL << BME_MIN_GRANULARITY_BITS);
+        return -EINVAL;
+    }
+
+    if ((len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
+        (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
+               granularity_bits))
+    {
+        error_setg(errp, "Too much space will be occupied by the bitmap. "
+                   "Use larger granularity");
+        return -EINVAL;
+    }
+
+    if (strlen(name) > BME_MAX_NAME_SIZE) {
+        error_setg(errp, "Name length exceeds maximum (%u characters)",
+                   BME_MAX_NAME_SIZE);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
+                               uint32_t bitmap_table_size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int i;
+
+    for (i = 0; i < bitmap_table_size; ++i) {
+        uint64_t addr = bitmap_table[i] & BME_TABLE_ENTRY_OFFSET_MASK;
+        if (!addr) {
+            continue;
+        }
+
+        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_OTHER);
+        bitmap_table[i] = 0;
+    }
+}
+
 static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
                              uint64_t **bitmap_table)
 {
@@ -165,6 +247,28 @@ fail:
     return ret;
 }
 
+static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
+{
+    int ret;
+    uint64_t *bitmap_table;
+
+    ret = bitmap_table_load(bs, tb, &bitmap_table);
+    if (ret < 0) {
+        assert(bitmap_table == NULL);
+        return ret;
+    }
+
+    clear_bitmap_table(bs, bitmap_table, tb->size);
+    qcow2_free_clusters(bs, tb->offset, tb->size * sizeof(uint64_t),
+                        QCOW2_DISCARD_OTHER);
+    g_free(bitmap_table);
+
+    tb->offset = 0;
+    tb->size = 0;
+
+    return 0;
+}
+
 /* This function returns the number of disk sectors covered by a single qcow2
  * cluster of bitmap data. */
 static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
@@ -748,6 +852,69 @@ static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
      */
 }
 
+static int update_ext_header_and_dir(BlockDriverState *bs,
+                                     Qcow2BitmapList *bm_list)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+    uint64_t new_offset = 0;
+    uint64_t new_size = 0;
+    uint32_t new_nb_bitmaps = 0;
+    uint64_t old_offset = s->bitmap_directory_offset;
+    uint64_t old_size = s->bitmap_directory_size;
+    uint32_t old_nb_bitmaps = s->nb_bitmaps;
+    uint64_t old_autocl = s->autoclear_features;
+
+    if (bm_list != NULL && !QSIMPLEQ_EMPTY(bm_list)) {
+        new_nb_bitmaps = bitmap_list_count(bm_list);
+
+        if (new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
+            return -EINVAL;
+        }
+
+        ret = bitmap_list_store(bs, bm_list, &new_offset, &new_size, false);
+        if (ret < 0) {
+            return ret;
+        }
+
+        ret = bdrv_flush(bs->file->bs);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        s->autoclear_features |= QCOW2_AUTOCLEAR_BITMAPS;
+    } else {
+        s->autoclear_features &= ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
+    }
+
+    s->bitmap_directory_offset = new_offset;
+    s->bitmap_directory_size = new_size;
+    s->nb_bitmaps = new_nb_bitmaps;
+
+    ret = update_header_sync(bs);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (old_size > 0) {
+        qcow2_free_clusters(bs, old_offset, old_size, QCOW2_DISCARD_OTHER);
+    }
+
+    return 0;
+
+fail:
+    if (new_offset > 0) {
+        qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_OTHER);
+    }
+
+    s->bitmap_directory_offset = old_offset;
+    s->bitmap_directory_size = old_size;
+    s->nb_bitmaps = old_nb_bitmaps;
+    s->autoclear_features = old_autocl;
+
+    return ret;
+}
+
 /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
 static void release_dirty_bitmap_helper(gpointer bitmap,
                                         gpointer bs)
@@ -890,3 +1057,311 @@ out:
 
     return ret;
 }
+
+/* store_bitmap_data()
+ * Store bitmap to image, filling bitmap table accordingly.
+ */
+static uint64_t *store_bitmap_data(BlockDriverState *bs,
+                                   BdrvDirtyBitmap *bitmap,
+                                   uint32_t *bitmap_table_size, Error **errp)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    int64_t sector;
+    uint64_t sbc;
+    uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
+    const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
+    uint8_t *buf = NULL;
+    BdrvDirtyBitmapIter *dbi;
+    uint64_t *tb;
+    uint64_t tb_size =
+            size_to_clusters(s,
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
+
+    if (tb_size > BME_MAX_TABLE_SIZE ||
+        tb_size * s->cluster_size > BME_MAX_PHYS_SIZE)
+    {
+        error_setg(errp, "Bitmap '%s' is too big", bm_name);
+        return NULL;
+    }
+
+    tb = g_try_new0(uint64_t, tb_size);
+    if (tb == NULL) {
+        error_setg(errp, "No memory");
+        return NULL;
+    }
+
+    dbi = bdrv_dirty_iter_new(bitmap, 0);
+    buf = g_malloc(s->cluster_size);
+    sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
+    assert(DIV_ROUND_UP(bm_size, sbc) == tb_size);
+
+    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
+        uint64_t cluster = sector / sbc;
+        uint64_t end, write_size;
+        int64_t off;
+
+        sector = cluster * sbc;
+        end = MIN(bm_size, sector + sbc);
+        write_size =
+            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end - sector);
+        assert(write_size <= s->cluster_size);
+
+        off = qcow2_alloc_clusters(bs, s->cluster_size);
+        if (off < 0) {
+            error_setg_errno(errp, -off,
+                             "Failed to allocate clusters for bitmap '%s'",
+                             bm_name);
+            goto fail;
+        }
+        tb[cluster] = off;
+
+        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - sector);
+        if (write_size < s->cluster_size) {
+            memset(buf + write_size, 0, s->cluster_size - write_size);
+        }
+
+        ret = qcow2_pre_write_overlap_check(bs, 0, off, s->cluster_size);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Qcow2 overlap check failed");
+            goto fail;
+        }
+
+        ret = bdrv_pwrite(bs->file, off, buf, s->cluster_size);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to write bitmap '%s' to file",
+                             bm_name);
+            goto fail;
+        }
+
+        if (end >= bm_size) {
+            break;
+        }
+
+        bdrv_set_dirty_iter(dbi, end);
+    }
+
+    *bitmap_table_size = tb_size;
+    g_free(buf);
+    bdrv_dirty_iter_free(dbi);
+
+    return tb;
+
+fail:
+    clear_bitmap_table(bs, tb, tb_size);
+    g_free(buf);
+    bdrv_dirty_iter_free(dbi);
+    g_free(tb);
+
+    return NULL;
+}
+
+/* store_bitmap()
+ * Store bm->dirty_bitmap to qcow2.
+ * Set bm->table_offset and bm->table_size accordingly.
+ */
+static int store_bitmap(BlockDriverState *bs, Qcow2Bitmap *bm, Error **errp)
+{
+    int ret;
+    uint64_t *tb;
+    int64_t tb_offset;
+    uint32_t tb_size;
+    BdrvDirtyBitmap *bitmap = bm->dirty_bitmap;
+    const char *bm_name;
+
+    assert(bitmap != NULL);
+
+    bm_name = bdrv_dirty_bitmap_name(bitmap);
+
+    tb = store_bitmap_data(bs, bitmap, &tb_size, errp);
+    if (tb == NULL) {
+        return -EINVAL;
+    }
+
+    assert(tb_size <= BME_MAX_TABLE_SIZE);
+    tb_offset = qcow2_alloc_clusters(bs, tb_size * sizeof(tb[0]));
+    if (tb_offset < 0) {
+        error_setg_errno(errp, -tb_offset,
+                         "Failed to allocate clusters for bitmap '%s'",
+                         bm_name);
+        goto fail;
+    }
+
+    ret = qcow2_pre_write_overlap_check(bs, 0, tb_offset,
+                                        tb_size * sizeof(tb[0]));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Qcow2 overlap check failed");
+        goto fail;
+    }
+
+    bitmap_table_to_be(tb, tb_size);
+    ret = bdrv_pwrite(bs->file, tb_offset, tb, tb_size * sizeof(tb[0]));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to write bitmap '%s' to file",
+                         bm_name);
+        goto fail;
+    }
+
+    g_free(tb);
+
+    bm->table.offset = tb_offset;
+    bm->table.size = tb_size;
+
+    return 0;
+
+fail:
+    clear_bitmap_table(bs, tb, tb_size);
+
+    if (tb_offset > 0) {
+        qcow2_free_clusters(bs, tb_offset, tb_size * sizeof(tb[0]),
+                            QCOW2_DISCARD_OTHER);
+    }
+
+    g_free(tb);
+
+    return ret;
+}
+
+static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
+                                        const char *name)
+{
+    Qcow2Bitmap *bm;
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if (strcmp(name, bm->name) == 0) {
+            return bm;
+        }
+    }
+
+    return NULL;
+}
+
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BdrvDirtyBitmap *bitmap;
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t new_nb_bitmaps = s->nb_bitmaps;
+    uint64_t new_dir_size = s->bitmap_directory_size;
+    int ret;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapTableList drop_tables;
+    Qcow2BitmapTable *tb, *tb_next;
+
+    if (!bdrv_has_changed_persistent_bitmaps(bs)) {
+        /* nothing to do */
+        return;
+    }
+
+    if (!can_write(bs)) {
+        error_setg(errp, "No write access");
+        return;
+    }
+
+    QSIMPLEQ_INIT(&drop_tables);
+
+    if (s->nb_bitmaps == 0) {
+        bm_list = bitmap_list_new();
+    } else {
+        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                                   s->bitmap_directory_size, errp);
+        if (bm_list == NULL) {
+            return;
+        }
+    }
+
+    /* check constraints and names */
+    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
+         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
+    {
+        const char *name = bdrv_dirty_bitmap_name(bitmap);
+        uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
+        Qcow2Bitmap *bm;
+
+        if (!bdrv_dirty_bitmap_get_persistance(bitmap) ||
+            bdrv_dirty_bitmap_readonly(bitmap))
+        {
+            continue;
+        }
+
+        if (check_constraints_on_bitmap(bs, name, granularity, errp) < 0) {
+            error_prepend(errp, "Bitmap '%s' doesn't satisfy the constraints: ",
+                          name);
+            goto fail;
+        }
+
+        bm = find_bitmap_by_name(bm_list, name);
+        if (bm == NULL) {
+            if (++new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
+                error_setg(errp, "Too many persistent bitmaps");
+                goto fail;
+            }
+
+            new_dir_size += calc_dir_entry_size(strlen(name), 0);
+            if (new_dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
+                error_setg(errp, "Bitmap directory is too large");
+                goto fail;
+            }
+
+            bm = g_new0(Qcow2Bitmap, 1);
+            bm->name = g_strdup(name);
+            QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
+        } else {
+            if (!(bm->flags & BME_FLAG_IN_USE)) {
+                error_setg(errp, "Bitmap '%s' already exists in the image",
+                           name);
+                goto fail;
+            }
+            tb = g_memdup(&bm->table, sizeof(bm->table));
+            bm->table.offset = 0;
+            bm->table.size = 0;
+            QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
+        }
+        bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
+        bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
+        bm->dirty_bitmap = bitmap;
+    }
+
+    /* allocate clusters and store bitmaps */
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if (bm->dirty_bitmap == NULL) {
+            continue;
+        }
+
+        ret = store_bitmap(bs, bm, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    ret = update_ext_header_and_dir(bs, bm_list);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
+        goto fail;
+    }
+
+    /* Bitmap directory was successfully updated, so, old data can be dropped.
+     * TODO it is better to reuse these clusters */
+    QSIMPLEQ_FOREACH_SAFE(tb, &drop_tables, entry, tb_next) {
+        free_bitmap_clusters(bs, tb);
+        g_free(tb);
+    }
+
+    bitmap_list_free(bm_list);
+    return;
+
+fail:
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if (bm->dirty_bitmap == NULL || bm->table.offset == 0) {
+            continue;
+        }
+
+        free_bitmap_clusters(bs, &bm->table);
+    }
+
+    QSIMPLEQ_FOREACH_SAFE(tb, &drop_tables, entry, tb_next) {
+        g_free(tb);
+    }
+
+    bitmap_list_free(bm_list);
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 19cc49a..790b5b1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2046,6 +2046,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret, result = 0;
+    Error *local_err = NULL;
 
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret) {
@@ -2061,6 +2062,14 @@ static int qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
 
+    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    if (local_err != NULL) {
+        result = -EINVAL;
+        error_report_err(local_err);
+        error_report("Persistent bitmaps are lost for node '%s'",
+                     bdrv_get_device_or_node_name(bs));
+    }
+
     if (result == 0) {
         qcow2_mark_clean(bs);
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index 633bd43..308cefd 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -647,5 +647,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   int64_t *refcount_table_size);
 bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 
 #endif
-- 
1.8.3.1
