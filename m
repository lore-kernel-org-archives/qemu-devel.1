Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWc-0002a3-7N
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWX-0004CT-VL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWX-00045M-Be
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWJ-0001Mx-Ff
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:27 +0000
Message-Id: <1483962824-29185-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/21] hw/arm/virt: Rename 'vbi' variables to
 'vms'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename all the variables which used to be VirtBoardInfo*
and are now VirtMachineState* so their names are in line
with the type being used.

Apart from the removal of the line 'VirtMachineState *vbi = vms;'
this commit is purely a search-and-replace of 'vbi' with 'vms'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 489 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 244 insertions(+), 245 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fd4eed9..54498ea 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -217,16 +217,16 @@ static bool cpuname_valid(const char *cpu)
     return false;
 }
 
-static void create_fdt(VirtMachineState *vbi)
+static void create_fdt(VirtMachineState *vms)
 {
-    void *fdt = create_device_tree(&vbi->fdt_size);
+    void *fdt = create_device_tree(&vms->fdt_size);
 
     if (!fdt) {
         error_report("create_device_tree() failed");
         exit(1);
     }
 
-    vbi->fdt = fdt;
+    vms->fdt = fdt;
 
     /* Header */
     qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
@@ -246,27 +246,27 @@ static void create_fdt(VirtMachineState *vbi)
      * optional but in practice if you omit them the kernel refuses to
      * probe for the device.
      */
-    vbi->clock_phandle = qemu_fdt_alloc_phandle(fdt);
+    vms->clock_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, "/apb-pclk");
     qemu_fdt_setprop_string(fdt, "/apb-pclk", "compatible", "fixed-clock");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "#clock-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "clock-frequency", 24000000);
     qemu_fdt_setprop_string(fdt, "/apb-pclk", "clock-output-names",
                                 "clk24mhz");
-    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vbi->clock_phandle);
+    qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
 
 }
 
