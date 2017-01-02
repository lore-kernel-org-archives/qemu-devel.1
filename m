Received: from eggs.gnu.org ([2001:4830:134:3::10]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o2-0001Z8-8f
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8o1-0003ov-6B
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:06 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:39 +0100
Message-Id: <20170102200153.28864-3-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/16] hw/arm/virt-acpi-build: name GIC CPU
 Interface Structure appropriately
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

Also move the enabled flag definition from mach-virt code to
acpi common.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c         | 8 ++++----
 include/hw/acpi/acpi-defs.h      | 9 ++++++---
 include/hw/arm/virt-acpi-build.h | 2 --
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f4b43562287a..0ed406cdd89c 100644
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
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 154f3b82f6dc..510f23c93183 100644
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
index f5ec749b8fea..2bcd22265cfa 100644
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
-- 
2.9.3
