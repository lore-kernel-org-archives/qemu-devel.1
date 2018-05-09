Received: from eggs.gnu.org ([2001:4830:134:3::10]:47689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKaK-0005jR-Ih
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKaG-0000oh-HK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:36:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:22237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGKaG-0000lz-74
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:36:24 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Wed,  9 May 2018 16:35:57 +0800
Message-Id: <1525854957-14095-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v1 3/7] hmat acpi: Build Memory Side Cache
 Information Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, Liu Jingqi <jingqi.liu@intel.com>

This structure describes memory side cache information for memory
proximity domains if the memory side cache is present and the
physical device(SMBIOS handle) forms the memory side cache.
The software could use this information to effectively place
the data in memory to maximize the performance of the system
memory that use the memory side cache.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 hw/acpi/hmat.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 00dfba9..cb5541d 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -37,6 +37,9 @@
 #define HOLE_640K_END    (1024 * 1024)
 
 struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES] = {0};
+struct numa_hmat_cache_info
+    *hmat_cache_info[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1] = {0};
+
 uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
 uint32_t num_initiator = 0, num_target = 0;
 
@@ -222,6 +225,56 @@ static void hmat_build_lb(GArray *table_data)
     }
 }
 
+static void hmat_build_cache(GArray *table_data)
+{
+    AcpiHmatCacheInfo *hmat_cache;
+    struct numa_hmat_cache_info *numa_hmat_cache;
+    int i, level;
+
+    for (i = 0; i < nb_numa_nodes; i++) {
+        for (level = 0; level <= MAX_HMAT_CACHE_LEVEL; level++) {
+            numa_hmat_cache = hmat_cache_info[i][level];
+            if (numa_hmat_cache) {
+                uint64_t start = table_data->len;
+
+                hmat_cache = acpi_data_push(table_data, sizeof(*hmat_cache));
+                hmat_cache->length = sizeof(*hmat_cache);
+                hmat_cache->type = ACPI_HMAT_CACHE_INFO;
+                hmat_cache->mem_proximity = numa_hmat_cache->mem_proximity;
+                hmat_cache->cache_size  = numa_hmat_cache->size;
+                hmat_cache->cache_attr  = HMAT_CACHE_TOTAL_LEVEL(
+                                          numa_hmat_cache->total_levels);
+                hmat_cache->cache_attr |= HMAT_CACHE_CURRENT_LEVEL(
+                                          numa_hmat_cache->level);
+                hmat_cache->cache_attr |= HMAT_CACHE_ASSOC(
+                                          numa_hmat_cache->associativity);
+                hmat_cache->cache_attr |= HMAT_CACHE_WRITE_POLICY(
+                                          numa_hmat_cache->write_policy);
+                hmat_cache->cache_attr |= HMAT_CACHE_LINE_SIZE(
+                                          numa_hmat_cache->line_size);
+                hmat_cache->num_smbios_handles =
+                                          numa_hmat_cache->num_smbios_handles;
+
+                if (hmat_cache->num_smbios_handles != 0) {
+                    uint16_t *smbios_handles;
+                    int size;
+
+                    size = hmat_cache->num_smbios_handles * sizeof(uint16_t);
+                    smbios_handles = acpi_data_push(table_data, size);
+
+                    hmat_cache = (AcpiHmatCacheInfo *)
+                                 (table_data->data + start);
+                    hmat_cache->length += size;
+
+                    /* TBD: how to set smbios handles? */
+                    memset(smbios_handles, 0, size);
+                }
+
+            }
+        }
+    }
+}
+
 static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 {
     /* Build HMAT Memory Subsystem Address Range. */
@@ -229,6 +282,9 @@ static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 
     /* Build HMAT System Locality Latency and Bandwidth Information. */
     hmat_build_lb(hma);
+
+    /* Build HMAT Memory Side Cache Information. */
+    hmat_build_cache(hma);
 }
 
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 93801be..a9a8dae 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -33,6 +33,15 @@
 
 #define ACPI_HMAT_SPA               0
 #define ACPI_HMAT_LB_INFO           1
+#define ACPI_HMAT_CACHE_INFO        2
+
+#define MAX_HMAT_CACHE_LEVEL        3
+
+#define HMAT_CACHE_TOTAL_LEVEL(level)      (level & 0xF)
+#define HMAT_CACHE_CURRENT_LEVEL(level)    ((level & 0xF) << 4)
+#define HMAT_CACHE_ASSOC(assoc)            ((assoc & 0xF) << 8)
+#define HMAT_CACHE_WRITE_POLICY(policy)    ((policy & 0xF) << 12)
+#define HMAT_CACHE_LINE_SIZE(size)         ((size & 0xFFFF) << 16)
 
 /* ACPI HMAT sub-structure header */
 #define ACPI_HMAT_SUB_HEADER_DEF    \
@@ -102,6 +111,17 @@ struct AcpiHmatLBInfo {
 } QEMU_PACKED;
 typedef struct AcpiHmatLBInfo AcpiHmatLBInfo;
 
+struct AcpiHmatCacheInfo {
+    ACPI_HMAT_SUB_HEADER_DEF
+    uint32_t    mem_proximity;
+    uint32_t    reserved;
+    uint64_t    cache_size;
+    uint32_t    cache_attr;
+    uint16_t    reserved2;
+    uint16_t    num_smbios_handles;
+} QEMU_PACKED;
+typedef struct AcpiHmatCacheInfo AcpiHmatCacheInfo;
+
 struct numa_hmat_lb_info {
     /*
      * Indicates total number of Proximity Domains
@@ -141,9 +161,33 @@ struct numa_hmat_lb_info {
     uint16_t    bandwidth[MAX_NODES][MAX_NODES];
 };
 
+struct numa_hmat_cache_info {
+    /* The memory proximity domain to which the memory belongs. */
+    uint32_t    mem_proximity;
+    /* Size of memory side cache in bytes. */
+    uint64_t    size;
+    /* Total cache levels for this memory proximity domain. */
+    uint8_t     total_levels;
+    /* Cache level described in this structure. */
+    uint8_t     level;
+    /* Cache Associativity: None/Direct Mapped/Comple Cache Indexing */
+    uint8_t     associativity;
+    /* Write Policy: None/Write Back(WB)/Write Through(WT) */
+    uint8_t     write_policy;
+    /* Cache Line size in bytes. */
+    uint16_t    line_size;
+    /*
+     * Number of SMBIOS handles that contributes to
+     * the memory side cache physical devices.
+     */
+    uint16_t    num_smbios_handles;
+};
+
 extern uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
 extern uint32_t num_initiator, num_target;
 extern struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES];
+extern struct numa_hmat_cache_info
+    *hmat_cache_info[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
 
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
                      MachineState *machine);
-- 
2.7.4
