Received: from eggs.gnu.org ([2001:4830:134:3::10]:59529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdvV-0005Vz-O0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdvR-0001pI-TA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkdvR-0001ol-Na
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D50514E4D3
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 22:15:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 23 Aug 2017 19:14:41 -0300
Message-Id: <20170823221445.15243-2-ehabkost@redhat.com>
In-Reply-To: <20170823221445.15243-1-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] pci: INTERFACE_LEGACY_PCI_DEVICE and
 INTERFACE_PCIE_DEVICE interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Those two interfaces will be used to indicate which device types
support legacy PCI or PCI-express buses.  Management software
will be able to use the qom-list-types QMP command to query that
information.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/pci/pci.h |  6 ++++++
 hw/pci/pci.c         | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e598b09..f5e8ab9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -195,6 +195,12 @@ enum {
 #define PCI_DEVICE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
 
+/* Interface implemented by devices that can be plugged on PCIe buses */
+#define INTERFACE_PCIE_DEVICE "pci-express-device"
+
+/* Interface implemented by devices that can be plugged on legacy PCI buses */
+#define INTERFACE_LEGACY_PCI_DEVICE "legacy-pci-device"
+
 typedef struct PCIINTxRoute {
     enum {
         PCI_INTX_ENABLED,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 258fbe5..baa3429 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -168,6 +168,16 @@ static const TypeInfo pci_bus_info = {
     .class_init = pci_bus_class_init,
 };
 
+static const TypeInfo pcie_interface_info = {
+    .name          = INTERFACE_PCIE_DEVICE,
+    .parent        = TYPE_INTERFACE,
+};
+
+static const TypeInfo legacy_pci_interface_info = {
+    .name          = INTERFACE_LEGACY_PCI_DEVICE,
+    .parent        = TYPE_INTERFACE,
+};
+
 static const TypeInfo pcie_bus_info = {
     .name = TYPE_PCIE_BUS,
     .parent = TYPE_PCI_BUS,
@@ -2645,6 +2655,8 @@ static void pci_register_types(void)
 {
     type_register_static(&pci_bus_info);
     type_register_static(&pcie_bus_info);
+    type_register_static(&legacy_pci_interface_info);
+    type_register_static(&pcie_interface_info);
     type_register_static(&pci_device_type_info);
 }
 
-- 
2.9.4
