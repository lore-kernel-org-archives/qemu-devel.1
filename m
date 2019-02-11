Received: from eggs.gnu.org ([209.51.188.92]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt3FH-0003MO-8g
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt32F-0006IZ-5J
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gt327-0005pG-UA
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:30 -0500
Message-Id: <e26ca956807437844403d835cb2d67bf306244fd.1549857716.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1549857716.git.balaton@eik.bme.hu>
References: <cover.1549857716.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 11 Feb 2019 05:01:56 +0100
Subject: [Qemu-devel] [PATCH 1/4] hw/pci-host/bonito.c: Add PCI mem region
 mapped at the correct address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

Stop using system memory as PCI memory otherwise devices such as VGA
that have regions mapped to PCI memory clash with RAM. Use a separate
memory region for PCI memory and map it to the correct address in
system memory which allows PCI mem regions to show at the correct
address where clients expect them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/bonito.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9f33582706..c940ec6e48 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -598,11 +598,14 @@ static const VMStateDescription vmstate_bonito = {
 static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    MemoryRegion *mr = g_new0(MemoryRegion, 1);
 
+    memory_region_init(mr, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
     phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
-                                     dev, get_system_memory(), get_system_io(),
+                                     dev, mr, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
+    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE, mr);
 }
 
 static void bonito_realize(PCIDevice *dev, Error **errp)
-- 
2.13.7
