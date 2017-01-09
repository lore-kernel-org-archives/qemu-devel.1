Received: from eggs.gnu.org ([2001:4830:134:3::10]:37411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWX-0002V4-Qq
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWW-0004Bb-Ow
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWW-00045M-Ig
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWK-0001Nh-Cx
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:29 +0000
Message-Id: <1483962824-29185-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/21] hw/arm/virt-acpi-build: add all missing
 cpu_to_le's
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

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20170102200153.28864-2-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7102686..0e255b7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -542,17 +542,18 @@ build_gtdt(GArray *table_data, BIOSLinker *linker)
 
     gtdt = acpi_data_push(table_data, sizeof *gtdt);
     /* The interrupt values are the same with the device tree when adding 16 */
-    gtdt->secure_el1_interrupt = ARCH_TIMER_S_EL1_IRQ + 16;
-    gtdt->secure_el1_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_S_EL1_IRQ + 16);
+    gtdt->secure_el1_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
 
-    gtdt->non_secure_el1_interrupt = ARCH_TIMER_NS_EL1_IRQ + 16;
-    gtdt->non_secure_el1_flags = ACPI_EDGE_SENSITIVE | ACPI_GTDT_ALWAYS_ON;
+    gtdt->non_secure_el1_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL1_IRQ + 16);
+    gtdt->non_secure_el1_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE |
+                                             ACPI_GTDT_ALWAYS_ON);
 
-    gtdt->virtual_timer_interrupt = ARCH_TIMER_VIRT_IRQ + 16;
-    gtdt->virtual_timer_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->virtual_timer_interrupt = cpu_to_le32(ARCH_TIMER_VIRT_IRQ + 16);
+    gtdt->virtual_timer_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
 
-    gtdt->non_secure_el2_interrupt = ARCH_TIMER_NS_EL2_IRQ + 16;
-    gtdt->non_secure_el2_flags = ACPI_EDGE_SENSITIVE;
+    gtdt->non_secure_el2_interrupt = cpu_to_le32(ARCH_TIMER_NS_EL2_IRQ + 16);
+    gtdt->non_secure_el2_flags = cpu_to_le32(ACPI_EDGE_SENSITIVE);
 
     build_header(linker, table_data,
                  (void *)(table_data->data + gtdt_start), "GTDT",
@@ -576,7 +577,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtGuestInfo *guest_info)
     gicd = acpi_data_push(table_data, sizeof *gicd);
     gicd->type = ACPI_APIC_GENERIC_DISTRIBUTOR;
     gicd->length = sizeof(*gicd);
-    gicd->base_address = memmap[VIRT_GIC_DIST].base;
+    gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
     gicd->version = guest_info->gic_version;
 
     for (i = 0; i < guest_info->smp_cpus; i++) {
@@ -587,11 +588,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtGuestInfo *guest_info)
         gicc->type = ACPI_APIC_GENERIC_INTERRUPT;
         gicc->length = sizeof(*gicc);
         if (guest_info->gic_version == 2) {
-            gicc->base_address = memmap[VIRT_GIC_CPU].base;
+            gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
         }
-        gicc->cpu_interface_number = i;
-        gicc->arm_mpidr = armcpu->mp_affinity;
-        gicc->uid = i;
+        gicc->cpu_interface_number = cpu_to_le32(i);
+        gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
+        gicc->uid = cpu_to_le32(i);
         gicc->flags = cpu_to_le32(ACPI_GICC_ENABLED);
 
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
-- 
2.7.4
