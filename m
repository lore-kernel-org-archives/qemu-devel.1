Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmK-0006OK-B7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmH-0000ex-3X
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:25 +0200
Message-Id: <1499447335-6125-71-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 070/100] qcow2: add bitmaps extension
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

Add bitmap extension as specified in docs/specs/qcow2.txt.
For now, just mirror extension header into Qcow2 state and check
constraints. Also, calculate refcounts for qcow2 bitmaps, to not break
qemu-img check.

For now, disable image resize if it has bitmaps. It will be fixed later.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-9-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs    |   2 +-
 block/qcow2-bitmap.c   | 439 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c |   6 +
 block/qcow2.c          | 125 +++++++++++++-
 block/qcow2.h          |  27 +++
 5 files changed, 593 insertions(+), 6 deletions(-)
 create mode 100644 block/qcow2-bitmap.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index f9368b5..2aaede4 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,5 +1,5 @@
 block-obj-y += raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o vvfat.o dmg.o
-block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o
+block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o
 block-obj-y += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
 block-obj-y += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
new file mode 100644
index 0000000..b8e472b
--- /dev/null
+++ b/block/qcow2-bitmap.c
@@ -0,0 +1,439 @@
+/*
+ * Bitmaps for the QCOW version 2 format
+ *
+ * Copyright (c) 2014-2017 Vladimir Sementsov-Ogievskiy
+ *
+ * This file is derived from qcow2-snapshot.c, original copyright:
+ * Copyright (c) 2004-2006 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+#include "block/block_int.h"
+#include "block/qcow2.h"
+
+/* NOTICE: BME here means Bitmaps Extension and used as a namespace for
+ * _internal_ constants. Please do not use this _internal_ abbreviation for
+ * other needs and/or outside of this file. */
+
+/* Bitmap directory entry constraints */
+#define BME_MAX_TABLE_SIZE 0x8000000
+#define BME_MAX_PHYS_SIZE 0x20000000 /* restrict BdrvDirtyBitmap size in RAM */
+#define BME_MAX_GRANULARITY_BITS 31
+#define BME_MIN_GRANULARITY_BITS 9
+#define BME_MAX_NAME_SIZE 1023
+
+/* Bitmap directory entry flags */
+#define BME_RESERVED_FLAGS 0xfffffffcU
+
+/* bits [1, 8] U [56, 63] are reserved */
+#define BME_TABLE_ENTRY_RESERVED_MASK 0xff000000000001feULL
+#define BME_TABLE_ENTRY_OFFSET_MASK 0x00fffffffffffe00ULL
+#define BME_TABLE_ENTRY_FLAG_ALL_ONES (1ULL << 0)
+
+typedef struct QEMU_PACKED Qcow2BitmapDirEntry {
+    /* header is 8 byte aligned */
+    uint64_t bitmap_table_offset;
+
+    uint32_t bitmap_table_size;
+    uint32_t flags;
+
+    uint8_t type;
+    uint8_t granularity_bits;
+    uint16_t name_size;
+    uint32_t extra_data_size;
+    /* extra data follows  */
+    /* name follows  */
+} Qcow2BitmapDirEntry;
+
+typedef struct Qcow2BitmapTable {
+    uint64_t offset;
+    uint32_t size; /* number of 64bit entries */
+    QSIMPLEQ_ENTRY(Qcow2BitmapTable) entry;
+} Qcow2BitmapTable;
+
+typedef struct Qcow2Bitmap {
+    Qcow2BitmapTable table;
+    uint32_t flags;
+    uint8_t granularity_bits;
+    char *name;
+
+    QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
+} Qcow2Bitmap;
+typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
+
+typedef enum BitmapType {
+    BT_DIRTY_TRACKING_BITMAP = 1
+} BitmapType;
+
+static int check_table_entry(uint64_t entry, int cluster_size)
+{
+    uint64_t offset;
+
+    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
+        return -EINVAL;
+    }
+
+    offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+    if (offset != 0) {
+        /* if offset specified, bit 0 is reserved */
+        if (entry & BME_TABLE_ENTRY_FLAG_ALL_ONES) {
+            return -EINVAL;
+        }
+
+        if (offset % cluster_size != 0) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
+                             uint64_t **bitmap_table)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t i;
+    uint64_t *table;
+
+    assert(tb->size != 0);
+    table = g_try_new(uint64_t, tb->size);
+    if (table == NULL) {
+        return -ENOMEM;
+    }
+
+    assert(tb->size <= BME_MAX_TABLE_SIZE);
+    ret = bdrv_pread(bs->file, tb->offset,
+                     table, tb->size * sizeof(uint64_t));
+    if (ret < 0) {
+        goto fail;
+    }
+
+    for (i = 0; i < tb->size; ++i) {
+        be64_to_cpus(&table[i]);
+        ret = check_table_entry(table[i], s->cluster_size);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    *bitmap_table = table;
+    return 0;
+
+fail:
+    g_free(table);
+
+    return ret;
+}
+
+/*
+ * Bitmap List
+ */
+
+/*
+ * Bitmap List private functions
+ * Only Bitmap List knows about bitmap directory structure in Qcow2.
+ */
+
+static inline void bitmap_dir_entry_to_cpu(Qcow2BitmapDirEntry *entry)
+{
+    be64_to_cpus(&entry->bitmap_table_offset);
+    be32_to_cpus(&entry->bitmap_table_size);
+    be32_to_cpus(&entry->flags);
+    be16_to_cpus(&entry->name_size);
+    be32_to_cpus(&entry->extra_data_size);
+}
+
+static inline int calc_dir_entry_size(size_t name_size, size_t extra_data_size)
+{
+    return align_offset(sizeof(Qcow2BitmapDirEntry) +
+                        name_size + extra_data_size, 8);
+}
+
+static inline int dir_entry_size(Qcow2BitmapDirEntry *entry)
+{
+    return calc_dir_entry_size(entry->name_size, entry->extra_data_size);
+}
+
+static inline const char *dir_entry_name_field(Qcow2BitmapDirEntry *entry)
+{
+    return (const char *)(entry + 1) + entry->extra_data_size;
+}
+
+static inline char *dir_entry_copy_name(Qcow2BitmapDirEntry *entry)
+{
+    const char *name_field = dir_entry_name_field(entry);
+    return g_strndup(name_field, entry->name_size);
+}
+
+static inline Qcow2BitmapDirEntry *next_dir_entry(Qcow2BitmapDirEntry *entry)
+{
+    return (Qcow2BitmapDirEntry *)((uint8_t *)entry + dir_entry_size(entry));
+}
+
+static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t phys_bitmap_bytes;
+    int64_t len;
+
+    bool fail = (entry->bitmap_table_size == 0) ||
+                (entry->bitmap_table_offset == 0) ||
+                (entry->bitmap_table_offset % s->cluster_size) ||
+                (entry->bitmap_table_size > BME_MAX_TABLE_SIZE) ||
+                (entry->granularity_bits > BME_MAX_GRANULARITY_BITS) ||
+                (entry->granularity_bits < BME_MIN_GRANULARITY_BITS) ||
+                (entry->flags & BME_RESERVED_FLAGS) ||
+                (entry->name_size > BME_MAX_NAME_SIZE) ||
+                (entry->type != BT_DIRTY_TRACKING_BITMAP);
+
+    if (fail) {
+        return -EINVAL;
+    }
+
+    phys_bitmap_bytes = (uint64_t)entry->bitmap_table_size * s->cluster_size;
+    len = bdrv_getlength(bs);
+
+    if (len < 0) {
+        return len;
+    }
+
+    fail = (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
+           (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits));
+
+    return fail ? -EINVAL : 0;
+}
+
+/*
+ * Bitmap List public functions
+ */
+
+static void bitmap_free(Qcow2Bitmap *bm)
+{
+    g_free(bm->name);
+    g_free(bm);
+}
+
+static void bitmap_list_free(Qcow2BitmapList *bm_list)
+{
+    Qcow2Bitmap *bm;
+
+    if (bm_list == NULL) {
+        return;
+    }
+
+    while ((bm = QSIMPLEQ_FIRST(bm_list)) != NULL) {
+        QSIMPLEQ_REMOVE_HEAD(bm_list, entry);
+        bitmap_free(bm);
+    }
+
+    g_free(bm_list);
+}
+
+static Qcow2BitmapList *bitmap_list_new(void)
+{
+    Qcow2BitmapList *bm_list = g_new(Qcow2BitmapList, 1);
+    QSIMPLEQ_INIT(bm_list);
+
+    return bm_list;
+}
+
+/* bitmap_list_load
+ * Get bitmap list from qcow2 image. Actually reads bitmap directory,
+ * checks it and convert to bitmap list.
+ */
+static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
+                                         uint64_t size, Error **errp)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint8_t *dir, *dir_end;
+    Qcow2BitmapDirEntry *e;
+    uint32_t nb_dir_entries = 0;
+    Qcow2BitmapList *bm_list = NULL;
+
+    if (size == 0) {
+        error_setg(errp, "Requested bitmap directory size is zero");
+        return NULL;
+    }
+
+    if (size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
+        error_setg(errp, "Requested bitmap directory size is too big");
+        return NULL;
+    }
+
+    dir = g_try_malloc(size);
+    if (dir == NULL) {
+        error_setg(errp, "Failed to allocate space for bitmap directory");
+        return NULL;
+    }
+    dir_end = dir + size;
+
+    ret = bdrv_pread(bs->file, offset, dir, size);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to read bitmap directory");
+        goto fail;
+    }
+
+    bm_list = bitmap_list_new();
+    for (e = (Qcow2BitmapDirEntry *)dir;
+         e < (Qcow2BitmapDirEntry *)dir_end;
+         e = next_dir_entry(e))
+    {
+        Qcow2Bitmap *bm;
+
+        if ((uint8_t *)(e + 1) > dir_end) {
+            goto broken_dir;
+        }
+
+        if (++nb_dir_entries > s->nb_bitmaps) {
+            error_setg(errp, "More bitmaps found than specified in header"
+                       " extension");
+            goto fail;
+        }
+        bitmap_dir_entry_to_cpu(e);
+
+        if ((uint8_t *)next_dir_entry(e) > dir_end) {
+            goto broken_dir;
+        }
+
+        if (e->extra_data_size != 0) {
+            error_setg(errp, "Bitmap extra data is not supported");
+            goto fail;
+        }
+
+        ret = check_dir_entry(bs, e);
+        if (ret < 0) {
+            error_setg(errp, "Bitmap '%.*s' doesn't satisfy the constraints",
+                       e->name_size, dir_entry_name_field(e));
+            goto fail;
+        }
+
+        bm = g_new(Qcow2Bitmap, 1);
+        bm->table.offset = e->bitmap_table_offset;
+        bm->table.size = e->bitmap_table_size;
+        bm->flags = e->flags;
+        bm->granularity_bits = e->granularity_bits;
+        bm->name = dir_entry_copy_name(e);
+        QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
+    }
+
+    if (nb_dir_entries != s->nb_bitmaps) {
+        error_setg(errp, "Less bitmaps found than specified in header"
+                         " extension");
+        goto fail;
+    }
+
+    if ((uint8_t *)e != dir_end) {
+        goto broken_dir;
+    }
+
+    g_free(dir);
+    return bm_list;
+
+broken_dir:
+    ret = -EINVAL;
+    error_setg(errp, "Broken bitmap directory");
+
+fail:
+    g_free(dir);
+    bitmap_list_free(bm_list);
+
+    return NULL;
+}
+
+int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                                  void **refcount_table,
+                                  int64_t *refcount_table_size)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+
+    if (s->nb_bitmaps == 0) {
+        return 0;
+    }
+
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
+                                   s->bitmap_directory_offset,
+                                   s->bitmap_directory_size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, NULL);
+    if (bm_list == NULL) {
+        res->corruptions++;
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        uint64_t *bitmap_table = NULL;
+        int i;
+
+        ret = qcow2_inc_refcounts_imrt(bs, res,
+                                       refcount_table, refcount_table_size,
+                                       bm->table.offset,
+                                       bm->table.size * sizeof(uint64_t));
+        if (ret < 0) {
+            goto out;
+        }
+
+        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+        if (ret < 0) {
+            res->corruptions++;
+            goto out;
+        }
+
+        for (i = 0; i < bm->table.size; ++i) {
+            uint64_t entry = bitmap_table[i];
+            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+
+            if (check_table_entry(entry, s->cluster_size) < 0) {
+                res->corruptions++;
+                continue;
+            }
+
+            if (offset == 0) {
+                continue;
+            }
+
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           offset, s->cluster_size);
+            if (ret < 0) {
+                g_free(bitmap_table);
+                goto out;
+            }
+        }
+
+        g_free(bitmap_table);
+    }
+
+out:
+    bitmap_list_free(bm_list);
+
+    return ret;
+}
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 8add3d5..ceb08bc 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1869,6 +1869,12 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
+    /* bitmaps */
+    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, nb_clusters);
+    if (ret < 0) {
+        return ret;
+    }
+
     return check_refblocks(bs, res, fix, rebuild, refcount_table, nb_clusters);
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 5339aa0..8688fdd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -67,6 +67,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
+#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -170,12 +171,18 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
  */
 static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                                  uint64_t end_offset, void **p_feature_table,
