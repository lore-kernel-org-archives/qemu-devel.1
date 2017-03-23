Received: from eggs.gnu.org ([2001:4830:134:3::10]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAII-0003YS-6d
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crAIG-0008CA-Kv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crAIG-0008BN-C0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:29:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 23 Mar 2017 18:28:46 -0300
Message-Id: <20170323212848.8492-3-ehabkost@redhat.com>
In-Reply-To: <20170323212848.8492-1-ehabkost@redhat.com>
References: <20170323212848.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 2/4] machine: Replace has_dynamic_sysbus with a
 whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Replace the existing has_dynamic_sysbus flag, that makes the
machine accept every single sysbus device type on the
command-line, with a short whitelist.

Most of the machines already have an internal whitelist
implemented using foreach_dynamic_sysbus_device(), so we just
encode the existing behavior inside the new MachineClass field.

The only problematic case is q35, that accepts all sysbus device
types. In this case, instad of adding TYPE_SYS_BUS_DEVICE to the
whitelist, add the existing list of existing sysbus device types
to keep compatibility. After that, we can gradually and carefully
remove unnecessary entries from the q35 whitelist.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/sysbus-fdt.h |  7 +++++++
 include/hw/boards.h         |  3 ++-
 hw/arm/sysbus-fdt.c         | 10 ++++++++++
 hw/arm/virt.c               |  4 +++-
 hw/core/machine.c           | 43 +++++++++++++++++++++++++++++--------------
 hw/i386/pc_q35.c            | 29 ++++++++++++++++++++++++++++-
 hw/ppc/e500plat.c           |  4 +++-
 hw/ppc/spapr.c              |  2 +-
 8 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/include/hw/arm/sysbus-fdt.h b/include/hw/arm/sysbus-fdt.h
index e15bb81807..071124e13d 100644
--- a/include/hw/arm/sysbus-fdt.h
+++ b/include/hw/arm/sysbus-fdt.h
@@ -57,4 +57,11 @@ typedef struct {
  */
 void arm_register_platform_bus_fdt_creator(ARMPlatformBusFDTParams *fdt_params);
 
+/**
+ * arm_register_fdt_sysbus_whitelist - register supported sysbus device types
+ *
+ * Add supported dynamic sysbus device types to machine class.
+ */
+void arm_register_fdt_sysbus_whitelist(MachineClass *mc);
+
 #endif
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 269d0ba399..6576f6a5b0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -42,6 +42,7 @@ bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
 void machine_register_compat_props(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
+void machine_class_add_sysbus_whitelist(MachineClass *mc, const char *type);
 
 /**
  * CPUArchId:
@@ -121,7 +122,6 @@ struct MachineClass {
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
-        has_dynamic_sysbus:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
     int is_default;
@@ -135,6 +135,7 @@ struct MachineClass {
     bool rom_file_has_mr;
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
+    strList *dynamic_sysbus_whitelist;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dcdbd..29573a4412 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -29,6 +29,7 @@
 #include <linux/vfio.h>
 #endif
 #include "hw/arm/sysbus-fdt.h"
+#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
 #include "hw/platform-bus.h"
@@ -424,6 +425,15 @@ static const NodeCreationPair add_fdt_node_functions[] = {
     {"", NULL}, /* last element */
 };
 
+void arm_register_fdt_sysbus_whitelist(MachineClass *mc)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(add_fdt_node_functions); i++) {
+        machine_class_add_sysbus_whitelist(mc, add_fdt_node_functions[i].typename);
+    }
+}
+
 /* Generic Code */
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5f62a0321e..293710a6ea 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -52,6 +52,8 @@
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/vfio/vfio-calxeda-xgmac.h"
+#include "hw/vfio/vfio-amd-xgbe.h"
 #include "kvm_arm.h"
 #include "hw/smbios/smbios.h"
 #include "qapi/visitor.h"
@@ -1528,7 +1530,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
      * configuration of the particular instance.
      */
     mc->max_cpus = 255;
-    mc->has_dynamic_sysbus = true;
+    arm_register_fdt_sysbus_whitelist(mc);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0d92672203..606edffc38 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -332,29 +332,44 @@ static bool machine_get_enforce_config_section(Object *obj, Error **errp)
     return ms->enforce_config_section;
 }
 
-static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
+void machine_class_add_sysbus_whitelist(MachineClass *mc, const char *type)
 {
-    error_report("Option '-device %s' cannot be handled by this machine",
-                 object_class_get_name(object_get_class(OBJECT(sbdev))));
-    exit(1);
+    strList *item = g_new0(strList, 1);
+
+    item->value = g_strdup(type);
+    item->next = mc->dynamic_sysbus_whitelist;
+    mc->dynamic_sysbus_whitelist = item;
 }
 
