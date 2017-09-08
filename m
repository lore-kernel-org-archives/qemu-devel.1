Received: from eggs.gnu.org ([2001:4830:134:3::10]:49263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK8H-0006zF-C0
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK8D-0005J9-Bx
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK8D-0005IJ-4d
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:41 -0400
Date: Fri, 8 Sep 2017 17:19:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-16-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/17] pci: move check for existing devfn into
 new pci_bus_devfn_available() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Marcel Apfelbaum <marcel@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also touch up the logic in do_pci_register_device() accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 26f346d..002e669 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -953,6 +953,11 @@ uint16_t pci_requester_id(PCIDevice *dev)
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
@@ -976,14 +981,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
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
MST
