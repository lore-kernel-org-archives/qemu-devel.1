Received: from eggs.gnu.org ([2001:4830:134:3::10]:53626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBV-0008Rl-Jw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBU-0007fC-8F
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:33 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43153
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRwBU-0007ca-1W
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:32 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:40 +0000
Message-Id: <20171221082045.14022-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 11/16] apb: split pci_pbm_map_irq() into
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
to improve the clarity of the interrupt paths.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 6c20285b04..3ebb9dc304 100644
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
@@ -673,13 +668,13 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
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
+    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
     qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
     qdev_init_nofail(&pci_dev->qdev);
 }
-- 
2.11.0
