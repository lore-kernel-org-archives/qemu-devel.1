Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6R-0005cZ-Cj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6P-0003TG-5E
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:51 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 14:08:39 +0200
Message-Id: <1525176522-200354-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/5] platform-bus-device: use device plug
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: agraf@suse.de
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org

v2:
  - don't save original MachineClass::get_hotplug_handler, just overwrite=
 it.
    (there isn't any use case for chaining get_hotplug_handler() yet,
     so keep things simple for now) (David Gibson <david@gibson.dropbear.=
id.au>)
  - s/hotpug/hotplug/ (Peter Maydell <peter.maydell@linaro.org>)
  - ppc: rebase on top (ppc: e500: switch E500 based machines to full  ma=
chine definition)
v3:
  - in virt_machine_device_plug_cb() check for vms->platform_bus_dev !=3D=
 NULL first
    before doing more expensive cast check to SYS_BUS_DEVICE
    (Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>)
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
index 621403b..3fd9f82 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -2,11 +2,16 @@
 #define PPCE500_H
=20
 #include "hw/boards.h"
+#include "hw/platform-bus.h"
=20
 typedef struct PPCE500MachineState {
     /*< private >*/
     MachineState parent_obj;
=20
+    /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
+     * board supports dynamic sysbus devices
+     */
+    PlatformBusDevice *pbus_dev;
 } PPCE500MachineState;
=20
 typedef struct PPCE500MachineClass {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ba0c1a4..e4e3e46 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -91,6 +91,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     Notifier machine_done;
+    DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index a00775c..19e20c5 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -37,8 +37,6 @@ typedef struct PlatformBusDevice PlatformBusDevice;
 struct PlatformBusDevice {
     /*< private >*/
     SysBusDevice parent_obj;
-    Notifier notifier;
-    bool done_gathering;
=20
     /*< public >*/
     uint32_t mmio_size;
@@ -54,4 +52,6 @@ int platform_bus_get_irqn(PlatformBusDevice *platform_b=
us, SysBusDevice *sbdev,
 hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice =
*sbdev,
                                   int n);
=20
+void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice *sbd=
ev);
+
 #endif /* HW_PLATFORM_BUS_H */
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dc..80ff70e 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -506,9 +506,6 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatfor=
mBusFDTParams *fdt_params)
     dev =3D qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_=
DEVICE);
     pbus =3D PLATFORM_BUS_DEVICE(dev);
=20
-    /* We can only create dt nodes for dynamic devices when they're read=
y */
-    assert(pbus->done_gathering);
-
     PlatformBusFDTData data =3D {
         .fdt =3D fdt,
         .irq_start =3D irq_start,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a18291c..75f0e30 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1087,6 +1087,7 @@ static void create_platform_bus(VirtMachineState *v=
ms, qemu_irq *pic)
     qdev_prop_set_uint32(dev, "mmio_size",
         platform_bus_params.platform_bus_size);
     qdev_init_nofail(dev);
+    vms->platform_bus_dev =3D dev;
     s =3D SYS_BUS_DEVICE(dev);
=20
     for (i =3D 0; i < platform_bus_params.platform_bus_num_irqs; i++) {
@@ -1536,9 +1537,33 @@ static const CPUArchIdList *virt_possible_cpu_arch=
_ids(MachineState *ms)
     return ms->possible_cpus;
 }
=20
+static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+
+    if (vms->platform_bus_dev) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+            platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_b=
us_dev),
+                                     SYS_BUS_DEVICE(dev));
+        }
+    }
+}
+
+static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *ma=
chine,
+                                                        DeviceState *dev=
)
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
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
=20
     mc->init =3D machvirt_init;
     /* Start max_cpus at the maximum QEMU supports. We'll further restri=
ct
@@ -1557,6 +1582,8 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
+    mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
+    hc->plug =3D virt_machine_device_plug_cb;
 }
=20
 static const TypeInfo virt_machine_info =3D {
@@ -1566,6 +1593,10 @@ static const TypeInfo virt_machine_info =3D {
     .instance_size =3D sizeof(VirtMachineState),
     .class_size    =3D sizeof(VirtMachineClass),
     .class_init    =3D virt_machine_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    },
 };
=20
 static void machvirt_machine_init(void)
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 33d32fb..807cb5c 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -103,7 +103,6 @@ static void plaform_bus_refresh_irqs(PlatformBusDevic=
e *pbus)
 {
     bitmap_zero(pbus->used_irqs, pbus->num_irqs);
     foreach_dynamic_sysbus_device(platform_bus_count_irqs, pbus);
-    pbus->done_gathering =3D true;
 }
=20
 static void platform_bus_map_irq(PlatformBusDevice *pbus, SysBusDevice *=
sbdev,
@@ -163,12 +162,11 @@ static void platform_bus_map_mmio(PlatformBusDevice=
 *pbus, SysBusDevice *sbdev,
 }
=20
 /*
- * For each sysbus device, look for unassigned IRQ lines as well as
- * unassociated MMIO regions. Connect them to the platform bus if availa=
ble.
+ * Look for unassigned IRQ lines as well as unassociated MMIO regions.
+ * Connect them to the platform bus if available.
  */
