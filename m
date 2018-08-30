Received: from eggs.gnu.org ([2001:4830:134:3::10]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBE-0000wh-38
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBC-0002qx-Ep
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:44 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40029
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fvGBC-0002qg-88
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 30 Aug 2018 07:11:29 +0100
Message-Id: <20180830061129.4157-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180830061129.4157-1-mark.cave-ayland@ilande.co.uk>
References: <20180830061129.4157-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] sun4u: implement custom FWPathProvider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This enables the correct generation of bootdevice fw paths for in-built IDE
and virtio-pci-blk devices suitable for OpenBIOS.

Note we also set the MachineClass ignore_boot_device_suffixes property to true
to allow the correct customisation of the disk node names as required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d16843b30e..f76b19e4e9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -51,6 +51,7 @@
 #include "hw/ide.h"
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
+#include "hw/fw-path-provider.h"
 #include "elf.h"
 #include "trace.h"
 
@@ -693,6 +694,56 @@ enum {
     sun4v_id = 64,
 };
 
+/*
+ * Implementation of an interface to adjust firmware path
+ * for the bootindex property handling.
+ */
+static char *sun4u_fw_dev_path(FWPathProvider *p, BusState *bus,
+                               DeviceState *dev)
+{
+    PCIDevice *pci;
+    IDEBus *ide_bus;
+    IDEState *ide_s;
+    int bus_id;
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "pbm-bridge")) {
+        pci = PCI_DEVICE(dev);
+
+        if (PCI_FUNC(pci->devfn)) {
+            return g_strdup_printf("pci@%x,%x", PCI_SLOT(pci->devfn),
+                                   PCI_FUNC(pci->devfn));
+        } else {
+            return g_strdup_printf("pci@%x", PCI_SLOT(pci->devfn));
+        }
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "ide-drive")) {
+         ide_bus = IDE_BUS(qdev_get_parent_bus(dev));
+         ide_s = idebus_active_if(ide_bus);
+         bus_id = ide_bus->bus_id;
+
+         if (ide_s->drive_kind == IDE_CD) {
+             return g_strdup_printf("ide@%x/cdrom", bus_id);
+         }
+
+         return g_strdup_printf("ide@%x/disk", bus_id);
+    }
+
+    if (!strcmp(object_get_typename(OBJECT(dev)), "ide-hd")) {
+        return g_strdup("disk");
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
 static const struct hwdef hwdefs[] = {
     /* Sun4u generic PC-like machine */
     {
@@ -723,6 +774,7 @@ static void sun4v_init(MachineState *machine)
 static void sun4u_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
     mc->desc = "Sun4u platform";
     mc->init = sun4u_init;
@@ -731,12 +783,18 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->is_default = 1;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
+    mc->ignore_boot_device_suffixes = true;
+    fwc->get_dev_path = sun4u_fw_dev_path;
 }
 
 static const TypeInfo sun4u_type = {
     .name = MACHINE_TYPE_NAME("sun4u"),
     .parent = TYPE_MACHINE,
     .class_init = sun4u_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_FW_PATH_PROVIDER },
+        { }
+    },
 };
 
 static void sun4v_class_init(ObjectClass *oc, void *data)
-- 
2.11.0
