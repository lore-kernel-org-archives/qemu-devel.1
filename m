Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WK2-0001nh-3n
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WK1-0006tP-4u
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e9WK0-0006em-TW
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WJu-0007Ij-LS
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:11:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 13:11:29 +0000
Message-Id: <1509455489-14101-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
References: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 5/5] hw/pci-host/gpex: Improve INTX to gsi
 routing error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We exposed gpex_set_irq_num() for machines to set the INTx to
GSI routing. However if the machine forgets to call that
function we currently do not check the association was properly
done. Let's initialize gsi values to -1 and if this value is
found in gpex_route_intx_pin_to_irq, set the routing mode as
disabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1508776211-22175-1-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
