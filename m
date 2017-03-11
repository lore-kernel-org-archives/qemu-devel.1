Received: from eggs.gnu.org ([2001:4830:134:3::10]:41324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cmfav-0004WV-7F
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 06:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cmfat-0007yV-2S
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 06:53:57 -0500
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 11 Mar 2017 17:24:04 +0530
Message-Id: <1489233245-27057-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
References: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] vmdk: Optimize I/O by allocating multiple
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

The vmdk driver in block/vmdk.c used to allocate cluster by cluster
which slowed down its I/O performance.

Make vmdk driver allocate multiple clusters at once to reduce the
overhead costs of multiple separate cluster allocation calls. The number
of clusters allocated at once depends on the L2 table boundaries. Also
the first and the last clusters are allocated separately as we may need
to perform COW for them

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 513 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 366 insertions(+), 147 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index a9bd22b..3dc178b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -136,6 +136,7 @@ typedef struct VmdkMetaData {
     unsigned int l2_offset;
     int valid;
     uint32_t *l2_cache_entry;
+    uint32_t nb_clusters;
 } VmdkMetaData;
 
 typedef struct VmdkGrainMarker {
@@ -242,6 +243,26 @@ static void vmdk_free_last_extent(BlockDriverState *bs)
     s->extents = g_renew(VmdkExtent, s->extents, s->num_extents);
 }
 
