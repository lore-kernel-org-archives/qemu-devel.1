Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHrs-0008OE-Ty
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHrr-00016z-SN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cRHrr-00016g-JV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFA948F22E
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:19:03 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 11 Jan 2017 14:18:55 +0200
Message-Id: <1484137136-8021-3-git-send-email-marcel@redhat.com>
In-Reply-To: <1484137136-8021-1-git-send-email-marcel@redhat.com>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 2/3] hw/ioh3420: derive from PCI Express
 Root Port base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

Preserve only Intel specific details.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/ioh3420.c | 152 +++---------------------------------------------
 1 file changed, 7 insertions(+), 145 deletions(-)

diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index 84b7946..431266c 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -38,142 +38,6 @@
 #define IOH_EP_EXP_OFFSET               0x90
 #define IOH_EP_AER_OFFSET               0x100
 
-/*
- * If two MSI vector are allocated, Advanced Error Interrupt Message Number
- * is 1. otherwise 0.
- * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Number.
- */
-static uint8_t ioh3420_aer_vector(const PCIDevice *d)
-{
-    switch (msi_nr_vectors_allocated(d)) {
-    case 1:
-        return 0;
-    case 2:
-        return 1;
-    case 4:
-    case 8:
-    case 16:
-    case 32:
-    default:
-        break;
-    }
-    abort();
-    return 0;
-}
-
-static void ioh3420_aer_vector_update(PCIDevice *d)
-{
-    pcie_aer_root_set_vector(d, ioh3420_aer_vector(d));
-}
-
-static void ioh3420_write_config(PCIDevice *d,
-                                   uint32_t address, uint32_t val, int len)
-{
-    uint32_t root_cmd =
-        pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
-
-    pci_bridge_write_config(d, address, val, len);
-    ioh3420_aer_vector_update(d);
-    pcie_cap_slot_write_config(d, address, val, len);
-    pcie_aer_write_config(d, address, val, len);
-    pcie_aer_root_write_config(d, address, val, len, root_cmd);
-}
-
-static void ioh3420_reset(DeviceState *qdev)
-{
-    PCIDevice *d = PCI_DEVICE(qdev);
-
-    ioh3420_aer_vector_update(d);
-    pcie_cap_root_reset(d);
-    pcie_cap_deverr_reset(d);
-    pcie_cap_slot_reset(d);
-    pcie_cap_arifwd_reset(d);
-    pcie_aer_root_reset(d);
-    pci_bridge_reset(qdev);
-    pci_bridge_disable_base_limit(d);
-}
-
-static int ioh3420_initfn(PCIDevice *d)
-{
-    PCIEPort *p = PCIE_PORT(d);
-    PCIESlot *s = PCIE_SLOT(d);
-    int rc;
-    Error *err = NULL;
-
-    pci_config_set_interrupt_pin(d->config, 1);
-    pci_bridge_initfn(d, TYPE_PCIE_BUS);
-    pcie_port_init_reg(d);
-
-    rc = pci_bridge_ssvid_init(d, IOH_EP_SSVID_OFFSET,
-                               IOH_EP_SSVID_SVID, IOH_EP_SSVID_SSID);
-    if (rc < 0) {
-        goto err_bridge;
-    }
-
-    rc = msi_init(d, IOH_EP_MSI_OFFSET, IOH_EP_MSI_NR_VECTOR,
-                  IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT, &err);
-    if (rc < 0) {
-        assert(rc == -ENOTSUP);
-        error_report_err(err);
-        goto err_bridge;
-    }
-
-    rc = pcie_cap_init(d, IOH_EP_EXP_OFFSET, PCI_EXP_TYPE_ROOT_PORT, p->port);
-    if (rc < 0) {
-        goto err_msi;
-    }
-
-    pcie_cap_arifwd_init(d);
-    pcie_cap_deverr_init(d);
-    pcie_cap_slot_init(d, s->slot);
-    pcie_cap_root_init(d);
-
-    pcie_chassis_create(s->chassis);
-    rc = pcie_chassis_add_slot(s);
-    if (rc < 0) {
-        goto err_pcie_cap;
-    }
-
-    rc = pcie_aer_init(d, PCI_ERR_VER, IOH_EP_AER_OFFSET,
-                       PCI_ERR_SIZEOF, &err);
-    if (rc < 0) {
-        error_report_err(err);
-        goto err;
-    }
-    pcie_aer_root_init(d);
-    ioh3420_aer_vector_update(d);
-
-    return 0;
-
-err:
-    pcie_chassis_del_slot(s);
-err_pcie_cap:
-    pcie_cap_exit(d);
-err_msi:
-    msi_uninit(d);
-err_bridge:
-    pci_bridge_exitfn(d);
-    return rc;
-}
-
-static void ioh3420_exitfn(PCIDevice *d)
-{
-    PCIESlot *s = PCIE_SLOT(d);
-
-    pcie_aer_exit(d);
-    pcie_chassis_del_slot(s);
-    pcie_cap_exit(d);
-    msi_uninit(d);
-    pci_bridge_exitfn(d);
-}
-
-static Property ioh3420_props[] = {
-    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
-                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static const VMStateDescription vmstate_ioh3420 = {
     .name = "ioh-3240-express-root-port",
     .version_id = 1,
@@ -191,25 +55,23 @@ static void ioh3420_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
 
-    k->is_express = 1;
-    k->is_bridge = 1;
-    k->config_write = ioh3420_write_config;
-    k->init = ioh3420_initfn;
-    k->exit = ioh3420_exitfn;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_IOH_EPORT;
     k->revision = PCI_DEVICE_ID_IOH_REV;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Intel IOH device id 3420 PCIE Root Port";
-    dc->reset = ioh3420_reset;
     dc->vmsd = &vmstate_ioh3420;
-    dc->props = ioh3420_props;
+    rpc->msi_offset = IOH_EP_MSI_OFFSET;
+    rpc->exp_offset = IOH_EP_EXP_OFFSET;
+    rpc->aer_offset = IOH_EP_AER_OFFSET;
+    rpc->ssvid_offset = IOH_EP_SSVID_OFFSET;
+    rpc->ssid = IOH_EP_SSVID_SSID;
 }
 
 static const TypeInfo ioh3420_info = {
     .name          = "ioh3420",
-    .parent        = TYPE_PCIE_SLOT,
+    .parent        = TYPE_PCIE_ROOT_PORT,
     .class_init    = ioh3420_class_init,
 };
 
-- 
2.5.5
