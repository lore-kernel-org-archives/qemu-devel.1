Received: from eggs.gnu.org ([2001:4830:134:3::10]:56638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eCecp-0002xT-E3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eCecn-0004hN-8i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:35 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eCecn-0004h9-0K
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:39:33 -0500
Received: by mail-pf0-x243.google.com with SMTP id d28so3441696pfe.2
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 20:39:32 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed,  8 Nov 2017 20:39:16 -0800
Message-Id: <1510202357-124052-2-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
References: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
	<1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 1/2] e1000e: Infrastructure for e1000-ng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>

Generalize e1000e to support e1000 and other devices with a similar
register spec:

- plain PCI instead of PCIe, skipping setup of MSI-X, AER, etc.
- model-specific PHY ID2, register values and access permissions
- model-specific EEPROM template and read/write methods

This is just infrastructure, no functional changes.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000e.c      | 166 ++++++++++++++++++++++++++++++++++++++-------------
 hw/net/e1000e_core.c | 131 +++++++++++++++++++++++-----------------
 hw/net/e1000e_core.h |  13 ++--
 3 files changed, 209 insertions(+), 101 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f1af279..7685ab0 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -49,8 +49,13 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define TYPE_E1000E "e1000e"
-#define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E)
+#define TYPE_E1000E_BASE "e1000e-base"
+#define E1000E(obj) \
+    OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E_BASE)
+#define E1000E_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(E1000EBaseClass, (klass), TYPE_E1000E_BASE)
+#define E1000E_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(E1000EBaseClass, (obj), TYPE_E1000E_BASE)
 
 typedef struct E1000EState {
     PCIDevice parent_obj;
@@ -76,6 +81,28 @@ typedef struct E1000EState {
 
 } E1000EState;
 
+typedef struct E1000EInfo {
+    const char *name;
+    const char *desc;
+
+    uint16_t    device_id;
+    uint8_t     revision;
+    uint16_t    subsystem_vendor_id;
+    uint16_t    subsystem_id;
+    int         is_express;
+    const char *romfile;
+
+    const uint16_t *eeprom_templ;
+    uint32_t        eeprom_size;
+
+    uint16_t phy_id2;
+} E1000EInfo;
+
+typedef struct E1000EBaseClass {
+    PCIDeviceClass    parent_class;
+    const E1000EInfo *info;
+} E1000EBaseClass;
+
 #define E1000E_MMIO_IDX     0
 #define E1000E_FLASH_IDX    1
 #define E1000E_IO_IDX       2
@@ -416,7 +443,9 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     static const uint16_t e1000e_pcie_offset = 0x0E0;
     static const uint16_t e1000e_aer_offset =  0x100;
     static const uint16_t e1000e_dsn_offset =  0x140;
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     E1000EState *s = E1000E(pci_dev);
+    E1000EBaseClass *edc = E1000E_DEVICE_GET_CLASS(s);
     uint8_t *macaddr;
     int ret;
 
@@ -427,6 +456,13 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     pci_dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
     pci_dev->config[PCI_INTERRUPT_PIN] = 1;
 
+    if (s->subsys_ven == (uint16_t)-1) {
+        s->subsys_ven = pci_get_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID);
+    }
+    if (s->subsys == (uint16_t)-1) {
+        s->subsys = pci_get_word(pci_dev->config + PCI_SUBSYSTEM_ID);
+    }
+
     pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID, s->subsys_ven);
     pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, s->subsys);
 
@@ -453,19 +489,23 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, E1000E_IO_IDX,
                      PCI_BASE_ADDRESS_SPACE_IO, &s->io);
 
-    memory_region_init(&s->msix, OBJECT(s), "e1000e-msix",
-                       E1000E_MSIX_SIZE);
-    pci_register_bar(pci_dev, E1000E_MSIX_IDX,
-                     PCI_BASE_ADDRESS_SPACE_MEMORY, &s->msix);
+    if (pc->is_express) {
+        memory_region_init(&s->msix, OBJECT(s), "e1000e-msix",
+                           E1000E_MSIX_SIZE);
+        pci_register_bar(pci_dev, E1000E_MSIX_IDX,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY, &s->msix);
+    }
 
     /* Create networking backend */
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     macaddr = s->conf.macaddr.a;
 
