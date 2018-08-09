Received: from eggs.gnu.org ([2001:4830:134:3::10]:57130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneWM-0001Fs-2r
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fneVs-0007B0-KT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:34:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fneVs-00079z-5r
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 02:33:36 -0400
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so2362341pfi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 23:33:36 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  9 Aug 2018 14:33:16 +0800
Message-Id: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v4 1/6] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by default,
change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of PCIe

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 127 ++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index e62de42..6dd38de 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -15,10 +15,12 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "qapi/visitor.h"
 
 #define TYPE_PXB_BUS "pxb-bus"
 #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
@@ -40,11 +42,20 @@ typedef struct PXBBus {
 #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
 #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCIE_DEVICE)
 
+#define PROP_PXB_PCIE_DEV "pxbdev"
+
+#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
+#define PROP_PXB_PCIE_MAX_BUS "max_bus"
+#define PROP_PXB_BUS_NR "bus_nr"
+#define PROP_PXB_NUMA_NODE "numa_node"
+
 typedef struct PXBDev {
     /*< private >*/
     PCIDevice parent_obj;
     /*< public >*/
 
+    uint32_t domain_nr; /* PCI domain number, non-zero means separate domain */
+    uint8_t max_bus;    /* max bus number to use(including this one) */
     uint8_t bus_nr;
     uint16_t numa_node;
 } PXBDev;
@@ -58,6 +69,16 @@ static PXBDev *convert_to_pxb(PCIDevice *dev)
 static GList *pxb_dev_list;
 
 #define TYPE_PXB_HOST "pxb-host"
+#define TYPE_PXB_PCIE_HOST "pxb-pcie-host"
+#define PXB_PCIE_HOST_DEVICE(obj) \
+     OBJECT_CHECK(PXBPCIEHost, (obj), TYPE_PXB_PCIE_HOST)
+
+typedef struct PXBPCIEHost {
+    PCIExpressHost parent_obj;
+
+    /* pointers to PXBDev */
+    PXBDev *pxbdev;
+} PXBPCIEHost;
 
 static int pxb_bus_num(PCIBus *bus)
 {
@@ -111,6 +132,35 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
     return bus->bus_path;
 }
 
+/* Use a dedicated function for PCIe since pxb-host does
+ * not have a domain_nr field */
+static const char *pxb_pcie_host_root_bus_path(PCIHostState *host_bridge,
+                                          PCIBus *rootbus)
+{
+    if (!pci_bus_is_express(rootbus)) {
+        /* pxb-pcie-host cannot reside on a PCI bus */
+        return NULL;
+    }
+    PXBBus *bus = PXB_PCIE_BUS(rootbus);
+
+    /* get the pointer to PXBDev */
+    Object *obj = object_property_get_link(OBJECT(host_bridge),
+                                           PROP_PXB_PCIE_DEV, NULL);
+
+    snprintf(bus->bus_path, 8, "%04lx:%02x",
+             object_property_get_uint(obj, PROP_PXB_PCIE_DOMAIN_NR, NULL),
+             pxb_bus_num(rootbus));
+    return bus->bus_path;
+}
+
+static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
+{
+    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
+
+    visit_type_uint64(v, name, &e->size, errp);
+}
+
 static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
 {
     const PCIHostState *pxb_host;
@@ -142,6 +192,31 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     return NULL;
 }
 
+static void pxb_pcie_host_initfn(Object *obj)
+{
+    PXBPCIEHost *s = PXB_PCIE_HOST_DEVICE(obj);
+    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
+
+    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
+                          "pci-conf-idx", 4);
+    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
+                          "pci-conf-data", 4);
+
+    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
+                         pxb_pcie_host_get_mmcfg_size,
+                         NULL, NULL, NULL, NULL);
+
+    object_property_add_link(obj, PROP_PXB_PCIE_DEV, TYPE_PXB_PCIE_DEVICE,
+                         (Object **)&s->pxbdev,
+                         qdev_prop_allow_set_link_before_realize, 0, NULL);
+}
+
+static Property pxb_pcie_host_props[] = {
+    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.base_addr,
+                        PCIE_BASE_ADDR_UNMAPPED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pxb_host_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -155,12 +230,34 @@ static void pxb_host_class_init(ObjectClass *class, void *data)
     hc->root_bus_path = pxb_host_root_bus_path;
 }
 
+static void pxb_pcie_host_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    dc->fw_name = "pcie";
+    dc->props = pxb_pcie_host_props;
+    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
+    dc->user_creatable = false;
+    sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
+    hc->root_bus_path = pxb_pcie_host_root_bus_path;
+}
+
 static const TypeInfo pxb_host_info = {
     .name          = TYPE_PXB_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .class_init    = pxb_host_class_init,
 };
 
+static const TypeInfo pxb_pcie_host_info = {
+    .name          = TYPE_PXB_PCIE_HOST,
+    .parent        = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(PXBPCIEHost),
+    .instance_init = pxb_pcie_host_initfn,
+    .class_init    = pxb_pcie_host_class_init,
+};
+
 /*
  * Registers the PXB bus as a child of pci host root bus.
  */
@@ -205,7 +302,10 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
     const PXBDev *pxb_a = a, *pxb_b = b;
 
-    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
+    /* check domain_nr, then bus_nr */
+    return pxb_a->domain_nr < pxb_b->domain_nr ? -1 :
+           pxb_a->domain_nr > pxb_b->domain_nr ?  1 :
+           pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
            pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
            0;
 }
@@ -228,10 +328,16 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
         dev_name = dev->qdev.id;
     }
 
-    ds = qdev_create(NULL, TYPE_PXB_HOST);
     if (pcie) {
+        g_assert (pxb->max_bus >= pxb->bus_nr);
+        ds = qdev_create(NULL, TYPE_PXB_PCIE_HOST);
+
+        object_property_set_link(OBJECT(ds), OBJECT(pxb),
+                                 PROP_PXB_PCIE_DEV, NULL);
+
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else {
+        ds = qdev_create(NULL, TYPE_PXB_HOST);
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
         bds = qdev_create(BUS(bus), "pci-bridge");
         bds->id = dev_name;
@@ -289,8 +395,18 @@ static void pxb_dev_exitfn(PCIDevice *pci_dev)
 
 static Property pxb_dev_properties[] = {
     /* Note: 0 is not a legal PXB bus number. */
-    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
-    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
+    DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
+    DEFINE_PROP_UINT16(PROP_PXB_NUMA_NODE, PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property pxb_pcie_dev_properties[] = {
+    DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
+    DEFINE_PROP_UINT16(PROP_PXB_NUMA_NODE, PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
+    DEFINE_PROP_UINT32(PROP_PXB_PCIE_DOMAIN_NR, PXBDev, domain_nr, 0),
+    /* set a small default value, bus interval is [bus_nr, max_bus] */
+    DEFINE_PROP_UINT8(PROP_PXB_PCIE_MAX_BUS, PXBDev, max_bus, 16),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -344,7 +460,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_HOST;
 
     dc->desc = "PCI Express Expander Bridge";
-    dc->props = pxb_dev_properties;
+    dc->props = pxb_pcie_dev_properties;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
@@ -365,6 +481,7 @@ static void pxb_register_types(void)
     type_register_static(&pxb_bus_info);
     type_register_static(&pxb_pcie_bus_info);
     type_register_static(&pxb_host_info);
+    type_register_static(&pxb_pcie_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
 }
-- 
2.7.4
