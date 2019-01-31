Received: from eggs.gnu.org ([209.51.188.92]:33450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6cj-00074V-OD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6ci-0003C9-MG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:58183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gp6ci-000313-EU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:56 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 31 Jan 2019 15:16:57 +0800
Message-Id: <20190131071658.29120-8-tao3.xu@intel.com>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 7/8] hmat acpi: move some function inside of
 the caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, karl.heubaum@oracle.com, jingqi.liu@intel.com, danmei.wei@intel.com, qemu-devel@nongnu.org, tao3.xu@intel.com

Per Igor comments, these function is used only once,
move its body inside of the caller

Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/acpi/hmat.c | 93 ++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 93c72ab14e..d802e1cce1 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -84,22 +84,41 @@ static int pc_dimm_device_list(Object *obj, void *opaque)
     return 0;
 }
 
+static void classify_proximity_domains(void)
+{
+    int node;
+
+    for (node = 0; node < nb_numa_nodes; node++) {
+        if (numa_info[node].is_initiator) {
+            initiator_pxm[num_initiator++] = node;
+        }
+        if (numa_info[node].is_target) {
+            target_pxm[num_target++] = node;
+        }
+    }
+}
+
+static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
+{
 /*
  * The Proximity Domain of System Physical Address ranges defined
  * in the HMAT, NFIT and SRAT tables shall match each other.
  */
-static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
-{
+
     GSList *device_list = NULL;
+    AcpiHmatLBInfo *hmat_lb;
+    AcpiHmatCacheInfo *hmat_cache;
+    struct numa_hmat_lb_info *numa_hmat_lb;
+    struct numa_hmat_cache_info *numa_hmat_cache;
     uint64_t mem_base, mem_len;
-    int i;
+    int i, j, hrchy, type, level;
 
     if (pcms->numa_nodes && !mem_ranges_number) {
         build_mem_ranges(pcms);
     }
 
     for (i = 0; i < mem_ranges_number; i++) {
-        hmat_build_spa_info(table_data, mem_ranges[i].base,
+        build_hmat_spa(hma, mem_ranges[i].base,
                             mem_ranges[i].length, mem_ranges[i].node);
     }
 
@@ -113,30 +132,10 @@ static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
         mem_len = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
                                            NULL);
         i = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
-        hmat_build_spa_info(table_data, mem_base, mem_len, i);
-    }
-}
-
-static void classify_proximity_domains(void)
-{
-    int node;
-
-    for (node = 0; node < nb_numa_nodes; node++) {
-        if (numa_info[node].is_initiator) {
-            initiator_pxm[num_initiator++] = node;
-        }
-        if (numa_info[node].is_target) {
-            target_pxm[num_target++] = node;
-        }
+        build_hmat_spa(hma, mem_base, mem_len, i);
     }
-}
-
-static void hmat_build_lb(GArray *table_data)
-{
-    AcpiHmatLBInfo *hmat_lb;
-    struct numa_hmat_lb_info *numa_hmat_lb;
-    int i, j, hrchy, type;
 
+    /* Build HMAT System Locality Latency and Bandwidth Information. */
     if (!num_initiator && !num_target) {
         classify_proximity_domains();
     }
@@ -154,8 +153,8 @@ static void hmat_build_lb(GArray *table_data)
                 uint32_t size;
                 uint8_t m, n;
 
-                start = table_data->len;
-                hmat_lb = acpi_data_push(table_data, sizeof(*hmat_lb));
+                start = hma->len;
+                hmat_lb = acpi_data_push(hma, sizeof(*hmat_lb));
 
                 hmat_lb->type          = cpu_to_le16(ACPI_HMAT_LB_INFO);
                 hmat_lb->flags         = numa_hmat_lb->hierarchy;
@@ -174,19 +173,19 @@ static void hmat_build_lb(GArray *table_data)
 
                 /* the initiator proximity domain list */
                 for (i = 0; i < num_initiator; i++) {
-                    list_entry = acpi_data_push(table_data, sizeof(uint32_t));
+                    list_entry = acpi_data_push(hma, sizeof(uint32_t));
                     *list_entry = cpu_to_le32(initiator_pxm[i]);
                 }
 
                 /* the target proximity domain list */
                 for (i = 0; i < num_target; i++) {
-                    list_entry = acpi_data_push(table_data, sizeof(uint32_t));
+                    list_entry = acpi_data_push(hma, sizeof(uint32_t));
                     *list_entry = cpu_to_le32(target_pxm[i]);
                 }
 
                 /* latency or bandwidth entries */
                 size = sizeof(uint16_t) * num_initiator * num_target;
-                entry_start = acpi_data_push(table_data, size);
+                entry_start = acpi_data_push(hma, size);
 
                 for (i = 0; i < num_initiator; i++) {
                     m = initiator_pxm[i];
@@ -200,26 +199,20 @@ static void hmat_build_lb(GArray *table_data)
                         }
                     }
                 }
-                hmat_lb = (AcpiHmatLBInfo *)(table_data->data + start);
-                hmat_lb->length = cpu_to_le16(table_data->len - start);
+                hmat_lb = (AcpiHmatLBInfo *)(hma->data + start);
+                hmat_lb->length = cpu_to_le16(hma->len - start);
             }
         }
     }
-}
-
-static void hmat_build_cache(GArray *table_data)
-{
-    AcpiHmatCacheInfo *hmat_cache;
-    struct numa_hmat_cache_info *numa_hmat_cache;
-    int i, level;
 
+    /* Build HMAT Memory Side Cache Information. */
     for (i = 0; i < nb_numa_nodes; i++) {
         for (level = 0; level <= MAX_HMAT_CACHE_LEVEL; level++) {
             numa_hmat_cache = hmat_cache_info[i][level];
             if (numa_hmat_cache) {
-                uint64_t start = table_data->len;
+                uint64_t start = hma->len;
 
-                hmat_cache = acpi_data_push(table_data, sizeof(*hmat_cache));
+                hmat_cache = acpi_data_push(hma, sizeof(*hmat_cache));
                 hmat_cache->length = cpu_to_le32(sizeof(*hmat_cache));
                 hmat_cache->type = cpu_to_le16(ACPI_HMAT_CACHE_INFO);
                 hmat_cache->mem_proximity =
@@ -242,10 +235,10 @@ static void hmat_build_cache(GArray *table_data)
                     int size;
 
                     size = hmat_cache->num_smbios_handles * sizeof(uint16_t);
-                    smbios_handles = acpi_data_push(table_data, size);
+                    smbios_handles = acpi_data_push(hma, size);
 
                     hmat_cache = (AcpiHmatCacheInfo *)
-                                 (table_data->data + start);
+                                 (hma->data + start);
                     hmat_cache->length += size;
 
                     /* TBD: set smbios handles */
@@ -258,18 +251,6 @@ static void hmat_build_cache(GArray *table_data)
     }
 }
 
-static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
-{
-    /* Build HMAT Memory Subsystem Address Range. */
-    hmat_build_spa(hma, pcms);
-
-    /* Build HMAT System Locality Latency and Bandwidth Information. */
-    hmat_build_lb(hma);
-
-    /* Build HMAT Memory Side Cache Information. */
-    hmat_build_cache(hma);
-}
-
 static uint64_t
 hmat_hma_method_read(void *opaque, hwaddr addr, unsigned size)
 {
-- 
2.17.1
