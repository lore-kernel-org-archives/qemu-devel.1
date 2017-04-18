Received: from eggs.gnu.org ([2001:4830:134:3::10]:56604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRK-0000d4-Lh
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRJ-0002Qm-SZ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0bRJ-0002QQ-MX
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:19 -0300
Message-Id: <20170418221724.5707-2-ehabkost@redhat.com>
In-Reply-To: <20170418221724.5707-1-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/6] pci: Inline pci_host_bus_register()
 inside pci_bus_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

There's no need for a separate function just to append an item to
pci_host_bridges.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b1c0..328f36cd21 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -312,13 +312,6 @@ static void pcibus_reset(BusState *qbus)
     }
 }
 
-static void pci_host_bus_register(DeviceState *host)
-{
-    PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
-
-    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
-}
-
 PCIBus *pci_find_primary_bus(void)
 {
     PCIBus *primary_bus = NULL;
@@ -369,6 +362,8 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min)
 {
+    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
+
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
     bus->address_space_mem = address_space_mem;
@@ -377,7 +372,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
     /* host bridge */
     QLIST_INIT(&bus->child);
 
-    pci_host_bus_register(parent);
+    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
 }
 
 bool pci_bus_is_express(PCIBus *bus)
-- 
2.11.0.259.g40922b1
