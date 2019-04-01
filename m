Received: from eggs.gnu.org ([209.51.188.92]:34366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19r-0006aa-Kr
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hB19p-00005o-Jr
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35756
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hB19n-0008Mg-MY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:55:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31HsdXd156891
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 13:55:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkpvua0e0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 13:55:15 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 1 Apr 2019 18:55:13 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 01 Apr 2019 19:55:08 +0200
In-Reply-To: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
References: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155414130834.574858.16502276132110219890.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH for-4.0 2/2] spapr_pci: Fix extended config
 space accesses
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

The PAPR PHB acts as a legacy PCI bus but it allows PCIe extended
config space accesses anyway (for pseries-2.9 and newer machine
types).

Introduce a specific PCI bus subtype to inform the common PCI code
about that.

Fixes: c2077e2ca0da7
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bba3a86dda6c..68cc15d2f534 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1642,6 +1642,28 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
 }
 
+static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
+{
+    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
+
+    return sphb->pcie_ecs;
+}
+
+static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data)
+{
+    PCIBusClass *pbc = PCI_BUS_CLASS(klass);
+
+    pbc->allows_extended_config_space = spapr_phb_allows_extended_config_space;
+}
+
+#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+
+static const TypeInfo spapr_phb_root_bus_info = {
+    .name = TYPE_SPAPR_PHB_ROOT_BUS,
+    .parent = TYPE_PCI_BUS,
+    .class_init = spapr_phb_root_bus_class_init,
+};
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
@@ -1746,7 +1768,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     bus = pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sphb,
                                 &sphb->memspace, &sphb->iospace,
-                                PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
+                                PCI_DEVFN(0, 0), PCI_NUM_PINS,
+                                TYPE_SPAPR_PHB_ROOT_BUS);
     phb->bus = bus;
     qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
 
@@ -2344,6 +2367,7 @@ void spapr_pci_rtas_init(void)
 static void spapr_pci_register_types(void)
 {
     type_register_static(&spapr_phb_info);
+    type_register_static(&spapr_phb_root_bus_info);
 }
 
 type_init(spapr_pci_register_types)