-static void fdt_add_psci_node(const VirtMachineState *vbi)
+static void fdt_add_psci_node(const VirtMachineState *vms)
 {
     uint32_t cpu_suspend_fn;
     uint32_t cpu_off_fn;
     uint32_t cpu_on_fn;
     uint32_t migrate_fn;
-    void *fdt = vbi->fdt;
+    void *fdt = vms->fdt;
     ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
 
-    if (!vbi->using_psci) {
+    if (!vms->using_psci) {
         return;
     }
 
@@ -307,7 +307,7 @@ static void fdt_add_psci_node(const VirtMachineState *vbi)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
-static void fdt_add_timer_nodes(const VirtMachineState *vbi, int gictype)
+static void fdt_add_timer_nodes(const VirtMachineState *vms, int gictype)
 {
     /* Note that on A15 h/w these interrupts are level-triggered,
      * but for the GIC implementation provided by both QEMU and KVM
@@ -319,29 +319,29 @@ static void fdt_add_timer_nodes(const VirtMachineState *vbi, int gictype)
     if (gictype == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
-                             (1 << vbi->smp_cpus) - 1);
+                             (1 << vms->smp_cpus) - 1);
     }
 
-    qemu_fdt_add_subnode(vbi->fdt, "/timer");
+    qemu_fdt_add_subnode(vms->fdt, "/timer");
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
-        qemu_fdt_setprop(vbi->fdt, "/timer", "compatible",
+        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
                          compat, sizeof(compat));
     } else {
-        qemu_fdt_setprop_string(vbi->fdt, "/timer", "compatible",
+        qemu_fdt_setprop_string(vms->fdt, "/timer", "compatible",
                                 "arm,armv7-timer");
     }
-    qemu_fdt_setprop(vbi->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(vbi->fdt, "/timer", "interrupts",
+    qemu_fdt_setprop(vms->fdt, "/timer", "always-on", NULL, 0);
+    qemu_fdt_setprop_cells(vms->fdt, "/timer", "interrupts",
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
 }
 
-static void fdt_add_cpu_nodes(const VirtMachineState *vbi)
+static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
@@ -360,7 +360,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vbi)
      *  The simplest way to go is to examine affinity IDs of all our CPUs. If
      *  at least one of them has Aff3 populated, we set #address-cells to 2.
      */
-    for (cpu = 0; cpu < vbi->smp_cpus; cpu++) {
+    for (cpu = 0; cpu < vms->smp_cpus; cpu++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
 
         if (armcpu->mp_affinity & ARM_AFF3_MASK) {
@@ -369,101 +369,101 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vbi)
         }
     }
 
-    qemu_fdt_add_subnode(vbi->fdt, "/cpus");
-    qemu_fdt_setprop_cell(vbi->fdt, "/cpus", "#address-cells", addr_cells);
-    qemu_fdt_setprop_cell(vbi->fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_add_subnode(vms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
+    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
 
-    for (cpu = vbi->smp_cpus - 1; cpu >= 0; cpu--) {
+    for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
 
-        qemu_fdt_add_subnode(vbi->fdt, nodename);
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "compatible",
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                                     armcpu->dtb_compatible);
 
-        if (vbi->using_psci && vbi->smp_cpus > 1) {
-            qemu_fdt_setprop_string(vbi->fdt, nodename,
+        if (vms->using_psci && vms->smp_cpus > 1) {
+            qemu_fdt_setprop_string(vms->fdt, nodename,
                                         "enable-method", "psci");
         }
 
         if (addr_cells == 2) {
-            qemu_fdt_setprop_u64(vbi->fdt, nodename, "reg",
+            qemu_fdt_setprop_u64(vms->fdt, nodename, "reg",
                                  armcpu->mp_affinity);
         } else {
-            qemu_fdt_setprop_cell(vbi->fdt, nodename, "reg",
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "reg",
                                   armcpu->mp_affinity);
         }
 
         i = numa_get_node_for_cpu(cpu);
         if (i < nb_numa_nodes) {
-            qemu_fdt_setprop_cell(vbi->fdt, nodename, "numa-node-id", i);
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id", i);
         }
 
         g_free(nodename);
     }
 }
 
-static void fdt_add_its_gic_node(VirtMachineState *vbi)
+static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
-    vbi->msi_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
-    qemu_fdt_add_subnode(vbi->fdt, "/intc/its");
-    qemu_fdt_setprop_string(vbi->fdt, "/intc/its", "compatible",
+    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    qemu_fdt_add_subnode(vms->fdt, "/intc/its");
+    qemu_fdt_setprop_string(vms->fdt, "/intc/its", "compatible",
                             "arm,gic-v3-its");
-    qemu_fdt_setprop(vbi->fdt, "/intc/its", "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vbi->fdt, "/intc/its", "reg",
-                                 2, vbi->memmap[VIRT_GIC_ITS].base,
-                                 2, vbi->memmap[VIRT_GIC_ITS].size);
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc/its", "phandle", vbi->msi_phandle);
+    qemu_fdt_setprop(vms->fdt, "/intc/its", "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(vms->fdt, "/intc/its", "reg",
+                                 2, vms->memmap[VIRT_GIC_ITS].base,
+                                 2, vms->memmap[VIRT_GIC_ITS].size);
+    qemu_fdt_setprop_cell(vms->fdt, "/intc/its", "phandle", vms->msi_phandle);
 }
 
-static void fdt_add_v2m_gic_node(VirtMachineState *vbi)
+static void fdt_add_v2m_gic_node(VirtMachineState *vms)
 {
-    vbi->msi_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
-    qemu_fdt_add_subnode(vbi->fdt, "/intc/v2m");
-    qemu_fdt_setprop_string(vbi->fdt, "/intc/v2m", "compatible",
+    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    qemu_fdt_add_subnode(vms->fdt, "/intc/v2m");
+    qemu_fdt_setprop_string(vms->fdt, "/intc/v2m", "compatible",
                             "arm,gic-v2m-frame");
-    qemu_fdt_setprop(vbi->fdt, "/intc/v2m", "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vbi->fdt, "/intc/v2m", "reg",
-                                 2, vbi->memmap[VIRT_GIC_V2M].base,
-                                 2, vbi->memmap[VIRT_GIC_V2M].size);
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc/v2m", "phandle", vbi->msi_phandle);
+    qemu_fdt_setprop(vms->fdt, "/intc/v2m", "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(vms->fdt, "/intc/v2m", "reg",
+                                 2, vms->memmap[VIRT_GIC_V2M].base,
+                                 2, vms->memmap[VIRT_GIC_V2M].size);
+    qemu_fdt_setprop_cell(vms->fdt, "/intc/v2m", "phandle", vms->msi_phandle);
 }
 
-static void fdt_add_gic_node(VirtMachineState *vbi, int type)
+static void fdt_add_gic_node(VirtMachineState *vms, int type)
 {
-    vbi->gic_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
-    qemu_fdt_setprop_cell(vbi->fdt, "/", "interrupt-parent", vbi->gic_phandle);
-
-    qemu_fdt_add_subnode(vbi->fdt, "/intc");
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc", "#interrupt-cells", 3);
-    qemu_fdt_setprop(vbi->fdt, "/intc", "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc", "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc", "#size-cells", 0x2);
-    qemu_fdt_setprop(vbi->fdt, "/intc", "ranges", NULL, 0);
+    vms->gic_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    qemu_fdt_setprop_cell(vms->fdt, "/", "interrupt-parent", vms->gic_phandle);
+
+    qemu_fdt_add_subnode(vms->fdt, "/intc");
+    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#interrupt-cells", 3);
+    qemu_fdt_setprop(vms->fdt, "/intc", "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
+    qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
     if (type == 3) {
-        qemu_fdt_setprop_string(vbi->fdt, "/intc", "compatible",
+        qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
                                 "arm,gic-v3");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, "/intc", "reg",
-                                     2, vbi->memmap[VIRT_GIC_DIST].base,
-                                     2, vbi->memmap[VIRT_GIC_DIST].size,
-                                     2, vbi->memmap[VIRT_GIC_REDIST].base,
-                                     2, vbi->memmap[VIRT_GIC_REDIST].size);
+        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+                                     2, vms->memmap[VIRT_GIC_DIST].base,
+                                     2, vms->memmap[VIRT_GIC_DIST].size,
+                                     2, vms->memmap[VIRT_GIC_REDIST].base,
+                                     2, vms->memmap[VIRT_GIC_REDIST].size);
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
-        qemu_fdt_setprop_string(vbi->fdt, "/intc", "compatible",
+        qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
                                 "arm,cortex-a15-gic");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, "/intc", "reg",
-                                      2, vbi->memmap[VIRT_GIC_DIST].base,
-                                      2, vbi->memmap[VIRT_GIC_DIST].size,
-                                      2, vbi->memmap[VIRT_GIC_CPU].base,
-                                      2, vbi->memmap[VIRT_GIC_CPU].size);
+        qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
+                                      2, vms->memmap[VIRT_GIC_DIST].base,
+                                      2, vms->memmap[VIRT_GIC_DIST].size,
+                                      2, vms->memmap[VIRT_GIC_CPU].base,
+                                      2, vms->memmap[VIRT_GIC_CPU].size);
     }
 
-    qemu_fdt_setprop_cell(vbi->fdt, "/intc", "phandle", vbi->gic_phandle);
+    qemu_fdt_setprop_cell(vms->fdt, "/intc", "phandle", vms->gic_phandle);
 }
 
-static void fdt_add_pmu_nodes(const VirtMachineState *vbi, int gictype)
+static void fdt_add_pmu_nodes(const VirtMachineState *vms, int gictype)
 {
     CPUState *cpu;
     ARMCPU *armcpu;
@@ -480,21 +480,21 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vbi, int gictype)
     if (gictype == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
-                             (1 << vbi->smp_cpus) - 1);
+                             (1 << vms->smp_cpus) - 1);
     }
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
-    qemu_fdt_add_subnode(vbi->fdt, "/pmu");
+    qemu_fdt_add_subnode(vms->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
-        qemu_fdt_setprop(vbi->fdt, "/pmu", "compatible",
+        qemu_fdt_setprop(vms->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
-        qemu_fdt_setprop_cells(vbi->fdt, "/pmu", "interrupts",
+        qemu_fdt_setprop_cells(vms->fdt, "/pmu", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irqflags);
     }
 }
 
-static void create_its(VirtMachineState *vbi, DeviceState *gicdev)
+static void create_its(VirtMachineState *vms, DeviceState *gicdev)
 {
     const char *itsclass = its_class_name();
     DeviceState *dev;
@@ -509,19 +509,19 @@ static void create_its(VirtMachineState *vbi, DeviceState *gicdev)
     object_property_set_link(OBJECT(dev), OBJECT(gicdev), "parent-gicv3",
                              &error_abort);
     qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vbi->memmap[VIRT_GIC_ITS].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
-    fdt_add_its_gic_node(vbi);
+    fdt_add_its_gic_node(vms);
 }
 
-static void create_v2m(VirtMachineState *vbi, qemu_irq *pic)
+static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
 {
     int i;
-    int irq = vbi->irqmap[VIRT_GIC_V2M];
+    int irq = vms->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
     dev = qdev_create(NULL, "arm-gicv2m");
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vbi->memmap[VIRT_GIC_V2M].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     qdev_init_nofail(dev);
@@ -530,10 +530,10 @@ static void create_v2m(VirtMachineState *vbi, qemu_irq *pic)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
     }
 
-    fdt_add_v2m_gic_node(vbi);
+    fdt_add_v2m_gic_node(vms);
 }
 
-static void create_gic(VirtMachineState *vbi, qemu_irq *pic, int type,
+static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
                        bool secure, bool no_its)
 {
     /* We create a standalone GIC */
@@ -556,11 +556,11 @@ static void create_gic(VirtMachineState *vbi, qemu_irq *pic, int type,
     }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
-    sysbus_mmio_map(gicbusdev, 0, vbi->memmap[VIRT_GIC_DIST].base);
+    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
-        sysbus_mmio_map(gicbusdev, 1, vbi->memmap[VIRT_GIC_REDIST].base);
+        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
     } else {
-        sysbus_mmio_map(gicbusdev, 1, vbi->memmap[VIRT_GIC_CPU].base);
+        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
     }
 
     /* Wire the outputs from each CPU's generic timer to the
@@ -596,22 +596,22 @@ static void create_gic(VirtMachineState *vbi, qemu_irq *pic, int type,
         pic[i] = qdev_get_gpio_in(gicdev, i);
     }
 
-    fdt_add_gic_node(vbi, type);
+    fdt_add_gic_node(vms, type);
 
     if (type == 3 && !no_its) {
-        create_its(vbi, gicdev);
+        create_its(vms, gicdev);
     } else if (type == 2) {
-        create_v2m(vbi, pic);
+        create_v2m(vms, pic);
     }
 }
 
-static void create_uart(const VirtMachineState *vbi, qemu_irq *pic, int uart,
+static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
                         MemoryRegion *mem, CharDriverState *chr)
 {
     char *nodename;
-    hwaddr base = vbi->memmap[uart].base;
-    hwaddr size = vbi->memmap[uart].size;
-    int irq = vbi->irqmap[uart];
+    hwaddr base = vms->memmap[uart].base;
+    hwaddr size = vms->memmap[uart].size;
+    int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
     DeviceState *dev = qdev_create(NULL, "pl011");
@@ -624,51 +624,51 @@ static void create_uart(const VirtMachineState *vbi, qemu_irq *pic, int uart,
     sysbus_connect_irq(s, 0, pic[irq]);
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
+    qemu_fdt_add_subnode(vms->fdt, nodename);
     /* Note that we can't use setprop_string because of the embedded NUL */
-    qemu_fdt_setprop(vbi->fdt, nodename, "compatible",
+    qemu_fdt_setprop(vms->fdt, nodename, "compatible",
                          compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                      2, base, 2, size);
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "clocks",
-                               vbi->clock_phandle, vbi->clock_phandle);
-    qemu_fdt_setprop(vbi->fdt, nodename, "clock-names",
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "clocks",
+                               vms->clock_phandle, vms->clock_phandle);
+    qemu_fdt_setprop(vms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
     if (uart == VIRT_UART) {
-        qemu_fdt_setprop_string(vbi->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
     } else {
         /* Mark as not usable by the normal world */
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
     }
 
     g_free(nodename);
 }
 
-static void create_rtc(const VirtMachineState *vbi, qemu_irq *pic)
+static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
 {
     char *nodename;
-    hwaddr base = vbi->memmap[VIRT_RTC].base;
-    hwaddr size = vbi->memmap[VIRT_RTC].size;
-    int irq = vbi->irqmap[VIRT_RTC];
+    hwaddr base = vms->memmap[VIRT_RTC].base;
+    hwaddr size = vms->memmap[VIRT_RTC].size;
+    int irq = vms->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
 
     sysbus_create_simple("pl031", base, pic[irq]);
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
-    qemu_fdt_setprop(vbi->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "clocks", vbi->clock_phandle);
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
     g_free(nodename);
 }
 
@@ -683,45 +683,45 @@ static Notifier virt_system_powerdown_notifier = {
     .notify = virt_powerdown_req
 };
 
-static void create_gpio(const VirtMachineState *vbi, qemu_irq *pic)
+static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
 {
     char *nodename;
     DeviceState *pl061_dev;
-    hwaddr base = vbi->memmap[VIRT_GPIO].base;
-    hwaddr size = vbi->memmap[VIRT_GPIO].size;
-    int irq = vbi->irqmap[VIRT_GPIO];
+    hwaddr base = vms->memmap[VIRT_GPIO].base;
+    hwaddr size = vms->memmap[VIRT_GPIO].size;
+    int irq = vms->irqmap[VIRT_GPIO];
     const char compat[] = "arm,pl061\0arm,primecell";
 
     pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
 
-    uint32_t phandle = qemu_fdt_alloc_phandle(vbi->fdt);
+    uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop(vbi->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "#gpio-cells", 2);
-    qemu_fdt_setprop(vbi->fdt, nodename, "gpio-controller", NULL, 0);
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "interrupts",
+    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#gpio-cells", 2);
+    qemu_fdt_setprop(vms->fdt, nodename, "gpio-controller", NULL, 0);
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "clocks", vbi->clock_phandle);
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "clock-names", "apb_pclk");
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "phandle", phandle);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", phandle);
 
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
-    qemu_fdt_add_subnode(vbi->fdt, "/gpio-keys");
-    qemu_fdt_setprop_string(vbi->fdt, "/gpio-keys", "compatible", "gpio-keys");
-    qemu_fdt_setprop_cell(vbi->fdt, "/gpio-keys", "#size-cells", 0);
-    qemu_fdt_setprop_cell(vbi->fdt, "/gpio-keys", "#address-cells", 1);
+    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys");
+    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys", "compatible", "gpio-keys");
+    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#size-cells", 0);
+    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#address-cells", 1);
 
-    qemu_fdt_add_subnode(vbi->fdt, "/gpio-keys/poweroff");
-    qemu_fdt_setprop_string(vbi->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys/poweroff");
+    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys/poweroff",
                             "label", "GPIO Key Poweroff");
-    qemu_fdt_setprop_cell(vbi->fdt, "/gpio-keys/poweroff", "linux,code",
+    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys/poweroff", "linux,code",
                           KEY_POWER);
-    qemu_fdt_setprop_cells(vbi->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
                            "gpios", phandle, 3, 0);
 
     /* connect powerdown request */
@@ -730,10 +730,10 @@ static void create_gpio(const VirtMachineState *vbi, qemu_irq *pic)
     g_free(nodename);
 }
 
-static void create_virtio_devices(const VirtMachineState *vbi, qemu_irq *pic)
+static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
 {
     int i;
-    hwaddr size = vbi->memmap[VIRT_MMIO].size;
+    hwaddr size = vms->memmap[VIRT_MMIO].size;
 
     /* We create the transports in forwards order. Since qbus_realize()
      * prepends (not appends) new child buses, the incrementing loop below will
@@ -763,8 +763,8 @@ static void create_virtio_devices(const VirtMachineState *vbi, qemu_irq *pic)
      * of disks users must use UUIDs or similar mechanisms.
      */
     for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
-        int irq = vbi->irqmap[VIRT_MMIO] + i;
-        hwaddr base = vbi->memmap[VIRT_MMIO].base + i * size;
+        int irq = vms->irqmap[VIRT_MMIO] + i;
+        hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
         sysbus_create_simple("virtio-mmio", base, pic[irq]);
     }
@@ -778,16 +778,16 @@ static void create_virtio_devices(const VirtMachineState *vbi, qemu_irq *pic)
      */
     for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
         char *nodename;
-        int irq = vbi->irqmap[VIRT_MMIO] + i;
-        hwaddr base = vbi->memmap[VIRT_MMIO].base + i * size;
+        int irq = vms->irqmap[VIRT_MMIO] + i;
+        hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
         nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-        qemu_fdt_add_subnode(vbi->fdt, nodename);
-        qemu_fdt_setprop_string(vbi->fdt, nodename,
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename,
                                 "compatible", "virtio,mmio");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                      2, base, 2, size);
