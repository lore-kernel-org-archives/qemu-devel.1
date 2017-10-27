Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e7uib-0003dk-Dp
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1e7uiY-0002no-9O
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:49:57 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1e7uiY-0002n7-18
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 22:49:54 -0400
Received: by mail-pf0-x242.google.com with SMTP id x7so3921848pfa.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:49:53 -0700 (PDT)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 26 Oct 2017 19:49:04 -0700
Message-Id: <1509072544-89012-3-git-send-email-eswierk@skyportsystems.com>
In-Reply-To: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
References: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 2/2] e1000e: Add e1000-ng devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Implement e1000-compatible devices using the reworked e1000e code:

- e1000-ng: Intel 82540EM
- e1000-82544gc-ng: Intel 82544GC
- e1000-82545em-ng: Intel 82545EM

>From a guest's perspective, these should be drop-in replacements for
the existing e1000 devices.

Among other deficiencies, this version does not handle migration. But
it should work well enough to start testing e1000-ng devices with a
variety of guest OSes.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 hw/net/e1000e.c      |  50 +++++++++++++++++++++
 hw/net/e1000e_core.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/net/e1000e_core.h |  12 ++++++
 3 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 100979c..5f75a41 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -281,6 +281,17 @@ static const uint16_t e1000e_eeprom_template[64] = {
     0xffff, 0xffff, 0xffff, 0xffff, 0x0000, 0x0120, 0xffff, 0x0000,
 };
 
+static const uint16_t e1000_eeprom_template[64] = {
+    0x0000, 0x0000, 0x0000, 0x0000,      0xffff, 0x0000,      0x0000, 0x0000,
+    0x3000, 0x1000, 0x6403, 0 /*DevId*/, 0x8086, 0 /*DevId*/, 0x8086, 0x3040,
+    0x0008, 0x2000, 0x7e14, 0x0048,      0x1000, 0x00d8,      0x0000, 0x2700,
+    0x6cc9, 0x3150, 0x0722, 0x040b,      0x0984, 0x0000,      0xc000, 0x0706,
+    0x1008, 0x0000, 0x0f04, 0x7fff,      0x4d01, 0xffff,      0xffff, 0xffff,
+    0xffff, 0xffff, 0xffff, 0xffff,      0xffff, 0xffff,      0xffff, 0xffff,
+    0x0100, 0x4000, 0x121c, 0xffff,      0xffff, 0xffff,      0xffff, 0xffff,
+    0xffff, 0xffff, 0xffff, 0xffff,      0xffff, 0xffff,      0xffff, 0x0000,
+};
+
 static void e1000e_core_realize(E1000EState *s)
 {
     s->core.owner = &s->parent_obj;
@@ -776,6 +787,45 @@ static const E1000EInfo e1000e_devices[] = {
         .eeprom_size         = sizeof(e1000e_eeprom_template),
         .phy_id2             = E1000_PHY_ID2_82574x,
     },
+    {
+        .name                = "e1000-ng",
+        .desc                = "Intel 82540EM Gigabit Ethernet Controller",
+        .device_id           = E1000_DEV_ID_82540EM,
+        .revision            = 3,
+        .subsystem_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
+        .subsystem_id        = PCI_SUBDEVICE_ID_QEMU,
+        .is_express          = 0,
+        .romfile             = "efi-e1000.rom",
+        .eeprom_templ        = e1000_eeprom_template,
+        .eeprom_size         = sizeof(e1000_eeprom_template),
+        .phy_id2             = E1000_PHY_ID2_8254xx_DEFAULT,
+    },
+    {
+        .name                = "e1000-82544gc-ng",
+        .desc                = "Intel 82544GC Gigabit Ethernet Controller",
+        .device_id           = E1000_DEV_ID_82544GC_COPPER,
+        .revision            = 3,
+        .subsystem_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
+        .subsystem_id        = PCI_SUBDEVICE_ID_QEMU,
+        .is_express          = 0,
+        .romfile             = "efi-e1000.rom",
+        .eeprom_templ        = e1000_eeprom_template,
+        .eeprom_size         = sizeof(e1000_eeprom_template),
+        .phy_id2             = E1000_PHY_ID2_82544x,
+    },
+    {
+        .name                = "e1000-82545em-ng",
+        .desc                = "Intel 82545EM Gigabit Ethernet Controller",
+        .device_id           = E1000_DEV_ID_82545EM_COPPER,
+        .revision            = 3,
+        .subsystem_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
+        .subsystem_id        = PCI_SUBDEVICE_ID_QEMU,
+        .is_express          = 0,
+        .romfile             = "efi-e1000.rom",
+        .eeprom_templ        = e1000_eeprom_template,
+        .eeprom_size         = sizeof(e1000_eeprom_template),
+        .phy_id2             = E1000_PHY_ID2_8254xx_DEFAULT,
+    },
 };
 
 static void e1000e_register_types(void)
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 959c697..02a60a1 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2261,6 +2261,24 @@ static const char e1000e_phy_regcap[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
     }
 };
 
