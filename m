Received: from eggs.gnu.org ([2001:4830:134:3::10]:49760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEZ-0005L1-2D
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEX-0003zi-BG
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:02 +1000
Message-Id: <20180618035324.19907-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/28] mac_newworld: add via machine option to
 control mac99 VIA/ADB configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This option allows the VIA configuration to be controlled between 3
different possible setups: cuda, pmu-adb and pmu with USB rather than ADB
keyboard/mouse.

For the moment we don't do anything with the configuration except to pass
it to the macio device (the via-cuda parent) and also to the firmware via
the fw_cfg interface so that it can present the correct device tree.

The default is cuda which is the current default and so will have no
change in behaviour.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c         |  7 ++++
 hw/ppc/mac.h                  |  6 +++
 hw/ppc/mac_newworld.c         | 69 +++++++++++++++++++++++++++++++----
 include/hw/misc/macio/macio.h |  2 +
 include/hw/ppc/ppc.h          |  1 +
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index f9a40eea81..dddf743bcb 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -399,6 +399,12 @@ static const VMStateDescription vmstate_macio_newworld = {
     }
 };
 
+static Property macio_newworld_properties[] = {
+    DEFINE_PROP_BOOL("has-pmu", NewWorldMacIOState, has_pmu, false),
+    DEFINE_PROP_BOOL("has-adb", NewWorldMacIOState, has_adb, false),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void macio_newworld_class_init(ObjectClass *oc, void *data)
 {
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
@@ -407,6 +413,7 @@ static void macio_newworld_class_init(ObjectClass *oc, void *data)
     pdc->realize = macio_newworld_realize;
     pdc->device_id = PCI_DEVICE_ID_APPLE_UNI_N_KEYL;
     dc->vmsd = &vmstate_macio_newworld;
+    dc->props = macio_newworld_properties;
 }
 
 static Property macio_properties[] = {
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 8046cd8a2f..4c08f52b87 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -71,9 +71,15 @@
 #define CORE99_MACHINE(obj) OBJECT_CHECK(Core99MachineState, (obj), \
                                          TYPE_CORE99_MACHINE)
 
+#define CORE99_VIA_CONFIG_CUDA     0x0
+#define CORE99_VIA_CONFIG_PMU      0x1
+#define CORE99_VIA_CONFIG_PMU_ADB  0x2
+
 typedef struct Core99MachineState {
     /*< private >*/
     MachineState parent;
+
+    uint8_t via_config;
 } Core99MachineState;
 
 /* MacIO */
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 5331aa002c..ca21d47234 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -111,6 +111,7 @@ static void ppc_core99_init(MachineState *machine)
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     const char *boot_device = machine->boot_order;
+    Core99MachineState *core99_machine = CORE99_MACHINE(machine);
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
@@ -122,6 +123,7 @@ static void ppc_core99_init(MachineState *machine)
     UNINHostState *uninorth_pci;
     PCIBus *pci_bus;
     NewWorldMacIOState *macio;
+    bool has_pmu, has_adb;
     MACIOIDEState *macio_ide;
     BusState *adb_bus;
     MacIONVRAMState *nvr;
@@ -361,6 +363,9 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     machine->usb |= defaults_enabled() && !machine->usb_disabled;
+    has_pmu = (core99_machine->via_config != CORE99_VIA_CONFIG_CUDA);
+    has_adb = (core99_machine->via_config == CORE99_VIA_CONFIG_CUDA ||
+               core99_machine->via_config == CORE99_VIA_CONFIG_PMU_ADB);
 
     /* Timebase Frequency */
     if (kvm_enabled()) {
@@ -376,6 +381,8 @@ static void ppc_core99_init(MachineState *machine)
     macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
+    qdev_prop_set_bit(dev, "has-pmu", has_pmu);
+    qdev_prop_set_bit(dev, "has-adb", has_adb);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
                              &error_abort);
     qdev_init_nofail(dev);
@@ -391,19 +398,21 @@ static void ppc_core99_init(MachineState *machine)
                                                         "ide[1]"));
     macio_ide_init_drives(macio_ide, &hd[MAX_IDE_DEVS]);
 
