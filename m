Received: from eggs.gnu.org ([2001:4830:134:3::10]:46500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJa-00086G-CE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-0007zX-GQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJZ-0007iP-8g
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJX-0005u1-UM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:52 +0100
Message-Id: <1505411573-27848-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/18] hw/pci-host/gpex: Implement PCI INTx
 routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Now we are able to retrieve the gsi from the INTx pin, let's
enable intx_to_irq routing. From that point on, irqfd becomes
usable along with INTx when assigning a PCIe device.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Feng Kan <fkan@apm.com>
Message-id: 1505296004-6798-4-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/gpex.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 41a884d..be25245 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -53,6 +53,17 @@ int gpex_set_irq_num(GPEXHost *s, int index, int gsi)
     return 0;
 }
 
+static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    PCIINTxRoute route;
+    GPEXHost *s = opaque;
+
+    route.mode = PCI_INTX_ENABLED;
+    route.irq = s->irq_num[pin];
+
+    return route;
+}
+
 static void gpex_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
@@ -77,6 +88,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
                                 &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
 
     qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
+    pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
     qdev_init_nofail(DEVICE(&s->gpex_root));
 }
 
-- 
2.7.4
