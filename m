Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd9-0004zX-TY
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd7-0000oy-Eo
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd6-0000lQ-Ej
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd5-0003UP-6P
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:02 +0100
Message-Id: <20180510174519.11264-5-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/21] platform-bus-device: use device plug
 callback instead of machine_done notifier
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

platform-bus were using machine_done notifier to get and map
(assign irq/mmio resources) dynamically added sysbus devices
after all '-device' options had been processed.
That however creates non obvious dependencies on ordering of
machine_done notifiers and requires carefull line juggling
to keep it working. For example see comment above
create_platform_bus() and 'straitforward' arm_load_kernel()
had to converted to machine_done notifier and that lead to
yet another machine_done notifier to keep it working
arm_register_platform_bus_fdt_creator().

Instead of hiding resource assignment in platform-bus-device
to magically initialize sysbus devices, use device plug
callback and assign resources explicitly at board level
at the moment each -device option is being processed.

That adds a bunch of machine declaration boiler plate to
e500plat board, similar to ARM/x86 but gets rid of hidden
machine_done notifier and would allow to remove the dependent
notifiers in ARM code simplifying it and making code flow
easier to follow.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 1525691524-32265-3-git-send-email-imammedo@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/e500.h             |  5 +++++
 include/hw/arm/virt.h     |  1 +
 include/hw/platform-bus.h |  4 ++--
 hw/arm/sysbus-fdt.c       |  3 ---
 hw/arm/virt.c             | 31 +++++++++++++++++++++++++++++++
 hw/core/platform-bus.c    | 29 +++++------------------------
 hw/ppc/e500.c             | 38 +++++++++++++++++---------------------
 hw/ppc/e500plat.c         | 31 +++++++++++++++++++++++++++++++
 8 files changed, 92 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 621403bd24..3fd9f825ca 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -2,11 +2,16 @@
 #define PPCE500_H
 
 #include "hw/boards.h"
+#include "hw/platform-bus.h"
 
 typedef struct PPCE500MachineState {
     /*< private >*/
     MachineState parent_obj;
 
+    /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
+     * board supports dynamic sysbus devices
+     */
+    PlatformBusDevice *pbus_dev;
 } PPCE500MachineState;
 
 typedef struct PPCE500MachineClass {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 886372cdbb..4ac7ef6a37 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -99,6 +99,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     Notifier machine_done;
+    DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index a00775cba6..19e20c57ce 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -37,8 +37,6 @@ typedef struct PlatformBusDevice PlatformBusDevice;
 struct PlatformBusDevice {
     /*< private >*/
     SysBusDevice parent_obj;
-    Notifier notifier;
-    bool done_gathering;
 
     /*< public >*/
     uint32_t mmio_size;
@@ -54,4 +52,6 @@ int platform_bus_get_irqn(PlatformBusDevice *platform_bus, SysBusDevice *sbdev,
 hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
                                   int n);
 
+void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice *sbdev);
+
 #endif /* HW_PLATFORM_BUS_H */
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dcdbd..80ff70e1ed 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -506,9 +506,6 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
     dev = qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_DEVICE);
     pbus = PLATFORM_BUS_DEVICE(dev);
 