-                                 int flags, Error **errp)
+                                 int flags, bool *need_update_header,
+                                 Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowExtension ext;
     uint64_t offset;
     int ret;
+    Qcow2BitmapHeaderExt bitmaps_ext;
+
+    if (need_update_header != NULL) {
+        *need_update_header = false;
+    }
 
 #ifdef DEBUG_EXT
     printf("qcow2_read_extensions: start=%ld end=%ld\n", start_offset, end_offset);
@@ -287,6 +294,85 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
         }   break;
 
+        case QCOW2_EXT_MAGIC_BITMAPS:
+            if (ext.len != sizeof(bitmaps_ext)) {
+                error_setg_errno(errp, -ret, "bitmaps_ext: "
+                                 "Invalid extension length");
+                return -EINVAL;
+            }
+
+            if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
+                error_report("WARNING: a program lacking bitmap support "
+                             "modified this file, so all bitmaps are now "
+                             "considered inconsistent. Some clusters may be "
+                             "leaked, run 'qemu-img check -r' on the image "
+                             "file to fix.");
+                if (need_update_header != NULL) {
+                    /* Updating is needed to drop invalid bitmap extension. */
+                    *need_update_header = true;
+                }
+                break;
+            }
+
+            ret = bdrv_pread(bs->file, offset, &bitmaps_ext, ext.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "bitmaps_ext: "
+                                 "Could not read ext header");
+                return ret;
+            }
+
+            if (bitmaps_ext.reserved32 != 0) {
+                error_setg_errno(errp, -ret, "bitmaps_ext: "
+                                 "Reserved field is not zero");
+                return -EINVAL;
+            }
+
+            be32_to_cpus(&bitmaps_ext.nb_bitmaps);
+            be64_to_cpus(&bitmaps_ext.bitmap_directory_size);
+            be64_to_cpus(&bitmaps_ext.bitmap_directory_offset);
+
+            if (bitmaps_ext.nb_bitmaps > QCOW2_MAX_BITMAPS) {
+                error_setg(errp,
+                           "bitmaps_ext: Image has %" PRIu32 " bitmaps, "
+                           "exceeding the QEMU supported maximum of %d",
+                           bitmaps_ext.nb_bitmaps, QCOW2_MAX_BITMAPS);
+                return -EINVAL;
+            }
+
+            if (bitmaps_ext.nb_bitmaps == 0) {
+                error_setg(errp, "found bitmaps extension with zero bitmaps");
+                return -EINVAL;
+            }
+
+            if (bitmaps_ext.bitmap_directory_offset & (s->cluster_size - 1)) {
+                error_setg(errp, "bitmaps_ext: "
+                                 "invalid bitmap directory offset");
+                return -EINVAL;
+            }
+
+            if (bitmaps_ext.bitmap_directory_size >
+                QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
+                error_setg(errp, "bitmaps_ext: "
+                                 "bitmap directory size (%" PRIu64 ") exceeds "
+                                 "the maximum supported size (%d)",
+                                 bitmaps_ext.bitmap_directory_size,
+                                 QCOW2_MAX_BITMAP_DIRECTORY_SIZE);
+                return -EINVAL;
+            }
+
+            s->nb_bitmaps = bitmaps_ext.nb_bitmaps;
+            s->bitmap_directory_offset =
+                    bitmaps_ext.bitmap_directory_offset;
+            s->bitmap_directory_size =
+                    bitmaps_ext.bitmap_directory_size;
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got bitmaps extension: "
+                   "offset=%" PRIu64 " nb_bitmaps=%" PRIu32 "\n",
+                   s->bitmap_directory_offset, s->nb_bitmaps);
+#endif
+            break;
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             {
@@ -1008,6 +1094,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
+    bool update_header = false;
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -1113,7 +1200,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
-                              &feature_table, flags, NULL);
+                              &feature_table, flags, NULL, NULL);
         report_unsupported_feature(errp, feature_table,
                                    s->incompatible_features &
                                    ~QCOW2_INCOMPAT_MASK);
