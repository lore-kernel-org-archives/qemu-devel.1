Received: from eggs.gnu.org ([2001:4830:134:3::10]:57328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVISa-0002VH-Aw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVISV-0004L2-Kf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:5803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fVISV-0004IO-BC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:15 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Tue, 19 Jun 2018 23:20:54 +0800
Message-Id: <1529421657-14969-4-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH V1 RESEND 3/6] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Liu Jingqi <jingqi.liu@intel.com>

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
index 214f150..9d29ef7 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -35,6 +35,8 @@
 #include "hw/acpi/bios-linker-loader.h"
 
 struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES] = {0};
+struct numa_hmat_cache_info
+       *hmat_cache_info[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1] = {0};
 
 static uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
 static uint32_t num_initiator, num_target;
@@ -210,6 +212,57 @@ static void hmat_build_lb(GArray *table_data)
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
+                hmat_cache->length = cpu_to_le32(sizeof(*hmat_cache));
+                hmat_cache->type = cpu_to_le16(ACPI_HMAT_CACHE_INFO);
+                hmat_cache->mem_proximity =
+                            cpu_to_le32(numa_hmat_cache->mem_proximity);
+                hmat_cache->cache_size  = cpu_to_le64(numa_hmat_cache->size);
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
+                hmat_cache->cache_attr = cpu_to_le32(hmat_cache->cache_attr);
+
+                if (numa_hmat_cache->num_smbios_handles != 0) {
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
+                    /* TBD: set smbios handles */
+                    memset(smbios_handles, 0, size);
+                }
+                hmat_cache->num_smbios_handles =
+                            cpu_to_le16(numa_hmat_cache->num_smbios_handles);
+            }
+        }
+    }
+}
+
 static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 {
     /* Build HMAT Memory Subsystem Address Range. */
@@ -217,6 +270,9 @@ static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 
     /* Build HMAT System Locality Latency and Bandwidth Information. */
     hmat_build_lb(hma);
+
+    /* Build HMAT Memory Side Cache Information. */
+    hmat_build_cache(hma);
 }
 
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index fddd05e..f9fdcdc 100644
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
@@ -141,7 +161,31 @@ struct numa_hmat_lb_info {
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
 extern struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES];
+extern struct numa_hmat_cache_info
+              *hmat_cache_info[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
 
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
                      MachineState *machine);
-- 
2.7.4
