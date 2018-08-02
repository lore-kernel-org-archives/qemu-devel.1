Received: from eggs.gnu.org ([2001:4830:134:3::10]:44546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a6-0001Kg-AA
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3a5-0007Nh-Av
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:14 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fl3a5-0007Mc-4z
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:43:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11-v6so724413wmc.2
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 19:43:12 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  2 Aug 2018 10:42:22 +0800
Message-Id: <1533177743-20894-6-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1533177743-20894-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v3 5/6] pci_expander_bridge: Add ioport for pxb
 host bus
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

This enables seabios to read config file in pxb host bus other than sysbus

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci-bridge/pci_expander_bridge.c         | 15 +++++++++++++++
 include/hw/pci-bridge/pci_expander_bridge.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index cdfdb90..38212db 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -226,6 +226,20 @@ static void pxb_pcie_host_initfn(Object *obj)
                          qdev_prop_allow_set_link_before_realize, 0, NULL);
 }
 
+static void pxb_pcie_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    // FIX ME! Use specific port number for pxb-pcie host bridge, not scalable!
+    /* port layout is | pxb1_cmd | pxb1_data | pxb2_cmd | pxb2_data | ... | */
+    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE, &pci->conf_mem);
+    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE + g_list_length(pxb_dev_list) * 8, 4);
+
+    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE, &pci->data_mem);
+    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE + g_list_length(pxb_dev_list) * 8, 4);
+}
+
 static Property pxb_pcie_host_props[] = {
     DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.base_addr,
                         PCIE_BASE_ADDR_UNMAPPED),
@@ -254,6 +268,7 @@ static void pxb_pcie_host_class_init(ObjectClass *class, void *data)
 
     dc->fw_name = "pcie";
     dc->props = pxb_pcie_host_props;
+    dc->realize = pxb_pcie_host_realize;
     /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
     dc->user_creatable = false;
     sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
index 1119210..e6d3b67 100644
--- a/include/hw/pci-bridge/pci_expander_bridge.h
+++ b/include/hw/pci-bridge/pci_expander_bridge.h
@@ -7,6 +7,9 @@
 #define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
 #define PROP_PXB_BUS_NR "bus_nr"
 
+#define PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE 0x1000
+#define PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE 0x1004
+
 uint64_t pxb_pcie_mcfg_hole(void);
 
 #endif
-- 
2.7.4
