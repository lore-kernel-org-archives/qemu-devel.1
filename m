Received: from eggs.gnu.org ([2001:4830:134:3::10]:36446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSW-0002J4-4b
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSO-0005D8-DF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:52 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:17779 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00059C-NS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:25 +0300
Message-Id: <20170123121036.4823-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 13/24] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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

Realize block bitmap storing interface, to allow qcow2 images store
persistent bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 509 +++++++++++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.c        |   1 +
 block/qcow2.h        |   1 +
 3 files changed, 496 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3e8fd030d9..a2b857ea72 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/log.h"
+#include "qemu/cutils.h"
 
 #include "block/block_int.h"
 #include "block/qcow2.h"
@@ -43,6 +44,10 @@
 #define BME_MIN_GRANULARITY_BITS 9
 #define BME_MAX_NAME_SIZE 1023
 
+#if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
+#error In the code bitmap table physical size assumed to fit into int
+#endif
+
 /* Bitmap directory entry flags */
 #define BME_RESERVED_FLAGS 0xfffffffcU
 #define BME_FLAG_IN_USE 1
@@ -67,13 +72,21 @@ typedef struct QEMU_PACKED Qcow2BitmapDirEntry {
     /* name follows  */
 } Qcow2BitmapDirEntry;
 
+typedef struct Qcow2BitmapTable {
+    uint64_t offset;
+    uint32_t size; /* number of 64bit entries */
+    QSIMPLEQ_ENTRY(Qcow2BitmapTable) entry;
+} Qcow2BitmapTable;
+typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable) Qcow2BitmapTableList;
+
 typedef struct Qcow2Bitmap {
-    uint64_t table_offset;
-    uint32_t table_size;
+    Qcow2BitmapTable table;
     uint32_t flags;
     uint8_t granularity_bits;
     char *name;
 
+    BdrvDirtyBitmap *dirty_bitmap;
+
     QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
 } Qcow2Bitmap;
 typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
@@ -87,6 +100,27 @@ static inline bool can_write(BlockDriverState *bs)
     return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
 }
 
+static int update_header_sync(BlockDriverState *bs)
+{
+    int ret;
+
+    ret = qcow2_update_header(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* We don't return bdrv_flush error code. Even if it fails, write was
+     * successful and it is more logical to consider that header is in the new
+     * state than in the old.
+     */
+    ret = bdrv_flush(bs);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to flush qcow2 header");
+    }
+
+    return 0;
+}
+
 static inline void bitmap_table_to_cpu(uint64_t *bitmap_table, size_t size)
 {
     size_t i;
@@ -96,6 +130,15 @@ static inline void bitmap_table_to_cpu(uint64_t *bitmap_table, size_t size)
     }
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
@@ -123,7 +166,50 @@ static int check_table_entry(uint64_t entry, int cluster_size)
     return 0;
 }
 
