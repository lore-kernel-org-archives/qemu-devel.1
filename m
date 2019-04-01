Received: from eggs.gnu.org ([209.51.188.92]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19z-0006iM-Nr
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19r-00007q-Je
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hB19n-0008Tz-MY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31HtWKc117121
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 13:55:36 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkpwr9u4q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 13:55:34 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 1 Apr 2019 18:55:05 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 01 Apr 2019 19:55:02 +0200
In-Reply-To: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
References: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155414130271.574858.4253514266378127489.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH for-4.0 1/2] pci: Allow PCI bus subtypes to
 support extended config space accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Some PHB implementations, eg. PAPR used on pseries machine, act like
a regular PCI bus rather than a PCIe bus, but allow access to the
PCIe extended config space anyway.

Introduce a new PCI bus class method to modelize this behaviour and
use it when adjusting the config space size limit during accesses.

No behaviour change for existing PCI bus types.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/pci/pci.c             |   24 ++++++++++++++++++++++++
 hw/pci/pci_host.c        |    2 +-
 include/hw/pci/pci.h     |    2 ++
 include/hw/pci/pci_bus.h |    1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 35451c1e9987..6d13ef877b42 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -147,6 +147,11 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+static bool pcibus_allows_extended_config_space(PCIBus *bus)
+{
+    return false;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -162,6 +167,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
     pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
     pbc->numa_node = pcibus_numa_node;
+    pbc->allows_extended_config_space = pcibus_allows_extended_config_space;
 }
 
 static const TypeInfo pci_bus_info = {
@@ -182,9 +188,22 @@ static const TypeInfo conventional_pci_interface_info = {
     .parent        = TYPE_INTERFACE,
 };
 
+static bool pciebus_allows_extended_config_space(PCIBus *bus)
+{
+    return true;
+}
+
+static void pcie_bus_class_init(ObjectClass *klass, void *data)
+{
+    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
+
+    pbc->allows_extended_config_space = pciebus_allows_extended_config_space;
+}
+
 static const TypeInfo pcie_bus_info = {
     .name = TYPE_PCIE_BUS,
     .parent = TYPE_PCI_BUS,
+    .class_init = pcie_bus_class_init,
 };
 
 static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
@@ -401,6 +420,11 @@ bool pci_bus_is_root(PCIBus *bus)
     return PCI_BUS_GET_CLASS(bus)->is_root(bus);
 }
 
+bool pci_bus_allows_extended_config_space(PCIBus *bus)
+{
+    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
+}
+
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5f5345dbac67..9d64b2e12f2c 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -54,7 +54,7 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus *bus, uint32_t addr)
 static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
 {
     if (*limit > PCI_CONFIG_SPACE_SIZE) {
-        if (!pci_bus_is_express(bus)) {
+        if (!pci_bus_allows_extended_config_space(bus)) {
             *limit = PCI_CONFIG_SPACE_SIZE;
             return;
         }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d87f5f93e9cd..0abb06b35747 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -396,6 +396,8 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
+bool pci_bus_allows_extended_config_space(PCIBus *bus);
+
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index dfb75752cbc1..f6df834170c5 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -18,6 +18,7 @@ typedef struct PCIBusClass {
     bool (*is_root)(PCIBus *bus);
     int (*bus_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
+    bool (*allows_extended_config_space)(PCIBus *bus);
 } PCIBusClass;
 
 struct PCIBus {