+static const char e1000_phy_regcap[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
+    [0] = {
+        [PHY_CTRL]                   = PHY_RW,
+        [PHY_STATUS]                 = PHY_R,
+        [PHY_ID1]                    = PHY_R,
+        [PHY_ID2]                    = PHY_R,
+        [PHY_AUTONEG_ADV]            = PHY_RW,
+        [PHY_LP_ABILITY]             = PHY_R,
+        [PHY_AUTONEG_EXP]            = PHY_R,
+        [PHY_1000T_CTRL]             = PHY_RW,
+        [PHY_1000T_STATUS]           = PHY_R,
+        [M88E1000_PHY_SPEC_CTRL]     = PHY_RW,
+        [M88E1000_PHY_SPEC_STATUS]   = PHY_R,
+        [M88E1000_EXT_PHY_SPEC_CTRL] = PHY_RW,
+        [M88E1000_RX_ERR_CNTR]       = PHY_R,
+    }
+};
+
 static bool
 e1000e_phy_reg_check_cap(E1000ECore *core, uint32_t addr,
                          char cap, uint8_t *page)
@@ -2616,6 +2634,10 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }
 
+    if (core->clear_icr_on_read) {
+        core->mac[ICR] = 0;
+    }
+
     trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
     e1000e_update_interrupt_state(core);
     return ret;
@@ -2732,50 +2754,83 @@ e1000e_mac_setmacaddr(E1000ECore *core, int index, uint32_t val)
 static uint32_t
 e1000e_get_eecd(E1000ECore *core, int index)
 {
-    return e1000e_mac_readreg(core, index);
+    uint32_t ret = E1000_EECD_PRES | E1000_EECD_GNT | core->eecd_state.old_eecd;
+
+    if (!core->eecd_state.reading ||
+        ((core->eeprom[(core->eecd_state.bitnum_out >> 4) & 0x3f] >>
+          ((core->eecd_state.bitnum_out & 0xf) ^ 0xf))) & 1) {
+        ret |= E1000_EECD_DO;
+    }
+    return ret;
 }
 
 static void
 e1000e_set_eecd(E1000ECore *core, int index, uint32_t val)
 {
-    static const uint32_t ro_bits = E1000_EECD_PRES          |
-                                    E1000_EECD_AUTO_RD       |
-                                    E1000_EECD_SIZE_EX_MASK;
+    uint32_t oldval = core->eecd_state.old_eecd;
 
-    core->mac[EECD] = (core->mac[EECD] & ro_bits) | (val & ~ro_bits);
+    core->eecd_state.old_eecd = val & (E1000_EECD_SK | E1000_EECD_CS |
+                                       E1000_EECD_DI | E1000_EECD_FWE_MASK |
+                                       E1000_EECD_REQ);
+    if (!(E1000_EECD_CS & val)) { /* CS inactive; nothing to do */
+        return;
+    }
+    if (E1000_EECD_CS & (val ^ oldval)) { /* CS rise edge; reset state */
+        core->eecd_state.val_in = 0;
+        core->eecd_state.bitnum_in = 0;
+        core->eecd_state.bitnum_out = 0;
+        core->eecd_state.reading = 0;
+    }
+    if (!(E1000_EECD_SK & (val ^ oldval))) { /* no clock edge */
+        return;
+    }
+    if (!(E1000_EECD_SK & val)) { /* falling edge */
+        core->eecd_state.bitnum_out++;
+        return;
+    }
+    core->eecd_state.val_in <<= 1;
+    if (val & E1000_EECD_DI) {
+        core->eecd_state.val_in |= 1;
+    }
+    if (++core->eecd_state.bitnum_in == 9 && !core->eecd_state.reading) {
+        core->eecd_state.bitnum_out = ((core->eecd_state.val_in & 0x3f)
+                                       << 4) - 1;
+        core->eecd_state.reading = (((core->eecd_state.val_in >> 6) & 7) ==
+                                    EEPROM_READ_OPCODE_MICROWIRE);
+    }
 }
 
 static void
 e1000e_set_eerd(E1000ECore *core, int index, uint32_t val)
 {
-    uint32_t addr = (val >> E1000_EERW_ADDR_SHIFT) & E1000_EERW_ADDR_MASK;
+    uint32_t addr = (val >> core->eerw_addr_shift) & core->eerw_addr_mask;
     uint32_t flags = 0;
     uint32_t data = 0;
 
     if ((addr < E1000E_EEPROM_SIZE) && (val & E1000_EERW_START)) {
         data = core->eeprom[addr];
-        flags = E1000_EERW_DONE;
+        flags = core->eerw_done;
     }
 
     core->mac[EERD] = flags                           |
-                      (addr << E1000_EERW_ADDR_SHIFT) |
+                      (addr << core->eerw_addr_shift) |
                       (data << E1000_EERW_DATA_SHIFT);
 }
 
 static void
 e1000e_set_eewr(E1000ECore *core, int index, uint32_t val)
 {
-    uint32_t addr = (val >> E1000_EERW_ADDR_SHIFT) & E1000_EERW_ADDR_MASK;
+    uint32_t addr = (val >> core->eerw_addr_shift) & core->eerw_addr_mask;
     uint32_t data = (val >> E1000_EERW_DATA_SHIFT) & E1000_EERW_DATA_MASK;
     uint32_t flags = 0;
 
     if ((addr < E1000E_EEPROM_SIZE) && (val & E1000_EERW_START)) {
         core->eeprom[addr] = data;
-        flags = E1000_EERW_DONE;
+        flags = core->eerw_done;
     }
 
     core->mac[EERD] = flags                           |
-                      (addr << E1000_EERW_ADDR_SHIFT) |
+                      (addr << core->eerw_addr_shift) |
                       (data << E1000_EERW_DATA_SHIFT);
 }
 