-        qemu_fdt_setprop_cells(vbi->fdt, nodename, "interrupts",
+        qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
         g_free(nodename);
@@ -850,7 +850,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     }
 }
 
-static void create_flash(const VirtMachineState *vbi,
+static void create_flash(const VirtMachineState *vms,
                          MemoryRegion *sysmem,
                          MemoryRegion *secure_sysmem)
 {
@@ -862,8 +862,8 @@ static void create_flash(const VirtMachineState *vbi,
      * If sysmem == secure_sysmem this means there is no separate Secure
      * address space and both flash devices are generally visible.
      */
-    hwaddr flashsize = vbi->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = vbi->memmap[VIRT_FLASH].base;
+    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
     char *nodename;
 
     create_one_flash("virt.flash0", flashbase, flashsize,
@@ -874,41 +874,41 @@ static void create_flash(const VirtMachineState *vbi,
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vbi->fdt, nodename);
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize,
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vbi->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     } else {
         /* Report the devices as separate nodes so we can mark one as
          * only visible to the secure world.
          */
         nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vbi->fdt, nodename);
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize);
-        qemu_fdt_setprop_cell(vbi->fdt, nodename, "bank-width", 4);
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
         g_free(nodename);
 
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vbi->fdt, nodename);
-        qemu_fdt_setprop_string(vbi->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vbi->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     }
 }
 
