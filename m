Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahE0-0007Vq-P8
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahDz-0000VO-Op
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:36 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed,  4 Jul 2018 14:49:21 +0200
Message-Id: <20180704124923.32483-5-drjones@redhat.com>
In-Reply-To: <20180704124923.32483-1-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/6] hw/arm/virt-acpi-build: distinguish
 possible and present cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, imammedo@redhat.com, eric.auger@redhat.com, wei@redhat.com

When building ACPI tables regarding CPUs we should always build
them for the number of possible CPUs, not the number of present
CPUs. We then ensure only the present CPUs are enabled.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt-acpi-build.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6ea47e258832..1d1fc824da6f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -49,14 +49,22 @@
 #define ARM_SPI_BASE 32
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
 
-static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
+static int possible_cpus(VirtMachineState *vms)
+{
+    return MACHINE_GET_CLASS(vms)->possible_cpu_arch_ids(MACHINE(vms))->len;
+}
+
+static void acpi_dsdt_add_cpus(Aml *scope, int possible, int present)
 {
     uint16_t i;
 
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < possible; i++) {
         Aml *dev = aml_device("C%.03X", i);
         aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
         aml_append(dev, aml_name_decl("_UID", aml_int(i)));
+        if (i >= present) {
+            aml_append(dev, aml_name_decl("_STA", aml_int(0)));
+        }
         aml_append(scope, dev);
     }
 }
@@ -650,7 +658,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
     gicd->version = vms->gic_version;
 
-    for (i = 0; i < vms->smp_cpus; i++) {
+    for (i = 0; i < possible_cpus(vms); i++) {
         AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
                                                            sizeof(*gicc));
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
@@ -663,7 +671,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         gicc->cpu_interface_number = cpu_to_le32(i);
         gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
         gicc->uid = cpu_to_le32(i);
-        gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
+        if (i < vms->smp_cpus) {
+            gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
+        }
 
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
@@ -763,7 +773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * the RTC ACPI device at all when using UEFI.
      */
     scope = aml_scope("\\_SB");
-    acpi_dsdt_add_cpus(scope, vms->smp_cpus);
+    acpi_dsdt_add_cpus(scope, possible_cpus(vms), vms->smp_cpus);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
-- 
2.17.1
