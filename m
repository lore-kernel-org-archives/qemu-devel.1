Received: from eggs.gnu.org ([2001:4830:134:3::10]:54311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Ega-0000a3-TR
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgZ-0005rS-PX
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0EgZ-0005rC-H4
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:15 -0300
Message-Id: <20170417215916.12431-7-ehabkost@redhat.com>
In-Reply-To: <20170417215916.12431-1-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 6/7] pci: Set phb->bus inside pci_bus_new()
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

Every single caller of pci_bus_new() saves the return value inside
phb->bus. Do that inside pci_bus_new() to avoid code duplication and
make it harder to break.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 2 --
 hw/pci-host/piix.c                  | 1 -
 hw/pci-host/q35.c                   | 6 +++---
 hw/pci/pci.c                        | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 39d29d2230..8344ca1cc8 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -245,8 +245,6 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     bus->address_space_io = dev->bus->address_space_io;
     bus->map_irq = pxb_map_irq_fn;
 
-    phb->bus = bus;
-
     pxb_register_bus(dev, bus, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 91fec05b38..818e4979d8 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -342,7 +342,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     s = PCI_HOST_BRIDGE(dev);
     b = pci_bus_new(s, NULL, pci_address_space,
                     address_space_io, 0, TYPE_PCI_BUS);
-    s->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 860b47a1ba..5b41412075 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -49,9 +49,9 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
     sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
 
-    pci->bus = pci_bus_new(pci, "pcie.0",
-                           s->mch.pci_address_space, s->mch.address_space_io,
-                           0, TYPE_PCIE_BUS);
+    pci_bus_new(pci, "pcie.0",
+                s->mch.pci_address_space, s->mch.address_space_io,
+                0, TYPE_PCIE_BUS);
     PC_MACHINE(qdev_get_machine())->bus = pci->bus;
     qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->mch));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3adf806e5..486aeb7514 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -408,6 +408,7 @@ PCIBus *pci_bus_new(PCIHostState *phb, const char *name,
 
     bus = PCI_BUS(qbus_create(typename, DEVICE(phb), name));
     pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_min);
+    phb->bus = bus;
     return bus;
 }
 
@@ -433,7 +434,6 @@ void pci_register_bus(PCIHostState *phb, const char *name,
     bus = pci_bus_new(phb, name, address_space_mem,
                       address_space_io, devfn_min, typename);
     pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
-    phb->bus = bus;
 }
 
 int pci_bus_num(PCIBus *s)
-- 
2.11.0.259.g40922b1
