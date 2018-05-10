Received: from eggs.gnu.org ([2001:4830:134:3::10]:48466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdA-00050W-Rb
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd8-0000pc-5O
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd6-0000nR-Ty
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd5-0003Uu-UT
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:03 +0100
Message-Id: <20180510174519.11264-6-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/21] arm/boot: split load_dtb() from
 arm_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

load_dtb() depends on arm_load_kernel() to figure out place
in RAM where it should be loaded, but it's not required for
arm_load_kernel() to work. Sometimes it's neccesary for
devices added with -device/device_add to be enumerated in
DTB as well, which's lead to [1] and surrounding commits to
add 2 more machine_done notifiers with non obvious ordering
to make dynamic sysbus devices initialization happen in
the right order.

However instead of moving whole arm_load_kernel() in to
machine_done, it's sufficient to move only load_dtb() into
virt_machine_done() notifier and remove ArmLoadKernelNotifier/
/PlatformBusFDTNotifierParams notifiers, which saves us ~90LOC
and simplifies code flow quite a bit.
Later would allow to consolidate DTB generation within one
function for 'mach-virt' board and make it reentrant so it
could generate updated DTB in device hotplug secenarios.

While at it rename load_dtb() to arm_load_dtb() since it's
public now.

Add additional field skip_dtb_autoload to struct arm_boot_info
to allow manual DTB load later in mach-virt and to avoid touching
all other boards to explicitly call arm_load_dtb().

 1) (ac9d32e hw/arm/boot: arm_load_kernel implemented as a machine init done notifier)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1525691524-32265-4-git-send-email-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/arm.h        | 45 +++++++++++++++++------
 include/hw/arm/sysbus-fdt.h | 37 ++++---------------
 hw/arm/boot.c               | 72 ++++++++++---------------------------
 hw/arm/sysbus-fdt.c         | 61 +++----------------------------
 hw/arm/virt.c               | 64 ++++++++++++++++-----------------
 5 files changed, 94 insertions(+), 185 deletions(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ce769bde6a..70fa2287e2 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -39,15 +39,6 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
  */
 void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
 
-/*
- * struct used as a parameter of the arm_load_kernel machine init
- * done notifier
- */
-typedef struct {
-    Notifier notifier; /* actual notifier */
-    ARMCPU *cpu; /* handle to the first cpu object */
-} ArmLoadKernelNotifier;
-
 /* arm_boot.c */
 struct arm_boot_info {
     uint64_t ram_size;
@@ -56,6 +47,13 @@ struct arm_boot_info {
     const char *initrd_filename;
     const char *dtb_filename;
     hwaddr loader_start;
+    hwaddr dtb_start;
+    hwaddr dtb_limit;
+    /* If set to True, arm_load_kernel() will not load DTB.
+     * It allows board to load DTB manually later.
+     * (default: False)
+     */
+    bool skip_dtb_autoload;
     /* multicore boards that use the default secondary core boot functions
      * need to put the address of the secondary boot code, the boot reg,
      * and the GIC address in the next 3 values, respectively. boards that
@@ -94,8 +92,6 @@ struct arm_boot_info {
      * the user it should implement this hook.
      */
     void (*modify_dtb)(const struct arm_boot_info *info, void *fdt);
-    /* machine init done notifier executing arm_load_dtb */
-    ArmLoadKernelNotifier load_kernel_notifier;
     /* Used internally by arm_boot.c */
     int is_linux;
     hwaddr initrd_start;
@@ -143,6 +139,33 @@ struct arm_boot_info {
  */
 void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info);
 
+AddressSpace *arm_boot_address_space(ARMCPU *cpu,
+                                     const struct arm_boot_info *info);
+
+/**
+ * arm_load_dtb() - load a device tree binary image into memory
+ * @addr:       the address to load the image at
+ * @binfo:      struct describing the boot environment
+ * @addr_limit: upper limit of the available memory area at @addr
+ * @as:         address space to load image to
+ *
+ * Load a device tree supplied by the machine or by the user  with the
+ * '-dtb' command line option, and put it at offset @addr in target
+ * memory.
+ *
+ * If @addr_limit contains a meaningful value (i.e., it is strictly greater
+ * than @addr), the device tree is only loaded if its size does not exceed
+ * the limit.
+ *
+ * Returns: the size of the device tree image on success,
+ *          0 if the image size exceeds the limit,
+ *          -1 on errors.
+ *
+ * Note: Must not be called unless have_dtb(binfo) is true.
+ */
+int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
+                 hwaddr addr_limit, AddressSpace *as);
+
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
diff --git a/include/hw/arm/sysbus-fdt.h b/include/hw/arm/sysbus-fdt.h
index e15bb81807..340c382cdd 100644
--- a/include/hw/arm/sysbus-fdt.h
+++ b/include/hw/arm/sysbus-fdt.h
@@ -24,37 +24,14 @@
 #ifndef HW_ARM_SYSBUS_FDT_H
 #define HW_ARM_SYSBUS_FDT_H
 
-#include "hw/arm/arm.h"
-#include "qemu-common.h"
-#include "hw/sysbus.h"
-
-/*
- * struct that contains dimensioning parameters of the platform bus
- */
-typedef struct {
-    hwaddr platform_bus_base; /* start address of the bus */
-    hwaddr platform_bus_size; /* size of the bus */
-    int platform_bus_first_irq; /* first hwirq assigned to the bus */
-    int platform_bus_num_irqs; /* number of hwirq assigned to the bus */
-} ARMPlatformBusSystemParams;
-
-/*
- * struct that contains all relevant info to build the fdt nodes of
- * platform bus and attached dynamic sysbus devices
- * in the future might be augmented with additional info
- * such as PHY, CLK handles ...
- */
-typedef struct {
-    const ARMPlatformBusSystemParams *system_params;
-    struct arm_boot_info *binfo;
-    const char *intc; /* parent interrupt controller name */
-} ARMPlatformBusFDTParams;
+#include "exec/hwaddr.h"
 
 /**
- * arm_register_platform_bus_fdt_creator - register a machine init done
- * notifier that creates the device tree nodes of the platform bus and
- * associated dynamic sysbus devices
+ * platform_bus_add_all_fdt_nodes - create all the platform bus nodes
+ *
+ * builds the parent platform bus node and all the nodes of dynamic
+ * sysbus devices attached to it.
  */
-void arm_register_platform_bus_fdt_creator(ARMPlatformBusFDTParams *fdt_params);
-
+void platform_bus_add_all_fdt_nodes(void *fdt, const char *intc, hwaddr addr,
+                                    hwaddr bus_size, int irq_start);
 #endif
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e2be20731..9496f331a8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -36,8 +36,8 @@
 #define ARM64_TEXT_OFFSET_OFFSET    8
 #define ARM64_MAGIC_OFFSET          56
 
-static AddressSpace *arm_boot_address_space(ARMCPU *cpu,
-                                            const struct arm_boot_info *info)
+AddressSpace *arm_boot_address_space(ARMCPU *cpu,
+                                     const struct arm_boot_info *info)
 {
     /* Return the address space to use for bootloader reads and writes.
      * We prefer the secure address space if the CPU has it and we're
@@ -486,29 +486,8 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
-/**
- * load_dtb() - load a device tree binary image into memory
- * @addr:       the address to load the image at
- * @binfo:      struct describing the boot environment
- * @addr_limit: upper limit of the available memory area at @addr
- * @as:         address space to load image to
- *
- * Load a device tree supplied by the machine or by the user  with the
- * '-dtb' command line option, and put it at offset @addr in target
- * memory.
- *
- * If @addr_limit contains a meaningful value (i.e., it is strictly greater
- * than @addr), the device tree is only loaded if its size does not exceed
- * the limit.
- *
- * Returns: the size of the device tree image on success,
- *          0 if the image size exceeds the limit,
- *          -1 on errors.
- *
- * Note: Must not be called unless have_dtb(binfo) is true.
- */
-static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                    hwaddr addr_limit, AddressSpace *as)
+int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
+                 hwaddr addr_limit, AddressSpace *as)
 {
     void *fdt = NULL;
     int size, rc;
@@ -935,7 +914,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     return size;
 }
 
-static void arm_load_kernel_notify(Notifier *notifier, void *data)
+void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
 {
     CPUState *cs;
     int kernel_size;
@@ -945,11 +924,6 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     int elf_machine;
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
-    ArmLoadKernelNotifier *n = DO_UPCAST(ArmLoadKernelNotifier,
-                                         notifier, notifier);
-    ARMCPU *cpu = n->cpu;
-    struct arm_boot_info *info =
-        container_of(n, struct arm_boot_info, load_kernel_notifier);
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
     /* The board code is not supposed to set secure_board_setup unless
@@ -959,6 +933,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     assert(!(info->secure_board_setup && kvm_enabled()));
 
     info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    info->dtb_limit = 0;
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
@@ -968,9 +943,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
              * the kernel is supposed to be loaded by the bootloader), copy the
              * DTB to the base of RAM for the bootloader to pick up.
              */
-            if (load_dtb(info->loader_start, info, 0, as) < 0) {
-                exit(1);
-            }
+            info->dtb_start = info->loader_start;
         }
 
         if (info->kernel_filename) {
@@ -1050,15 +1023,14 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
          */
         if (elf_low_addr > info->loader_start
             || elf_high_addr < info->loader_start) {
-            /* Pass elf_low_addr as address limit to load_dtb if it may be
+            /* Set elf_low_addr as address limit for arm_load_dtb if it may be
              * pointing into RAM, otherwise pass '0' (no limit)
              */
             if (elf_low_addr < info->loader_start) {
                 elf_low_addr = 0;
             }
-            if (load_dtb(info->loader_start, info, elf_low_addr, as) < 0) {
-                exit(1);
-            }
+            info->dtb_start = info->loader_start;
+            info->dtb_limit = elf_low_addr;
         }
     }
     entry = elf_entry;
@@ -1116,7 +1088,6 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
          */
         if (have_dtb(info)) {
             hwaddr align;
-            hwaddr dtb_start;
 
             if (elf_machine == EM_AARCH64) {
                 /*
@@ -1136,11 +1107,9 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
             }
 
             /* Place the DTB after the initrd in memory with alignment. */
-            dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size, align);
-            if (load_dtb(dtb_start, info, 0, as) < 0) {
-                exit(1);
-            }
-            fixupcontext[FIXUP_ARGPTR] = dtb_start;
+            info->dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size,
+                                           align);
+            fixupcontext[FIXUP_ARGPTR] = info->dtb_start;
         } else {
             fixupcontext[FIXUP_ARGPTR] = info->loader_start + KERNEL_ARGS_ADDR;
             if (info->ram_size >= (1ULL << 32)) {
@@ -1173,15 +1142,6 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         ARM_CPU(cs)->env.boot_info = info;
     }
-}
-
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
-{
-    CPUState *cs;
-
-    info->load_kernel_notifier.cpu = cpu;
-    info->load_kernel_notifier.notifier.notify = arm_load_kernel_notify;
-    qemu_add_machine_init_done_notifier(&info->load_kernel_notifier.notifier);
 
     /* CPU objects (unlike devices) are not automatically reset on system
      * reset, so we must always register a handler to do so. If we're
@@ -1191,6 +1151,12 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
     }
+
+    if (!info->skip_dtb_autoload && have_dtb(info)) {
+        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
+            exit(1);
+        }
+    }
 }
 
 static const TypeInfo arm_linux_boot_if_info = {
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 80ff70e1ed..e4c492ea44 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -49,15 +49,6 @@ typedef struct PlatformBusFDTData {
     PlatformBusDevice *pbus;
 } PlatformBusFDTData;
 
-/*
- * struct used when calling the machine init done notifier
- * that constructs the fdt nodes of platform bus devices
- */
-typedef struct PlatformBusFDTNotifierParams {
-    Notifier notifier;
-    ARMPlatformBusFDTParams *fdt_params;
-} PlatformBusFDTNotifierParams;
-
 /* struct that associates a device type name and a node creation function */
 typedef struct NodeCreationPair {
     const char *typename;
@@ -453,42 +444,17 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
     exit(1);
 }
 
-/**
- * add_all_platform_bus_fdt_nodes - create all the platform bus nodes
- *
- * builds the parent platform bus node and all the nodes of dynamic
- * sysbus devices attached to it.
- */
-static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
+void platform_bus_add_all_fdt_nodes(void *fdt, const char *intc, hwaddr addr,
+                                    hwaddr bus_size, int irq_start)
 {
     const char platcomp[] = "qemu,platform\0simple-bus";
     PlatformBusDevice *pbus;
     DeviceState *dev;
     gchar *node;
-    uint64_t addr, size;
-    int irq_start, dtb_size;
-    struct arm_boot_info *info = fdt_params->binfo;
-    const ARMPlatformBusSystemParams *params = fdt_params->system_params;
-    const char *intc = fdt_params->intc;
-    void *fdt = info->get_dtb(info, &dtb_size);
-
-    /*
-     * If the user provided a dtb, we assume the dynamic sysbus nodes
-     * already are integrated there. This corresponds to a use case where
-     * the dynamic sysbus nodes are complex and their generation is not yet
-     * supported. In that case the user can take charge of the guest dt
-     * while qemu takes charge of the qom stuff.
-     */
-    if (info->dtb_filename) {
-        return;
-    }
 
     assert(fdt);
 
-    node = g_strdup_printf("/platform@%"PRIx64, params->platform_bus_base);
-    addr = params->platform_bus_base;
-    size = params->platform_bus_size;
-    irq_start = params->platform_bus_first_irq;
+    node = g_strdup_printf("/platform@%"PRIx64, addr);
 
     /* Create a /platform node that we can put all devices into */
     qemu_fdt_add_subnode(fdt, node);
@@ -499,7 +465,7 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
      */
     qemu_fdt_setprop_cells(fdt, node, "#size-cells", 1);
     qemu_fdt_setprop_cells(fdt, node, "#address-cells", 1);
-    qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, size);
+    qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, bus_size);
 
     qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", intc);
 