-static void create_fw_cfg(const VirtMachineState *vbi, AddressSpace *as)
+static void create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
-    hwaddr base = vbi->memmap[VIRT_FW_CFG].base;
-    hwaddr size = vbi->memmap[VIRT_FW_CFG].size;
+    hwaddr base = vms->memmap[VIRT_FW_CFG].base;
+    hwaddr size = vms->memmap[VIRT_FW_CFG].size;
     FWCfgState *fw_cfg;
     char *nodename;
 
@@ -916,15 +916,15 @@ static void create_fw_cfg(const VirtMachineState *vbi, AddressSpace *as)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
-    qemu_fdt_setprop_string(vbi->fdt, nodename,
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename,
                             "compatible", "qemu,fw-cfg-mmio");
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
     g_free(nodename);
 }
 
-static void create_pcie_irq_map(const VirtMachineState *vbi,
+static void create_pcie_irq_map(const VirtMachineState *vms,
                                 uint32_t gic_phandle,
                                 int first_irq, const char *nodename)
 {
@@ -952,28 +952,28 @@ static void create_pcie_irq_map(const VirtMachineState *vbi,
         }
     }
 
-    qemu_fdt_setprop(vbi->fdt, nodename, "interrupt-map",
+    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-map",
                      full_irq_map, sizeof(full_irq_map));
 
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "interrupt-map-mask",
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupt-map-mask",
                            0x1800, 0, 0, /* devfn (PCI_SLOT(3)) */
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtMachineState *vbi, qemu_irq *pic,
+static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
                         bool use_highmem)
 {
-    hwaddr base_mmio = vbi->memmap[VIRT_PCIE_MMIO].base;
-    hwaddr size_mmio = vbi->memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_mmio_high = vbi->memmap[VIRT_PCIE_MMIO_HIGH].base;
-    hwaddr size_mmio_high = vbi->memmap[VIRT_PCIE_MMIO_HIGH].size;
-    hwaddr base_pio = vbi->memmap[VIRT_PCIE_PIO].base;
-    hwaddr size_pio = vbi->memmap[VIRT_PCIE_PIO].size;
-    hwaddr base_ecam = vbi->memmap[VIRT_PCIE_ECAM].base;
-    hwaddr size_ecam = vbi->memmap[VIRT_PCIE_ECAM].size;
+    hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
+    hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
+    hwaddr base_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].base;
+    hwaddr size_mmio_high = vms->memmap[VIRT_PCIE_MMIO_HIGH].size;
+    hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
+    hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
+    hwaddr base_ecam = vms->memmap[VIRT_PCIE_ECAM].base;
+    hwaddr size_ecam = vms->memmap[VIRT_PCIE_ECAM].size;
     hwaddr base = base_mmio;
     int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
