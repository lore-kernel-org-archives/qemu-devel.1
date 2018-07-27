Received: from eggs.gnu.org ([2001:4830:134:3::10]:58394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSm-0003vW-9O
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSj-0006Oj-GO
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:21 +0200
Message-Id: <20180727095421.386-21-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 20/20] arm/virt: Add support for GICv2
 virtualization extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Add support for GICv2 virtualization extensions by mapping the necessary
I/O regions and connecting the maintenance IRQ lines.

Declare those additions in the device tree and in the ACPI tables.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c |  6 +++--
 hw/arm/virt.c            | 52 +++++++++++++++++++++++++++++++++-------
 include/hw/arm/virt.h    |  4 +++-
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6ea47e2588..ce31abd62c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -657,21 +657,23 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
         gicc->type = ACPI_APIC_GENERIC_CPU_INTERFACE;
         gicc->length = sizeof(*gicc);
         if (vms->gic_version == 2) {
             gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
+            gicc->gich_base_address = cpu_to_le64(memmap[VIRT_GIC_HYP].base);
+            gicc->gicv_base_address = cpu_to_le64(memmap[VIRT_GIC_VCPU].base);
         }
         gicc->cpu_interface_number = cpu_to_le32(i);
         gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
         gicc->uid = cpu_to_le32(i);
         gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
 
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
         }
-        if (vms->virt && vms->gic_version == 3) {
-            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
+        if (vms->virt) {
+            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
         }
     }
 
     if (vms->gic_version == 3) {
         AcpiMadtGenericTranslator *gic_its;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcdf6e..0807be985c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -129,10 +129,12 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_CPUPERIPHS] =         { 0x08000000, 0x00020000 },
     /* GIC distributor and CPU interfaces sit inside the CPU peripheral space */
     [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
     [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
     [VIRT_GIC_V2M] =            { 0x08020000, 0x00001000 },
+    [VIRT_GIC_HYP] =            { 0x08030000, 0x00010000 },
+    [VIRT_GIC_VCPU] =           { 0x08040000, 0x00010000 },
     /* The space in between here is reserved for GICv3 CPU/vCPU/HYP */
     [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
     /* This redistributor space allows up to 2*64kB*123 CPUs */
     [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
     [VIRT_UART] =               { 0x09000000, 0x00001000 },
@@ -438,22 +440,37 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_REDIST2].size);
         }
 
         if (vms->virt) {
             qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
+                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
         qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                                 "arm,cortex-a15-gic");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
-                                      2, vms->memmap[VIRT_GIC_DIST].base,
-                                      2, vms->memmap[VIRT_GIC_DIST].size,
-                                      2, vms->memmap[VIRT_GIC_CPU].base,
-                                      2, vms->memmap[VIRT_GIC_CPU].size);
+        if (!vms->virt) {
+            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                         2, vms->memmap[VIRT_GIC_DIST].base,
+                                         2, vms->memmap[VIRT_GIC_DIST].size,
+                                         2, vms->memmap[VIRT_GIC_CPU].base,
+                                         2, vms->memmap[VIRT_GIC_CPU].size);
+        } else {
+            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+                                         2, vms->memmap[VIRT_GIC_DIST].base,
+                                         2, vms->memmap[VIRT_GIC_DIST].size,
+                                         2, vms->memmap[VIRT_GIC_CPU].base,
+                                         2, vms->memmap[VIRT_GIC_CPU].size,
+                                         2, vms->memmap[VIRT_GIC_HYP].base,
+                                         2, vms->memmap[VIRT_GIC_HYP].size,
+                                         2, vms->memmap[VIRT_GIC_VCPU].base,
+                                         2, vms->memmap[VIRT_GIC_VCPU].size);
+            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        }
     }
 
     qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->gic_phandle);
     g_free(nodename);
 }
@@ -571,10 +588,15 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
                         vms->memmap[VIRT_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
             qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
         }
+    } else {
+        if (!kvm_irqchip_in_kernel()) {
+            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+                              vms->virt);
+        }
     }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
@@ -582,10 +604,14 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
         if (nb_redist_regions == 2) {
             sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_REDIST2].base);
         }
     } else {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
+        if (vms->virt) {
+            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_HYP].base);
+            sysbus_mmio_map(gicbusdev, 3, vms->memmap[VIRT_GIC_VCPU].base);
+        }
     }
 
     /* Wire the outputs from each CPU's generic timer and the GICv3
      * maintenance interrupt signal to the appropriate GIC PPI inputs,
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
@@ -608,13 +634,21 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(gicdev,
                                                    ppibase + timer_irq[irq]));
         }
 
-        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
-                                    qdev_get_gpio_in(gicdev, ppibase
-                                                     + ARCH_GICV3_MAINT_IRQ));
+        if (type == 3) {
+            qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                            ppibase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+        } else if (vms->virt) {
+            qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                            ppibase + ARCH_GIC_MAINT_IRQ);
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+        }
+
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
                                     qdev_get_gpio_in(gicdev, ppibase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a870ccb6a..4cc57a7ef6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -40,11 +40,11 @@
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
-#define ARCH_GICV3_MAINT_IRQ  9
+#define ARCH_GIC_MAINT_IRQ  9
 
 #define ARCH_TIMER_VIRT_IRQ   11
 #define ARCH_TIMER_S_EL1_IRQ  13
 #define ARCH_TIMER_NS_EL1_IRQ 14
 #define ARCH_TIMER_NS_EL2_IRQ 10
@@ -58,10 +58,12 @@ enum {
     VIRT_MEM,
     VIRT_CPUPERIPHS,
     VIRT_GIC_DIST,
     VIRT_GIC_CPU,
     VIRT_GIC_V2M,
+    VIRT_GIC_HYP,
+    VIRT_GIC_VCPU,
     VIRT_GIC_ITS,
     VIRT_GIC_REDIST,
     VIRT_GIC_REDIST2,
     VIRT_SMMU,
     VIRT_UART,
-- 
2.18.0