-    e1000e_init_msix(s);
+    if (pc->is_express) {
+        e1000e_init_msix(s);
 
-    if (pcie_endpoint_cap_v1_init(pci_dev, e1000e_pcie_offset) < 0) {
-        hw_error("Failed to initialize PCIe capability");
+        if (pcie_endpoint_cap_v1_init(pci_dev, e1000e_pcie_offset) < 0) {
+            hw_error("Failed to initialize PCIe capability");
+        }
     }
 
     ret = msi_init(PCI_DEVICE(s), 0xD0, 1, true, false, NULL);
@@ -473,18 +513,20 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
         trace_e1000e_msi_init_fail(ret);
     }
 
-    if (e1000e_add_pm_capability(pci_dev, e1000e_pmrb_offset,
-                                  PCI_PM_CAP_DSI) < 0) {
-        hw_error("Failed to initialize PM capability");
-    }
+    if (pc->is_express) {
+        if (e1000e_add_pm_capability(pci_dev, e1000e_pmrb_offset,
+                                     PCI_PM_CAP_DSI) < 0) {
+            hw_error("Failed to initialize PM capability");
+        }
 
-    if (pcie_aer_init(pci_dev, PCI_ERR_VER, e1000e_aer_offset,
-                      PCI_ERR_SIZEOF, NULL) < 0) {
-        hw_error("Failed to initialize AER capability");
-    }
+        if (pcie_aer_init(pci_dev, PCI_ERR_VER, e1000e_aer_offset,
+                          PCI_ERR_SIZEOF, NULL) < 0) {
+            hw_error("Failed to initialize AER capability");
+        }
 
-    pcie_dev_ser_num_init(pci_dev, e1000e_dsn_offset,
-                          e1000e_gen_dsn(macaddr));
+        pcie_dev_ser_num_init(pci_dev, e1000e_dsn_offset,
+                              e1000e_gen_dsn(macaddr));
+    }
 
     e1000e_init_net_peer(s, pci_dev, macaddr);
 
@@ -492,25 +534,31 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
     e1000e_core_realize(s);
 
     e1000e_core_pci_realize(&s->core,
-                            e1000e_eeprom_template,
-                            sizeof(e1000e_eeprom_template),
-                            macaddr);
+                            edc->info->eeprom_templ,
+                            edc->info->eeprom_size,
+                            macaddr,
+                            edc->info->phy_id2);
 }
 
 static void e1000e_pci_uninit(PCIDevice *pci_dev)
 {
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     E1000EState *s = E1000E(pci_dev);
 
     trace_e1000e_cb_pci_uninit();
 
     e1000e_core_pci_uninit(&s->core);
 
-    pcie_aer_exit(pci_dev);
-    pcie_cap_exit(pci_dev);
+    if (pc->is_express) {
+        pcie_aer_exit(pci_dev);
+        pcie_cap_exit(pci_dev);
+    }
 
     qemu_del_nic(s->nic);
 
-    e1000e_cleanup_msix(s);
+    if (pc->is_express) {
+        e1000e_cleanup_msix(s);
+    }
     msi_uninit(pci_dev);
 }
 
@@ -544,7 +592,7 @@ static int e1000e_post_load(void *opaque, int version_id)
         (s->subsys_ven != s->subsys_ven_used)) {
         fprintf(stderr,
             "ERROR: Cannot migrate while device properties "
-            "(subsys/subsys_ven) differ");
+            "(subsys/subsys_ven) differ\n");
         return -1;
     }
 
@@ -655,10 +703,9 @@ static Property e1000e_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000EState, conf),
     DEFINE_PROP_SIGNED("disable_vnet_hdr", E1000EState, disable_vnet, false,
                         e1000e_prop_disable_vnet, bool),