-    int irq = vbi->irqmap[VIRT_PCIE];
+    int irq = vms->irqmap[VIRT_PCIE];
     MemoryRegion *mmio_alias;
     MemoryRegion *mmio_reg;
     MemoryRegion *ecam_alias;
@@ -1035,26 +1035,26 @@ static void create_pcie(const VirtMachineState *vbi, qemu_irq *pic,
     }
 
     nodename = g_strdup_printf("/pcie@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
-    qemu_fdt_setprop_string(vbi->fdt, nodename,
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "#address-cells", 3);
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "#size-cells", 2);
-    qemu_fdt_setprop_cells(vbi->fdt, nodename, "bus-range", 0,
+    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
-    qemu_fdt_setprop(vbi->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
 
-    if (vbi->msi_phandle) {
-        qemu_fdt_setprop_cells(vbi->fdt, nodename, "msi-parent",
-                               vbi->msi_phandle);
+    if (vms->msi_phandle) {
+        qemu_fdt_setprop_cells(vms->fdt, nodename, "msi-parent",
+                               vms->msi_phandle);
     }
 
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base_ecam, 2, size_ecam);
 
     if (use_highmem) {
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
@@ -1063,20 +1063,20 @@ static void create_pcie(const VirtMachineState *vbi, qemu_irq *pic,
                                      2, base_mmio_high,
                                      2, base_mmio_high, 2, size_mmio_high);
     } else {
-        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
                                      2, base_mmio, 2, size_mmio);
     }
 
-    qemu_fdt_setprop_cell(vbi->fdt, nodename, "#interrupt-cells", 1);
-    create_pcie_irq_map(vbi, vbi->gic_phandle, irq, nodename);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
+    create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
 
     g_free(nodename);
 }
 
