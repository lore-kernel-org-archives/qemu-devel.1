Received: from eggs.gnu.org ([2001:4830:134:3::10]:57303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVISZ-0002Uc-64
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVISU-0004KD-9v
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:5803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fVIST-0004IO-UN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:22:14 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Tue, 19 Jun 2018 23:20:53 +0800
Message-Id: <1529421657-14969-3-git-send-email-jingqi.liu@intel.com>
In-Reply-To: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH V1 RESEND 2/6] hmat acpi: Build System Locality
 Latency and Bandwidth Information Structure(s) in ACPI HMAT
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

This structure describes the memory access latency and bandwidth
information from various memory access initiator proximity domains.
The latency and bandwidth numbers represented in this structure
correspond to rated latency and bandwidth for the platform.
The software could use this information as hint for optimization.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 hw/acpi/hmat.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h | 76 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index d4e586d..214f150 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -34,6 +34,11 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 
+struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES] = {0};
+
+static uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
+static uint32_t num_initiator, num_target;
+
 /* Build Memory Subsystem Address Range Structure */
 static void hmat_build_spa_info(GArray *table_data,
                                 uint64_t base, uint64_t length, int node)
@@ -115,10 +120,103 @@ static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
     }
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
+static void hmat_build_lb(GArray *table_data)
+{
+    AcpiHmatLBInfo *hmat_lb;
+    struct numa_hmat_lb_info *numa_hmat_lb;
+    int i, j, hrchy, type;
+
+    if (!num_initiator && !num_target) {
+        classify_proximity_domains();
+    }
+
+    for (hrchy = HMAT_LB_MEM_MEMORY;
+         hrchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hrchy++) {
+        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
+             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
+            numa_hmat_lb = hmat_lb_info[hrchy][type];
+
+            if (numa_hmat_lb) {
+                uint64_t start;
+                uint32_t *list_entry;
+                uint16_t *entry, *entry_start;
+                uint32_t size;
+                uint8_t m, n;
+
+                start = table_data->len;
+                hmat_lb = acpi_data_push(table_data, sizeof(*hmat_lb));
+
+                hmat_lb->type          = cpu_to_le16(ACPI_HMAT_LB_INFO);
+                hmat_lb->flags         = numa_hmat_lb->hierarchy;
+                hmat_lb->data_type     = numa_hmat_lb->data_type;
+                hmat_lb->num_initiator = cpu_to_le32(num_initiator);
+                hmat_lb->num_target    = cpu_to_le32(num_target);
+
+                if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
+                    hmat_lb->base_unit = cpu_to_le32(numa_hmat_lb->base_lat);
+                } else {
+                    hmat_lb->base_unit = cpu_to_le32(numa_hmat_lb->base_bw);
+                }
+                if (!hmat_lb->base_unit) {
+                    hmat_lb->base_unit = cpu_to_le32(1);
+                }
+
+                /* the initiator proximity domain list */
+                for (i = 0; i < num_initiator; i++) {
+                    list_entry = acpi_data_push(table_data, sizeof(uint32_t));
+                    *list_entry = cpu_to_le32(initiator_pxm[i]);
+                }
+
+                /* the target proximity domain list */
+                for (i = 0; i < num_target; i++) {
+                    list_entry = acpi_data_push(table_data, sizeof(uint32_t));
+                    *list_entry = cpu_to_le32(target_pxm[i]);
+                }
+
+                /* latency or bandwidth entries */
+                size = sizeof(uint16_t) * num_initiator * num_target;
+                entry_start = acpi_data_push(table_data, size);
+
+                for (i = 0; i < num_initiator; i++) {
+                    m = initiator_pxm[i];
+                    for (j = 0; j < num_target; j++) {
+                        n = target_pxm[j];
+                        entry = entry_start + i * num_target + j;
+                        if (type <= HMAT_LB_DATA_WRITE_LATENCY) {
+                            *entry = cpu_to_le16(numa_hmat_lb->latency[m][n]);
+                        } else {
+                            *entry = cpu_to_le16(numa_hmat_lb->bandwidth[m][n]);
+                        }
+                    }
+                }
+                hmat_lb = (AcpiHmatLBInfo *)(table_data->data + start);
+                hmat_lb->length = cpu_to_le16(table_data->len - start);
+            }
+        }
+    }
+}
+
 static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 {
     /* Build HMAT Memory Subsystem Address Range. */
     hmat_build_spa(hma, pcms);
+
+    /* Build HMAT System Locality Latency and Bandwidth Information. */
+    hmat_build_lb(hma);
 }
 
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 096415d..fddd05e 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -32,6 +32,7 @@
 #include "hw/acpi/aml-build.h"
 
 #define ACPI_HMAT_SPA               0
