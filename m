Received: from eggs.gnu.org ([2001:4830:134:3::10]:60167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8TZV-0005nw-7i
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8TZR-0004ce-5d
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:35:09 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 17 Apr 2018 18:34:05 +0200
Message-Id: <1523982845-249379-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180417011549.GF20551@umbus.fritz.box>
References: <20180417011549.GF20551@umbus.fritz.box>
Subject: [Qemu-devel] [PATCH] ppc: e500: switch E500 based machines to full
 machine definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "open list:e500" <qemu-ppc@nongnu.org>

Convert PPCE500Params to PCCE500MachineClass which it essentially is,
and introduce PCCE500MachineState to keep track of E500 specific
state instead of adding global variables or extra parameters to
functions when we need to keep data beyond machine init
(i.e. make it look like typical fully defined machine).

It's pretty shallow conversion instead of currently used trivial
DEFINE_MACHINE() macro. It adds extra 60LOC of boilerplate code
of full machine definition.

The patch on top[1] will use PCCE500MachineState to keep track of
platform_bus device and add E500Plate specific machine class
to use HOTPLUG_HANDLER for explicitly initializing dynamic
sysbus devices at the time they are added instead of delaying
it to machine done time by platform_bus_init_notify() which is
being removed.

 1)  <1523551221-11612-3-git-send-email-imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: David Gibson <david@gibson.dropbear.id.au>
---
tested only with make check.

CC: Alexander Graf <agraf@suse.de> (supporter:e500)
CC: David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
CC: qemu-ppc@nongnu.org (open list:e500)
---
 hw/ppc/e500.h      |  29 ++++++++++---
 hw/ppc/e500.c      | 119 ++++++++++++++++++++++++++++-------------------------
 hw/ppc/e500plat.c  |  64 +++++++++++++++++-----------
 hw/ppc/mpc8544ds.c |  47 +++++++++++++--------
 4 files changed, 156 insertions(+), 103 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 70ba1d8..621403b 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -3,12 +3,21 @@
 
 #include "hw/boards.h"
 
-typedef struct PPCE500Params {
-    int pci_first_slot;
-    int pci_nr_slots;
+typedef struct PPCE500MachineState {
+    /*< private >*/
+    MachineState parent_obj;
+
+} PPCE500MachineState;
+
+typedef struct PPCE500MachineClass {
+    /*< private >*/
+    MachineClass parent_class;
 
     /* required -- must at least add toplevel board compatible */
-    void (*fixup_devtree)(struct PPCE500Params *params, void *fdt);
+    void (*fixup_devtree)(void *fdt);
+
+    int pci_first_slot;
+    int pci_nr_slots;
 
     int mpic_version;
     bool has_mpc8xxx_gpio;
@@ -22,10 +31,18 @@ typedef struct PPCE500Params {
     hwaddr pci_mmio_base;
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
-} PPCE500Params;
+} PPCE500MachineClass;
 
-void ppce500_init(MachineState *machine, PPCE500Params *params);
+void ppce500_init(MachineState *machine);
 
 hwaddr booke206_page_size_to_tlb(uint64_t size);
 
+#define TYPE_PPCE500_MACHINE      "ppce500-base-machine"
+#define PPCE500_MACHINE(obj) \
+    OBJECT_CHECK(PPCE500MachineState, (obj), TYPE_PPCE500_MACHINE)
+#define PPCE500_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(PPCE500MachineClass, obj, TYPE_PPCE500_MACHINE)
+#define PPCE500_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(PPCE500MachineClass, klass, TYPE_PPCE500_MACHINE)
+
 #endif
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 9a85a41..30b42a8 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -221,14 +221,14 @@ static void sysbus_device_create_devtree(SysBusDevice *sbdev, void *opaque)
     }
 }
 
