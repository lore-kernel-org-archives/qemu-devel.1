Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huan.xiong@hxt-semitech.com>) id 1gUTi9-0001y2-RC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huan.xiong@hxt-semitech.com>) id 1gUTi5-00036B-CT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:43:17 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:56579
	helo=barracuda.hxt-semitech.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <huan.xiong@hxt-semitech.com>)
	id 1gUTi4-0002kv-Fu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:43:13 -0500
From: Huan Xiong <huan.xiong@hxt-semitech.com>
Date: Wed, 5 Dec 2018 17:41:26 +0800
Message-ID: <1544002886-11333-1-git-send-email-huan.xiong@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/pci-bridge: check invalid slot number for
 root and downstream port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com

Since root and downstream port have only one slot, device should be
connected to them using slot 0. QEMU doesn't have a check for that
and starts up when a non-zero slot is specified, though the device
is not seen in guest OS.

The change fixes that by adding a check in PCI device "attr" property
setter function. The check is performed only if a PCI device has been
connected to a bus, otherwise it does nothing. The latter occurs because
setter function is also called in object instantiation phase to set
property default value.

Signed-off-by: Huan Xiong <huan.xiong@hxt-semitech.com>
---
 hw/core/qdev-properties.c          |  5 ++++-
 hw/pci-bridge/pcie_root_port.c     |  2 +-
 hw/pci-bridge/xio3130_downstream.c |  2 +-
 hw/pci/pci.c                       | 13 +++++++++++++
 include/hw/pci/pci.h               |  1 +
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 35072de..6e79219 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -654,6 +654,8 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
+    BusState *bus = qdev_get_parent_bus(dev);
+    BusClass *bus_class = bus ? BUS_GET_CLASS(bus) : NULL;
     Property *prop = opaque;
     int32_t value, *ptr = qdev_get_prop_ptr(dev, prop);
     unsigned int slot, fn, n;
@@ -687,7 +689,8 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
             goto invalid;
         }
     }
-    if (str[n] != '\0' || fn > 7 || slot > 31) {
+    if (str[n] != '\0' || fn > 7 || slot > 31 || (bus_class &&
+        bus_class->max_dev != 0 && slot >= bus_class->max_dev)) {
         goto invalid;
     }
     *ptr = slot << 3 | fn;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 45f9e8c..ee42411 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -61,7 +61,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     int rc;
 
     pci_config_set_interrupt_pin(d->config, 1);
-    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pci_bridge_initfn(d, TYPE_PCIE_DOWNSTREAM_BUS);
     pcie_port_init_reg(d);
 
     rc = pci_bridge_ssvid_init(d, rpc->ssvid_offset, dc->vendor_id,
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 467bbab..960a90c 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -62,7 +62,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     PCIESlot *s = PCIE_SLOT(d);
     int rc;
 
-    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pci_bridge_initfn(d, TYPE_PCIE_DOWNSTREAM_BUS);
     pcie_port_init_reg(d);
 
     rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 56b13b3..457736d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -187,6 +187,18 @@ static const TypeInfo pcie_bus_info = {
     .parent = TYPE_PCI_BUS,
 };
 
+static void pcie_downstream_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    k->max_dev = 1;
+}
+
+static const TypeInfo pcie_downstream_bus_info = {
+    .name = TYPE_PCIE_DOWNSTREAM_BUS,
+    .parent = TYPE_PCIE_BUS,
+    .class_init = pcie_downstream_bus_class_init,
+};
+
 static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num);
 static void pci_update_mappings(PCIDevice *d);
 static void pci_irq_handler(void *opaque, int irq_num, int level);
@@ -2681,6 +2693,7 @@ static void pci_register_types(void)
 {
     type_register_static(&pci_bus_info);
     type_register_static(&pcie_bus_info);
+    type_register_static(&pcie_downstream_bus_info);
     type_register_static(&conventional_pci_interface_info);
     type_register_static(&pcie_interface_info);
     type_register_static(&pci_device_type_info);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bb..2253757 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -393,6 +393,7 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 #define PCI_BUS_CLASS(klass) OBJECT_CLASS_CHECK(PCIBusClass, (klass), TYPE_PCI_BUS)
 #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
 #define TYPE_PCIE_BUS "PCIE"
+#define TYPE_PCIE_DOWNSTREAM_BUS "PCIE-downstream"
 
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
-- 
2.7.4
