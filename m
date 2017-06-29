Received: from eggs.gnu.org ([2001:4830:134:3::10]:55694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVfb-0004yH-9X
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQVfZ-00073J-1K
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:23:27 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:53:40 +0530
Message-Id: <1498728221-23979-8-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
References: <1498728221-23979-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v7 7/8] vmdk: Update metadata for multiple
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
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Include a next pointer in VmdkMetaData struct to point to the previous
allocated L2 table. Modify vmdk_L2update to start updating metadata for
allocation of multiple clusters at once.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 27 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 277db16..60b8adc 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -137,6 +137,8 @@ typedef struct VmdkMetaData {
     int valid;
     uint32_t *l2_cache_entry;
     uint32_t nb_clusters;
+    uint32_t offset;
+    struct VmdkMetaData *next;
 } VmdkMetaData;
 
 typedef struct VmdkGrainMarker {
@@ -1116,34 +1118,87 @@ exit:
     return ret;
 }
 
-static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
-                         uint32_t offset)
+static int vmdk_alloc_cluster_link_l2(VmdkExtent *extent,
+                                      VmdkMetaData *m_data, bool zeroed)
 {
-    offset = cpu_to_le32(offset);
+    int i;
+    uint32_t offset, temp_offset;
+    int *l2_table_array;
+    int l2_array_size;
+
+    if (zeroed) {
+        temp_offset = VMDK_GTE_ZEROED;
+    } else {
+        temp_offset = m_data->offset;
+    }
+
+    l2_array_size = sizeof(uint32_t) * m_data->nb_clusters;
+    l2_table_array = qemu_try_blockalign(extent->file->bs,
+                                         QEMU_ALIGN_UP(l2_array_size,
+                                                       BDRV_SECTOR_SIZE));
+    if (l2_table_array == NULL) {
+        return VMDK_ERROR;
+    }
+    memset(l2_table_array, 0, QEMU_ALIGN_UP(l2_array_size, BDRV_SECTOR_SIZE));
     /* update L2 table */
+    offset = temp_offset;
+    for (i = 0; i < m_data->nb_clusters; i++) {
+        l2_table_array[i] = cpu_to_le32(offset);
+        if (!zeroed) {
+            offset += extent->cluster_sectors;
+        }
+    }
     if (bdrv_pwrite_sync(extent->file,
-                ((int64_t)m_data->l2_offset * 512)
-                    + (m_data->l2_index * sizeof(offset)),
-                &offset, sizeof(offset)) < 0) {
+                         ((int64_t)m_data->l2_offset * 512)
+                         + ((m_data->l2_index) * sizeof(offset)),
+                         l2_table_array, l2_array_size) < 0) {
         return VMDK_ERROR;
     }
     /* update backup L2 table */
     if (extent->l1_backup_table_offset != 0) {
         m_data->l2_offset = extent->l1_backup_table[m_data->l1_index];
         if (bdrv_pwrite_sync(extent->file,
-                    ((int64_t)m_data->l2_offset * 512)
-                        + (m_data->l2_index * sizeof(offset)),
-                    &offset, sizeof(offset)) < 0) {
+                             ((int64_t)m_data->l2_offset * 512)
+                             + ((m_data->l2_index) * sizeof(offset)),
+                             l2_table_array, l2_array_size) < 0) {
             return VMDK_ERROR;
         }
     }
+
+    offset = temp_offset;
     if (m_data->l2_cache_entry) {
-        *m_data->l2_cache_entry = offset;
+        for (i = 0; i < m_data->nb_clusters; i++) {
+            *m_data->l2_cache_entry = cpu_to_le32(offset);
+            m_data->l2_cache_entry++;
+
+            if (!zeroed) {
+                offset += extent->cluster_sectors;
+            }
+        }
     }
 
+    qemu_vfree(l2_table_array);
     return VMDK_OK;
 }
 
+static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
+                         bool zeroed)
+{
+    int ret;
+
+    while (m_data->next != NULL) {
+
+        ret = vmdk_alloc_cluster_link_l2(extent, m_data, zeroed);
+        if (ret < 0) {
+            return ret;
+        }
+
+        m_data = m_data->next;
+     }
+
+     return VMDK_OK;
+}
+
 /*
  * vmdk_l2load
  *
@@ -1260,9 +1315,10 @@ static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
  *
  *   VMDK_ERROR:    in error cases
  */
+
 static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
                              uint64_t offset, uint64_t *cluster_offset,
