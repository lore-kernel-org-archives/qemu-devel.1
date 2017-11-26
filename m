Received: from eggs.gnu.org ([2001:4830:134:3::10]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIwAY-0005c2-VN
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 07:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIwAW-0006A1-RR
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 07:36:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48689
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIwAW-00068v-Kv
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 07:36:20 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 12:34:42 +0000
Message-Id: <1511699686-12605-12-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1511699686-12605-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511699686-12605-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 11/15] apb: split pci_pbm_map_irq() into
 separate functions for bus A and bus B
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

After the previous refactoring it is now possible to use separate functions
to improve clarity of the interrupt paths. Similarly by checking the PCI
devnfn to identify busA during apb_pci_bridge_realize() it becomes possible
to completely remove the busA property from the PBMPCIBridge state.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c         |   60 +++++++++++++++++++--------------------------
 include/hw/pci-host/apb.h |    3 ---
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 6c20285..d260db3 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -517,32 +517,27 @@ static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
     return irq_num;
 }
 
-static int pci_pbm_map_irq(PCIDevice *pci_dev, int irq_num)
+static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
 {
-    PBMPCIBridge *br = PBM_PCI_BRIDGE(pci_bridge_get_device(
-                           PCI_BUS(qdev_get_parent_bus(DEVICE(pci_dev)))));
-
-    int bus_offset;
-    if (br->busA) {
-        bus_offset = 0x0;
+    /* The on-board devices have fixed (legacy) OBIO intnos */
+    switch (PCI_SLOT(pci_dev->devfn)) {
+    case 1:
+        /* Onboard NIC */
+        return 0x21;
+    case 3:
+        /* Onboard IDE */
+        return 0x20;
+    default:
+        /* Normal intno, fall through */
+        break;
+    }
 
-        /* The on-board devices have fixed (legacy) OBIO intnos */
-        switch (PCI_SLOT(pci_dev->devfn)) {
-        case 1:
-            /* Onboard NIC */
-            return 0x21;
-        case 3:
-            /* Onboard IDE */
-            return 0x20;
+    return ((PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
+}
 
-        default:
-            /* Normal intno, fall through */
-            break;
-        }
-    } else {
-        bus_offset = 0x10;
-    }
-    return (bus_offset + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
+static int pci_pbmB_map_irq(PCIDevice *pci_dev, int irq_num)
+{
+    return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
 }
 
 static void pci_apb_set_irq(void *opaque, int irq_num, int level)
@@ -591,9 +586,11 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
 
     pci_bridge_initfn(dev, TYPE_PCI_BUS);
 
-    /* If initialising busA, ensure that we allow IO transactions so that
-       we get the early serial console until OpenBIOS configures the bridge */
-    if (br->busA) {
+    /* If this is the busA PCI bridge which contains the on-board devices
+     * attached to the ebus, ensure that we initially allow IO transactions
+     * so that we get the early serial console until OpenBIOS can properly
+     * configure the PCI bridge itself */
+    if (dev->devfn == PCI_DEVFN(1, 1)) {
         cmd |= PCI_COMMAND_IO;
     }
 
@@ -673,14 +670,13 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
                                    TYPE_PBM_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbm_map_irq);
+    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbmB_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
 
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
                                    TYPE_PBM_PCI_BRIDGE);
     s->bridgeA = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbm_map_irq);
-    qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
+    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
 }
 
@@ -789,11 +785,6 @@ static const TypeInfo pbm_host_info = {
     .class_init    = pbm_host_class_init,
 };
 
-static Property pbm_pci_properties[] = {
-    DEFINE_PROP_BOOL("busA", PBMPCIBridge, busA, false),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -809,7 +800,6 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = pci_bridge_reset;
     dc->vmsd = &vmstate_pci_device;
-    dc->props = pbm_pci_properties;
 }
 
 static const TypeInfo pbm_pci_bridge_info = {
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index f0074f7..dd49437 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -86,9 +86,6 @@ typedef struct APBState {
 typedef struct PBMPCIBridge {
     /*< private >*/
     PCIBridge parent_obj;
-
-    /* Is this busA with in-built devices (ebus)? */
-    bool busA;
 } PBMPCIBridge;
 
 #define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
-- 
1.7.10.4