@@ -3352,6 +3407,36 @@ e1000e_phy_reg_init[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
     }
 };
 
+static const uint16_t
+e1000_phy_reg_init[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE] = {
+    [0] = {
+        [PHY_CTRL] =   MII_CR_SPEED_SELECT_MSB  |
+                       MII_CR_FULL_DUPLEX       |
+                       MII_CR_AUTO_NEG_EN,
+
+        [PHY_STATUS] = MII_SR_EXTENDED_CAPS     |
+                       MII_SR_LINK_STATUS       |
+                       MII_SR_AUTONEG_CAPS      |
+                       MII_SR_PREAMBLE_SUPPRESS |
+                       MII_SR_EXTENDED_STATUS   |
+                       MII_SR_10T_HD_CAPS       |
+                       MII_SR_10T_FD_CAPS       |
+                       MII_SR_100X_HD_CAPS      |
+                       MII_SR_100X_FD_CAPS,
+
+        [PHY_ID1]          = 0x141,
+     /* [PHY_ID2] set by e1000e_core_reset() */
+        [PHY_AUTONEG_ADV]  = 0xde1,
+        [PHY_LP_ABILITY]   = 0x1e0,
+        [PHY_1000T_CTRL]   = 0x0e00,
+        [PHY_1000T_STATUS] = 0x3c00,
+
+        [M88E1000_PHY_SPEC_CTRL]     = 0x360,
+        [M88E1000_PHY_SPEC_STATUS]   = 0xac00,
+        [M88E1000_EXT_PHY_SPEC_CTRL] = 0x0d60,
+    }
+};
+
 static const uint32_t e1000e_mac_reg_init[] = {
     [PBA]           =     0x00140014,
     [LEDCTL]        =  BIT(1) | BIT(8) | BIT(9) | BIT(15) | BIT(17) | BIT(18),
@@ -3408,6 +3493,19 @@ e1000e_core_pci_realize(E1000ECore     *core,
     case E1000_PHY_ID2_82574x:
         core->phy_regcap = &e1000e_phy_regcap;
         core->phy_reg_init = &e1000e_phy_reg_init;
+        core->clear_icr_on_read = false;
+        core->eerw_done = BIT(1);
+        core->eerw_addr_shift = 2;
+        core->eerw_addr_mask = ((1L << 14) - 1);
+        break;
+    case E1000_PHY_ID2_8254xx_DEFAULT:
+    case E1000_PHY_ID2_82544x:
+        core->phy_regcap = &e1000_phy_regcap;
+        core->phy_reg_init = &e1000_phy_reg_init;
+        core->clear_icr_on_read = true;
+        core->eerw_done = BIT(4);
+        core->eerw_addr_shift = 8;
+        core->eerw_addr_mask = ((1L << 8) - 1);
         break;
     default:
         g_assert_not_reached();
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 9ac6f32..f667631 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -59,6 +59,7 @@ struct E1000Core {
     uint16_t phy_id2;
     const char (*phy_regcap)[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
     const uint16_t (*phy_reg_init)[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
+    bool clear_icr_on_read;
 
     uint32_t mac[E1000E_MAC_SIZE];
     uint16_t phy[E1000E_PHY_PAGES][E1000E_PHY_PAGE_SIZE];
@@ -108,6 +109,17 @@ struct E1000Core {
 
     uint8_t permanent_mac[ETH_ALEN];
 
+    int eerw_done;
+    int eerw_addr_shift;
+    int eerw_addr_mask;
+    struct {
+        uint32_t val_in; /* shifted in from guest driver */
+        uint16_t bitnum_in;
+        uint16_t bitnum_out;
+        uint16_t reading;
+        uint32_t old_eecd;
+    } eecd_state;
+
     NICState *owner_nic;
     PCIDevice *owner;
     void (*owner_start_recv)(PCIDevice *d);
-- 
1.9.1