-    DEFINE_PROP_SIGNED("subsys_ven", E1000EState, subsys_ven,
-                        PCI_VENDOR_ID_INTEL,
+    DEFINE_PROP_SIGNED("subsys_ven", E1000EState, subsys_ven, -1,
                         e1000e_prop_subsys_ven, uint16_t),
-    DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
+    DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, -1,
                         e1000e_prop_subsys, uint16_t),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -667,21 +714,27 @@ static void e1000e_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
+    E1000EBaseClass *edc = E1000E_DEVICE_CLASS(class);
+    const E1000EInfo *info = data;
 
     c->realize = e1000e_pci_realize;
     c->exit = e1000e_pci_uninit;
     c->vendor_id = PCI_VENDOR_ID_INTEL;
-    c->device_id = E1000_DEV_ID_82574L;
-    c->revision = 0;
-    c->romfile = "efi-e1000e.rom";
+    c->device_id = info->device_id;
+    c->revision = info->revision;
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    c->is_express = 1;
+    c->subsystem_vendor_id = info->subsystem_vendor_id;
+    c->subsystem_id = info->subsystem_id;
+    c->is_express = info->is_express;
+    c->romfile = info->romfile;
 
-    dc->desc = "Intel 82574L GbE Controller";
+    dc->desc = info->desc;
     dc->reset = e1000e_qdev_reset;
     dc->vmsd = &e1000e_vmstate;
     dc->props = e1000e_properties;
 
+    edc->info = info;
+
     e1000e_prop_disable_vnet = qdev_prop_uint8;
     e1000e_prop_disable_vnet.description = "Do not use virtio headers, "
                                            "perform SW offloads emulation "
@@ -704,21 +757,52 @@ static void e1000e_instance_init(Object *obj)
                                   DEVICE(obj), NULL);
 }
 
