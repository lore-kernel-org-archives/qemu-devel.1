Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fDruZ-0005ni-KE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fDruW-00016m-F7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:35:11 -0400
From: Ivan Ren <renyime@gmail.com>
Date: Wed,  2 May 2018 21:34:53 +0800
Message-Id: <1525268093-531-1-git-send-email-ivanren@tencent.com>
Subject: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

qemu-img info with a block device which has a qcow2 format always
return 0 for disk size, and this can not reflect the qcow2 size
and the used space of the block device. This patch return the
allocated size of qcow2 as the disk size.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 block/qcow2-bitmap.c |  69 +++++++++++++++++
 block/qcow2.c        | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.h        |  42 ++++++++++
 3 files changed, 323 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6e93ec4..2957a7a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -636,6 +636,75 @@ fail:
     return NULL;
 }
 
+/*
+ * Get the highest allocated cluster index of bitmap
+ */
+int qcow2_get_bitmap_allocated_clusters(BlockDriverState *bs,
+                                        int64_t *p_highest_cluster_index,
+                                        int64_t nb_clusters)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list = NULL;
+    Qcow2Bitmap *bm;
+
+    if (s->nb_bitmaps == 0) {
+        return 0;
+    }
+
+    ret = update_highest_cluster_index(s, s->bitmap_directory_offset,
+                                       s->bitmap_directory_size,
+                                       p_highest_cluster_index, nb_clusters);
+    if (ret == 1) {
+        goto out;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, NULL);
+    if (bm_list == NULL) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        uint64_t *bitmap_table = NULL;
+        int i;
+
+        ret = update_highest_cluster_index(s, bm->table.offset,
+                                        bm->table.size * sizeof(uint64_t),
+                                        p_highest_cluster_index, nb_clusters);
+        if (ret == 1) {
+            goto out;
+        }
+
+        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+        if (ret < 0) {
+            goto out;
+        }
+
+        for (i = 0; i < bm->table.size; ++i) {
+            uint64_t entry = bitmap_table[i];
+            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+
+            /* ignore entry legality */
+            if (offset == 0) {
+                continue;
+            }
+
+            ret = update_highest_cluster_index(s, offset, s->cluster_size,
+                                         p_highest_cluster_index, nb_clusters);
+            if (ret == 1) {
+                g_free(bitmap_table);
+                goto out;
+            }
+        }
+        g_free(bitmap_table);
+    }
+out:
+    bitmap_list_free(bm_list);
+    return ret;
+}
+
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size)
diff --git a/block/qcow2.c b/block/qcow2.c
index ef68772..fa251af 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4493,6 +4493,217 @@ static QemuOptsList qcow2_create_opts = {
     }
 };
 