-static void create_platform_bus(VirtMachineState *vbi, qemu_irq *pic)
+static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -1084,13 +1084,13 @@ static void create_platform_bus(VirtMachineState *vbi, qemu_irq *pic)
     ARMPlatformBusFDTParams *fdt_params = g_new(ARMPlatformBusFDTParams, 1);
     MemoryRegion *sysmem = get_system_memory();
 
-    platform_bus_params.platform_bus_base = vbi->memmap[VIRT_PLATFORM_BUS].base;
-    platform_bus_params.platform_bus_size = vbi->memmap[VIRT_PLATFORM_BUS].size;
-    platform_bus_params.platform_bus_first_irq = vbi->irqmap[VIRT_PLATFORM_BUS];
+    platform_bus_params.platform_bus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
+    platform_bus_params.platform_bus_size = vms->memmap[VIRT_PLATFORM_BUS].size;
+    platform_bus_params.platform_bus_first_irq = vms->irqmap[VIRT_PLATFORM_BUS];
     platform_bus_params.platform_bus_num_irqs = PLATFORM_BUS_NUM_IRQS;
 
     fdt_params->system_params = &platform_bus_params;
-    fdt_params->binfo = &vbi->bootinfo;
+    fdt_params->binfo = &vms->bootinfo;
     fdt_params->intc = "/intc";
     /*
      * register a machine init done notifier that creates the device tree
@@ -1117,24 +1117,24 @@ static void create_platform_bus(VirtMachineState *vbi, qemu_irq *pic)
                                 sysbus_mmio_get_region(s, 0));
 }
 
-static void create_secure_ram(VirtMachineState *vbi,
+static void create_secure_ram(VirtMachineState *vms,
                               MemoryRegion *secure_sysmem)
 {
     MemoryRegion *secram = g_new(MemoryRegion, 1);
     char *nodename;
-    hwaddr base = vbi->memmap[VIRT_SECURE_MEM].base;
-    hwaddr size = vbi->memmap[VIRT_SECURE_MEM].size;
+    hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
+    hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
 
     memory_region_init_ram(secram, NULL, "virt.secure-ram", size, &error_fatal);
     vmstate_register_ram_global(secram);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
     nodename = g_strdup_printf("/secram@%" PRIx64, base);
-    qemu_fdt_add_subnode(vbi->fdt, nodename);
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "device_type", "memory");
-    qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "status", "disabled");
-    qemu_fdt_setprop_string(vbi->fdt, nodename, "secure-status", "okay");
+    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
+    qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
 
     g_free(nodename);
 }
@@ -1197,7 +1197,6 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    VirtMachineState *vbi = vms;
     VirtGuestInfoState *guest_info_state = g_malloc0(sizeof *guest_info_state);
     VirtGuestInfo *guest_info = &guest_info_state->info;
     char **cpustr;
@@ -1243,13 +1242,13 @@ static void machvirt_init(MachineState *machine)
      * let the boot ROM sort them out.
      * The usual case is that we do use QEMU's PSCI implementation.
      */
