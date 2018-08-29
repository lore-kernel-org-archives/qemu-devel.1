Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wh-0005L7-CA
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oW-0004Jp-Bg
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:09 +0100
Message-Id: <20180829165911.30106-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/7] mac_oldworld: implement custom
 FWPathProvider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This enables the correct generation of bootdevice fw paths for in-built IDE
and virtio-pci-blk devices suitable for OpenBIOS.

Note we also set the MachineClass ignore_boot_device_suffixes property to true
since an additional disk node should not be added except for virtio devices.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index c7b73e274f..9891c325a9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -42,6 +42,7 @@
 #include "hw/misc/macio/macio.h"
 #include "hw/ide.h"
 #include "hw/loader.h"
+#include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
@@ -373,6 +374,54 @@ static void ppc_heathrow_init(MachineState *machine)
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
+/*
+ * Implementation of an interface to adjust firmware path
+ * for the bootindex property handling.
+ */
+static char *heathrow_fw_dev_path(FWPathProvider *p, BusState *bus,
+                                  DeviceState *dev)
+{
+    PCIDevice *pci;
+    IDEBus *ide_bus;
+    IDEState *ide_s;
+    MACIOIDEState *macio_ide;
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "macio-oldworld")) {
+        pci = PCI_DEVICE(dev);
+        return g_strdup_printf("mac-io@%x", PCI_SLOT(pci->devfn));
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "macio-ide")) {
+        macio_ide = MACIO_IDE(dev);
+        return g_strdup_printf("ata-3@%x", macio_ide->addr);
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "ide-drive")) {
+        ide_bus = IDE_BUS(qdev_get_parent_bus(dev));
+        ide_s = idebus_active_if(ide_bus);
+
+        if (ide_s->drive_kind == IDE_CD) {
+            return g_strdup("cdrom");
+        }
+
+        return g_strdup("hd");
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "ide-hd")) {
+        return g_strdup("hd");
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "ide-cd")) {
+        return g_strdup("cdrom");
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "virtio-blk-device")) {
+        return g_strdup("disk");
+    }
+
+    return NULL;
+}
+
 static int heathrow_kvm_type(const char *arg)
 {
     /* Always force PR KVM */
@@ -382,6 +431,7 @@ static int heathrow_kvm_type(const char *arg)
 static void heathrow_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
     mc->desc = "Heathrow based PowerMAC";
     mc->init = ppc_heathrow_init;
@@ -395,12 +445,18 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = heathrow_kvm_type;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750_v3.1");
     mc->default_display = "std";
+    mc->ignore_boot_device_suffixes = true;
+    fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
 static const TypeInfo ppc_heathrow_machine_info = {
     .name          = MACHINE_TYPE_NAME("g3beige"),
     .parent        = TYPE_MACHINE,
-    .class_init    = heathrow_class_init
+    .class_init    = heathrow_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_FW_PATH_PROVIDER },
+        { }
+    },
 };
 
 static void ppc_heathrow_register_types(void)
-- 
2.11.0