+static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
+                                                   int64_t offset)
+{
+    uint64_t extent_begin_offset, extent_relative_offset;
+    uint64_t cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
+
+    extent_begin_offset =
+        (extent->end_sector - extent->sectors) * BDRV_SECTOR_SIZE;
+    extent_relative_offset = offset - extent_begin_offset;
+    return extent_relative_offset % cluster_size;
+}
+
+static inline uint64_t size_to_clusters(VmdkExtent *extent, uint64_t size)
+{
+    uint64_t cluster_size, round_off_size;
+    cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
+    round_off_size = cluster_size - (size % cluster_size);
+    return ((size + round_off_size) >> 16) - 1;
+}
+
 static uint32_t vmdk_read_cid(BlockDriverState *bs, int parent)
 {
     char *desc;
@@ -1016,8 +1037,135 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
-/**
- * get_whole_cluster
+static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
+                         uint32_t offset)
+{
+    offset = cpu_to_le32(offset);
+    /* update L2 table */
+    if (bdrv_pwrite_sync(extent->file,
+                ((int64_t)m_data->l2_offset * 512)
+                    + (m_data->l2_index * sizeof(offset)),
+                &offset, sizeof(offset)) < 0) {
+        return VMDK_ERROR;
+    }
+    /* update backup L2 table */
+    if (extent->l1_backup_table_offset != 0) {
+        m_data->l2_offset = extent->l1_backup_table[m_data->l1_index];
+        if (bdrv_pwrite_sync(extent->file,
+                    ((int64_t)m_data->l2_offset * 512)
+                        + (m_data->l2_index * sizeof(offset)),
+                    &offset, sizeof(offset)) < 0) {
+            return VMDK_ERROR;
+        }
+    }
+    if (m_data->l2_cache_entry) {
+        *m_data->l2_cache_entry = offset;
+    }
+
+    return VMDK_OK;
+}
+
+/*
+ * vmdk_L2load
+ *
+ * Loads a new L2 table into memory. If the table is in the cache, the cache
+ * is used; otherwise the L2 table is loaded from the image file.
+ *
+ * Returns:
+ *   VMDK_OK:       on success
+ *   VMDK_ERROR:    in error cases
+ */
+static int vmdk_L2load(VmdkExtent *extent, uint64_t offset, int l2_offset,
+                       uint32_t **new_l2_table, int *new_l2_index)
+{
+    int min_index, i, j;
+    uint32_t *l2_table;
+    uint32_t min_count;
+
+    for (i = 0; i < L2_CACHE_SIZE; i++) {
+        if (l2_offset == extent->l2_cache_offsets[i]) {
+            /* increment the hit count */
+            if (++extent->l2_cache_counts[i] == 0xffffffff) {
+                for (j = 0; j < L2_CACHE_SIZE; j++) {
+                    extent->l2_cache_counts[j] >>= 1;
+                }
+            }
+            l2_table = extent->l2_cache + (i * extent->l2_size);
+            goto found;
+        }
+    }
+    /* not found: load a new entry in the least used one */
+    min_index = 0;
+    min_count = 0xffffffff;
+    for (i = 0; i < L2_CACHE_SIZE; i++) {
+        if (extent->l2_cache_counts[i] < min_count) {
+            min_count = extent->l2_cache_counts[i];
+            min_index = i;
+        }
+    }
+    l2_table = extent->l2_cache + (min_index * extent->l2_size);
+    if (bdrv_pread(extent->file,
+                (int64_t)l2_offset * 512,
+                l2_table,
+                extent->l2_size * sizeof(uint32_t)
+            ) != extent->l2_size * sizeof(uint32_t)) {
+        return VMDK_ERROR;
+    }
+
+    extent->l2_cache_offsets[min_index] = l2_offset;
+    extent->l2_cache_counts[min_index] = 1;
+found:
+    *new_l2_index = ((offset >> 9) / extent->cluster_sectors) % extent->l2_size;
+    *new_l2_table = l2_table;
+
+    return VMDK_OK;
+}
+
+/*
+ * get_cluster_table
+ *
+ * for a given offset, load (and allocate if needed) the l2 table.
+ *
+ * Returns:
+ *   VMDK_OK:        on success
+ *
+ *   VMDK_UNALLOC:   if cluster is not mapped
+ *
+ *   VMDK_ERROR:     in error cases
+ */
+static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
+                             int *new_l1_index, int *new_l2_offset,
+                             int *new_l2_index, uint32_t **new_l2_table)
+{
+    int l1_index, l2_offset, l2_index;
+    uint32_t *l2_table;
+    int ret;
+
+    offset -= (extent->end_sector - extent->sectors) * SECTOR_SIZE;
+    l1_index = (offset >> 9) / extent->l1_entry_sectors;
+    if (l1_index >= extent->l1_size) {
+        return VMDK_ERROR;
+    }
+    l2_offset = extent->l1_table[l1_index];
+    if (!l2_offset) {
+        return VMDK_UNALLOC;
+    }
+
+    ret = vmdk_L2load(extent, offset, l2_offset, &l2_table, &l2_index);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *new_l1_index = l1_index;
+    *new_l2_offset = l2_offset;
+    *new_l2_index = l2_index;
+    *new_l2_table = l2_table;
+
+    return VMDK_OK;
+}
+
+/*
+ * do_alloc_cluster_offset
  *
  * Copy backing file's cluster that covers @sector_num, otherwise write zero,
  * to the cluster at @cluster_sector_num.
@@ -1025,13 +1173,18 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
  * If @skip_start_sector < @skip_end_sector, the relative range
  * [@skip_start_sector, @skip_end_sector) is not copied or written, and leave
  * it for call to write user data in the request.
+ *
+ * Returns:
+ *   VMDK_OK:       on success
+ *
+ *   VMDK_ERROR:    in error cases
  */
-static int get_whole_cluster(BlockDriverState *bs,
-                             VmdkExtent *extent,
-                             uint64_t cluster_offset,
-                             uint64_t offset,
-                             uint64_t skip_start_bytes,
-                             uint64_t skip_end_bytes)
+static int do_alloc_cluster_offset(BlockDriverState *bs,
+                                   VmdkExtent *extent,
+                                   uint64_t cluster_offset,
+                                   uint64_t offset,
+                                   uint64_t skip_start_bytes,
+                                   uint64_t skip_end_bytes)
 {
     int ret = VMDK_OK;
     int64_t cluster_bytes;
@@ -1098,36 +1251,176 @@ exit:
     return ret;
 }
 
