Received: from eggs.gnu.org ([2001:4830:134:3::10]:42083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6fcd-00069k-OW
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6fcZ-0007YG-SO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:30:39 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 23 Oct 2017 18:30:11 +0200
Message-Id: <1508776211-22175-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/pci-host/gpex: Improve INTX to gsi routing
 error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, drjones@redhat.com

We exposed gpex_set_irq_num() for machines to set the INTx to
GSI routing. However if the machine forgets to call that
function we currently do not check the association was properly
done. Let's initialize gsi values to -1 and if this value is
found in gpex_route_intx_pin_to_irq, set the routing mode as
disabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/pci-host/gpex.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 4090793..edf305b 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -57,9 +57,14 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
 {
     PCIINTxRoute route;
     GPEXHost *s = opaque;
+    int gsi = s->irq_num[pin];
 
-    route.mode = PCI_INTX_ENABLED;
-    route.irq = s->irq_num[pin];
+    route.irq = gsi;
+    if (gsi < 0) {
+        route.mode = PCI_INTX_DISABLED;
+    } else {
+        route.mode = PCI_INTX_ENABLED;
+    }
 
     return route;
 }
@@ -81,6 +86,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->io_ioport);
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
+        s->irq_num[i] = -1;
     }
 
     pci->bus = pci_register_bus(dev, "pcie.0", gpex_set_irq,
-- 
2.5.5
