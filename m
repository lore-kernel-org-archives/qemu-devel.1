Received: from eggs.gnu.org ([2001:4830:134:3::10]:54196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgL-0000PP-KP
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgI-0005mU-L1
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0EgI-0005mI-ER
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:11 -0300
Message-Id: <20170417215916.12431-3-ehabkost@redhat.com>
In-Reply-To: <20170417215916.12431-1-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 2/7] pci: Change pci_bus_init() 'parent'
 parameter to PCIHostState
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

pci_bus_init() already requires 'parent' to be a PCI_HOST_BRIDGE object,
so change the parameter type to reflect that.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 25118fb91d..d9535c0bdc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -362,7 +362,7 @@ const char *pci_root_bus_path(PCIDevice *dev)
     return rootbus->qbus.name;
 }
 
-static void pci_bus_init(PCIBus *bus, DeviceState *parent,
+static void pci_bus_init(PCIBus *bus, PCIHostState *phb,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min)
@@ -375,7 +375,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
     /* host bridge */
     QLIST_INIT(&bus->child);
 
-    pci_host_bus_register(PCI_HOST_BRIDGE(host));
+    pci_host_bus_register(phb);
 }
 
 bool pci_bus_is_express(PCIBus *bus)
@@ -394,8 +394,9 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, const char *typename)
 {
+    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
     qbus_create_inplace(bus, bus_size, typename, parent, name);
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_min);
 }
 
 PCIBus *pci_bus_new(DeviceState *parent, const char *name,
@@ -403,10 +404,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
                     MemoryRegion *address_space_io,
                     uint8_t devfn_min, const char *typename)
 {
+    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
     PCIBus *bus;
 
     bus = PCI_BUS(qbus_create(typename, parent, name));
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_min);
     return bus;
 }
 
-- 
2.11.0.259.g40922b1
