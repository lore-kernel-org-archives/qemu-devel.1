Received: from eggs.gnu.org ([2001:4830:134:3::10]:57085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48V-0002RO-T7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48S-00021E-Qp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:47 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:52524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da48S-0001yR-4J
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:44 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A8E64116677
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:42 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:00:34 +0200
Message-ID: <150100563478.27487.17227002781587919515.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 12/26] pci: allow
 cleanup/unregistration of PCI buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This adds cleanup counterparts to pci_register_bus(),
pci_bus_new(), and pci_bus_irqs().

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
---
Changes since RFC:
- rebased against ppc-for-2.10
- renamed arg of pci_host_bus_register() to host for consistency
---
 hw/pci/pci.c         |   33 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |    3 +++
 2 files changed, 36 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 258fbe51e2ee..22765b8529d1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -319,6 +319,13 @@ static void pci_host_bus_register(DeviceState *host)
     QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
 }
 
+static void pci_host_bus_unregister(DeviceState *host)
+{
+    PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
+
+    QLIST_REMOVE(host_bridge, next);
+}
+
 PCIBus *pci_find_primary_bus(void)
 {
     PCIBus *primary_bus = NULL;
@@ -380,6 +387,11 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
     pci_host_bus_register(parent);
 }
 
+static void pci_bus_uninit(PCIBus *bus)
+{
+    pci_host_bus_unregister(BUS(bus)->parent);
+}
+
 bool pci_bus_is_express(PCIBus *bus)
 {
     return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
@@ -412,6 +424,12 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
     return bus;
 }
 
+void pci_bus_cleanup(PCIBus *bus)
+{
+    pci_bus_uninit(bus);
+    object_unparent(OBJECT(bus));
+}
+
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                   void *irq_opaque, int nirq)
 {
@@ -422,6 +440,15 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
     bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
 }
 
+void pci_bus_irqs_cleanup(PCIBus *bus)
+{
+    bus->set_irq = NULL;
+    bus->map_irq = NULL;
+    bus->irq_opaque = NULL;
+    bus->nirq = 0;
+    g_free(bus->irq_count);
+}
+
 PCIBus *pci_register_bus(DeviceState *parent, const char *name,
                          pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                          void *irq_opaque,
@@ -437,6 +464,12 @@ PCIBus *pci_register_bus(DeviceState *parent, const char *name,
     return bus;
 }
 
+void pci_unregister_bus(PCIBus *bus)
+{
+    pci_bus_irqs_cleanup(bus);
+    pci_bus_cleanup(bus);
+}
+
 int pci_bus_num(PCIBus *s)
 {
     return PCI_BUS_GET_CLASS(s)->bus_num(s);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e598b095ebca..3667e4cda73e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -400,8 +400,10 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
                     uint8_t devfn_min, const char *typename);
+void pci_bus_cleanup(PCIBus *bus);
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                   void *irq_opaque, int nirq);
+void pci_bus_irqs_cleanup(PCIBus *bus);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
@@ -411,6 +413,7 @@ PCIBus *pci_register_bus(DeviceState *parent, const char *name,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, int nirq, const char *typename);
+void pci_unregister_bus(PCIBus *bus);
 void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
 PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
 bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
