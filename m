Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIS5-0006JG-2c
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIS2-0007AK-13
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxIS1-0007A0-Qa
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:56:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 16:56:31 -0300
Message-Id: <20170927195635.16014-2-ehabkost@redhat.com>
In-Reply-To: <20170927195635.16014-1-ehabkost@redhat.com>
References: <20170927195635.16014-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] pci: conventional-pci-device and
 pci-express-device interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Those two interfaces will be used to indicate which device types
support Conventional PCI or PCI Express buses.  Management
software will be able to use the qom-list-types QMP command to
query that information.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* s/legacy/conventional/
  * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/hw/pci/pci.h |  6 ++++++
 hw/pci/pci.c         | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index aa7ef9cf69..8d02a0a383 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -198,6 +198,12 @@ enum {
 #define PCI_DEVICE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
 
+/* Implemented by devices that can be plugged on PCI Express buses */
+#define INTERFACE_PCIE_DEVICE "pci-express-device"
+
+/* Implemented by devices that can be plugged on Conventional PCI buses */
+#define INTERFACE_CONVENTIONAL_PCI_DEVICE "conventional-pci-device"
+
 typedef struct PCIINTxRoute {
     enum {
         PCI_INTX_ENABLED,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88eba..1b08e18205 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -170,6 +170,16 @@ static const TypeInfo pci_bus_info = {
     .class_init = pci_bus_class_init,
 };
 
+static const TypeInfo pcie_interface_info = {
+    .name          = INTERFACE_PCIE_DEVICE,
+    .parent        = TYPE_INTERFACE,
+};
+
+static const TypeInfo conventional_pci_interface_info = {
+    .name          = INTERFACE_CONVENTIONAL_PCI_DEVICE,
+    .parent        = TYPE_INTERFACE,
+};
+
 static const TypeInfo pcie_bus_info = {
     .name = TYPE_PCIE_BUS,
     .parent = TYPE_PCI_BUS,
@@ -2667,6 +2677,8 @@ static void pci_register_types(void)
 {
     type_register_static(&pci_bus_info);
     type_register_static(&pcie_bus_info);
+    type_register_static(&conventional_pci_interface_info);
+    type_register_static(&pcie_interface_info);
     type_register_static(&pci_device_type_info);
 }
 
-- 
2.13.5
