Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh272-0007Pp-3q
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh270-0005w0-Io
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:04 -0400
Message-Id: <a35170661f03bc19dbd2a5d6e9af626b83e2913d.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 03/12] ohci: Allow sysbus version to be
 used as a companion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/hcd-ohci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 267982e..17beedd 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1999,7 +1999,9 @@ typedef struct {
     /*< public >*/
 
     OHCIState ohci;
+    char *masterbus;
     uint32_t num_ports;
+    uint32_t firstport;
     dma_addr_t dma_offset;
 } OHCISysBusState;
 
@@ -2007,10 +2009,15 @@ static void ohci_realize_pxa(DeviceState *dev, Error **errp)
 {
     OHCISysBusState *s = SYSBUS_OHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *err = NULL;
 
-    /* Cannot fail as we pass NULL for masterbus */
-    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset, NULL, 0,
-                  &address_space_memory, &error_abort);
+    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
+                  s->masterbus, s->firstport,
+                  &address_space_memory, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_init_irq(sbd, &s->ohci.irq);
     sysbus_init_mmio(sbd, &s->ohci.mem);
 }
@@ -2142,7 +2149,9 @@ static const TypeInfo ohci_pci_info = {
 };
 
 static Property ohci_sysbus_properties[] = {
+    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
+    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
     DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.7.4
