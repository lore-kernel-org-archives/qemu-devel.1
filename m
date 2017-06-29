Received: from eggs.gnu.org ([2001:4830:134:3::10]:55629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVfU-0004sE-GY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVfS-00070T-Vp
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:20 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:39 +0530
Message-Id: <1498728221-23979-7-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 6/8] vmdk: New functions to assist
 allocating multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Introduce two new helper functions handle_alloc() and
vmdk_alloc_cluster_offset(). handle_alloc() helps to allocate multiple
clusters at once starting from a given offset on disk and performs COW
if necessary for first and last allocated clusters.
vmdk_alloc_cluster_offset() helps to return the offset of the first of
the many newly allocated clusters. Also, provide proper documentation
for both.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 190 insertions(+), 10 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index fe2046b..277db16 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -136,6 +136,7 @@ typedef struct VmdkMetaData {
     unsigned int l2_offset;
     int valid;
     uint32_t *l2_cache_entry;
+    uint32_t nb_clusters;
 } VmdkMetaData;
 
 typedef struct VmdkGrainMarker {
@@ -1242,6 +1243,182 @@ static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
     return VMDK_OK;
 }
 
+/*
+ * vmdk_handle_alloc
+ *
+ * Allocate new clusters for an area that either is yet unallocated or needs a
+ * copy on write.
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
+static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
+                             uint64_t offset, uint64_t *cluster_offset,
+                             int64_t *bytes, VmdkMetaData *m_data,
+                             bool allocate, uint32_t *total_alloc_clusters)
+{
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
+    }
+
+    cluster_sector = le32_to_cpu(l2_table[l2_index]);
+
+    skip_start_bytes = vmdk_find_offset_in_cluster(extent, offset);
+    /* Calculate the number of clusters to look for. Here we truncate the last
+     * cluster, i.e. 1 less than the actual value calculated as we may need to
+     * perform COW for the last one. */
+    nb_clusters = DIV_ROUND_UP(skip_start_bytes + *bytes,
+                               extent->cluster_sectors << BDRV_SECTOR_BITS) - 1;
+
+    nb_clusters = MIN(nb_clusters, extent->l2_size - l2_index);
+    assert(nb_clusters <= INT_MAX);
+
+    /* update bytes according to final nb_clusters value */
+    if (nb_clusters != 0) {
+        *bytes = ((nb_clusters * extent->cluster_sectors) << BDRV_SECTOR_BITS)
+                 - skip_start_bytes;
+    } else {
+        nb_clusters = 1;
+    }
+    *total_alloc_clusters += nb_clusters;
+
+    /* we need to use MIN() for basically 3 cases that arise :
+     * 1. alloc very first cluster : here skip_start_bytes >= 0 and
+     *    *bytes <= cluster_size.
+     * 2. alloc middle clusters : here *bytes is a perfect multiple of
+     *    cluster_size and skip_start_bytes is 0.
+     * 3. alloc very last cluster : here *bytes <= cluster_size and
+     *    skip_start_bytes is 0
+     */
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
+        ret = vmdk_perform_cow(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
+                               offset, skip_start_bytes,
+                               skip_end_bytes);
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
+        }
+    }
+    *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
+    return VMDK_OK;
+}
+
+/*
+ * vmdk_alloc_clusters
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
+static int vmdk_alloc_clusters(BlockDriverState *bs,
+                               VmdkExtent *extent,
+                               VmdkMetaData *m_data, uint64_t offset,
+                               bool allocate, uint64_t *cluster_offset,
+                               int64_t bytes,
+                               uint32_t *total_alloc_clusters)
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
+        ret = vmdk_handle_alloc(bs, extent, start, &new_cluster_offset, &n_bytes,
+                                m_data, allocate, total_alloc_clusters);
+
+        if (ret < 0) {
+            return ret;
+
+        }
+    }
+
+    return VMDK_OK;
+}
+
 /**
  * vmdk_get_cluster_offset
  *
@@ -1625,6 +1802,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
     uint64_t bytes_done = 0;
     VmdkMetaData m_data;
     uint64_t extent_end;
+    uint32_t total_alloc_clusters = 0;
 
     if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
         error_report("Wrong offset: offset=0x%" PRIx64
@@ -1650,10 +1828,10 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
             n_bytes = MIN(bytes, extent_end - offset);
         }
 
-        ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
-                                      !(extent->compressed || zeroed),
-                                      &cluster_offset, offset_in_cluster,
-                                      offset_in_cluster + n_bytes);
+        ret = vmdk_alloc_clusters(bs, extent, &m_data, offset,
+                                  !(extent->compressed || zeroed),
+                                  &cluster_offset, n_bytes,
+                                  &total_alloc_clusters);
         if (extent->compressed) {
             if (ret == VMDK_OK) {
                 /* Refuse write to allocated cluster for streamOptimized */
@@ -1662,8 +1840,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
                 return -EIO;
             } else {
                 /* allocate */
-                ret = vmdk_get_cluster_offset(bs, extent, &m_data, offset,
-                                              true, &cluster_offset, 0, 0);
+                ret = vmdk_alloc_clusters(bs, extent, &m_data, offset,
+                                          true, &cluster_offset, n_bytes,
+                                          &total_alloc_clusters);
             }
         }
         if (ret == VMDK_ERROR) {
@@ -1671,10 +1850,11 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         }
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
-- 
2.6.2