-    /* We can only create dt nodes for dynamic devices when they're ready */
-    assert(pbus->done_gathering);
-
     PlatformBusFDTData data = {
         .fdt = fdt,
         .irq_start = irq_start,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 11b9f599ca..1f54223f19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1150,6 +1150,7 @@ static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
     qdev_prop_set_uint32(dev, "mmio_size",
         platform_bus_params.platform_bus_size);
     qdev_init_nofail(dev);
+    vms->platform_bus_dev = dev;
     s = SYS_BUS_DEVICE(dev);
 
     for (i = 0; i < platform_bus_params.platform_bus_num_irqs; i++) {
@@ -1627,9 +1628,33 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+
+    if (vms->platform_bus_dev) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+            platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                     SYS_BUS_DEVICE(dev));
+        }
+    }
+}
+
+static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
+                                                        DeviceState *dev)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+        return HOTPLUG_HANDLER(machine);
+    }
+
+    return NULL;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = machvirt_init;
     /* Start max_cpus at the maximum QEMU supports. We'll further restrict
@@ -1648,6 +1673,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    hc->plug = virt_machine_device_plug_cb;
 }
 
 static const TypeInfo virt_machine_info = {
@@ -1657,6 +1684,10 @@ static const TypeInfo virt_machine_info = {
     .instance_size = sizeof(VirtMachineState),
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
+    .interfaces = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    },
 };
 
 static void machvirt_machine_init(void)
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 33d32fbf22..807cb5ccda 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -103,7 +103,6 @@ static void plaform_bus_refresh_irqs(PlatformBusDevice *pbus)
 {
     bitmap_zero(pbus->used_irqs, pbus->num_irqs);
     foreach_dynamic_sysbus_device(platform_bus_count_irqs, pbus);
-    pbus->done_gathering = true;
 }
 
 static void platform_bus_map_irq(PlatformBusDevice *pbus, SysBusDevice *sbdev,
@@ -163,12 +162,11 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
 }
 
 /*
- * For each sysbus device, look for unassigned IRQ lines as well as
- * unassociated MMIO regions. Connect them to the platform bus if available.
+ * Look for unassigned IRQ lines as well as unassociated MMIO regions.
+ * Connect them to the platform bus if available.
  */
-static void link_sysbus_device(SysBusDevice *sbdev, void *opaque)
+void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice *sbdev)
 {
-    PlatformBusDevice *pbus = opaque;
     int i;
 
     for (i = 0; sysbus_has_irq(sbdev, i); i++) {
@@ -180,19 +178,6 @@ static void link_sysbus_device(SysBusDevice *sbdev, void *opaque)
     }
 }
 
-static void platform_bus_init_notify(Notifier *notifier, void *data)
-{
-    PlatformBusDevice *pb = container_of(notifier, PlatformBusDevice, notifier);
-
-    /*
-     * Generate a bitmap of used IRQ lines, as the user might have specified
-     * them on the command line.
-     */
-    plaform_bus_refresh_irqs(pb);
-
-    foreach_dynamic_sysbus_device(link_sysbus_device, pb);
-}
-
 static void platform_bus_realize(DeviceState *dev, Error **errp)
 {
     PlatformBusDevice *pbus;
@@ -211,12 +196,8 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(d, &pbus->irqs[i]);
     }
 
-    /*
-     * Register notifier that allows us to gather dangling devices once the
-     * machine is completely assembled
-     */
-    pbus->notifier.notify = platform_bus_init_notify;
-    qemu_add_machine_init_done_notifier(&pbus->notifier);
+    /* some devices might be initialized before so update used IRQs map */
+    plaform_bus_refresh_irqs(pbus);
 }
 
 static Property platform_bus_properties[] = {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 748a8d213b..826053edc8 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -222,16 +222,15 @@ static void sysbus_device_create_devtree(SysBusDevice *sbdev, void *opaque)
     }
 }
 