@@ -518,22 +484,3 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
 
     g_free(node);
 }
-
-static void platform_bus_fdt_notify(Notifier *notifier, void *data)
-{
-    PlatformBusFDTNotifierParams *p = DO_UPCAST(PlatformBusFDTNotifierParams,
-                                                notifier, notifier);
-
-    add_all_platform_bus_fdt_nodes(p->fdt_params);
-    g_free(p->fdt_params);
-    g_free(p);
-}
-
-void arm_register_platform_bus_fdt_creator(ARMPlatformBusFDTParams *fdt_params)
-{
-    PlatformBusFDTNotifierParams *p = g_new(PlatformBusFDTNotifierParams, 1);
-
-    p->fdt_params = fdt_params;
-    p->notifier.notify = platform_bus_fdt_notify;
-    qemu_add_machine_init_done_notifier(&p->notifier);
-}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1f54223f19..6710be226f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,8 +94,6 @@
 
 #define PLATFORM_BUS_NUM_IRQS 64
 
-static ARMPlatformBusSystemParams platform_bus_params;
-
 /* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
  * RAM can go up to the 256GB mark, leaving 256GB of the physical
  * address space unallocated and free for future use between 256G and 512G.
@@ -1126,40 +1124,23 @@ static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
     DeviceState *dev;
     SysBusDevice *s;
     int i;
-    ARMPlatformBusFDTParams *fdt_params = g_new(ARMPlatformBusFDTParams, 1);
     MemoryRegion *sysmem = get_system_memory();
 
-    platform_bus_params.platform_bus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
-    platform_bus_params.platform_bus_size = vms->memmap[VIRT_PLATFORM_BUS].size;
-    platform_bus_params.platform_bus_first_irq = vms->irqmap[VIRT_PLATFORM_BUS];
-    platform_bus_params.platform_bus_num_irqs = PLATFORM_BUS_NUM_IRQS;
-
-    fdt_params->system_params = &platform_bus_params;
-    fdt_params->binfo = &vms->bootinfo;
-    fdt_params->intc = "/intc";
-    /*
-     * register a machine init done notifier that creates the device tree
-     * nodes of the platform bus and its children dynamic sysbus devices
-     */
-    arm_register_platform_bus_fdt_creator(fdt_params);
-
     dev = qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
     dev->id = TYPE_PLATFORM_BUS_DEVICE;