+static int qcow2_get_l2_allocated_size(BlockDriverState *bs,
+                                     uint64_t l2_table_offset,
+                                     int64_t *p_highest_cluster_index,
+                                     int64_t nb_clusters)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *l2_table = NULL, l2_entry, cluster_offset;
+    int l2_size, ret, i, nb_csectors;
+
+    /* malloc L2 table */
+    l2_size = s->l2_size * sizeof(uint64_t);
+    if (l2_size > 0) {
+        l2_table = g_malloc(l2_size);
+        if (l2_table == NULL) {
+            ret = -ENOMEM;
+            goto out;
+        }
+        /* load l2 table from image file */
+        ret = bdrv_pread(bs->file, l2_table_offset, l2_table, l2_size);
+        if (ret < 0 || ret != l2_size) {
+            goto out;
+        }
+
+        ret = update_highest_cluster_index(s, l2_table_offset, l2_size,
+                p_highest_cluster_index, nb_clusters);
+        if (ret == 1) {
+            goto out;
+        }
+    }
+
+    for (i = 0; i < s->l2_size; i++) {
+        l2_entry = be64_to_cpu(l2_table[i]);
+        switch (qcow2_get_cluster_type(l2_entry)) {
+        case QCOW2_CLUSTER_COMPRESSED:
+            nb_csectors = ((l2_entry >> s->csize_shift) & s->csize_mask) + 1;
+            l2_entry &= s->cluster_offset_mask;
+            ret = update_highest_cluster_index(s, l2_entry & ~511,
+                                        nb_csectors * 512,
+                                        p_highest_cluster_index, nb_clusters);
+            if (ret == 1) {
+                goto out;
+            }
+            break;
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_CLUSTER_NORMAL:
+            cluster_offset = l2_entry & L2E_OFFSET_MASK;
+
+            ret = update_highest_cluster_index(s, cluster_offset,
+                                        s->cluster_size,
+                                        p_highest_cluster_index, nb_clusters);
+            if (ret == 1) {
+                goto out;
+            }
+
+            break;
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_UNALLOCATED:
+            break;
+        default:
+            abort(); /* some error happen */
+        }
+    }
+    ret = 0;
+out:
+    g_free(l2_table);
+    return ret;
+}
+
+static int qcow2_get_l1_allocated_size(BlockDriverState *bs,
+                                     uint64_t l1_table_offset,
+                                     int l1_size,
+                                     int64_t *p_highest_cluster_index,
+                                     int64_t nb_clusters)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *l1_table = NULL, l2_offset;
+    int i, ret, l1_size2;
+
+    /* malloca l1 table memory */
+    l1_size2 = l1_size * sizeof(uint64_t);
+    if (l1_size2 > 0) {
+        l1_table = g_malloc(l1_size2);
+        if (!l1_table) {
+            ret = -ENOMEM;
+            goto out;
+        }
+        ret = bdrv_pread(bs->file, l1_table_offset, l1_table, l1_size2);
+        if (ret < 0 || ret != l1_size2) {
+            goto out;
+        }
+
+        ret = update_highest_cluster_index(s, l1_table_offset, l1_size2,
+                                        p_highest_cluster_index, nb_clusters);
+        if (ret == 1) /* has reached the end */
+            goto out;
+    }
+
+
+    for (i = 0; i < l1_size; i++) {
+        be64_to_cpus(&l1_table[i]);
+        l2_offset = l1_table[i];
+        if (l2_offset) {
+            l2_offset &= L1E_OFFSET_MASK;
+            ret = qcow2_get_l2_allocated_size(bs, l2_offset,
+                                p_highest_cluster_index,  nb_clusters);
+            if (ret <  0 || ret == 1) {
+                goto out;
+            }
+        }
+    }
+
+    ret = 0;
+out:
+    g_free(l1_table);
+    return ret;
+
+}
+
+/* Get block device allocated space for qcow2, aligned with cluster_size */
+static int64_t qcow2_get_block_allocated_size(BlockDriverState *bs)
+{
+    int64_t file_size, file_max_clusters;
+    uint64_t offset, allocated_size;
+    int64_t highest_cluster_index = 0;
+    int i, ret;
+    BDRVQcow2State *s = bs->opaque;
+    QCowSnapshot *sn;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    file_max_clusters = size_to_clusters(s, file_size);
+
+    /* current image map */
+    ret = qcow2_get_l1_allocated_size(bs, s->l1_table_offset,
+                                          s->l1_size, &highest_cluster_index,
+                                          file_max_clusters);
+    if (ret < 0 || ret == 1) {
+        goto out;
+    }
+
+    /* snapshot */
+    for (i = 0; i < s->nb_snapshots; i++) {
+        sn = s->snapshots + i;
+        ret = qcow2_get_l1_allocated_size(bs, sn->l1_table_offset,
+                                            sn->l1_size, &highest_cluster_index,
+                                            file_max_clusters);
+        if (ret < 0 || ret == 1) {
+            goto out;
+        }
+    }
+    ret = update_highest_cluster_index(s, s->snapshots_offset,
+                  s->snapshots_size, &highest_cluster_index, file_max_clusters);
+    if (ret == 1) {
+        goto out;
+    }
+
+    /* refcount table */
+    ret = update_highest_cluster_index(s, s->refcount_table_offset,
+                                 s->refcount_table_size * sizeof(uint64_t),
+                                 &highest_cluster_index, file_max_clusters);
+    if (ret == 1) {
+        goto out;
+    }
+    for (i = 0; i < s->refcount_table_size; i++) {
+        offset = s->refcount_table[i];
+        ret = update_highest_cluster_index(s, offset, s->cluster_size,
+                                     &highest_cluster_index, file_max_clusters);
+        if (ret == 1) {
+            goto out;
+        }
+    }
+
+    /* encryption */
+    if (s->crypto_header.length) {
+        ret = update_highest_cluster_index(s, s->crypto_header.offset,
+                                    s->crypto_header.length,
+                                    &highest_cluster_index, file_max_clusters);
+        if (ret == 1) {
+            goto out;
+        }
+    }
+
+    /* bitmap */
+    ret = qcow2_get_bitmap_allocated_clusters(bs, &highest_cluster_index,
+                                        file_max_clusters);
+out:
+    if (ret < 0) {
+        allocated_size = 0; /* if any error happen, return zero */
+    } else {
+        allocated_size = MIN((highest_cluster_index + 1) * s->cluster_size,
+                              file_size);
+    }
+
+    return allocated_size;
+}
+
+static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
+{
+    struct stat st;
+    if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
+        goto get_file_size;
+    }
+
+    return qcow2_get_block_allocated_size(bs);
+
+get_file_size:
+    if (bs->file) {
+        return bdrv_get_allocated_file_size(bs->file->bs);
+    }
+    return -ENOTSUP;
+}
+
 BlockDriver bdrv_qcow2 = {
     .format_name        = "qcow2",
     .instance_size      = sizeof(BDRVQcow2State),
@@ -4516,6 +4727,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
     .bdrv_truncate          = qcow2_truncate,
+    .bdrv_get_allocated_file_size = qcow2_get_allocated_file_size,
     .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
     .bdrv_make_empty        = qcow2_make_empty,
 
diff --git a/block/qcow2.h b/block/qcow2.h
index adf5c39..9ed3771 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -466,6 +466,45 @@ static inline int64_t size_to_l1(BDRVQcow2State *s, int64_t size)
     return (size + (1ULL << shift) - 1) >> shift;
 }
 
