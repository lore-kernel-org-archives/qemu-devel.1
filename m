Received: from eggs.gnu.org ([2001:4830:134:3::10]:37403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWX-0002Uf-H7
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWW-0004AR-BP
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWW-00043I-4I
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWK-0001O4-Qv
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:30 +0000
Message-Id: <1483962824-29185-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/21] hw/arm/virt-acpi-build: name GIC CPU
 Interface Structure appropriately
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

Also move the enabled flag definition from mach-virt code to
acpi common.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20170102200153.28864-3-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/acpi-defs.h      | 9 ++++++---
 include/hw/arm/virt-acpi-build.h | 2 --
 hw/arm/virt-acpi-build.c         | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 154f3b8..510f23c 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -290,7 +290,7 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
 #define ACPI_APIC_XRUPT_SOURCE       8
 #define ACPI_APIC_LOCAL_X2APIC       9
 #define ACPI_APIC_LOCAL_X2APIC_NMI      10
-#define ACPI_APIC_GENERIC_INTERRUPT     11
+#define ACPI_APIC_GENERIC_CPU_INTERFACE 11
 #define ACPI_APIC_GENERIC_DISTRIBUTOR   12
 #define ACPI_APIC_GENERIC_MSI_FRAME     13
 #define ACPI_APIC_GENERIC_REDISTRIBUTOR 14
@@ -361,7 +361,7 @@ struct AcpiMadtLocalX2ApicNmi {
 } QEMU_PACKED;
 typedef struct AcpiMadtLocalX2ApicNmi AcpiMadtLocalX2ApicNmi;
 
-struct AcpiMadtGenericInterrupt {
+struct AcpiMadtGenericCpuInterface {
     ACPI_SUB_HEADER_DEF
     uint16_t reserved;
     uint32_t cpu_interface_number;
@@ -378,7 +378,10 @@ struct AcpiMadtGenericInterrupt {
     uint64_t arm_mpidr;
 } QEMU_PACKED;
 
-typedef struct AcpiMadtGenericInterrupt AcpiMadtGenericInterrupt;
+typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
+
+/* GICC CPU Interface Flags */
+#define ACPI_MADT_GICC_ENABLED 1
 
 struct AcpiMadtGenericDistributor {
     ACPI_SUB_HEADER_DEF
diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
index f5ec749..2bcd222 100644
--- a/include/hw/arm/virt-acpi-build.h
+++ b/include/hw/arm/virt-acpi-build.h
@@ -24,8 +24,6 @@
 #include "hw/arm/virt.h"
 #include "qemu/notify.h"
 
-#define ACPI_GICC_ENABLED 1
-
 typedef struct VirtGuestInfo {
     int smp_cpus;
     FWCfgState *fw_cfg;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0e255b7..5071a0b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -581,11 +581,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtGuestInfo *guest_info)
     gicd->version = guest_info->gic_version;
 
     for (i = 0; i < guest_info->smp_cpus; i++) {
-        AcpiMadtGenericInterrupt *gicc = acpi_data_push(table_data,
-                                                     sizeof *gicc);
+        AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
+                                                           sizeof(*gicc));
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
 
-        gicc->type = ACPI_APIC_GENERIC_INTERRUPT;
+        gicc->type = ACPI_APIC_GENERIC_CPU_INTERFACE;
         gicc->length = sizeof(*gicc);
         if (guest_info->gic_version == 2) {
             gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
@@ -593,7 +593,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtGuestInfo *guest_info)
         gicc->cpu_interface_number = cpu_to_le32(i);
         gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
         gicc->uid = cpu_to_le32(i);
-        gicc->flags = cpu_to_le32(ACPI_GICC_ENABLED);
+        gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
 
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
-- 
2.7.4