-static const TypeInfo e1000e_info = {
-    .name = TYPE_E1000E,
+static const TypeInfo e1000e_base_info = {
+    .name = TYPE_E1000E_BASE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(E1000EState),
-    .class_init = e1000e_class_init,
     .instance_init = e1000e_instance_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { }
+    .class_size = sizeof(E1000EBaseClass),
+    .abstract = true,
+};
+
+static const E1000EInfo e1000e_devices[] = {
+    {
+        .name                = "e1000e",
+        .desc                = "Intel 82574L GbE Controller",
+        .device_id           = E1000_DEV_ID_82574L,
+        .revision            = 0,
+        .subsystem_vendor_id = PCI_VENDOR_ID_INTEL,
+        .subsystem_id        = 0,
+        .is_express          = 1,
+        .romfile             = "efi-e1000e.rom",
+        .eeprom_templ        = e1000e_eeprom_template,
+        .eeprom_size         = sizeof(e1000e_eeprom_template),
+        .phy_id2             = E1000_PHY_ID2_82574x,
     },
 };
 
 static void e1000e_register_types(void)
 {
-    type_register_static(&e1000e_info);
+    int i;
+
+    type_register_static(&e1000e_base_info);
+    for (i = 0; i < ARRAY_SIZE(e1000e_devices); i++) {
+        const E1000EInfo *info = &e1000e_devices[i];
+        TypeInfo type_info = {};
+
+        type_info.name = info->name;
+        type_info.parent = TYPE_E1000E_BASE;
+        type_info.class_data = (void *)info;
+        type_info.class_init = e1000e_class_init;
+        type_info.interfaces = (InterfaceInfo[]) {
+            { info->is_express ? INTERFACE_PCIE_DEVICE
+              : INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        };
+
+        type_register(&type_info);
+    }
 }
 
 type_init(e1000e_register_types)
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 43a8d89..959c697 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2213,7 +2213,7 @@ e1000e_get_reg_index_with_offset(const uint16_t *mac_reg_access, hwaddr addr)
     return index + (mac_reg_access[index] & 0xfffe);
 }
 
-static const char e1000e_phy_regcap[E1000E_PHY_PAGES][0x20] = {
+static const char e1000e_phy_regcap[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
     [0] = {
         [PHY_CTRL]          = PHY_ANYPAGE | PHY_RW,
         [PHY_STATUS]        = PHY_ANYPAGE | PHY_R,
@@ -2266,14 +2266,14 @@ e1000e_phy_reg_check_cap(E1000ECore *core, uint32_t addr,
                          char cap, uint8_t *page)
 {
     *page =
-        (e1000e_phy_regcap[0][addr] & PHY_ANYPAGE) ? 0
-                                                    : core->phy[0][PHY_PAGE];
+        ((*core->phy_regcap)[0][addr] & PHY_ANYPAGE) ? 0
+                                                  : core->phy[0][PHY_PAGE];
 
     if (*page >= E1000E_PHY_PAGES) {
         return false;
     }
 
-    return e1000e_phy_regcap[*page][addr] & cap;
+    return (*core->phy_regcap)[*page][addr] & cap;
 }
 
 static void
@@ -2729,6 +2729,12 @@ e1000e_mac_setmacaddr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_mac_set_sw(MAC_ARG(macaddr));
 }
 
+static uint32_t
+e1000e_get_eecd(E1000ECore *core, int index)
+{
+    return e1000e_mac_readreg(core, index);
+}
+
 static void
 e1000e_set_eecd(E1000ECore *core, int index, uint32_t val)
 {
@@ -3028,6 +3034,7 @@ static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) = {
     [TARC1]   = e1000e_get_tarc,
     [SWSM]    = e1000e_mac_swsm_read,
     [IMS]     = e1000e_mac_ims_read,
+    [EECD]    = e1000e_get_eecd,
 
     [CRCERRS ... MPC]      = e1000e_mac_readreg,
     [IP6AT ... IP6AT + 3]  = e1000e_mac_readreg,
@@ -3305,56 +3312,6 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
-void
-e1000e_core_pci_realize(E1000ECore     *core,
-                        const uint16_t *eeprom_templ,
-                        uint32_t        eeprom_size,
-                        const uint8_t  *macaddr)
-{
-    int i;
-
-    core->autoneg_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                       e1000e_autoneg_timer, core);
-    e1000e_intrmgr_pci_realize(core);
-
-    core->vmstate =
-        qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
-
-    for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
-                        E1000E_MAX_TX_FRAGS, core->has_vnet);
-    }
-
-    net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
-
-    e1000x_core_prepare_eeprom(core->eeprom,
-                               eeprom_templ,
-                               eeprom_size,
-                               PCI_DEVICE_GET_CLASS(core->owner)->device_id,
-                               macaddr);
-    e1000e_update_rx_offloads(core);
-}
-
-void
-e1000e_core_pci_uninit(E1000ECore *core)
-{
-    int i;
-
-    timer_del(core->autoneg_timer);
-    timer_free(core->autoneg_timer);
-
-    e1000e_intrmgr_pci_unint(core);
-
-    qemu_del_vm_change_state_handler(core->vmstate);
-
-    for (i = 0; i < E1000E_NUM_QUEUES; i++) {
-        net_tx_pkt_reset(core->tx[i].tx_pkt);
-        net_tx_pkt_uninit(core->tx[i].tx_pkt);
-    }
-
-    net_rx_pkt_uninit(core->rx_pkt);
-}
-
 static const uint16_t
 e1000e_phy_reg_init[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
     [0] = {
@@ -3373,7 +3330,7 @@ e1000e_phy_reg_init[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
                        MII_SR_100X_FD_CAPS,
 
         [PHY_ID1]               = 0x141,
-        [PHY_ID2]               = E1000_PHY_ID2_82574x,
+     /* [PHY_ID2] set by e1000e_core_reset() */
         [PHY_AUTONEG_ADV]       = 0xde1,
         [PHY_LP_ABILITY]        = 0x7e0,
         [PHY_AUTONEG_EXP]       = BIT(2),
@@ -3438,6 +3395,67 @@ static const uint32_t e1000e_mac_reg_init[] = {
 };
 
 void
+e1000e_core_pci_realize(E1000ECore     *core,
+                        const uint16_t *eeprom_templ,
+                        uint32_t        eeprom_size,
+                        const uint8_t  *macaddr,
+                        uint16_t        phy_id2)
+{
+    int i;
+
+    core->phy_id2 = phy_id2;
+    switch (phy_id2) {
+    case E1000_PHY_ID2_82574x:
+        core->phy_regcap = &e1000e_phy_regcap;
+        core->phy_reg_init = &e1000e_phy_reg_init;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    core->autoneg_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                       e1000e_autoneg_timer, core);
+    e1000e_intrmgr_pci_realize(core);
+
+    core->vmstate =
+        qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
+
+    for (i = 0; i < E1000E_NUM_QUEUES; i++) {
+        net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
+                        E1000E_MAX_TX_FRAGS, core->has_vnet);
+    }
+
+    net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
+
+    e1000x_core_prepare_eeprom(core->eeprom,
+                               eeprom_templ,
+                               eeprom_size,
+                               PCI_DEVICE_GET_CLASS(core->owner)->device_id,
+                               macaddr);
+    e1000e_update_rx_offloads(core);
+}
+
+void
+e1000e_core_pci_uninit(E1000ECore *core)
+{
+    int i;
+
+    timer_del(core->autoneg_timer);
+    timer_free(core->autoneg_timer);
+
+    e1000e_intrmgr_pci_unint(core);
+
+    qemu_del_vm_change_state_handler(core->vmstate);
+
+    for (i = 0; i < E1000E_NUM_QUEUES; i++) {
+        net_tx_pkt_reset(core->tx[i].tx_pkt);
+        net_tx_pkt_uninit(core->tx[i].tx_pkt);
+    }
+
+    net_rx_pkt_uninit(core->rx_pkt);
+}
+
+void
 e1000e_core_reset(E1000ECore *core)
 {
     int i;
@@ -3447,7 +3465,8 @@ e1000e_core_reset(E1000ECore *core)
     e1000e_intrmgr_reset(core);
 
     memset(core->phy, 0, sizeof core->phy);
-    memmove(core->phy, e1000e_phy_reg_init, sizeof e1000e_phy_reg_init);
+    memmove(core->phy, *core->phy_reg_init, sizeof *core->phy_reg_init);
+    core->phy[0][PHY_ID2] = core->phy_id2;
     memset(core->mac, 0, sizeof core->mac);
     memmove(core->mac, e1000e_mac_reg_init, sizeof e1000e_mac_reg_init);
 
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 1ff6978..9ac6f32 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -56,6 +56,10 @@ typedef struct E1000IntrDelayTimer_st {
 } E1000IntrDelayTimer;
 
 struct E1000Core {
+    uint16_t phy_id2;
+    const char (*phy_regcap)[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
+    const uint16_t (*phy_reg_init)[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
+
     uint32_t mac[E1000E_MAC_SIZE];
     uint16_t phy[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
     uint16_t eeprom[E1000E_EEPROM_SIZE];
@@ -116,10 +120,11 @@ uint64_t
 e1000e_core_read(E1000ECore *core, hwaddr addr, unsigned size);
 
 void
-e1000e_core_pci_realize(E1000ECore      *regs,
-                       const uint16_t *eeprom_templ,
-                       uint32_t        eeprom_size,
-                       const uint8_t  *macaddr);
+e1000e_core_pci_realize(E1000ECore     *regs,
+                        const uint16_t *eeprom_templ,
+                        uint32_t        eeprom_size,
+                        const uint8_t  *macaddr,
+                        uint16_t        phy_id2);
 
 void
 e1000e_core_reset(E1000ECore *core);
-- 
1.9.1
