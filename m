Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRS-0000i9-I1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRP-0002T6-EE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0bRP-0002Sh-4r
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:17:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:20 -0300
Message-Id: <20170418221724.5707-3-ehabkost@redhat.com>
In-Reply-To: <20170418221724.5707-1-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/6] pci: Move pci_bus_init() logic to
 pci_bus_new_inplace()
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

Instead of having 3 separate functions, just make pci_bus_new() a
wrapper that allocates the object and calls pci_bus_new_inplace().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 328f36cd21..0d28ee4e3f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -357,24 +357,6 @@ const char *pci_root_bus_path(PCIDevice *dev)
     return rootbus->qbus.name;
 }
 
-static void pci_bus_init(PCIBus *bus, DeviceState *parent,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
-                         uint8_t devfn_min)
-{
-    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
-
-    assert(PCI_FUNC(devfn_min) == 0);
-    bus->devfn_min = devfn_min;
-    bus->address_space_mem = address_space_mem;
-    bus->address_space_io = address_space_io;
-
-    /* host bridge */
-    QLIST_INIT(&bus->child);
-
-    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
-}
-
 bool pci_bus_is_express(PCIBus *bus)
 {
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
@@ -391,8 +373,20 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, const char *typename)
 {
+    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
+
     qbus_create_inplace(bus, bus_size, typename, parent, name);
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+
+    assert(PCI_FUNC(devfn_min) == 0);
+    bus->devfn_min = devfn_min;
+    bus->address_space_mem = address_space_mem;
+    bus->address_space_io = address_space_io;
+
+    /* host bridge */
+    QLIST_INIT(&bus->child);
+
+    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
+
 }
 
 PCIBus *pci_bus_new(DeviceState *parent, const char *name,
@@ -400,10 +394,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
                     MemoryRegion *address_space_io,
                     uint8_t devfn_min, const char *typename)
 {
-    PCIBus *bus;
+    size_t bus_size = object_type_get_instance_size(typename);
+    PCIBus *bus = g_malloc(bus_size);
 
-    bus = PCI_BUS(qbus_create(typename, parent, name));
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+    pci_bus_new_inplace(bus, bus_size, parent, name, address_space_mem,
+                        address_space_io, devfn_min, typename);
     return bus;
 }
 
-- 
2.11.0.259.g40922b1