-    dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
-    adb_bus = qdev_get_child_bus(dev, "adb.0");
-    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
-    qdev_init_nofail(dev);
-    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
-    qdev_init_nofail(dev);
+    if (has_adb) {
+        dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
+        adb_bus = qdev_get_child_bus(dev, "adb.0");
+        dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
+        qdev_init_nofail(dev);
+        dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
+        qdev_init_nofail(dev);
+    }
 
     if (machine->usb) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
 
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
-        if (machine_arch == ARCH_MAC99_U3) {
+        if (!has_adb || machine_arch == ARCH_MAC99_U3) {
             USBBus *usb_bus = usb_bus_find(-1);
 
             usb_create_simple(usb_bus, "usb-kbd");
@@ -459,6 +468,8 @@ static void ppc_core99_init(MachineState *machine)
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
 
+    fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_VIACONFIG, core99_machine->via_config);
+
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
 #ifdef CONFIG_KVM
@@ -515,8 +526,52 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
+static char *core99_get_via_config(Object *obj, Error **errp)
+{
+    Core99MachineState *cms = CORE99_MACHINE(obj);
+
+    switch (cms->via_config) {
+    default:
+    case CORE99_VIA_CONFIG_CUDA:
+        return g_strdup("cuda");
+
+    case CORE99_VIA_CONFIG_PMU:
+        return g_strdup("pmu");
+
+    case CORE99_VIA_CONFIG_PMU_ADB:
+        return g_strdup("pmu-adb");
+    }
+}
+
+static void core99_set_via_config(Object *obj, const char *value, Error **errp)
+{
+    Core99MachineState *cms = CORE99_MACHINE(obj);
+
+    if (!strcmp(value, "cuda")) {
+        cms->via_config = CORE99_VIA_CONFIG_CUDA;
+    } else if (!strcmp(value, "pmu")) {
+        cms->via_config = CORE99_VIA_CONFIG_PMU;
+    } else if (!strcmp(value, "pmu-adb")) {
+        cms->via_config = CORE99_VIA_CONFIG_PMU_ADB;
+    } else {
+        error_setg(errp, "Invalid via value");
+        error_append_hint(errp, "Valid values are cuda, pmu, pmu-adb.\n");
+    }
+}
+
 static void core99_instance_init(Object *obj)
 {
+    Core99MachineState *cms = CORE99_MACHINE(obj);
+
+    /* Default via_config is CORE99_VIA_CONFIG_CUDA */
+    cms->via_config = CORE99_VIA_CONFIG_CUDA;
+    object_property_add_str(obj, "via", core99_get_via_config,
+                            core99_set_via_config, NULL);
+    object_property_set_description(obj, "via",
+                                    "Set VIA configuration. "
+                                    "Valid values are cuda, pmu and pmu-adb",
+                                    NULL);
+
     return;
 }
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 838eaf1db0..9529073ba8 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -70,6 +70,8 @@ typedef struct NewWorldMacIOState {
     MacIOState parent_obj;
     /*< public >*/
 
+    bool has_pmu;
+    bool has_adb;
     OpenPICState *pic;
     MACIOIDEState ide[2];
 } NewWorldMacIOState;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index b18ef3eefb..298ec354a8 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -101,6 +101,7 @@ enum {
 #define FW_CFG_PPC_NVRAM_ADDR   (FW_CFG_ARCH_LOCAL + 0x08)
 #define FW_CFG_PPC_BUSFREQ      (FW_CFG_ARCH_LOCAL + 0x09)
 #define FW_CFG_PPC_NVRAM_FLAT   (FW_CFG_ARCH_LOCAL + 0x0a)
+#define FW_CFG_PPC_VIACONFIG    (FW_CFG_ARCH_LOCAL + 0x0b)
 
 #define PPC_SERIAL_MM_BAUDBASE 399193
 
-- 
2.17.1
