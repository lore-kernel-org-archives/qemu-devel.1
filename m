Received: from eggs.gnu.org ([2001:4830:134:3::10]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutG-0002SA-Ok
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutD-0007W3-Gk
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:38 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:13 +0100
Message-Id: <20161213214522.25548-3-drjones@redhat.com>
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 02/11] hw/arm/virt: use
 VirtMachineState.gic_version
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

machvirt_init may need to probe for the gic version. If so, then
make sure the result is written to VirtMachineState. With the
state up to date, use it instead of a local variable. This is a
cleanup that prepares for VirtMachineState to be passed to functions
even outside hw/arm/virt.c

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d451bc4f6b9b..67c0abb30b5b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -319,7 +319,7 @@ static void fdt_add_psci_node(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
-static void fdt_add_timer_nodes(const VirtMachineState *vms, int gictype)
+static void fdt_add_timer_nodes(const VirtMachineState *vms)
 {
     /* On real hardware these interrupts are level-triggered.
      * On KVM they were edge-triggered before host kernel version 4.4,
@@ -347,7 +347,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms, int gictype)
         irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
     }
 
-    if (gictype == 2) {
+    if (vms->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -462,7 +462,7 @@ static void fdt_add_v2m_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, "/intc/v2m", "phandle", vms->msi_phandle);
 }
 
-static void fdt_add_gic_node(VirtMachineState *vms, int type)
+static void fdt_add_gic_node(VirtMachineState *vms)
 {
     vms->gic_phandle = qemu_fdt_alloc_phandle(vms->fdt);
     qemu_fdt_setprop_cell(vms->fdt, "/", "interrupt-parent", vms->gic_phandle);
@@ -473,7 +473,7 @@ static void fdt_add_gic_node(VirtMachineState *vms, int type)
     qemu_fdt_setprop_cell(vms->fdt, "/intc", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(vms->fdt, "/intc", "#size-cells", 0x2);
     qemu_fdt_setprop(vms->fdt, "/intc", "ranges", NULL, 0);
-    if (type == 3) {
+    if (vms->gic_version == 3) {
         qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
                                 "arm,gic-v3");
         qemu_fdt_setprop_sized_cells(vms->fdt, "/intc", "reg",
@@ -500,7 +500,7 @@ static void fdt_add_gic_node(VirtMachineState *vms, int type)
     qemu_fdt_setprop_cell(vms->fdt, "/intc", "phandle", vms->gic_phandle);
 }
 
-static void fdt_add_pmu_nodes(const VirtMachineState *vms, int gictype)
+static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 {
     CPUState *cpu;
     ARMCPU *armcpu;
@@ -514,7 +514,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms, int gictype)
         }
     }
 
-    if (gictype == 2) {
+    if (vms->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -570,14 +570,14 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
     fdt_add_v2m_gic_node(vms);
 }
 
-static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type)
+static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 {
     /* We create a standalone GIC */
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
-    int i;
+    int type = vms->gic_version, i;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
@@ -641,7 +641,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type)
         pic[i] = qdev_get_gpio_in(gicdev, i);
     }
 
-    fdt_add_gic_node(vms, type);
+    fdt_add_gic_node(vms);
 
     if (type == 3 && !vmc->no_its) {
         create_its(vms, gicdev);
@@ -1237,7 +1237,6 @@ static void machvirt_init(MachineState *machine)
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
-    int gic_version = vms->gic_version;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
@@ -1258,14 +1257,14 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (!gic_version) {
+    if (!vms->gic_version) {
         if (!kvm_enabled()) {
             error_report("gic-version=host requires KVM");
             exit(1);
         }
 
-        gic_version = kvm_arm_vgic_probe();
-        if (!gic_version) {
+        vms->gic_version = kvm_arm_vgic_probe();
+        if (!vms->gic_version) {
             error_report("Unable to determine GIC version supported by host");
             exit(1);
         }
@@ -1300,7 +1299,7 @@ static void machvirt_init(MachineState *machine)
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
      */
-    if (gic_version == 3) {
+    if (vms->gic_version == 3) {
         virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
         clustersz = GICV3_TARGETLIST_BITS;
     } else {
@@ -1417,7 +1416,7 @@ static void machvirt_init(MachineState *machine)
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
     }
-    fdt_add_timer_nodes(vms, gic_version);
+    fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
     fdt_add_psci_node(vms);
 
@@ -1427,9 +1426,9 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
-    create_gic(vms, pic, gic_version);
+    create_gic(vms, pic);
 
-    fdt_add_pmu_nodes(vms, gic_version);
+    fdt_add_pmu_nodes(vms);
 
     create_uart(vms, pic, VIRT_UART, sysmem, serial_hds[0]);
 
@@ -1458,7 +1457,7 @@ static void machvirt_init(MachineState *machine)
     guest_info->memmap = vms->memmap;
     guest_info->irqmap = vms->irqmap;
     guest_info->use_highmem = vms->highmem;
-    guest_info->gic_version = gic_version;
+    guest_info->gic_version = vms->gic_version;
     guest_info->no_its = vmc->no_its;
     guest_info_state->machine_done.notify = virt_guest_info_machine_done;
     qemu_add_machine_init_done_notifier(&guest_info_state->machine_done);
-- 
2.9.3