-    vbi->using_psci = !(vms->secure && firmware_loaded);
+    vms->using_psci = !(vms->secure && firmware_loaded);
 
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
      */
     if (gic_version == 3) {
-        virt_max_cpus = vbi->memmap[VIRT_GIC_REDIST].size / 0x20000;
+        virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
         clustersz = GICV3_TARGETLIST_BITS;
     } else {
         virt_max_cpus = GIC_NCPU;
@@ -1263,9 +1262,9 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    vbi->smp_cpus = smp_cpus;
+    vms->smp_cpus = smp_cpus;
 
-    if (machine->ram_size > vbi->memmap[VIRT_MEM].size) {
+    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
         error_report("mach-virt: cannot model more than %dGB RAM", RAMLIMIT_GB);
         exit(1);
     }
@@ -1287,7 +1286,7 @@ static void machvirt_init(MachineState *machine)
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
     }
 
-    create_fdt(vbi);
+    create_fdt(vms);
 
     oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
     if (!oc) {
@@ -1326,7 +1325,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
 
-        if (vbi->using_psci) {
+        if (vms->using_psci) {
             object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_HVC,
                                     "psci-conduit", NULL);
 
@@ -1342,7 +1341,7 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, vbi->memmap[VIRT_CPUPERIPHS].base,
+            object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
                                     "reset-cbar", &error_abort);
         }
 