-    qdev_prop_set_uint32(dev, "num_irqs",
-        platform_bus_params.platform_bus_num_irqs);
-    qdev_prop_set_uint32(dev, "mmio_size",
-        platform_bus_params.platform_bus_size);
+    qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
+    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
     qdev_init_nofail(dev);
     vms->platform_bus_dev = dev;
-    s = SYS_BUS_DEVICE(dev);
 
-    for (i = 0; i < platform_bus_params.platform_bus_num_irqs; i++) {
-        int irqn = platform_bus_params.platform_bus_first_irq + i;
+    s = SYS_BUS_DEVICE(dev);
+    for (i = 0; i < PLATFORM_BUS_NUM_IRQS; i++) {
+        int irqn = vms->irqmap[VIRT_PLATFORM_BUS] + i;
         sysbus_connect_irq(s, i, pic[irqn]);
     }
 
     memory_region_add_subregion(sysmem,
-                                platform_bus_params.platform_bus_base,
+                                vms->memmap[VIRT_PLATFORM_BUS].base,
                                 sysbus_mmio_get_region(s, 0));
 }
 
@@ -1230,6 +1211,26 @@ void virt_machine_done(Notifier *notifier, void *data)
 {
     VirtMachineState *vms = container_of(notifier, VirtMachineState,
                                          machine_done);
+    ARMCPU *cpu = ARM_CPU(first_cpu);
+    struct arm_boot_info *info = &vms->bootinfo;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+
+    /*
+     * If the user provided a dtb, we assume the dynamic sysbus nodes
+     * already are integrated there. This corresponds to a use case where
+     * the dynamic sysbus nodes are complex and their generation is not yet
+     * supported. In that case the user can take charge of the guest dt
+     * while qemu takes charge of the qom stuff.
+     */
+    if (info->dtb_filename == NULL) {
+        platform_bus_add_all_fdt_nodes(vms->fdt, "/intc",
+                                       vms->memmap[VIRT_PLATFORM_BUS].base,
+                                       vms->memmap[VIRT_PLATFORM_BUS].size,
+                                       vms->irqmap[VIRT_PLATFORM_BUS]);
+    }
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
+        exit(1);
+    }
 
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
@@ -1457,8 +1458,7 @@ static void machvirt_init(MachineState *machine)
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
 
-    vms->machine_done.notify = virt_machine_done;
-    qemu_add_machine_init_done_notifier(&vms->machine_done);
+    create_platform_bus(vms, pic);
 
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
@@ -1468,16 +1468,12 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb = machvirt_dtb;
+    vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
     arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
 
-    /*
-     * arm_load_kernel machine init done notifier registration must
-     * happen before the platform_bus_create call. In this latter,
-     * another notifier is registered which adds platform bus nodes.
-     * Notifiers are executed in registration reverse order.
-     */
-    create_platform_bus(vms, pic);
+    vms->machine_done.notify = virt_machine_done;
+    qemu_add_machine_init_done_notifier(&vms->machine_done);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
-- 
2.17.0