-static void platform_bus_create_devtree(const PPCE500MachineClass *pmc,
+static void platform_bus_create_devtree(PPCE500MachineState *pms,
                                         void *fdt, const char *mpic)
 {
+    const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
     gchar *node = g_strdup_printf("/platform@%"PRIx64, pmc->platform_bus_base);
     const char platcomp[] = "qemu,platform\0simple-bus";
     uint64_t addr = pmc->platform_bus_base;
     uint64_t size = pmc->platform_bus_size;
     int irq_start = pmc->platform_bus_first_irq;
-    PlatformBusDevice *pbus;
-    DeviceState *dev;
 
     /* Create a /platform node that we can put all devices into */
 
@@ -246,22 +245,17 @@ static void platform_bus_create_devtree(const PPCE500MachineClass *pmc,
 
     qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", mpic);
 
-    dev = qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_DEVICE);
-    pbus = PLATFORM_BUS_DEVICE(dev);
+    /* Create dt nodes for dynamic devices */
+    PlatformDevtreeData data = {
+        .fdt = fdt,
+        .mpic = mpic,
+        .irq_start = irq_start,
+        .node = node,
+        .pbus = pms->pbus_dev,
+    };
 
-    /* We can only create dt nodes for dynamic devices when they're ready */
-    if (pbus->done_gathering) {
-        PlatformDevtreeData data = {
-            .fdt = fdt,
-            .mpic = mpic,
-            .irq_start = irq_start,
-            .node = node,
-            .pbus = pbus,
-        };
-
-        /* Loop through all dynamic sysbus devices and create nodes for them */
-        foreach_dynamic_sysbus_device(sysbus_device_create_devtree, &data);
-    }
+    /* Loop through all dynamic sysbus devices and create nodes for them */
+    foreach_dynamic_sysbus_device(sysbus_device_create_devtree, &data);
 
     g_free(node);
 }
@@ -533,8 +527,8 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     }
     g_free(soc);
 
-    if (pmc->has_platform_bus) {
-        platform_bus_create_devtree(pmc, fdt, mpic);
+    if (pms->pbus_dev) {
+        platform_bus_create_devtree(pms, fdt, mpic);
     }
     g_free(mpic);
 
@@ -953,8 +947,9 @@ void ppce500_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs);
         qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
         qdev_init_nofail(dev);
-        s = SYS_BUS_DEVICE(dev);
+        pms->pbus_dev = PLATFORM_BUS_DEVICE(dev);
 
+        s = SYS_BUS_DEVICE(pms->pbus_dev);
         for (i = 0; i < pmc->platform_bus_num_irqs; i++) {
             int irqn = pmc->platform_bus_first_irq + i;
             sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
@@ -1097,6 +1092,7 @@ static const TypeInfo ppce500_info = {
     .name          = TYPE_PPCE500_MACHINE,
     .parent        = TYPE_MACHINE,
     .abstract      = true,
+    .instance_size = sizeof(PPCE500MachineState),
     .class_size    = sizeof(PPCE500MachineClass),
 };
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index f69aadb666..1a469ba69f 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -43,13 +43,40 @@ static void e500plat_init(MachineState *machine)
     ppce500_init(machine);
 }
 
+static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
+{
+    PPCE500MachineState *pms = PPCE500_MACHINE(hotplug_dev);
+
+    if (pms->pbus_dev) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+            platform_bus_link_device(pms->pbus_dev, SYS_BUS_DEVICE(dev));
+        }
+    }
+}
+
+static
+HotplugHandler *e500plat_machine_get_hotpug_handler(MachineState *machine,
+                                                    DeviceState *dev)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+        return HOTPLUG_HANDLER(machine);
+    }
+
+    return NULL;
+}
+
 #define TYPE_E500PLAT_MACHINE  MACHINE_TYPE_NAME("ppce500")
 
 static void e500plat_machine_class_init(ObjectClass *oc, void *data)
 {
     PPCE500MachineClass *pmc = PPCE500_MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
+    mc->get_hotplug_handler = e500plat_machine_get_hotpug_handler;
+    hc->plug = e500plat_machine_device_plug_cb;
+
     pmc->pci_first_slot = 0x1;
     pmc->pci_nr_slots = PCI_SLOT_MAX - 1;
     pmc->fixup_devtree = e500plat_fixup_devtree;
@@ -77,6 +104,10 @@ static const TypeInfo e500plat_info = {
     .name          = TYPE_E500PLAT_MACHINE,
     .parent        = TYPE_PPCE500_MACHINE,
     .class_init    = e500plat_machine_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    }
 };
 
 static void e500plat_register_types(void)
-- 
2.17.0