@@ -1355,62 +1354,62 @@ static void machvirt_init(MachineState *machine)
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
     }
-    fdt_add_timer_nodes(vbi, gic_version);
-    fdt_add_cpu_nodes(vbi);
-    fdt_add_psci_node(vbi);
+    fdt_add_timer_nodes(vms, gic_version);
+    fdt_add_cpu_nodes(vms);
+    fdt_add_psci_node(vms);
 
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
-    memory_region_add_subregion(sysmem, vbi->memmap[VIRT_MEM].base, ram);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
 
-    create_flash(vbi, sysmem, secure_sysmem ? secure_sysmem : sysmem);
+    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
-    create_gic(vbi, pic, gic_version, vms->secure, vmc->no_its);
+    create_gic(vms, pic, gic_version, vms->secure, vmc->no_its);
 
-    fdt_add_pmu_nodes(vbi, gic_version);
+    fdt_add_pmu_nodes(vms, gic_version);
 
-    create_uart(vbi, pic, VIRT_UART, sysmem, serial_hds[0]);
+    create_uart(vms, pic, VIRT_UART, sysmem, serial_hds[0]);
 
     if (vms->secure) {
-        create_secure_ram(vbi, secure_sysmem);
-        create_uart(vbi, pic, VIRT_SECURE_UART, secure_sysmem, serial_hds[1]);
+        create_secure_ram(vms, secure_sysmem);
+        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hds[1]);
     }
 
-    create_rtc(vbi, pic);
+    create_rtc(vms, pic);
 
-    create_pcie(vbi, pic, vms->highmem);
+    create_pcie(vms, pic, vms->highmem);
 
-    create_gpio(vbi, pic);
+    create_gpio(vms, pic);
 
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
      */
-    create_virtio_devices(vbi, pic);
+    create_virtio_devices(vms, pic);
 
-    create_fw_cfg(vbi, &address_space_memory);
+    create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(fw_cfg_find());
 
     guest_info->smp_cpus = smp_cpus;
     guest_info->fw_cfg = fw_cfg_find();
-    guest_info->memmap = vbi->memmap;
-    guest_info->irqmap = vbi->irqmap;
+    guest_info->memmap = vms->memmap;
+    guest_info->irqmap = vms->irqmap;
     guest_info->use_highmem = vms->highmem;
     guest_info->gic_version = gic_version;
     guest_info->no_its = vmc->no_its;
     guest_info_state->machine_done.notify = virt_guest_info_machine_done;
     qemu_add_machine_init_done_notifier(&guest_info_state->machine_done);
 
-    vbi->bootinfo.ram_size = machine->ram_size;
-    vbi->bootinfo.kernel_filename = machine->kernel_filename;
-    vbi->bootinfo.kernel_cmdline = machine->kernel_cmdline;
-    vbi->bootinfo.initrd_filename = machine->initrd_filename;
-    vbi->bootinfo.nb_cpus = smp_cpus;
-    vbi->bootinfo.board_id = -1;
-    vbi->bootinfo.loader_start = vbi->memmap[VIRT_MEM].base;
-    vbi->bootinfo.get_dtb = machvirt_dtb;
-    vbi->bootinfo.firmware_loaded = firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), &vbi->bootinfo);
+    vms->bootinfo.ram_size = machine->ram_size;
+    vms->bootinfo.kernel_filename = machine->kernel_filename;
+    vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
+    vms->bootinfo.initrd_filename = machine->initrd_filename;
+    vms->bootinfo.nb_cpus = smp_cpus;
+    vms->bootinfo.board_id = -1;
+    vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
+    vms->bootinfo.get_dtb = machvirt_dtb;
+    vms->bootinfo.firmware_loaded = firmware_loaded;
+    arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
 
     /*
      * arm_load_kernel machine init done notifier registration must
@@ -1418,7 +1417,7 @@ static void machvirt_init(MachineState *machine)
      * another notifier is registered which adds platform bus nodes.
      * Notifiers are executed in registration reverse order.
      */
-    create_platform_bus(vbi, pic);
+    create_platform_bus(vms, pic);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
-- 
2.7.4
