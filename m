Received: from eggs.gnu.org ([2001:4830:134:3::10]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWa-0002XX-3H
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWY-0004Ci-7m
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWX-00043I-Uf
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:02 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWJ-0001Ma-1L
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:26 +0000
Message-Id: <1483962824-29185-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/21] hw/arm/virt: Merge VirtBoardInfo and
 VirtMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

One of the purposes of VirtBoardInfo was to hold various
bits of state about the board. Now we have MachineState
and the subclass VirtMachineState to do this. Fold the
VirtBoardInfo into VirtMachineState rather than having
some flags in one struct and some in another with no
useful way to get between them.

In the process we drop the code for looking up the
memory map and irq map from the CPU model, because
in practice we always use the same maps in all cases.

For easier code review, this change removes the
VirtBoardInfo type but leaves all the variables which
used to be VirtBoardInfo* and are now VirtMachineState*
with their now-confusing 'vbi' names.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 118 +++++++++++++++++++++++++---------------------------------
 1 file changed, 51 insertions(+), 67 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 11c53a5..fd4eed9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -66,23 +66,8 @@
 
 static ARMPlatformBusSystemParams platform_bus_params;
 
-typedef struct VirtBoardInfo {
-    struct arm_boot_info bootinfo;
-    const char *cpu_model;
-    const MemMapEntry *memmap;
-    const int *irqmap;
-    int smp_cpus;
-    void *fdt;
-    int fdt_size;
-    uint32_t clock_phandle;
-    uint32_t gic_phandle;
-    uint32_t msi_phandle;
-    bool using_psci;
-} VirtBoardInfo;
-
 typedef struct {
     MachineClass parent;
-    VirtBoardInfo *daughterboard;
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
@@ -93,6 +78,16 @@ typedef struct {
     bool secure;
     bool highmem;
     int32_t gic_version;
+    struct arm_boot_info bootinfo;
+    const MemMapEntry *memmap;
+    const int *irqmap;
+    int smp_cpus;
+    void *fdt;
+    int fdt_size;
+    uint32_t clock_phandle;
+    uint32_t gic_phandle;
+    uint32_t msi_phandle;
+    bool using_psci;
 } VirtMachineState;
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
@@ -202,42 +197,27 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
-static VirtBoardInfo machines[] = {
-    {
-        .cpu_model = "cortex-a15",
-        .memmap = a15memmap,
-        .irqmap = a15irqmap,
-    },
-    {
-        .cpu_model = "cortex-a53",
-        .memmap = a15memmap,
-        .irqmap = a15irqmap,
-    },
-    {
-        .cpu_model = "cortex-a57",
-        .memmap = a15memmap,
-        .irqmap = a15irqmap,
-    },
-    {
-        .cpu_model = "host",
-        .memmap = a15memmap,
-        .irqmap = a15irqmap,
-    },
+static const char *valid_cpus[] = {
+    "cortex-a15",
+    "cortex-a53",
+    "cortex-a57",
+    "host",
+    NULL
 };
 
-static VirtBoardInfo *find_machine_info(const char *cpu)
+static bool cpuname_valid(const char *cpu)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(machines); i++) {
-        if (strcmp(cpu, machines[i].cpu_model) == 0) {
-            return &machines[i];
+    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
+        if (strcmp(cpu, valid_cpus[i]) == 0) {
+            return true;
         }
     }
-    return NULL;
+    return false;
 }
 
-static void create_fdt(VirtBoardInfo *vbi)
+static void create_fdt(VirtMachineState *vbi)
 {
     void *fdt = create_device_tree(&vbi->fdt_size);
 
@@ -277,7 +257,7 @@ static void create_fdt(VirtBoardInfo *vbi)
 
 }
 
-static void fdt_add_psci_node(const VirtBoardInfo *vbi)
+static void fdt_add_psci_node(const VirtMachineState *vbi)
 {
     uint32_t cpu_suspend_fn;
     uint32_t cpu_off_fn;
@@ -327,7 +307,7 @@ static void fdt_add_psci_node(const VirtBoardInfo *vbi)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
-static void fdt_add_timer_nodes(const VirtBoardInfo *vbi, int gictype)
+static void fdt_add_timer_nodes(const VirtMachineState *vbi, int gictype)
 {
     /* Note that on A15 h/w these interrupts are level-triggered,
      * but for the GIC implementation provided by both QEMU and KVM
@@ -361,7 +341,7 @@ static void fdt_add_timer_nodes(const VirtBoardInfo *vbi, int gictype)
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
 }
 
-static void fdt_add_cpu_nodes(const VirtBoardInfo *vbi)
+static void fdt_add_cpu_nodes(const VirtMachineState *vbi)
 {
     int cpu;
     int addr_cells = 1;
@@ -424,7 +404,7 @@ static void fdt_add_cpu_nodes(const VirtBoardInfo *vbi)
     }
 }
 
-static void fdt_add_its_gic_node(VirtBoardInfo *vbi)
+static void fdt_add_its_gic_node(VirtMachineState *vbi)
 {
     vbi->msi_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
     qemu_fdt_add_subnode(vbi->fdt, "/intc/its");
@@ -437,7 +417,7 @@ static void fdt_add_its_gic_node(VirtBoardInfo *vbi)
     qemu_fdt_setprop_cell(vbi->fdt, "/intc/its", "phandle", vbi->msi_phandle);
 }
 
-static void fdt_add_v2m_gic_node(VirtBoardInfo *vbi)
+static void fdt_add_v2m_gic_node(VirtMachineState *vbi)
 {
     vbi->msi_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
     qemu_fdt_add_subnode(vbi->fdt, "/intc/v2m");
@@ -450,7 +430,7 @@ static void fdt_add_v2m_gic_node(VirtBoardInfo *vbi)
     qemu_fdt_setprop_cell(vbi->fdt, "/intc/v2m", "phandle", vbi->msi_phandle);
 }
 
-static void fdt_add_gic_node(VirtBoardInfo *vbi, int type)
+static void fdt_add_gic_node(VirtMachineState *vbi, int type)
 {
     vbi->gic_phandle = qemu_fdt_alloc_phandle(vbi->fdt);
     qemu_fdt_setprop_cell(vbi->fdt, "/", "interrupt-parent", vbi->gic_phandle);
@@ -483,7 +463,7 @@ static void fdt_add_gic_node(VirtBoardInfo *vbi, int type)
     qemu_fdt_setprop_cell(vbi->fdt, "/intc", "phandle", vbi->gic_phandle);
 }
 
-static void fdt_add_pmu_nodes(const VirtBoardInfo *vbi, int gictype)
+static void fdt_add_pmu_nodes(const VirtMachineState *vbi, int gictype)
 {
     CPUState *cpu;
     ARMCPU *armcpu;
@@ -514,7 +494,7 @@ static void fdt_add_pmu_nodes(const VirtBoardInfo *vbi, int gictype)
     }
 }
 
-static void create_its(VirtBoardInfo *vbi, DeviceState *gicdev)
+static void create_its(VirtMachineState *vbi, DeviceState *gicdev)
 {
     const char *itsclass = its_class_name();
     DeviceState *dev;
@@ -534,7 +514,7 @@ static void create_its(VirtBoardInfo *vbi, DeviceState *gicdev)
     fdt_add_its_gic_node(vbi);
 }
 
-static void create_v2m(VirtBoardInfo *vbi, qemu_irq *pic)
+static void create_v2m(VirtMachineState *vbi, qemu_irq *pic)
 {
     int i;
     int irq = vbi->irqmap[VIRT_GIC_V2M];
@@ -553,7 +533,7 @@ static void create_v2m(VirtBoardInfo *vbi, qemu_irq *pic)
     fdt_add_v2m_gic_node(vbi);
 }
 
-static void create_gic(VirtBoardInfo *vbi, qemu_irq *pic, int type,
+static void create_gic(VirtMachineState *vbi, qemu_irq *pic, int type,
                        bool secure, bool no_its)
 {
     /* We create a standalone GIC */
@@ -625,7 +605,7 @@ static void create_gic(VirtBoardInfo *vbi, qemu_irq *pic, int type,
     }
 }
 
-static void create_uart(const VirtBoardInfo *vbi, qemu_irq *pic, int uart,
+static void create_uart(const VirtMachineState *vbi, qemu_irq *pic, int uart,
                         MemoryRegion *mem, CharDriverState *chr)
 {
     char *nodename;
@@ -669,7 +649,7 @@ static void create_uart(const VirtBoardInfo *vbi, qemu_irq *pic, int uart,
     g_free(nodename);
 }
 
-static void create_rtc(const VirtBoardInfo *vbi, qemu_irq *pic)
+static void create_rtc(const VirtMachineState *vbi, qemu_irq *pic)
 {
     char *nodename;
     hwaddr base = vbi->memmap[VIRT_RTC].base;
@@ -703,7 +683,7 @@ static Notifier virt_system_powerdown_notifier = {
     .notify = virt_powerdown_req
 };
 
-static void create_gpio(const VirtBoardInfo *vbi, qemu_irq *pic)
+static void create_gpio(const VirtMachineState *vbi, qemu_irq *pic)
 {
     char *nodename;
     DeviceState *pl061_dev;
@@ -750,7 +730,7 @@ static void create_gpio(const VirtBoardInfo *vbi, qemu_irq *pic)
     g_free(nodename);
 }
 
-static void create_virtio_devices(const VirtBoardInfo *vbi, qemu_irq *pic)
+static void create_virtio_devices(const VirtMachineState *vbi, qemu_irq *pic)
 {
     int i;
     hwaddr size = vbi->memmap[VIRT_MMIO].size;
@@ -870,7 +850,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     }
 }
 
-static void create_flash(const VirtBoardInfo *vbi,
+static void create_flash(const VirtMachineState *vbi,
                          MemoryRegion *sysmem,
                          MemoryRegion *secure_sysmem)
 {
@@ -925,7 +905,7 @@ static void create_flash(const VirtBoardInfo *vbi,
     }
 }
 
-static void create_fw_cfg(const VirtBoardInfo *vbi, AddressSpace *as)
+static void create_fw_cfg(const VirtMachineState *vbi, AddressSpace *as)
 {
     hwaddr base = vbi->memmap[VIRT_FW_CFG].base;
     hwaddr size = vbi->memmap[VIRT_FW_CFG].size;
@@ -944,7 +924,8 @@ static void create_fw_cfg(const VirtBoardInfo *vbi, AddressSpace *as)
     g_free(nodename);
 }
 
-static void create_pcie_irq_map(const VirtBoardInfo *vbi, uint32_t gic_phandle,
+static void create_pcie_irq_map(const VirtMachineState *vbi,
+                                uint32_t gic_phandle,
                                 int first_irq, const char *nodename)
 {
     int devfn, pin;
@@ -979,7 +960,7 @@ static void create_pcie_irq_map(const VirtBoardInfo *vbi, uint32_t gic_phandle,
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtBoardInfo *vbi, qemu_irq *pic,
+static void create_pcie(const VirtMachineState *vbi, qemu_irq *pic,
                         bool use_highmem)
 {
     hwaddr base_mmio = vbi->memmap[VIRT_PCIE_MMIO].base;
@@ -1095,7 +1076,7 @@ static void create_pcie(const VirtBoardInfo *vbi, qemu_irq *pic,
     g_free(nodename);
 }
 
-static void create_platform_bus(VirtBoardInfo *vbi, qemu_irq *pic)
+static void create_platform_bus(VirtMachineState *vbi, qemu_irq *pic)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -1136,7 +1117,8 @@ static void create_platform_bus(VirtBoardInfo *vbi, qemu_irq *pic)
                                 sysbus_mmio_get_region(s, 0));
 }
 
-static void create_secure_ram(VirtBoardInfo *vbi, MemoryRegion *secure_sysmem)
+static void create_secure_ram(VirtMachineState *vbi,
+                              MemoryRegion *secure_sysmem)
 {
     MemoryRegion *secram = g_new(MemoryRegion, 1);
     char *nodename;
@@ -1159,7 +1141,8 @@ static void create_secure_ram(VirtBoardInfo *vbi, MemoryRegion *secure_sysmem)
 
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
-    const VirtBoardInfo *board = (const VirtBoardInfo *)binfo;
+    const VirtMachineState *board = container_of(binfo, VirtMachineState,
+                                                 bootinfo);
 
     *fdt_size = board->fdt_size;
     return board->fdt;
@@ -1214,7 +1197,7 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    VirtBoardInfo *vbi;
+    VirtMachineState *vbi = vms;
     VirtGuestInfoState *guest_info_state = g_malloc0(sizeof *guest_info_state);
     VirtGuestInfo *guest_info = &guest_info_state->info;
     char **cpustr;
@@ -1248,9 +1231,7 @@ static void machvirt_init(MachineState *machine)
     /* Separate the actual CPU model name from any appended features */
     cpustr = g_strsplit(cpu_model, ",", 2);
 
-    vbi = find_machine_info(cpustr[0]);
-
-    if (!vbi) {
+    if (!cpuname_valid(cpustr[0])) {
         error_report("mach-virt: CPU %s not supported", cpustr[0]);
         exit(1);
     }
@@ -1556,6 +1537,9 @@ static void virt_2_9_instance_init(Object *obj)
     object_property_set_description(obj, "gic-version",
                                     "Set GIC version. "
                                     "Valid values are 2, 3 and host", NULL);
+
+    vms->memmap = a15memmap;
+    vms->irqmap = a15irqmap;
 }
 
 static void virt_machine_2_9_options(MachineClass *mc)
-- 
2.7.4
