Received: from eggs.gnu.org ([2001:4830:134:3::10]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6L-0003iq-Ki
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRw6F-0004TG-BD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:13 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43124
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRw6E-0004R8-VC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:21:07 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:38 +0000
Message-Id: <20171221082045.14022-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 09/16] apb: move the two secondary PCI
 bridges objects into APBState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This enables us to remove these parameters from pci_apb_init().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/apb.c         | 14 +++++---------
 hw/sparc64/sun4u.c        |  5 ++++-
 include/hw/pci-host/apb.h |  5 +++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index c0b97e41bf..823661a8a6 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -612,8 +612,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
 }
 
 APBState *pci_apb_init(hwaddr special_base,
-                       hwaddr mem_base,
-                       PCIBus **busA, PCIBus **busB)
+                       hwaddr mem_base)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -621,7 +620,6 @@ APBState *pci_apb_init(hwaddr special_base,
     APBState *d;
     IOMMUState *is;
     PCIDevice *pci_dev;
-    PCIBridge *br;
 
     /* Ultrasparc PBM main bus */
     dev = qdev_create(NULL, TYPE_APB);
@@ -659,18 +657,16 @@ APBState *pci_apb_init(hwaddr special_base,
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
                                    TYPE_PBM_PCI_BRIDGE);
-    br = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(br, "pciB", pci_pbm_map_irq);
+    d->bridgeB = PCI_BRIDGE(pci_dev);
+    pci_bridge_map_irq(d->bridgeB, "pciB", pci_pbm_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
-    *busB = pci_bridge_get_sec_bus(br);
 
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
                                    TYPE_PBM_PCI_BRIDGE);
-    br = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(br, "pciA", pci_pbm_map_irq);
+    d->bridgeA = PCI_BRIDGE(pci_dev);
+    pci_bridge_map_irq(d->bridgeA, "pciA", pci_pbm_map_irq);
     qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
     qdev_init_nofail(&pci_dev->qdev);
-    *busA = pci_bridge_get_sec_bus(br);
 
     return d;
 }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 2afd3f28dd..47952befcb 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -27,6 +27,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/apb.h"
 #include "hw/i386/pc.h"
@@ -501,7 +502,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     prom_init(hwdef->prom_addr, bios_name);
 
-    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, &pci_busA, &pci_busB);
+    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE);
 
     /* Wire up PCI interrupts to CPU */
     for (i = 0; i < IVEC_MAX; i++) {
@@ -510,6 +511,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     }
 
     pci_bus = PCI_HOST_BRIDGE(apb)->bus;
+    pci_busA = pci_bridge_get_sec_bus(apb->bridgeA);
+    pci_busB = pci_bridge_get_sec_bus(apb->bridgeB);
 
     /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
        reserved (leaving no slots free after on-board devices) however slots
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index f7ead680f3..ae15d8ce59 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -68,6 +68,8 @@ typedef struct APBState {
     MemoryRegion pci_ioport;
     uint64_t pci_irq_in;
     IOMMUState iommu;
+    PCIBridge *bridgeA;
+    PCIBridge *bridgeB;
     uint32_t pci_control[16];
     uint32_t pci_irq_map[8];
     uint32_t pci_err_irq_map[4];
@@ -92,6 +94,5 @@ typedef struct PBMPCIBridge {
     OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
 
 APBState *pci_apb_init(hwaddr special_base,
-                       hwaddr mem_base,
-                       PCIBus **bus2, PCIBus **bus3);
+                       hwaddr mem_base);
 #endif
-- 
2.11.0