-static void platform_bus_create_devtree(PPCE500Params *params, void *fdt,
-                                        const char *mpic)
+static void platform_bus_create_devtree(const PPCE500MachineClass *pmc,
+                                        void *fdt, const char *mpic)
 {
-    gchar *node = g_strdup_printf("/platform@%"PRIx64, params->platform_bus_base);
+    gchar *node = g_strdup_printf("/platform@%"PRIx64, pmc->platform_bus_base);
     const char platcomp[] = "qemu,platform\0simple-bus";
-    uint64_t addr = params->platform_bus_base;
-    uint64_t size = params->platform_bus_size;
-    int irq_start = params->platform_bus_first_irq;
+    uint64_t addr = pmc->platform_bus_base;
+    uint64_t size = pmc->platform_bus_size;
+    int irq_start = pmc->platform_bus_first_irq;
     PlatformBusDevice *pbus;
     DeviceState *dev;
 
@@ -265,8 +265,7 @@ static void platform_bus_create_devtree(PPCE500Params *params, void *fdt,
     g_free(node);
 }
 
-static int ppce500_load_device_tree(MachineState *machine,
-                                    PPCE500Params *params,
+static int ppce500_load_device_tree(PPCE500MachineState *pms,
                                     hwaddr addr,
                                     hwaddr initrd_base,
                                     hwaddr initrd_size,
@@ -274,6 +273,8 @@ static int ppce500_load_device_tree(MachineState *machine,
                                     hwaddr kernel_size,
                                     bool dry_run)
 {
+    MachineState *machine = MACHINE(pms);
+    const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
     CPUPPCState *env = first_cpu->env_ptr;
     int ret = -1;
     uint64_t mem_reg_property[] = { 0, cpu_to_be64(machine->ram_size) };
@@ -295,12 +296,12 @@ static int ppce500_load_device_tree(MachineState *machine,
     int len;
     uint32_t pci_ranges[14] =
         {
-            0x2000000, 0x0, params->pci_mmio_bus_base,
-            params->pci_mmio_base >> 32, params->pci_mmio_base,
+            0x2000000, 0x0, pmc->pci_mmio_bus_base,
+            pmc->pci_mmio_base >> 32, pmc->pci_mmio_base,
             0x0, 0x20000000,
 
             0x1000000, 0x0, 0x0,
-            params->pci_pio_base >> 32, params->pci_pio_base,
+            pmc->pci_pio_base >> 32, pmc->pci_pio_base,
             0x0, 0x10000,
         };
     QemuOpts *machine_opts = qemu_get_machine_opts();
@@ -391,7 +392,7 @@ static int ppce500_load_device_tree(MachineState *machine,
     for (i = smp_cpus - 1; i >= 0; i--) {
         CPUState *cpu;
         char cpu_name[128];
-        uint64_t cpu_release_addr = params->spin_base + (i * 0x20);
+        uint64_t cpu_release_addr = pmc->spin_base + (i * 0x20);
 
         cpu = qemu_get_cpu(i);
         if (cpu == NULL) {
@@ -425,7 +426,7 @@ static int ppce500_load_device_tree(MachineState *machine,
 
     qemu_fdt_add_subnode(fdt, "/aliases");
     /* XXX These should go into their respective devices' code */
-    snprintf(soc, sizeof(soc), "/soc@%"PRIx64, params->ccsrbar_base);
+    snprintf(soc, sizeof(soc), "/soc@%"PRIx64, pmc->ccsrbar_base);
     qemu_fdt_add_subnode(fdt, soc);
     qemu_fdt_setprop_string(fdt, soc, "device_type", "soc");
     qemu_fdt_setprop(fdt, soc, "compatible", compatible_sb,
@@ -433,7 +434,7 @@ static int ppce500_load_device_tree(MachineState *machine,
     qemu_fdt_setprop_cell(fdt, soc, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, soc, "#size-cells", 1);
     qemu_fdt_setprop_cells(fdt, soc, "ranges", 0x0,
-                           params->ccsrbar_base >> 32, params->ccsrbar_base,
+                           pmc->ccsrbar_base >> 32, pmc->ccsrbar_base,
                            MPC8544_CCSRBAR_SIZE);
     /* XXX should contain a reasonable value */
     qemu_fdt_setprop_cell(fdt, soc, "bus-frequency", 0);
@@ -493,7 +494,7 @@ static int ppce500_load_device_tree(MachineState *machine,
     qemu_fdt_setprop_cell(fdt, msi, "linux,phandle", msi_ph);
 
     snprintf(pci, sizeof(pci), "/pci@%llx",
-             params->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
+             pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
     qemu_fdt_add_subnode(fdt, pci);
     qemu_fdt_setprop_cell(fdt, pci, "cell-index", 0);
     qemu_fdt_setprop_string(fdt, pci, "compatible", "fsl,mpc8540-pci");
@@ -501,7 +502,7 @@ static int ppce500_load_device_tree(MachineState *machine,
     qemu_fdt_setprop_cells(fdt, pci, "interrupt-map-mask", 0xf800, 0x0,
                            0x0, 0x7);
     pci_map = pci_map_create(fdt, qemu_fdt_get_phandle(fdt, mpic),
-                             params->pci_first_slot, params->pci_nr_slots,
+                             pmc->pci_first_slot, pmc->pci_nr_slots,
                              &len);
     qemu_fdt_setprop(fdt, pci, "interrupt-map", pci_map, len);
     qemu_fdt_setprop_phandle(fdt, pci, "interrupt-parent", mpic);
@@ -513,8 +514,8 @@ static int ppce500_load_device_tree(MachineState *machine,
     qemu_fdt_setprop_cell(fdt, pci, "fsl,msi", msi_ph);
     qemu_fdt_setprop(fdt, pci, "ranges", pci_ranges, sizeof(pci_ranges));
     qemu_fdt_setprop_cells(fdt, pci, "reg",
-                           (params->ccsrbar_base + MPC8544_PCI_REGS_OFFSET) >> 32,
-                           (params->ccsrbar_base + MPC8544_PCI_REGS_OFFSET),
+                           (pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET) >> 32,
+                           (pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET),
                            0, 0x1000);
     qemu_fdt_setprop_cell(fdt, pci, "clock-frequency", 66666666);
     qemu_fdt_setprop_cell(fdt, pci, "#interrupt-cells", 1);
@@ -522,15 +523,15 @@ static int ppce500_load_device_tree(MachineState *machine,
     qemu_fdt_setprop_cell(fdt, pci, "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/aliases", "pci0", pci);
 
-    if (params->has_mpc8xxx_gpio) {
+    if (pmc->has_mpc8xxx_gpio) {
         create_dt_mpc8xxx_gpio(fdt, soc, mpic);
     }
 
-    if (params->has_platform_bus) {
-        platform_bus_create_devtree(params, fdt, mpic);
+    if (pmc->has_platform_bus) {
+        platform_bus_create_devtree(pmc, fdt, mpic);
     }
 
-    params->fixup_devtree(params, fdt);
+    pmc->fixup_devtree(fdt);
 
     if (toplevel_compat) {
         qemu_fdt_setprop(fdt, "/", "compatible", toplevel_compat,
@@ -551,8 +552,7 @@ out:
 }
 
 typedef struct DeviceTreeParams {
-    MachineState *machine;
-    PPCE500Params params;
+    PPCE500MachineState *machine;
     hwaddr addr;
     hwaddr initrd_base;
     hwaddr initrd_size;
@@ -564,7 +564,7 @@ typedef struct DeviceTreeParams {
 static void ppce500_reset_device_tree(void *opaque)
 {
     DeviceTreeParams *p = opaque;
-    ppce500_load_device_tree(p->machine, &p->params, p->addr, p->initrd_base,
+    ppce500_load_device_tree(p->machine, p->addr, p->initrd_base,
                              p->initrd_size, p->kernel_base, p->kernel_size,
                              false);
 }
@@ -575,8 +575,7 @@ static void ppce500_init_notify(Notifier *notifier, void *data)
     ppce500_reset_device_tree(p);
 }
 
-static int ppce500_prep_device_tree(MachineState *machine,
-                                    PPCE500Params *params,
+static int ppce500_prep_device_tree(PPCE500MachineState *machine,
                                     hwaddr addr,
                                     hwaddr initrd_base,
                                     hwaddr initrd_size,
@@ -585,7 +584,6 @@ static int ppce500_prep_device_tree(MachineState *machine,
 {
     DeviceTreeParams *p = g_new(DeviceTreeParams, 1);
     p->machine = machine;
-    p->params = *params;
     p->addr = addr;
     p->initrd_base = initrd_base;
     p->initrd_size = initrd_size;
@@ -597,9 +595,8 @@ static int ppce500_prep_device_tree(MachineState *machine,
     qemu_add_machine_init_done_notifier(&p->notifier);
 
     /* Issue the device tree loader once, so that we get the size of the blob */
-    return ppce500_load_device_tree(machine, params, addr, initrd_base,
-                                    initrd_size, kernel_base, kernel_size,
-                                    true);
+    return ppce500_load_device_tree(machine, addr, initrd_base, initrd_size,
+                                    kernel_base, kernel_size, true);
 }
 
 /* Create -kernel TLB entries for BookE.  */
@@ -685,17 +682,19 @@ static void ppce500_cpu_reset(void *opaque)
     mmubooke_create_initial_mapping(env);
 }
 
-static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
+static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
                                            qemu_irq **irqs)
 {
     DeviceState *dev;
     SysBusDevice *s;
     int i, j, k;
+    MachineState *machine = MACHINE(pms);
+    const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
 
     dev = qdev_create(NULL, TYPE_OPENPIC);
-    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
+    object_property_add_child(OBJECT(machine), "pic", OBJECT(dev),
                               &error_fatal);
-    qdev_prop_set_uint32(dev, "model", params->mpic_version);
+    qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
     qdev_init_nofail(dev);
@@ -711,7 +710,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
     return dev;
 }
 
-static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
+static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
                                           qemu_irq **irqs, Error **errp)
 {
     Error *err = NULL;
@@ -719,7 +718,7 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
     CPUState *cs;
 
     dev = qdev_create(NULL, TYPE_KVM_OPENPIC);
-    qdev_prop_set_uint32(dev, "model", params->mpic_version);
+    qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
@@ -739,11 +738,12 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
     return dev;
 }
 
-static DeviceState *ppce500_init_mpic(MachineState *machine,
-                                      PPCE500Params *params,
+static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
                                       MemoryRegion *ccsr,
                                       qemu_irq **irqs)
 {
+    MachineState *machine = MACHINE(pms);
+    const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
     DeviceState *dev = NULL;
     SysBusDevice *s;
 
@@ -751,7 +751,7 @@ static DeviceState *ppce500_init_mpic(MachineState *machine,
         Error *err = NULL;
 
         if (machine_kernel_irqchip_allowed(machine)) {
-            dev = ppce500_init_mpic_kvm(params, irqs, &err);
+            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
         }
         if (machine_kernel_irqchip_required(machine) && !dev) {
             error_reportf_err(err,
@@ -761,7 +761,7 @@ static DeviceState *ppce500_init_mpic(MachineState *machine,
     }
 
     if (!dev) {
-        dev = ppce500_init_mpic_qemu(params, irqs);
+        dev = ppce500_init_mpic_qemu(pms, irqs);
     }
 
     s = SYS_BUS_DEVICE(dev);
@@ -778,10 +778,12 @@ static void ppce500_power_off(void *opaque, int line, int on)
     }
 }
 
-void ppce500_init(MachineState *machine, PPCE500Params *params)
+void ppce500_init(MachineState *machine)
 {
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
+    PPCE500MachineState *pms = PPCE500_MACHINE(machine);
+    const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
     PCIBus *pci_bus;
     CPUPPCState *env = NULL;
     uint64_t loadaddr;
@@ -835,8 +837,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         irqs[i][OPENPIC_OUTPUT_INT] = input[PPCE500_INPUT_INT];
         irqs[i][OPENPIC_OUTPUT_CINT] = input[PPCE500_INPUT_CINT];
         env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
-        env->mpic_iack = params->ccsrbar_base +
-                         MPC8544_MPIC_REGS_OFFSET + 0xa0;
+        env->mpic_iack = pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET + 0xa0;
 
         ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
 
@@ -869,10 +870,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     qdev_init_nofail(dev);
     ccsr = CCSR(dev);
     ccsr_addr_space = &ccsr->ccsr_space;
-    memory_region_add_subregion(address_space_mem, params->ccsrbar_base,
+    memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
-    mpicdev = ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
+    mpicdev = ppce500_init_mpic(pms, ccsr_addr_space, irqs);
 
     /* Serial */
     if (serial_hds[0]) {
@@ -898,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     dev = qdev_create(NULL, "e500-pcihost");
     object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev),
                               &error_abort);
-    qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
+    qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
@@ -921,9 +922,9 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     }
 
     /* Register spinning region */
-    sysbus_create_simple("e500-spin", params->spin_base, NULL);
+    sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
 
-    if (params->has_mpc8xxx_gpio) {
+    if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
 
         dev = qdev_create(NULL, "mpc8xxx_gpio");
@@ -939,21 +940,21 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     }
 
     /* Platform Bus Device */
-    if (params->has_platform_bus) {
+    if (pmc->has_platform_bus) {
         dev = qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
         dev->id = TYPE_PLATFORM_BUS_DEVICE;
-        qdev_prop_set_uint32(dev, "num_irqs", params->platform_bus_num_irqs);
-        qdev_prop_set_uint32(dev, "mmio_size", params->platform_bus_size);
+        qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
+        qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
         qdev_init_nofail(dev);
         s = SYS_BUS_DEVICE(dev);
 
-        for (i = 0; i < params->platform_bus_num_irqs; i++) {
-            int irqn = params->platform_bus_first_irq + i;
+        for (i = 0; i < pmc->platform_bus_num_irqs; i++) {
+            int irqn = pmc->platform_bus_first_irq + i;
             sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
         }
 
         memory_region_add_subregion(address_space_mem,
-                                    params->platform_bus_base,
+                                    pmc->platform_bus_base,
                                     sysbus_mmio_get_region(s, 0));
     }
 
@@ -1056,7 +1057,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
             exit(1);
     }
 
-    dt_size = ppce500_prep_device_tree(machine, params, dt_base,
+    dt_size = ppce500_prep_device_tree(pms, dt_base,
                                        initrd_base, initrd_size,
                                        kernel_base, kernel_size);
     if (dt_size < 0) {
@@ -1085,9 +1086,17 @@ static const TypeInfo e500_ccsr_info = {
     .instance_init = e500_ccsr_initfn,
 };
 
+static const TypeInfo ppce500_info = {
+    .name          = TYPE_PPCE500_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .abstract      = true,
+    .class_size    = sizeof(PPCE500MachineClass),
+};
+
 static void e500_register_types(void)
 {
     type_register_static(&e500_ccsr_info);
+    type_register_static(&ppce500_info);
 }
 
 type_init(e500_register_types)
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 81d03e1..f69aadb 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -21,7 +21,7 @@
 #include "hw/ppc/openpic.h"
 #include "kvm_ppc.h"
 
-static void e500plat_fixup_devtree(PPCE500Params *params, void *fdt)
+static void e500plat_fixup_devtree(void *fdt)
 {
     const char model[] = "QEMU ppce500";
     const char compatible[] = "fsl,qemu-e500";
@@ -33,40 +33,54 @@ static void e500plat_fixup_devtree(PPCE500Params *params, void *fdt)
 
 static void e500plat_init(MachineState *machine)
 {
-    PPCE500Params params = {
-        .pci_first_slot = 0x1,
-        .pci_nr_slots = PCI_SLOT_MAX - 1,
-        .fixup_devtree = e500plat_fixup_devtree,
-        .mpic_version = OPENPIC_MODEL_FSL_MPIC_42,
-        .has_mpc8xxx_gpio = true,
-        .has_platform_bus = true,
-        .platform_bus_base = 0xf00000000ULL,
-        .platform_bus_size = (128ULL * 1024 * 1024),
-        .platform_bus_first_irq = 5,
-        .platform_bus_num_irqs = 10,
-        .ccsrbar_base = 0xFE0000000ULL,
-        .pci_pio_base = 0xFE1000000ULL,
-        .pci_mmio_base = 0xC00000000ULL,
-        .pci_mmio_bus_base = 0xE0000000ULL,
-        .spin_base = 0xFEF000000ULL,
-    };
-
+    PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
     /* Older KVM versions don't support EPR which breaks guests when we announce
        MPIC variants that support EPR. Revert to an older one for those */
     if (kvm_enabled() && !kvmppc_has_cap_epr()) {
-        params.mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
+        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
     }
 
-    ppce500_init(machine, &params);
+    ppce500_init(machine);
 }
 
-static void e500plat_machine_init(MachineClass *mc)
+#define TYPE_E500PLAT_MACHINE  MACHINE_TYPE_NAME("ppce500")
+
+static void e500plat_machine_class_init(ObjectClass *oc, void *data)
 {
+    PPCE500MachineClass *pmc = PPCE500_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pmc->pci_first_slot = 0x1;
+    pmc->pci_nr_slots = PCI_SLOT_MAX - 1;
+    pmc->fixup_devtree = e500plat_fixup_devtree;
+    pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_42;
+    pmc->has_mpc8xxx_gpio = true;
+    pmc->has_platform_bus = true;
+    pmc->platform_bus_base = 0xf00000000ULL;
+    pmc->platform_bus_size = (128ULL * 1024 * 1024);
+    pmc->platform_bus_first_irq = 5;
+    pmc->platform_bus_num_irqs = 10;
+    pmc->ccsrbar_base = 0xFE0000000ULL;
+    pmc->pci_pio_base = 0xFE1000000ULL;
+    pmc->pci_mmio_base = 0xC00000000ULL;
+    pmc->pci_mmio_bus_base = 0xE0000000ULL;
+    pmc->spin_base = 0xFEF000000ULL;
+
     mc->desc = "generic paravirt e500 platform";
     mc->init = e500plat_init;
     mc->max_cpus = 32;
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
-}
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
+ }
+
+static const TypeInfo e500plat_info = {
+    .name          = TYPE_E500PLAT_MACHINE,
+    .parent        = TYPE_PPCE500_MACHINE,
+    .class_init    = e500plat_machine_class_init,
+};
 
-DEFINE_MACHINE("ppce500", e500plat_machine_init)
+static void e500plat_register_types(void)
+{
+    type_register_static(&e500plat_info);
+}
+type_init(e500plat_register_types)
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 1717953..ab30a2a 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 
-static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
+static void mpc8544ds_fixup_devtree(void *fdt)
 {
     const char model[] = "MPC8544DS";
     const char compatible[] = "MPC8544DS\0MPC85xxDS";
@@ -30,33 +30,46 @@ static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
 
 static void mpc8544ds_init(MachineState *machine)
 {
-    PPCE500Params params = {
-        .pci_first_slot = 0x11,
-        .pci_nr_slots = 2,
-        .fixup_devtree = mpc8544ds_fixup_devtree,
-        .mpic_version = OPENPIC_MODEL_FSL_MPIC_20,
-        .ccsrbar_base = 0xE0000000ULL,
-        .pci_mmio_base = 0xC0000000ULL,
-        .pci_mmio_bus_base = 0xC0000000ULL,
-        .pci_pio_base = 0xE1000000ULL,
-        .spin_base = 0xEF000000ULL,
-    };
-
     if (machine->ram_size > 0xc0000000) {
         error_report("The MPC8544DS board only supports up to 3GB of RAM");
         exit(1);
     }
 
-    ppce500_init(machine, &params);
+    ppce500_init(machine);
 }
 
-
-static void ppce500_machine_init(MachineClass *mc)
+static void e500plat_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PPCE500MachineClass *pmc = PPCE500_MACHINE_CLASS(oc);
+
+    pmc->pci_first_slot = 0x11;
+    pmc->pci_nr_slots = 2;
+    pmc->fixup_devtree = mpc8544ds_fixup_devtree;
+    pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
+    pmc->ccsrbar_base = 0xE0000000ULL;
+    pmc->pci_mmio_base = 0xC0000000ULL;
+    pmc->pci_mmio_bus_base = 0xC0000000ULL;
+    pmc->pci_pio_base = 0xE1000000ULL;
+    pmc->spin_base = 0xEF000000ULL;
+
     mc->desc = "mpc8544ds";
     mc->init = mpc8544ds_init;
     mc->max_cpus = 15;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
 }
 
-DEFINE_MACHINE("mpc8544ds", ppce500_machine_init)
+#define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
+
+static const TypeInfo mpc8544ds_info = {
+    .name          = TYPE_MPC8544DS_MACHINE,
+    .parent        = TYPE_PPCE500_MACHINE,
+    .class_init    = e500plat_machine_class_init,
+};
+
+static void mpc8544ds_register_types(void)
+{
+    type_register_static(&mpc8544ds_info);
+}
+
+type_init(mpc8544ds_register_types)
-- 
2.7.4
