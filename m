Received: from eggs.gnu.org ([2001:4830:134:3::10]:50902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWq8t-0003yG-24
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWq8q-0006Oq-AQ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:27:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47569
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dWq8q-0006NS-38
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:27:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 16 Jul 2017 21:27:33 +0100
Message-Id: <1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 1/2] pci: move check for existing devfn into
 new pci_bus_devfn_available() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

Also touch up the logic in do_pci_register_device() accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0c6f74a..efc9c86 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -951,6 +951,11 @@ uint16_t pci_requester_id(PCIDevice *dev)
     return pci_req_id_cache_extract(&dev->requester_id_cache);
 }
 
+static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
+{
+    return !(bus->devices[devfn]);
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -974,14 +979,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (devfn < 0) {
         for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
             devfn += PCI_FUNC_MAX) {
-            if (!bus->devices[devfn])
+            if (pci_bus_devfn_available(bus, devfn)) {
                 goto found;
+            }
         }
         error_setg(errp, "PCI: no slot/function available for %s, all in use",
                    name);
         return NULL;
     found: ;
-    } else if (bus->devices[devfn]) {
+    } else if (!pci_bus_devfn_available(bus, devfn)) {
         error_setg(errp, "PCI: slot %d function %d not available for %s,"
                    " in use by %s",
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
-- 
1.7.10.4