-                             int64_t *bytes, VmdkMetaData *m_data,
+                             int64_t *bytes, VmdkMetaData **m_data,
                              bool allocate, uint32_t *total_alloc_clusters)
 {
     int l1_index, l2_offset, l2_index;
@@ -1271,6 +1327,7 @@ static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
     uint32_t nb_clusters;
     bool zeroed = false;
     uint64_t skip_start_bytes, skip_end_bytes;
+    VmdkMetaData *old_m_data;
     int ret;
 
     ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
@@ -1331,13 +1388,21 @@ static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
         if (ret < 0) {
             return ret;
         }
-        if (m_data) {
-            m_data->valid = 1;
-            m_data->l1_index = l1_index;
-            m_data->l2_index = l2_index;
-            m_data->l2_offset = l2_offset;
-            m_data->l2_cache_entry = &l2_table[l2_index];
-            m_data->nb_clusters = nb_clusters;
+
+        if (m_data != NULL) {
+            old_m_data = *m_data;
+            *m_data = g_malloc0(sizeof(**m_data));
+
+            **m_data = (VmdkMetaData) {
+                .valid            =    1,
+                .l1_index         =    l1_index,
+                .l2_index         =    l2_index,
+                .l2_offset        =    l2_offset,
+                .l2_cache_entry   =    &l2_table[l2_index],
+                .nb_clusters      =    nb_clusters,
+                .offset           =    cluster_sector,
+                .next             =    old_m_data,
+            };
         }
     }
     *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
@@ -1366,7 +1431,7 @@ static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
  */
 static int vmdk_alloc_clusters(BlockDriverState *bs,
                                VmdkExtent *extent,
-                               VmdkMetaData *m_data, uint64_t offset,
+                               VmdkMetaData **m_data, uint64_t offset,
                                bool allocate, uint64_t *cluster_offset,
                                int64_t bytes,
                                uint32_t *total_alloc_clusters)
@@ -1386,8 +1451,8 @@ static int vmdk_alloc_clusters(BlockDriverState *bs,
     new_cluster_offset = 0;
     *cluster_offset = 0;
     n_bytes = 0;
-    if (m_data) {
-        m_data->valid = 0;
+    if (*m_data) {
+        (*m_data)->valid = 0;
     }
 
     /* due to L2 table margins all bytes may not get allocated at once */
@@ -1800,10 +1865,12 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
     int64_t offset_in_cluster, n_bytes;
     uint64_t cluster_offset;
     uint64_t bytes_done = 0;
-    VmdkMetaData m_data;
     uint64_t extent_end;
+    VmdkMetaData *m_data;
     uint32_t total_alloc_clusters = 0;
 
+    m_data = g_new0(VmdkMetaData, 1);
+
     if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
         error_report("Wrong offset: offset=0x%" PRIx64
                      " total_sectors=0x%" PRIx64,
@@ -1812,6 +1879,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
     }
 
     while (bytes > 0) {
+        m_data->next = NULL;
         extent = find_extent(s, offset >> BDRV_SECTOR_BITS, extent);
         if (!extent) {
             return -EIO;
@@ -1857,7 +1925,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
                                         total_alloc_clusters;
                 if (!zero_dry_run) {
                     /* update L2 tables */
-                    if (vmdk_L2update(extent, &m_data, VMDK_GTE_ZEROED)
+                    if (vmdk_L2update(extent, m_data, zeroed)
                             != VMDK_OK) {
                         return -EIO;
                     }
@@ -1871,11 +1939,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
             if (ret) {
                 return ret;
             }
-            if (m_data.valid) {
+            if (m_data->valid) {
                 /* update L2 tables */
-                if (vmdk_L2update(extent, &m_data,
-                                  cluster_offset >> BDRV_SECTOR_BITS)
-                        != VMDK_OK) {
+                if (vmdk_L2update(extent, m_data, zeroed) != VMDK_OK) {
                     return -EIO;
                 }
             }
@@ -1884,6 +1950,13 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         offset += n_bytes;
         bytes_done += n_bytes;
 
+        while (m_data->next != NULL) {
+            VmdkMetaData *next;
+            next = m_data->next;
+            g_free(m_data);
+            m_data = next;
+        }
+
         /* update CID on the first write every time the virtual disk is
          * opened */
         if (!s->cid_updated) {
@@ -1894,6 +1967,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
             s->cid_updated = true;
         }
     }
+    g_free(m_data);
     return 0;
 }
 
-- 
2.6.2