-static void machine_init_notify(Notifier *notifier, void *data)
+static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
-    Object *machine = qdev_get_machine();
-    ObjectClass *oc = object_get_class(machine);
-    MachineClass *mc = MACHINE_CLASS(oc);
+    MachineState *machine = opaque;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    bool whitelisted = false;
+    strList *wl;
 
-    if (mc->has_dynamic_sysbus) {
-        /* Our machine can handle dynamic sysbus devices, we're all good */
-        return;
+    for (wl = mc->dynamic_sysbus_whitelist;
+         !whitelisted && wl;
+         wl = wl->next) {
+        whitelisted |= !!object_dynamic_cast(OBJECT(sbdev), wl->value);
     }
 
+    if (!whitelisted) {
+        error_report("Option '-device %s' cannot be handled by this machine",
+                     object_class_get_name(object_get_class(OBJECT(sbdev))));
+        exit(1);
+    }
+}
+
+static void machine_init_notify(Notifier *notifier, void *data)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+
     /*
-     * Loop through all dynamically created devices and check whether there
-     * are sysbus devices among them. If there are, error out.
+     * Loop through all dynamically created sysbus devices and check if they are
+     * all whitelisted. If there are non-whitelisted devices, error out.
      */
-    foreach_dynamic_sysbus_device(error_on_sysbus_device, NULL);
+    foreach_dynamic_sysbus_device(validate_sysbus_device, machine);
 }
 
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8547..ea039540d8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -297,7 +297,34 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     m->no_floppy = 1;
-    m->has_dynamic_sysbus = true;
+    /* The following whitelist is based on the set of available
+     * sysbus devices when has_dynamic_sysbus was replaced with
+     * a whitelist. Not every single device in this list is really
+     * supposed to be supported, but they are kept here for compatibility.
+     * We can gradually remove unnecessary devices from the whitelist.
+     */
+    machine_class_add_sysbus_whitelist(m, "allwinner-ahci");
+    machine_class_add_sysbus_whitelist(m, "amd-iommu");
+    machine_class_add_sysbus_whitelist(m, "cfi.pflash01");
+    machine_class_add_sysbus_whitelist(m, "esp");
+    machine_class_add_sysbus_whitelist(m, "fw_cfg_io");
+    machine_class_add_sysbus_whitelist(m, "fw_cfg_mem");
+    machine_class_add_sysbus_whitelist(m, "generic-sdhci");
+    machine_class_add_sysbus_whitelist(m, "hpet");
+    machine_class_add_sysbus_whitelist(m, "intel-iommu");
+    machine_class_add_sysbus_whitelist(m, "ioapic");
+    machine_class_add_sysbus_whitelist(m, "isabus-bridge");
+    machine_class_add_sysbus_whitelist(m, "kvm-ioapic");
+    machine_class_add_sysbus_whitelist(m, "kvmclock");
+    machine_class_add_sysbus_whitelist(m, "kvmvapic");
+    machine_class_add_sysbus_whitelist(m, "SUNW,fdtwo");
+    machine_class_add_sysbus_whitelist(m, "sysbus-ahci");
+    machine_class_add_sysbus_whitelist(m, "sysbus-fdc");
+    machine_class_add_sysbus_whitelist(m, "sysbus-ohci");
+    machine_class_add_sysbus_whitelist(m, "unimplemented-device");
+    machine_class_add_sysbus_whitelist(m, "virtio-mmio");
+    machine_class_add_sysbus_whitelist(m, "xen-backend");
+    machine_class_add_sysbus_whitelist(m, "xen-sysdev");
     m->max_cpus = 288;
 }
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 94b454551f..3abed05add 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -12,7 +12,9 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "e500.h"
+#include "hw/net/fsl_etsec/etsec.h"
 #include "hw/boards.h"
+#include "hw/sysbus.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
 #include "hw/pci/pci.h"
@@ -63,7 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
     mc->desc = "generic paravirt e500 platform";
     mc->init = e500plat_init;
     mc->max_cpus = 32;
-    mc->has_dynamic_sysbus = true;
+    machine_class_add_sysbus_whitelist(mc, TYPE_ETSEC_COMMON);
 }
 
 DEFINE_MACHINE("ppce500", e500plat_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6ee566d658..db56d0a653 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3070,7 +3070,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
     mc->kvm_type = spapr_kvm_type;
-    mc->has_dynamic_sysbus = true;
+    machine_class_add_sysbus_whitelist(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
-- 
2.11.0.259.g40922b1
