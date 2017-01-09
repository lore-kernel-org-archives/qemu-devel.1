Received: from eggs.gnu.org ([2001:4830:134:3::10]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWS-0002Qq-S3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWR-00045l-48
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWQ-00045M-TY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:55 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWP-0001SY-Uv
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:42 +0000
Message-Id: <1483962824-29185-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/21] hw/arm/virt-acpi-build: Don't incorrectly
 claim architectural timer to be edge-triggered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

This is the ACPI equivalent to "hw/arm/virt: Don't incorrectly claim
architectural timer to be edge-triggered" which fixes the DT for
machine types 2.9 and later.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-15-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/acpi-defs.h |  1 +
 hw/arm/virt-acpi-build.c    | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index d15b7e5..d43ec00 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -428,6 +428,7 @@ typedef struct AcpiMadtGenericTranslator AcpiMadtGenericTranslator;
 /*
  * Generic Timer Description Table (GTDT)
  */
+#define ACPI_GTDT_INTERRUPT_MODE_LEVEL    (0 << 0)
 #define ACPI_GTDT_INTERRUPT_MODE_EDGE     (1 << 0)
 #define ACPI_GTDT_CAP_ALWAYS_ON           (1 << 2)
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 44b5234..085a611 100644
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
-- 
2.7.4
