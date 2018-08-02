Received: from eggs.gnu.org ([2001:4830:134:3::10]:44530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a5-0001KD-OY
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a2-0007Jq-Cq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fl3a2-0007J7-2s
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:10 -0400
Received: by mail-wm0-x244.google.com with SMTP id w24-v6so729491wmc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 19:43:09 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  2 Aug 2018 10:42:21 +0800
Message-Id: <1533177743-20894-5-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v3 4/6] pci_expander_bridge: Add config_read
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

This allows SeaBIOS to retrieve MCFG base and size when it initializes
pxb host bridges.

A backlink to PXBPCIEHost is added in PXBDev to achieve above goal

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci-bridge/pci_expander_bridge.c         | 55 +++++++++++++++++++++++++++++
 include/hw/pci-bridge/pci_expander_bridge.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index f50938f..cdfdb90 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -49,11 +49,18 @@ typedef struct PXBBus {
 #define PROP_PXB_PCIE_MAX_BUS "max_bus"
 #define PROP_PXB_NUMA_NODE "numa_node"
 
+typedef struct PXBPCIEHost PXBPCIEHost;
+typedef struct PXBDev PXBDev;
+
 typedef struct PXBDev {
     /*< private >*/
     PCIDevice parent_obj;
     /*< public >*/
 
+    /* backlink to PXBPCIEHost, this makes it easier to get
+     * mcfg properties in pxb-pcie-host bridge */
+    PXBPCIEHost *pxbhost;
+
     uint32_t domain_nr; /* PCI domain number, non-zero means separate domain */
     uint8_t max_bus;    /* max bus number to use(including this one) */
     uint8_t bus_nr;
@@ -342,9 +349,15 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     if (pcie) {
         g_assert (pxb->max_bus >= pxb->bus_nr);
         ds = qdev_create(NULL, TYPE_PXB_PCIE_HOST);
+        /* attach it under /machine, so that we can resolve a valid path in
+         * object_property_set_link below */
+        object_property_add_child(qdev_get_machine(), "pxb-pcie-host[*]", OBJECT(ds), NULL);
 
+        /* set link and backlink between PXBPCIEHost and PXBDev */
         object_property_set_link(OBJECT(ds), OBJECT(pxb),
                                  PROP_PXB_PCIE_DEV, errp);
+        object_property_set_link(OBJECT(pxb), OBJECT(ds),
+                                 PROP_PXB_PCIE_HOST, errp);
 
         /* will be overwritten by firmware, but kept for readability */
         qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
@@ -413,6 +426,36 @@ static void pxb_dev_exitfn(PCIDevice *pci_dev)
     pxb_dev_list = g_list_remove(pxb_dev_list, pxb);
 }
 
+static uint32_t pxb_pcie_config_read(PCIDevice *d, uint32_t address, int len)
+{
+    PXBDev *pxb = convert_to_pxb(d);
+    uint32_t val;
+    Object *host;
+
+   switch (address) {
+    case MCH_HOST_BRIDGE_PCIEXBAR:
+        host = object_property_get_link(OBJECT(pxb), PROP_PXB_PCIE_HOST, NULL);
+        assert(host);
+        val = object_property_get_uint(host, PCIE_HOST_MCFG_BASE, NULL) & 0xFFFFFFFF;
+        break;
+    case MCH_HOST_BRIDGE_PCIEXBAR + 4:
+        host = object_property_get_link(OBJECT(pxb), PROP_PXB_PCIE_HOST, NULL);
+        assert(host);
+        val = (object_property_get_uint(host, PCIE_HOST_MCFG_BASE, NULL) >> 32) & 0xFFFFFFFF;
+        break;
+    case MCH_HOST_BRIDGE_PCIEXBAR + 8:  // Fix me!
+        host = object_property_get_link(OBJECT(pxb), PROP_PXB_PCIE_HOST, NULL);
+        assert(host);
+        val = object_property_get_uint(host, PCIE_HOST_MCFG_SIZE, NULL) & 0xFFFFFFFF;
+        break;
+    default:
+        val = pci_default_read_config(d, address, len);
+        break;
+    }
+
+    return val;
+}
+
 static Property pxb_dev_properties[] = {
     /* Note: 0 is not a legal PXB bus number. */
     DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
@@ -447,6 +490,16 @@ static void pxb_dev_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
+static void pxb_pcie_dev_initfn(Object *obj)
+{
+    PXBDev *pxb = PXB_PCIE_DEV(obj);
+
+    /* Add backlink to pxb-pcie-host */
+    object_property_add_link(obj, PROP_PXB_PCIE_HOST, TYPE_PXB_PCIE_HOST,
+                         (Object **)&pxb->pxbhost,
+                         qdev_prop_allow_set_link_before_realize, 0, NULL);
+}
+
 static const TypeInfo pxb_dev_info = {
     .name          = TYPE_PXB_DEVICE,
     .parent        = TYPE_PCI_DEVICE,
@@ -478,6 +531,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
 
     k->realize = pxb_pcie_dev_realize;
     k->exit = pxb_dev_exitfn;
+    k->config_read = pxb_pcie_config_read;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PXB_PCIE;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
@@ -492,6 +546,7 @@ static const TypeInfo pxb_pcie_dev_info = {
     .name          = TYPE_PXB_PCIE_DEVICE,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PXBDev),
+    .instance_init = pxb_pcie_dev_initfn,
     .class_init    = pxb_pcie_dev_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
index 870c4cd..1119210 100644
--- a/include/hw/pci-bridge/pci_expander_bridge.h
+++ b/include/hw/pci-bridge/pci_expander_bridge.h
@@ -2,6 +2,7 @@
 #define HW_PCI_EXPANDER_H
 
 #define PROP_PXB_PCIE_DEV "pxbdev"
+#define PROP_PXB_PCIE_HOST "x-pxb-host"
 
 #define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
 #define PROP_PXB_BUS_NR "bus_nr"
-- 
2.7.4