-static int bitmap_table_load(BlockDriverState *bs, Qcow2Bitmap *bm,
+static int check_constraints_on_bitmap(BlockDriverState *bs,
+                                       const char *name,
+                                       uint32_t granularity)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int granularity_bits = ctz32(granularity);
+    int64_t len = bdrv_getlength(bs);
+    bool fail;
+
+    assert(granularity > 0);
+    assert((granularity & (granularity - 1)) == 0);
+
+    if (len < 0) {
+        return len;
+    }
+
+    fail = (granularity_bits > BME_MAX_GRANULARITY_BITS) ||
+           (granularity_bits < BME_MIN_GRANULARITY_BITS) ||
+           (len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
+           (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
+                  granularity_bits) ||
+           (strlen(name) > BME_MAX_NAME_SIZE);
+
+    return fail ? -EINVAL : 0;
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
+static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
                              uint64_t **bitmap_table)
 {
     int ret;
@@ -131,20 +217,20 @@ static int bitmap_table_load(BlockDriverState *bs, Qcow2Bitmap *bm,
     uint32_t i;
     uint64_t *table;
 
-    assert(bm->table_size != 0);
-    table = g_try_new(uint64_t, bm->table_size);
+    assert(tb->size != 0);
+    table = g_try_new(uint64_t, tb->size);
     if (table == NULL) {
         return -ENOMEM;
     }
 
-    assert(bm->table_size <= BME_MAX_TABLE_SIZE);
-    ret = bdrv_pread(bs->file, bm->table_offset,
-                     table, bm->table_size * sizeof(uint64_t));
+    assert(tb->size <= BME_MAX_TABLE_SIZE);
+    ret = bdrv_pread(bs->file, tb->offset,
+                     table, tb->size * sizeof(uint64_t));
     if (ret < 0) {
         goto fail;
     }
 
-    for (i = 0; i < bm->table_size; ++i) {
+    for (i = 0; i < tb->size; ++i) {
         be64_to_cpus(&table[i]);
         ret = check_table_entry(table[i], s->cluster_size);
         if (ret < 0) {
@@ -161,6 +247,28 @@ fail:
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
 /* This function returns the number of disk sectors covered by a single cluster
  * of bitmap data. */
 static uint64_t disk_sectors_in_bitmap_cluster(const BDRVQcow2State *s,
@@ -242,7 +350,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    ret = bitmap_table_load(bs, bm, &bitmap_table);
+    ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "Could not read bitmap_table table from image for "
@@ -256,7 +364,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    ret = load_bitmap_data(bs, bitmap_table, bm->table_size,
+    ret = load_bitmap_data(bs, bitmap_table, bm->table.size,
                            bitmap);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read bitmap '%s' from image",
@@ -492,8 +600,8 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
         }
 
         bm = g_new(Qcow2Bitmap, 1);
-        bm->table_offset = e->bitmap_table_offset;
-        bm->table_size = e->bitmap_table_size;
+        bm->table.offset = e->bitmap_table_offset;
+        bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
         bm->granularity_bits = e->granularity_bits;
         bm->name = dir_entry_copy_name(e);
@@ -561,8 +669,8 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
 
     e = (Qcow2BitmapDirEntry *)dir;
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        e->bitmap_table_offset = bm->table_offset;
-        e->bitmap_table_size = bm->table_size;
+        e->bitmap_table_offset = bm->table.offset;
+        e->bitmap_table_size = bm->table.size;
         e->flags = bm->flags;
         e->type = BT_DIRTY_TRACKING_BITMAP;
         e->granularity_bits = bm->granularity_bits;
@@ -654,6 +762,69 @@ static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
     return update_header_sync(bs);
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
@@ -713,3 +884,311 @@ fail:
     g_slist_free(created_dirty_bitmaps);
     bitmap_list_free(bm_list);
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
+    uint64_t dsc;
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
+    dsc = disk_sectors_in_bitmap_cluster(s, bitmap);
+    assert(DIV_ROUND_UP(bm_size, dsc) == tb_size);
+
+    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
+        uint64_t cluster = sector / dsc;
+        uint64_t end, write_size;
+        int64_t off;
+
+        sector = cluster * dsc;
+        end = MIN(bm_size, sector + dsc);
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
+        g_free(tb);
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
+    QSIMPLEQ_INIT(&drop_tables);
+
+    if (!can_write(bs)) {
+        error_setg(errp, "No write access");
+        return;
+    }
+
+    if (!bdrv_has_persistent_bitmaps(bs)) {
+        /* nothing to do */
+        return;
+    }
+
+    if (s->nb_bitmaps == 0) {
+        bm_list = bitmap_list_new();
+    } else {
+        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                                   s->bitmap_directory_size, errp);
+        if (bm_list == NULL) {
+            /* errp is already set */
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
+        if (!bdrv_dirty_bitmap_get_persistance(bitmap)) {
+            continue;
+        }
+
+        if (check_constraints_on_bitmap(bs, name, granularity) < 0) {
+            error_setg(errp, "Bitmap '%s' doesn't satisfy the constraints",
+                       name);
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
+                error_setg(errp, "Too large bitmap directory");
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
index 9f64753138..af580d2299 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3542,6 +3542,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
 
     .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
+    .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index bcedf5bdf2..d9a7643a60 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -615,5 +615,6 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 
 /* qcow2-bitmap.c functions */
 void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 
 #endif
-- 
2.11.0
