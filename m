Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfq-0006Ej-2b
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfn-00038V-VM
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47979
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfn-0002yS-Oe
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:19 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:46 +0000
Message-Id: <20180121091154.17426-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 02/10] simba: rename PBMPCIBridge and QOM
 types to reflect simba naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Here we rename PBMPCIBridge to SimbaPCIBridge and the QOM type from
TYPE_PBM_PCI_BRIDGE to TYPE_SIMBA_PCI_BRIDGE in improve the clarity
of the device name.

Also touch up the relevant spots in apb.c and various other function
names as appropriate.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/pci-bridge/simba.c         | 22 +++++++++++-----------
 hw/pci-host/apb.c             | 12 ++++++------
 include/hw/pci-bridge/simba.h | 10 +++++-----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index 05ba6f0f34..dea4c8c5e7 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -36,7 +36,7 @@
  * http://www.sun.com/processors/manuals/805-1251.pdf
  */
 
-static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
+static void simba_pci_bridge_realize(PCIDevice *dev, Error **errp)
 {
     /*
      * command register:
@@ -47,7 +47,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
      *   the reset value should be zero unless the boot pin is tied high
      *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
      */
-    PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
+    SimbaPCIBridge *br = SIMBA_PCI_BRIDGE(dev);
 
     pci_bridge_initfn(dev, TYPE_PCI_BUS);
 
@@ -65,12 +65,12 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
     pci_bridge_update_mappings(PCI_BRIDGE(br));
 }
 
-static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
+static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = apb_pci_bridge_realize;
+    k->realize = simba_pci_bridge_realize;
     k->exit = pci_bridge_exitfn;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
@@ -82,20 +82,20 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_device;
 }
 
-static const TypeInfo pbm_pci_bridge_info = {
-    .name          = TYPE_PBM_PCI_BRIDGE,
+static const TypeInfo simba_pci_bridge_info = {
+    .name          = TYPE_SIMBA_PCI_BRIDGE,
     .parent        = TYPE_PCI_BRIDGE,
-    .class_init    = pbm_pci_bridge_class_init,
-    .instance_size = sizeof(PBMPCIBridge),
+    .class_init    = simba_pci_bridge_class_init,
+    .instance_size = sizeof(SimbaPCIBridge),
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
 };
 
-static void pbm_register_types(void)
+static void simba_register_types(void)
 {
-    type_register_static(&pbm_pci_bridge_info);
+    type_register_static(&simba_pci_bridge_info);
 }
 
-type_init(pbm_register_types)
+type_init(simba_register_types)
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 3a5c046794..43ee42d170 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -293,7 +293,7 @@ static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
     return irq_num;
 }
 
-static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
+static int pci_simbaA_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     /* The on-board devices have fixed (legacy) OBIO intnos */
     switch (PCI_SLOT(pci_dev->devfn)) {
@@ -311,7 +311,7 @@ static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
     return ((PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
 }
 
-static int pci_pbmB_map_irq(PCIDevice *pci_dev, int irq_num)
+static int pci_simbaB_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
 }
@@ -417,15 +417,15 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
 
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
-                                   TYPE_PBM_PCI_BRIDGE);
+                                       TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbmB_map_irq);
+    pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
 
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
-                                   TYPE_PBM_PCI_BRIDGE);
+                                       TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeA = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
+    pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
 }
 
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.h
index 5ab1330236..fac56ab1cf 100644
--- a/include/hw/pci-bridge/simba.h
+++ b/include/hw/pci-bridge/simba.h
@@ -28,11 +28,11 @@
 #include "hw/pci/pci_bridge.h"
 
 
-typedef struct PBMPCIBridge {
+typedef struct SimbaPCIBridge {
     /*< private >*/
     PCIBridge parent_obj;
-} PBMPCIBridge;
+} SimbaPCIBridge;
 
-#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
-#define PBM_PCI_BRIDGE(obj) \
-    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
+#define TYPE_SIMBA_PCI_BRIDGE "pbm-bridge"
+#define SIMBA_PCI_BRIDGE(obj) \
+    OBJECT_CHECK(SimbaPCIBridge, (obj), TYPE_SIMBA_PCI_BRIDGE)
-- 
2.11.0