-static void link_sysbus_device(SysBusDevice *sbdev, void *opaque)
+void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice *sbd=
ev)
 {
-    PlatformBusDevice *pbus =3D opaque;
     int i;
=20
     for (i =3D 0; sysbus_has_irq(sbdev, i); i++) {
@@ -180,19 +178,6 @@ static void link_sysbus_device(SysBusDevice *sbdev, =
void *opaque)
     }
 }
=20
-static void platform_bus_init_notify(Notifier *notifier, void *data)
-{
-    PlatformBusDevice *pb =3D container_of(notifier, PlatformBusDevice, =
notifier);
-
-    /*
-     * Generate a bitmap of used IRQ lines, as the user might have speci=
fied
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
@@ -211,12 +196,8 @@ static void platform_bus_realize(DeviceState *dev, E=
rror **errp)
         sysbus_init_irq(d, &pbus->irqs[i]);
     }
=20
-    /*
-     * Register notifier that allows us to gather dangling devices once =
the
-     * machine is completely assembled
-     */
-    pbus->notifier.notify =3D platform_bus_init_notify;
-    qemu_add_machine_init_done_notifier(&pbus->notifier);
+    /* some devices might be initialized before so update used IRQs map =
*/
+    plaform_bus_refresh_irqs(pbus);
 }
=20
 static Property platform_bus_properties[] =3D {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3e0923c..739af05 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -221,16 +221,15 @@ static void sysbus_device_create_devtree(SysBusDevi=
ce *sbdev, void *opaque)
     }
 }