+static inline int64_t offset_to_cluster_index(BDRVQcow2State *s,
+                                              uint64_t offset)
+{
+    return offset >> s->cluster_bits;
+}
+
+/*
+ * Return value may be 0 or 1, 1 means the highest cluster
+ * index has reached the max device size, so There is no need
+ * to continue scanning. @*p_highest_cluster_index has the
+ * new highest cluster index
+ */
+static inline int update_highest_cluster_index(BDRVQcow2State *s,
+                                        int64_t offset,
+                                        int64_t size,
+                                        int64_t *p_highest_cluster_index,
+                                        int64_t nb_clusters)
+{
+    int64_t cluster_index;
+    cluster_index = offset_to_cluster_index(s, offset + size - 1);
+
+    /* If necessary update the new highest index.
+     * Cluster Index exceed the device will be ignored.
+     */
+    if (cluster_index > *p_highest_cluster_index
+                        && cluster_index < nb_clusters) {
+        *p_highest_cluster_index = cluster_index;
+    } else {
+        return 0;
+    }
+
+
+    if (*p_highest_cluster_index == (nb_clusters - 1)) {
+        return 1; /* have reached max */
+    } else {
+        return 0;
+    }
+}
+
 static inline int offset_to_l1_index(BDRVQcow2State *s, uint64_t offset)
 {
     return offset >> (s->l2_bits + s->cluster_bits);
@@ -668,6 +707,9 @@ void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
+int qcow2_get_bitmap_allocated_clusters(BlockDriverState *bs,
+                                        int64_t *p_highest_cluster_index,
+                                        int64_t nb_clusters);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
-- 
1.8.3.1
