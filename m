Received: from eggs.gnu.org ([2001:4830:134:3::10]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oS-00021d-N5
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oR-0003z4-G7
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:32 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:51 +0100
Message-Id: <20170102200153.28864-15-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/16] hw/arm/virt-acpi-build: Don't
 incorrectly claim architectural timer to be edge-triggered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

This is the ACPI equivalent to "hw/arm/virt: Don't incorrectly claim
architectural timer to be edge-triggered" which fixes the DT for
machine types 2.9 and later.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c    | 20 ++++++++++++++------
 include/hw/acpi/acpi-defs.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index aa800d2a9657..b5e17a680d51 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -535,25 +535,33 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /* GTDT */
 static void
-build_gtdt(GArray *table_data, BIOSLinker *linker)
+build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int gtdt_start = table_data->len;
     AcpiGenericTimerTable *gtdt;
+    uint32_t irqflags;
+
+    if (vmc->claim_edge_triggered_timers) {
+        irqflags = ACPI_GTDT_INTERRUPT_MODE_EDGE;
+    } else {
+        irqflags = ACPI_GTDT_INTERRUPT_MODE_LEVEL;
+    }
 
     gtdt = acpi_data_push(table_data, sizeof *gtdt);
     /* The interrupt values are the same with the device tree when adding 16 */
     gtdt->secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_S_EL1_IRQ + 16);
-    gtdt->secure_el1_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
+    gtdt->secure_el1_flags = cpu_to_le32(irqflags);
 
     gtdt->non_secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL1_IRQ + 16);
-    gtdt->non_secure_el1_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE |
+    gtdt->non_secure_el1_flags = cpu_to_le32(irqflags |
                                              ACPI_GTDT_CAP_ALWAYS_ON);
 
     gtdt->virtual_timer_interrupt = cpu_to_le32(ARCH_TIMER_VIRT_IRQ + 16);
-    gtdt->virtual_timer_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
+    gtdt->virtual_timer_flags = cpu_to_le32(irqflags);
 
     gtdt->non_secure_el2_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL2_IRQ + 16);
-    gtdt->non_secure_el2_flags = cpu_to_le32(ACPI_GTDT_INTERRUPT_MODE_EDGE);
+    gtdt->non_secure_el2_flags = cpu_to_le32(irqflags);
 
     build_header(linker, table_data,
                  (void *)(table_data->data + gtdt_start), "GTDT",
@@ -736,7 +744,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_madt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_gtdt(tables_blob, tables->linker);
+    build_gtdt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_mcfg(tables_blob, tables->linker, vms);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index d15b7e5cd39a..d43ec005cbb7 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -428,6 +428,7 @@ typedef struct AcpiMadtGenericTranslator AcpiMadtGenericTranslator;
 /*
  * Generic Timer Description Table (GTDT)
  */
+#define ACPI_GTDT_INTERRUPT_MODE_LEVEL    (0 << 0)
 #define ACPI_GTDT_INTERRUPT_MODE_EDGE     (1 << 0)
 #define ACPI_GTDT_CAP_ALWAYS_ON           (1 << 2)
 
-- 
2.9.3
