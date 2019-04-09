Received: from eggs.gnu.org ([209.51.188.92]:55038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDksC-0005gl-2T
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDksA-0005Dr-QJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  9 Apr 2019 17:08:29 +1000
Message-Id: <20190409070830.22430-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190409070830.22430-1-david@gibson.dropbear.id.au>
References: <20190409070830.22430-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] pci: Allow PCI bus subtypes to support
 extended config space accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, mst@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, clg@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Some PHB implementations, eg. PAPR used on pseries machine, act like
a regular PCI bus rather than a PCIe bus, but allow access to the
PCIe extended config space anyway.

Introduce a new PCI bus class method to modelize this behaviour and
use it when adjusting the config space size limit during accesses.

No behaviour change for existing PCI bus types.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155414130271.574858.4253514266378127489.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c             | 24 ++++++++++++++++++++++++
 hw/pci/pci_host.c        |  2 +-
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 35451c1e99..6d13ef877b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -147,6 +147,11 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
=20
+static bool pcibus_allows_extended_config_space(PCIBus *bus)
+{
+    return false;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k =3D BUS_CLASS(klass);
@@ -162,6 +167,7 @@ static void pci_bus_class_init(ObjectClass *klass, vo=
id *data)
     pbc->is_root =3D pcibus_is_root;
     pbc->bus_num =3D pcibus_num;
     pbc->numa_node =3D pcibus_numa_node;
+    pbc->allows_extended_config_space =3D pcibus_allows_extended_config_=
space;
 }
=20
 static const TypeInfo pci_bus_info =3D {
@@ -182,9 +188,22 @@ static const TypeInfo conventional_pci_interface_inf=
o =3D {
     .parent        =3D TYPE_INTERFACE,
 };
=20
+static bool pciebus_allows_extended_config_space(PCIBus *bus)
+{
+    return true;
+}
+
+static void pcie_bus_class_init(ObjectClass *klass, void *data)
+{
+    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
+
+    pbc->allows_extended_config_space =3D pciebus_allows_extended_config=
_space;
+}
+
 static const TypeInfo pcie_bus_info =3D {
     .name =3D TYPE_PCIE_BUS,
     .parent =3D TYPE_PCI_BUS,
+    .class_init =3D pcie_bus_class_init,
 };
=20
 static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
@@ -401,6 +420,11 @@ bool pci_bus_is_root(PCIBus *bus)
     return PCI_BUS_GET_CLASS(bus)->is_root(bus);
 }
=20
+bool pci_bus_allows_extended_config_space(PCIBus *bus)
+{
+    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
+}
+
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState =
*parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5f5345dbac..9d64b2e12f 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -54,7 +54,7 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *b=
us, uint32_t addr)
 static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
 {
     if (*limit > PCI_CONFIG_SPACE_SIZE) {
-        if (!pci_bus_is_express(bus)) {
+        if (!pci_bus_allows_extended_config_space(bus)) {
             *limit =3D PCI_CONFIG_SPACE_SIZE;
             return;
         }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d87f5f93e9..0abb06b357 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -396,6 +396,8 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque=
, int pin);
=20
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
+bool pci_bus_allows_extended_config_space(PCIBus *bus);
+
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState =
*parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index dfb75752cb..f6df834170 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -18,6 +18,7 @@ typedef struct PCIBusClass {
     bool (*is_root)(PCIBus *bus);
     int (*bus_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
+    bool (*allows_extended_config_space)(PCIBus *bus);
 } PCIBusClass;
=20
 struct PCIBus {
--=20
2.20.1
