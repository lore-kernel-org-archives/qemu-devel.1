Received: from eggs.gnu.org ([2001:4830:134:3::10]:35176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crjiF-0001CU-01
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1crjiD-0000q8-W1
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:18:27 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 25 Mar 2017 16:48:17 +0530
Message-Id: <1490440701-12037-4-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
References: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/7] vmdk: Factor out metadata loading code
 out of get_cluster_offset()
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

Move the cluster tables loading code out of the existing
get_cluster_offset() function and implement it in separate
get_cluster_table() and vmdk_L2load() functions. This patch will help
us avoid code duplication in future patches of this series.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/vmdk.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index f5fda2c..a42322e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1037,6 +1037,105 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
 }
 
 /*
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
  * vmdk_perform_cow
  *
  * Copy backing file's cluster that covers @sector_num, otherwise write zero,
-- 
2.6.2
