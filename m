Received: from eggs.gnu.org ([2001:4830:134:3::10]:33438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNw3-0000MV-7O
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNw2-0008VV-Du
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:19 -0400
Received: from chuckie.co.uk ([82.165.15.123]:54688
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTNw2-0008Sm-6d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:18 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Jul 2017 08:44:02 +0100
Message-Id: <1499413442-5053-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] pci: add reserved slot check to
 do_pci_register_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 239161e..9dece2a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -961,6 +961,15 @@ static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
     }
 }
 
+static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
+{
+    if (bus->dev_reserved_mask & (1UL << PCI_SLOT(devfn))) {
+        return true;
+    } else {
+        return false;
+    }
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -984,14 +993,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (devfn < 0) {
         for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
             devfn += PCI_FUNC_MAX) {
-            if (pci_bus_devfn_available(bus, devfn)) {
+            if (pci_bus_devfn_available(bus, devfn) &&
+                   !pci_bus_devfn_reserved(bus, devfn)) {
                 goto found;
             }
         }
-        error_setg(errp, "PCI: no slot/function available for %s, all in use",
-                   name);
+        error_setg(errp, "PCI: no slot/function available for %s, all in use "
+                   "or reserved", name);
         return NULL;
     found: ;
+    } else if (pci_bus_devfn_reserved(bus, devfn)) {
+        error_setg(errp, "PCI: slot %d function %d not available for %s,"
+                   " reserved",
+                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
+        return NULL;
     } else if (!pci_bus_devfn_available(bus, devfn)) {
         error_setg(errp, "PCI: slot %d function %d not available for %s,"
                    " in use by %s",
-- 
1.7.10.4
