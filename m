Received: from eggs.gnu.org ([209.51.188.92]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08y-000689-Ln
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08t-0006kl-9H
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:48 +1100
Message-Id: <20190108224600.23125-18-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/29] pci: allow cleanup/unregistration of PCI
 root buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This adds cleanup counterparts to pci_register_root_bus(),
pci_root_bus_new(), and pci_bus_irqs().

These cleanup routines are needed in the case of hotpluggable
PCIHostBridge implementations. Currently we can rely on the
object_unparent()'ing of the PCIHostState recursively unparenting
and cleaning up it's child buses, but we need explicit calls
to also:

  1) remove the PCIHostState from pci_host_bridges global list.
     otherwise, we risk accessing freed memory when we access
     the list later
  2) clean up memory allocated in pci_bus_irqs()

Both are handled outside the context of any particular bus or
host bridge's init/realize functions, making it difficult to
avoid the need for explicit cleanup functions without remodeling
how PCIHostBridges are created. So keep it simple and just add
them for now.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c         | 33 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d831fa0a36..46d5010fac 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -333,6 +333,13 @@ static void pci_host_bus_register(DeviceState *host)
     QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
 }
=20
+static void pci_host_bus_unregister(DeviceState *host)
+{
+    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
+
+    QLIST_REMOVE(host_bridge, next);
+}
+
 PCIBus *pci_device_root_bus(const PCIDevice *d)
 {
     PCIBus *bus =3D pci_get_bus(d);
@@ -379,6 +386,11 @@ static void pci_root_bus_init(PCIBus *bus, DeviceSta=
te *parent,
     pci_host_bus_register(parent);
 }
=20
+static void pci_bus_uninit(PCIBus *bus)
+{
+    pci_host_bus_unregister(BUS(bus)->parent);
+}
+
 bool pci_bus_is_express(PCIBus *bus)
 {
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
@@ -413,6 +425,12 @@ PCIBus *pci_root_bus_new(DeviceState *parent, const =
char *name,
     return bus;
 }
=20
+void pci_root_bus_cleanup(PCIBus *bus)
+{
+    pci_bus_uninit(bus);
+    object_unparent(OBJECT(bus));
+}
+
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn ma=
p_irq,
                   void *irq_opaque, int nirq)
 {
@@ -423,6 +441,15 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_ir=
q, pci_map_irq_fn map_irq,
     bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
 }
=20
+void pci_bus_irqs_cleanup(PCIBus *bus)
+{
+    bus->set_irq =3D NULL;
+    bus->map_irq =3D NULL;
+    bus->irq_opaque =3D NULL;
+    bus->nirq =3D 0;
+    g_free(bus->irq_count);
+}
+
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               pci_set_irq_fn set_irq, pci_map_irq_fn map=
_irq,
                               void *irq_opaque,
@@ -439,6 +466,12 @@ PCIBus *pci_register_root_bus(DeviceState *parent, c=
onst char *name,
     return bus;
 }
=20
+void pci_unregister_root_bus(PCIBus *bus)
+{
+    pci_bus_irqs_cleanup(bus);
+    pci_root_bus_cleanup(bus);
+}
+
 int pci_bus_num(PCIBus *s)
 {
     return PCI_BUS_GET_CLASS(s)->bus_num(s);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb12fa112e..d87f5f93e9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -405,8 +405,10 @@ PCIBus *pci_root_bus_new(DeviceState *parent, const =
char *name,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, const char *typename);
+void pci_root_bus_cleanup(PCIBus *bus);
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn ma=
p_irq,
                   void *irq_opaque, int nirq);
+void pci_bus_irqs_cleanup(PCIBus *bus);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
@@ -417,6 +419,7 @@ PCIBus *pci_register_root_bus(DeviceState *parent, co=
nst char *name,
                               MemoryRegion *address_space_io,
                               uint8_t devfn_min, int nirq,
                               const char *typename);
+void pci_unregister_root_bus(PCIBus *bus);
 void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
 PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
 bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
--=20
2.20.1