+#define ACPI_HMAT_LB_INFO           1
 
 /* ACPI HMAT sub-structure header */
 #define ACPI_HMAT_SUB_HEADER_DEF    \
@@ -46,6 +47,28 @@ enum {
     HMAT_SPA_RESERVATION_HINT = 0x4,
 };
 
+/* the value of AcpiHmatLBInfo flags */
+enum {
+    HMAT_LB_MEM_MEMORY           = 0,
+    HMAT_LB_MEM_CACHE_LAST_LEVEL = 1,
+    HMAT_LB_MEM_CACHE_1ST_LEVEL  = 2,
+    HMAT_LB_MEM_CACHE_2ND_LEVEL  = 3,
+    HMAT_LB_MEM_CACHE_3RD_LEVEL  = 4,
+};
+
+/* the value of AcpiHmatLBInfo data type */
+enum {
+    HMAT_LB_DATA_ACCESS_LATENCY = 0,
+    HMAT_LB_DATA_READ_LATENCY = 1,
+    HMAT_LB_DATA_WRITE_LATENCY = 2,
+    HMAT_LB_DATA_ACCESS_BANDWIDTH = 3,
+    HMAT_LB_DATA_READ_BANDWIDTH = 4,
+    HMAT_LB_DATA_WRITE_BANDWIDTH = 5,
+};
+
+#define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
+#define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
+
 /*
  * HMAT (Heterogeneous Memory Attributes Table)
  */
@@ -67,6 +90,59 @@ struct AcpiHmatSpaRange {
 } QEMU_PACKED;
 typedef struct AcpiHmatSpaRange AcpiHmatSpaRange;
 
+struct AcpiHmatLBInfo {
+    ACPI_HMAT_SUB_HEADER_DEF
+    uint8_t     flags;
+    uint8_t     data_type;
+    uint16_t    reserved1;
+    uint32_t    num_initiator;
+    uint32_t    num_target;
+    uint32_t    reserved2;
+    uint64_t    base_unit;
+} QEMU_PACKED;
+typedef struct AcpiHmatLBInfo AcpiHmatLBInfo;
+
+struct numa_hmat_lb_info {
+    /*
+     * Indicates total number of Proximity Domains
+     * that can initiate memory access requests.
+     */
+    uint32_t    num_initiator;
+    /*
+     * Indicates total number of Proximity Domains
+     * that can act as target.
+     */
+    uint32_t    num_target;
+    /*
+     * Indicates it's memory or
+     * the specified level memory side cache.
+     */
+    uint8_t     hierarchy;
+    /*
+     * Present the type of data,
+     * access/read/write latency or bandwidth.
+     */
+    uint8_t     data_type;
+    /* The base unit for latency in nanoseconds. */
+    uint64_t    base_lat;
+    /* The base unit for bandwidth in megabytes per second(MB/s). */
+    uint64_t    base_bw;
+    /*
+     * latency[i][j]:
+     * Indicates the latency based on base_lat
+     * from Initiator Proximity Domain i to Target Proximity Domain j.
+     */
+    uint16_t    latency[MAX_NODES][MAX_NODES];
+    /*
+     * bandwidth[i][j]:
+     * Indicates the bandwidth based on base_bw
+     * from Initiator Proximity Domain i to Target Proximity Domain j.
+     */
+    uint16_t    bandwidth[MAX_NODES][MAX_NODES];
+};
+
+extern struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES];
+
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
                      MachineState *machine);
 
-- 
2.7.4