-static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
-                         uint32_t offset)
+/*
+ * handle_alloc
+ *
+ * Allocates new clusters for an area that either is yet unallocated or needs a
+ * copy on write. If *cluster_offset is non_zero, clusters are only allocated if
+ * the new allocation can match the specified host offset.
+ *
+ * Returns:
+ *   VMDK_OK:       if new clusters were allocated, *bytes may be decreased if
+ *                  the new allocation doesn't cover all of the requested area.
+ *                  *cluster_offset is updated to contain the offset of the
+ *                  first newly allocated cluster.
+ *
+ *   VMDK_UNALLOC:  if no clusters could be allocated. *cluster_offset is left
+ *                  unchanged.
+ *
+ *   VMDK_ERROR:    in error cases
+ */
+static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
+                        uint64_t offset, uint64_t *cluster_offset,
+                        int64_t *bytes, VmdkMetaData *m_data,
+                        bool allocate, uint32_t *total_alloc_clusters)
 {
-    offset = cpu_to_le32(offset);
-    /* update L2 table */
-    if (bdrv_pwrite_sync(extent->file,
-                ((int64_t)m_data->l2_offset * 512)
-                    + (m_data->l2_index * sizeof(offset)),
-                &offset, sizeof(offset)) < 0) {
-        return VMDK_ERROR;
+    int l1_index, l2_offset, l2_index;
+    uint32_t *l2_table;
+    uint32_t cluster_sector;
+    uint32_t nb_clusters;
+    bool zeroed = false;
+    uint64_t skip_start_bytes, skip_end_bytes;
+    int ret;
+
+    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
+                            &l2_index, &l2_table);
+    if (ret < 0) {
+        return ret;
     }
-    /* update backup L2 table */
-    if (extent->l1_backup_table_offset != 0) {
-        m_data->l2_offset = extent->l1_backup_table[m_data->l1_index];
-        if (bdrv_pwrite_sync(extent->file,
-                    ((int64_t)m_data->l2_offset * 512)
-                        + (m_data->l2_index * sizeof(offset)),
-                    &offset, sizeof(offset)) < 0) {
-            return VMDK_ERROR;
+
+    cluster_sector = le32_to_cpu(l2_table[l2_index]);
+
+    skip_start_bytes = vmdk_find_offset_in_cluster(extent, offset);
+    /* Calculate the number of clusters to look for. Here it will return one
+     * cluster less than the actual value calculated as we may need to perfrom
+     * COW for the last one. */
+    nb_clusters = size_to_clusters(extent, skip_start_bytes + *bytes);
+
+    nb_clusters = MIN(nb_clusters, extent->l2_size - l2_index);
+    assert(nb_clusters <= INT_MAX);
+
+    /* update bytes according to final nb_clusters value */
+    if (nb_clusters != 0) {
+        *bytes = ((nb_clusters * extent->cluster_sectors) << 9)
+                                            - skip_start_bytes;
+    } else {
+        nb_clusters = 1;
+    }
+    *total_alloc_clusters += nb_clusters;
+    skip_end_bytes = skip_start_bytes + MIN(*bytes,
+                     extent->cluster_sectors * BDRV_SECTOR_SIZE
+                                    - skip_start_bytes);
+
+    if (extent->has_zero_grain && cluster_sector == VMDK_GTE_ZEROED) {
+        zeroed = true;
+    }
+
+    if (!cluster_sector || zeroed) {
+        if (!allocate) {
+            return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
+        }
+
+        cluster_sector = extent->next_cluster_sector;
+        extent->next_cluster_sector += extent->cluster_sectors
+                                                * nb_clusters;
+
+        ret = do_alloc_cluster_offset(bs, extent,
+                                      cluster_sector * BDRV_SECTOR_SIZE,
+                                      offset, skip_start_bytes,
+                                      skip_end_bytes);
+        if (ret < 0) {
+            return ret;
+        }
+        if (m_data) {
+            m_data->valid = 1;
+            m_data->l1_index = l1_index;
+            m_data->l2_index = l2_index;
+            m_data->l2_offset = l2_offset;
+            m_data->l2_cache_entry = &l2_table[l2_index];
+            m_data->nb_clusters = nb_clusters;
         }
     }
-    if (m_data->l2_cache_entry) {
-        *m_data->l2_cache_entry = offset;
+    *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
+    return VMDK_OK;
+}
+
+/*
+ * vmdk_alloc_cluster_offset
+ *
+ * For a given offset on the virtual disk, find the cluster offset in vmdk
+ * file. If the offset is not found, allocate a new cluster.
+ *
+ * If the cluster is newly allocated, m_data->nb_clusters is set to the number
+ * of contiguous clusters that have been allocated. In this case, the other
+ * fields of m_data are valid and contain information about the first allocated
+ * cluster.
+ *
+ * Returns:
+ *
+ *   VMDK_OK:           on success and @cluster_offset was set
+ *
+ *   VMDK_UNALLOC:      if no clusters were allocated and @cluster_offset is
+ *                      set to zero
+ *
+ *   VMDK_ERROR:        in error cases
+ */
+static int vmdk_alloc_cluster_offset(BlockDriverState *bs,
+                                     VmdkExtent *extent,
+                                     VmdkMetaData *m_data, uint64_t offset,
+                                     bool allocate, uint64_t *cluster_offset,
+                                     int64_t bytes,
+                                     uint32_t *total_alloc_clusters)
+{
+    uint64_t start, remaining;
+    uint64_t new_cluster_offset;
+    int64_t n_bytes;
+    int ret;
+
+    if (extent->flat) {
+        *cluster_offset = extent->flat_start_offset;
+        return VMDK_OK;
+    }
+
+    start = offset;
+    remaining = bytes;
+    new_cluster_offset = 0;
+    *cluster_offset = 0;
+    n_bytes = 0;
+    if (m_data) {
+        m_data->valid = 0;
+    }
+
+    /* due to L2 table margins all bytes may not get allocated at once */
+    while (true) {
+
+        if (!*cluster_offset) {
+            *cluster_offset = new_cluster_offset;
+        }
+
+        start              += n_bytes;
+        remaining          -= n_bytes;
+        new_cluster_offset += n_bytes;
+
+        if (remaining == 0) {
+            break;
+        }
+
+        n_bytes = remaining;
+
+        ret = handle_alloc(bs, extent, start, &new_cluster_offset, &n_bytes,
+                           m_data, allocate, total_alloc_clusters);
+
+        if (ret < 0) {
+            return ret;
+
+        }
     }
 
     return VMDK_OK;
 }
 
 /**
- * get_cluster_offset
+ * vmdk_get_cluster_offset
  *
  * Look up cluster offset in extent file by sector number, and store in
  * @cluster_offset.
@@ -1135,84 +1428,34 @@ static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
  * For flat extents, the start offset as parsed from the description file is
  * returned.
  *
- * For sparse extents, look up in L1, L2 table. If allocate is true, return an
- * offset for a new cluster and update L2 cache. If there is a backing file,
- * COW is done before returning; otherwise, zeroes are written to the allocated
- * cluster. Both COW and zero writing skips the sector range
- * [@skip_start_sector, @skip_end_sector) passed in by caller, because caller
- * has new data to write there.
+ * For sparse extents, look up in L1, L2 table.
  *
  * Returns: VMDK_OK if cluster exists and mapped in the image.
- *          VMDK_UNALLOC if cluster is not mapped and @allocate is false.
- *          VMDK_ERROR if failed.
+ *          VMDK_UNALLOC if cluster is not mapped.
+ *          VMDK_ERROR if failed
  */
-static int get_cluster_offset(BlockDriverState *bs,
-                              VmdkExtent *extent,
-                              VmdkMetaData *m_data,
-                              uint64_t offset,
-                              bool allocate,
-                              uint64_t *cluster_offset,
-                              uint64_t skip_start_bytes,
-                              uint64_t skip_end_bytes)
+static int vmdk_get_cluster_offset(BlockDriverState *bs,
+                                   VmdkExtent *extent,
+                                   uint64_t offset,
+                                   uint64_t *cluster_offset)
 {
-    unsigned int l1_index, l2_offset, l2_index;
-    int min_index, i, j;
-    uint32_t min_count, *l2_table;
+    int l1_index, l2_offset, l2_index;
+    uint32_t *l2_table;
     bool zeroed = false;
     int64_t ret;
     int64_t cluster_sector;
 
-    if (m_data) {
-        m_data->valid = 0;
-    }
     if (extent->flat) {
         *cluster_offset = extent->flat_start_offset;
         return VMDK_OK;
     }
 
-    offset -= (extent->end_sector - extent->sectors) * SECTOR_SIZE;
-    l1_index = (offset >> 9) / extent->l1_entry_sectors;
-    if (l1_index >= extent->l1_size) {
-        return VMDK_ERROR;
-    }
-    l2_offset = extent->l1_table[l1_index];
-    if (!l2_offset) {
-        return VMDK_UNALLOC;
-    }
-    for (i = 0; i < L2_CACHE_SIZE; i++) {
-        if (l2_offset == extent->l2_cache_offsets[i]) {
-            /* increment the hit count */
-            if (++extent->l2_cache_counts[i] == 0xffffffff) {
-                for (j = 0; j < L2_CACHE_SIZE; j++) {
-                    extent->l2_cache_counts[j] >>= 1;
-                }
-            }
-            l2_table = extent->l2_cache + (i * extent->l2_size);
-            goto found;
-        }
-    }
-    /* not found: load a new entry in the least used one */
-    min_index = 0;
-    min_count = 0xffffffff;
-    for (i = 0; i < L2_CACHE_SIZE; i++) {
-        if (extent->l2_cache_counts[i] < min_count) {
-            min_count = extent->l2_cache_counts[i];
-            min_index = i;
-        }
-    }
-    l2_table = extent->l2_cache + (min_index * extent->l2_size);
-    if (bdrv_pread(extent->file,
-                (int64_t)l2_offset * 512,
-                l2_table,
-                extent->l2_size * sizeof(uint32_t)
-            ) != extent->l2_size * sizeof(uint32_t)) {
-        return VMDK_ERROR;
+    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
+                            &l2_index, &l2_table);
+    if (ret < 0) {
+        return ret;
     }
 
-    extent->l2_cache_offsets[min_index] = l2_offset;
-    extent->l2_cache_counts[min_index] = 1;
- found:
-    l2_index = ((offset >> 9) / extent->cluster_sectors) % extent->l2_size;
     cluster_sector = le32_to_cpu(l2_table[l2_index]);
 
     if (extent->has_zero_grain && cluster_sector == VMDK_GTE_ZEROED) {
@@ -1220,31 +1463,9 @@ static int get_cluster_offset(BlockDriverState *bs,
     }
 
     if (!cluster_sector || zeroed) {
-        if (!allocate) {
-            return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
-        }
-
-        cluster_sector = extent->next_cluster_sector;
-        extent->next_cluster_sector += extent->cluster_sectors;
-
-        /* First of all we write grain itself, to avoid race condition
-         * that may to corrupt the image.
-         * This problem may occur because of insufficient space on host disk
-         * or inappropriate VM shutdown.
-         */
-        ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes);
-        if (ret) {
-            return ret;
-        }
-        if (m_data) {
-            m_data->valid = 1;
-            m_data->l1_index = l1_index;
-            m_data->l2_index = l2_index;
-            m_data->l2_offset = l2_offset;
-            m_data->l2_cache_entry = &l2_table[l2_index];
-        }
+        return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
     }
+
     *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
     return VMDK_OK;
 }
@@ -1266,18 +1487,6 @@ static VmdkExtent *find_extent(BDRVVmdkState *s,
     return NULL;
 }
 
-static inline uint64_t vmdk_find_offset_in_cluster(VmdkExtent *extent,
-                                                   int64_t offset)
-{
-    uint64_t extent_begin_offset, extent_relative_offset;
-    uint64_t cluster_size = extent->cluster_sectors * BDRV_SECTOR_SIZE;
-
-    extent_begin_offset =
-        (extent->end_sector - extent->sectors) * BDRV_SECTOR_SIZE;
-    extent_relative_offset = offset - extent_begin_offset;
-    return extent_relative_offset % cluster_size;
-}
-
 static inline uint64_t vmdk_find_index_in_cluster(VmdkExtent *extent,
                                                   int64_t sector_num)
 {
@@ -1299,9 +1508,7 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
         return 0;
     }
     qemu_co_mutex_lock(&s->lock);
-    ret = get_cluster_offset(bs, extent, NULL,
-                             sector_num * 512, false, &offset,
-                             0, 0);
+    ret = vmdk_get_cluster_offset(bs, extent, sector_num * 512, &offset);
     qemu_co_mutex_unlock(&s->lock);
 
     index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
@@ -1492,13 +1699,13 @@ vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             ret = -EIO;
             goto fail;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 offset, false, &cluster_offset, 0, 0);
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
 
         n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
                              - offset_in_cluster);
 
+        ret = vmdk_get_cluster_offset(bs, extent, offset, &cluster_offset);
+
         if (ret != VMDK_OK) {
             /* if not allocated, try to read from parent image, if exist */
             if (bs->backing && ret != VMDK_ZEROED) {
@@ -1561,7 +1768,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
     int64_t offset_in_cluster, n_bytes;
     uint64_t cluster_offset;
     uint64_t bytes_done = 0;
+    uint64_t extent_size;
     VmdkMetaData m_data;
+    uint32_t total_alloc_clusters = 0;
 
     if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
         error_report("Wrong offset: offset=0x%" PRIx64
@@ -1575,14 +1784,22 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         if (!extent) {
             return -EIO;
         }
+        extent_size = extent->end_sector * BDRV_SECTOR_SIZE;
+
         offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
-        n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
-                             - offset_in_cluster);
 
-        ret = get_cluster_offset(bs, extent, &m_data, offset,
-                                 !(extent->compressed || zeroed),
-                                 &cluster_offset, offset_in_cluster,
-                                 offset_in_cluster + n_bytes);
+        /* truncate n_bytes to first cluster because we need to perform COW */
+        if (offset_in_cluster > 0) {
+            n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
+                                 - offset_in_cluster);
+        } else {
+            n_bytes = MIN(bytes, extent_size - offset);
+        }
+
+        ret = vmdk_alloc_cluster_offset(bs, extent, &m_data, offset,
+                                        !(extent->compressed || zeroed),
+                                        &cluster_offset, n_bytes,
+                                        &total_alloc_clusters);
         if (extent->compressed) {
             if (ret == VMDK_OK) {
                 /* Refuse write to allocated cluster for streamOptimized */
@@ -1591,19 +1808,22 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
                 return -EIO;
             } else {
                 /* allocate */
-                ret = get_cluster_offset(bs, extent, &m_data, offset,
-                                         true, &cluster_offset, 0, 0);
+                ret = vmdk_alloc_cluster_offset(bs, extent, &m_data, offset,
+                                                true, &cluster_offset, n_bytes,
+                                                &total_alloc_clusters);
             }
         }
         if (ret == VMDK_ERROR) {
             return -EINVAL;
         }
+
         if (zeroed) {
             /* Do zeroed write, buf is ignored */
-            if (extent->has_zero_grain &&
-                    offset_in_cluster == 0 &&
-                    n_bytes >= extent->cluster_sectors * BDRV_SECTOR_SIZE) {
-                n_bytes = extent->cluster_sectors * BDRV_SECTOR_SIZE;
+            if (extent->has_zero_grain && offset_in_cluster == 0 &&
+                    n_bytes >= extent->cluster_sectors * BDRV_SECTOR_SIZE *
+                        total_alloc_clusters) {
+                n_bytes = extent->cluster_sectors * BDRV_SECTOR_SIZE *
+                                        total_alloc_clusters;
                 if (!zero_dry_run) {
                     /* update L2 tables */
                     if (vmdk_L2update(extent, &m_data, VMDK_GTE_ZEROED)
@@ -2224,9 +2444,8 @@ static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
                     sector_num);
             break;
         }
-        ret = get_cluster_offset(bs, extent, NULL,
-                                 sector_num << BDRV_SECTOR_BITS,
-                                 false, &cluster_offset, 0, 0);
+        ret = vmdk_get_cluster_offset(bs, extent,
+                        sector_num << BDRV_SECTOR_BITS, &cluster_offset);
         if (ret == VMDK_ERROR) {
             fprintf(stderr,
                     "ERROR: could not get cluster_offset for sector %"
-- 
2.6.2