=20
-static void platform_bus_create_devtree(const PPCE500MachineClass *pmc,
+static void platform_bus_create_devtree(PPCE500MachineState *pms,
                                         void *fdt, const char *mpic)
 {
+    const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
     gchar *node =3D g_strdup_printf("/platform@%"PRIx64, pmc->platform_b=
us_base);
     const char platcomp[] =3D "qemu,platform\0simple-bus";
     uint64_t addr =3D pmc->platform_bus_base;
     uint64_t size =3D pmc->platform_bus_size;
     int irq_start =3D pmc->platform_bus_first_irq;
-    PlatformBusDevice *pbus;
-    DeviceState *dev;
=20
     /* Create a /platform node that we can put all devices into */
=20
@@ -245,22 +244,17 @@ static void platform_bus_create_devtree(const PPCE5=
00MachineClass *pmc,
=20
     qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", mpic);
=20
-    dev =3D qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_=
DEVICE);
-    pbus =3D PLATFORM_BUS_DEVICE(dev);
-
-    /* We can only create dt nodes for dynamic devices when they're read=
y */
-    if (pbus->done_gathering) {
-        PlatformDevtreeData data =3D {
-            .fdt =3D fdt,
-            .mpic =3D mpic,
-            .irq_start =3D irq_start,
-            .node =3D node,
-            .pbus =3D pbus,
-        };
+    /* Create dt nodes for dynamic devices */
+    PlatformDevtreeData data =3D {
+        .fdt =3D fdt,
+        .mpic =3D mpic,
+        .irq_start =3D irq_start,
+        .node =3D node,
+        .pbus =3D pms->pbus_dev,
+    };
=20
-        /* Loop through all dynamic sysbus devices and create nodes for =
them */
-        foreach_dynamic_sysbus_device(sysbus_device_create_devtree, &dat=
a);
-    }
+    /* Loop through all dynamic sysbus devices and create nodes for them=
 */
+    foreach_dynamic_sysbus_device(sysbus_device_create_devtree, &data);
=20
     g_free(node);
 }
@@ -527,8 +521,8 @@ static int ppce500_load_device_tree(PPCE500MachineSta=
te *pms,
         create_dt_mpc8xxx_gpio(fdt, soc, mpic);
     }
=20
-    if (pmc->has_platform_bus) {
-        platform_bus_create_devtree(pmc, fdt, mpic);
+    if (pms->pbus_dev) {
+        platform_bus_create_devtree(pms, fdt, mpic);
     }
=20
     pmc->fixup_devtree(fdt);
@@ -946,8 +940,9 @@ void ppce500_init(MachineState *machine)
         qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs=
);
         qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
         qdev_init_nofail(dev);
-        s =3D SYS_BUS_DEVICE(dev);
+        pms->pbus_dev =3D PLATFORM_BUS_DEVICE(dev);
=20
+        s =3D SYS_BUS_DEVICE(pms->pbus_dev);
         for (i =3D 0; i < pmc->platform_bus_num_irqs; i++) {
             int irqn =3D pmc->platform_bus_first_irq + i;
             sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
@@ -1090,6 +1085,7 @@ static const TypeInfo ppce500_info =3D {
     .name          =3D TYPE_PPCE500_MACHINE,
     .parent        =3D TYPE_MACHINE,
     .abstract      =3D true,
+    .instance_size =3D sizeof(PPCE500MachineState),
     .class_size    =3D sizeof(PPCE500MachineClass),
 };
=20
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index f69aadb..1a469ba 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -43,13 +43,40 @@ static void e500plat_init(MachineState *machine)
     ppce500_init(machine);
 }
=20
+static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **er=
rp)
+{
+    PPCE500MachineState *pms =3D PPCE500_MACHINE(hotplug_dev);
+
+    if (pms->pbus_dev) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+            platform_bus_link_device(pms->pbus_dev, SYS_BUS_DEVICE(dev))=
;
+        }
+    }
+}
+
+static
+HotplugHandler *e500plat_machine_get_hotpug_handler(MachineState *machin=
e,
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
=20
 static void e500plat_machine_class_init(ObjectClass *oc, void *data)
 {
     PPCE500MachineClass *pmc =3D PPCE500_MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     MachineClass *mc =3D MACHINE_CLASS(oc);
=20
+    mc->get_hotplug_handler =3D e500plat_machine_get_hotpug_handler;
+    hc->plug =3D e500plat_machine_device_plug_cb;
+
     pmc->pci_first_slot =3D 0x1;
     pmc->pci_nr_slots =3D PCI_SLOT_MAX - 1;
     pmc->fixup_devtree =3D e500plat_fixup_devtree;
@@ -77,6 +104,10 @@ static const TypeInfo e500plat_info =3D {
     .name          =3D TYPE_E500PLAT_MACHINE,
     .parent        =3D TYPE_PPCE500_MACHINE,
     .class_init    =3D e500plat_machine_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    }
 };
=20
 static void e500plat_register_types(void)
--=20
2.7.4
