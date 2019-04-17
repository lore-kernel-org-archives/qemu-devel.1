Received: from eggs.gnu.org ([209.51.188.92]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hGZZt-0006ZZ-0B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hGZZs-0006NZ-0L
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:41:32 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 17 Apr 2019 09:40:38 +0800
Message-Id: <20190417014038.26018-7-richardw.yang@linux.intel.com>
In-Reply-To: <20190417014038.26018-1-richardw.yang@linux.intel.com>
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/6] acpi: pci: use build_append_foo() API
 to construct MCFG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com, philmd@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

build_append_foo() API doesn't need explicit endianness conversions
which eliminates a source of errors and it makes build_mcfg() look like
declarative definition of MCFG table in ACPI spec, which makes it easy
to review.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/pci.c               | 30 ++++++++++++++++++------------
 include/hw/acpi/acpi-defs.h | 18 ------------------
 2 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index fa0fa30bb9..05050fa087 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -30,17 +30,23 @@
 
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
 {
-    AcpiTableMcfg *mcfg;
-    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
-
-    mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(info->base);
-
-    /* Only a single allocation so no need to play with segments */
-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
-    mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
-
-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
+    int mcfg_start = table_data->len;
+
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+
+    /* PCI fw r3.0 MCFG table. */
+    /* Base address, processor-relative */
+    build_append_int_noprefix(table_data, info->base, 8);
+    /* PCI segment group number */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Starting PCI Bus number */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Final PCI Bus number */
+    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
+                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
 }
 
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index f9aa4bd398..57a3f58b0c 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
 
 typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
 
-/* PCI fw r3.0 MCFG table. */
-/* Subtable */
-struct AcpiMcfgAllocation {
-    uint64_t address;                /* Base address, processor-relative */
-    uint16_t pci_segment;            /* PCI segment group number */
-    uint8_t start_bus_number;       /* Starting PCI Bus number */
-    uint8_t end_bus_number;         /* Final PCI Bus number */
-    uint32_t reserved;
-} QEMU_PACKED;
-typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
-
-struct AcpiTableMcfg {
-    ACPI_TABLE_HEADER_DEF;
-    uint8_t reserved[8];
-    AcpiMcfgAllocation allocation[0];
-} QEMU_PACKED;
-typedef struct AcpiTableMcfg AcpiTableMcfg;
-
 /*
  * TCPA Description Table
  *
-- 
2.19.1