@@ -1297,7 +1384,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* read qcow2 extensions */
     if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
-                              flags, &local_err)) {
+                              flags, &update_header, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
@@ -1357,8 +1444,10 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Clear unknown autoclear feature bits */
-    if (!bs->read_only && !(flags & BDRV_O_INACTIVE) && s->autoclear_features) {
-        s->autoclear_features = 0;
+    update_header |= s->autoclear_features & ~QCOW2_AUTOCLEAR_MASK;
+
+    if (update_header && !bs->read_only && !(flags & BDRV_O_INACTIVE)) {
+        s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
         ret = qcow2_update_header(bs);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not update qcow2 header");
@@ -2203,6 +2292,25 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Bitmap extension */
+    if (s->nb_bitmaps > 0) {
+        Qcow2BitmapHeaderExt bitmaps_header = {
+            .nb_bitmaps = cpu_to_be32(s->nb_bitmaps),
+            .bitmap_directory_size =
+                    cpu_to_be64(s->bitmap_directory_size),
+            .bitmap_directory_offset =
+                    cpu_to_be64(s->bitmap_directory_offset)
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_BITMAPS,
+                             &bitmaps_header, sizeof(bitmaps_header),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Keep unknown header extensions */
     QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
         ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
@@ -2884,6 +2992,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
         return -ENOTSUP;
     }
 
+    /* cannot proceed if image has bitmaps */
+    if (s->nb_bitmaps) {
+        /* TODO: resize bitmaps in the image */
+        error_setg(errp, "Can't resize an image which has bitmaps");
+        return -ENOTSUP;
+    }
+
     /* shrinking is currently not supported */
     if (offset < bs->total_sectors * 512) {
         error_setg(errp, "qcow2 doesn't support shrinking images yet");
diff --git a/block/qcow2.h b/block/qcow2.h
index a272a39..3488648 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -53,6 +53,10 @@
  * space for snapshot names and IDs */
 #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
 
+/* Bitmap header extension constraints */
+#define QCOW2_MAX_BITMAPS 65535
+#define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
+
 /* indicate that the refcount of the referenced cluster is exactly one. */
 #define QCOW_OFLAG_COPIED     (1ULL << 63)
 /* indicate that the cluster is compressed (they never have the copied flag) */
@@ -201,6 +205,14 @@ enum {
     QCOW2_COMPAT_FEAT_MASK            = QCOW2_COMPAT_LAZY_REFCOUNTS,
 };
 
+/* Autoclear feature bits */
+enum {
+    QCOW2_AUTOCLEAR_BITMAPS_BITNR = 0,
+    QCOW2_AUTOCLEAR_BITMAPS       = 1 << QCOW2_AUTOCLEAR_BITMAPS_BITNR,
+
+    QCOW2_AUTOCLEAR_MASK          = QCOW2_AUTOCLEAR_BITMAPS,
+};
+
 enum qcow2_discard_type {
     QCOW2_DISCARD_NEVER = 0,
     QCOW2_DISCARD_ALWAYS,
@@ -228,6 +240,13 @@ typedef uint64_t Qcow2GetRefcountFunc(const void *refcount_array,
 typedef void Qcow2SetRefcountFunc(void *refcount_array,
                                   uint64_t index, uint64_t value);
 
+typedef struct Qcow2BitmapHeaderExt {
+    uint32_t nb_bitmaps;
+    uint32_t reserved32;
+    uint64_t bitmap_directory_size;
+    uint64_t bitmap_directory_offset;
+} QEMU_PACKED Qcow2BitmapHeaderExt;
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -274,6 +293,10 @@ typedef struct BDRVQcow2State {
     unsigned int nb_snapshots;
     QCowSnapshot *snapshots;
 
+    uint32_t nb_bitmaps;
+    uint64_t bitmap_directory_size;
+    uint64_t bitmap_directory_offset;
+
     int flags;
     int qcow_version;
     bool use_lazy_refcounts;
@@ -618,4 +641,8 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 
+/* qcow2-bitmap.c functions */
+int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                                  void **refcount_table,
+                                  int64_t *refcount_table_size);
 #endif
-- 
1.8.3.1
