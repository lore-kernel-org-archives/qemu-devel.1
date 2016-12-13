Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGuta-0002lz-Rk
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutZ-0007ib-RQ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:58 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:22 +0100
Message-Id: <20161213214522.25548-12-drjones@redhat.com>
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] hw/arm/virt-acpi-build: Don't
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
Cc: peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

This is the ACPI equivalent to "hw/arm/virt: Don't incorrectly claim
architectural timer to be edge-triggered" which fixes the DT for
machine types 2.9 and later.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0e6caf5f1083..62cf4e7f6615 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -535,24 +535,30 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /* GTDT */
 static void
-build_gtdt(GArray *table_data, BIOSLinker *linker)
+build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int gtdt_start = table_data->len;
     AcpiGenericTimerTable *gtdt;
+    uint8_t irqflags = ACPI_LEVEL_SENSITIVE;
+
+    if (vmc->claim_edge_triggered_timers) {
+        irqflags = ACPI_EDGE_SENSITIVE;
+    }
 
     gtdt = acpi_data_push(table_data, sizeof *gtdt);
     /* The interrupt values are the same with the device tree when adding 16 */
     gtdt->secure_el1_interrupt = ARCH_TIMER_S_EL1_IRQ + 16;
-    gtdt->secure_el1_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->secure_el1_flags = irqflags;
 
     gtdt->non_secure_el1_interrupt = ARCH_TIMER_NS_EL1_IRQ + 16;
-    gtdt->non_secure_el1_flags = ACPI_EDGE_SENSITIVE | ACPI_GTDT_ALWAYS_ON;
+    gtdt->non_secure_el1_flags = irqflags | ACPI_GTDT_ALWAYS_ON;
 
     gtdt->virtual_timer_interrupt = ARCH_TIMER_VIRT_IRQ + 16;
-    gtdt->virtual_timer_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->virtual_timer_flags = irqflags;
 
     gtdt->non_secure_el2_interrupt = ARCH_TIMER_NS_EL2_IRQ + 16;
-    gtdt->non_secure_el2_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->non_secure_el2_flags = irqflags;
 
     build_header(linker, table_data,
                  (void *)(table_data->data + gtdt_start), "GTDT",
@@ -735,7 +741,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_madt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_gtdt(tables_blob, tables->linker);
+    build_gtdt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_mcfg(tables_blob, tables->linker, vms);
-- 
2.9.3
