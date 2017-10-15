Received: from eggs.gnu.org ([2001:4830:134:3::10]:49053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWY-0002ec-Ed
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWV-0006mE-9P
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWV-0006ku-2x
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:31 -0400
Date: Sun, 15 Oct 2017 06:23:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-16-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/26] pci: conventional-pci-device and
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Those two interfaces will be used to indicate which device types
support Conventional PCI or PCI Express buses.  Management
software will be able to use the qom-list-types QMP command to
query that information.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h |  6 ++++++
 hw/pci/pci.c         | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index aa7ef9c..8d02a0a 100644
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
index 1e6fb88..1b08e18 100644
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
MST
