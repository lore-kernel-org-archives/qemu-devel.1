Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC80C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FA822CAE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FA822CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHLS-0000m8-Px
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBf-0000CE-GF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:27 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:47915)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBd-0005yl-09
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:27 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id CA76D108974;
 Thu, 27 Aug 2020 21:39:08 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 813D91C0792;
 Thu, 27 Aug 2020 21:39:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/20] hw/net: Add generic Bit-bang MDIO PHY.
Date: Thu, 27 Aug 2020 21:38:54 +0900
Message-Id: <20200827123859.81793-16-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only supported link status.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/net/mdio.h | 126 ++++++++++++++++++++
 hw/net/mdio.c         | 264 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/Kconfig        |   3 +
 hw/net/meson.build    |   2 +
 4 files changed, 395 insertions(+)
 create mode 100644 include/hw/net/mdio.h
 create mode 100644 hw/net/mdio.c

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
new file mode 100644
index 0000000000..55a7170e67
--- /dev/null
+++ b/include/hw/net/mdio.h
@@ -0,0 +1,126 @@
+/*
+ *  MDIO PHY emulation
+ *
+ *  Copyright 2020 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; under version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *  Contributions after 2012-01-13 are licensed under the terms of the
+ *  GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef MDIO_H
+#define MDIO_H
+
+#include "hw/qdev-core.h"
+#include "hw/net/mii.h"
+
+typedef enum mdio_pin {
+    mdio_z = -1,
+    mdio_l = 0,
+    mdio_h = 1,
+} MDIOPin;
+
+#define TYPE_ETHER_PHY "ether-phy"
+#define TYPE_ETHER_PHY_CLASS(obj) \
+    OBJECT_GET_CLASS(EtherPHYClass, (obj), TYPE_ETHER_PHY)
+#define EtherPHYClass(klass) \
+    OBJECT_CHECK_CLASS(EtherPHYClass, (klass), TYPE_ETHER_PHY)
+#define EtherPHY(obj) \
+    OBJECT_CHECK(PHYState, (obj), TYPE_ETHER_PHY)
+
+#define TYPE_ETHER_MDIO_BB "ether-mdio-bb"
+#define TYPE_ETHER_MDIO_BB_CLASS(obj)                           \
+    OBJECT_GET_CLASS(MDIO_BBClass, (obj), TYPE_ETHER_MDIO_BB)
+#define MDIO_BBClass(klass) \
+    OBJECT_CHECK_CLASS(MDIO_BBClass, (klass), TYPE_ETHER_MDIO_BB)
+#define MDIO_BB(obj) \
+    OBJECT_CHECK(MDIOState, (obj), TYPE_ETHER_MDIO_BB)
+
+typedef enum {
+    phy_out_p = 0,    /* Link up is 'H' */
+    phy_out_n = 1,    /* Link up is 'L' */
+} phy_output_polarity;
+
+typedef struct {
+    DeviceState parent;
+
+    uint16_t regs[32];
+    uint32_t identifier;
+    bool link_ok;
+    phy_output_polarity link_out_pol;
+    uint16_t bmsr;
+    uint16_t anlpar;
+} PHYState;
+
+#define MDIO_ANLPAR_LINK \
+    (MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD | MII_ANLPAR_10 | \
+     MII_ANLPAR_CSMACD)
+
+typedef enum {
+    BB_PRE,
+    BB_ST,
+    BB_CMD,
+    BB_TA_R,
+    BB_TA_W,
+    BB_DATA_R,
+    BB_DATA_W,
+    BB_INH,
+} mdio_bb_state;
+
+typedef struct {
+    DeviceState parent;
+
+    PHYState *phy;
+    mdio_bb_state bb_state;
+    int pclk;
+    int bits;
+    int cmd;
+    int phyad;
+    int selphy;
+    int regad;
+    int data;
+    int mdi_pin;
+    int mdo_pin;
+} MDIOState;
+
+#define mdio_get_phy(s) (s->phy)
+
+typedef struct {
+    DeviceClass parent;
+} EtherPHYClass;
+
+typedef struct {
+    DeviceClass parent;
+} MDIO_BBClass;
+
+/* Generic PHY interface */
+void mdio_phy_set_link(PHYState *s, bool ok);
+int mdio_phy_linksta(PHYState *s);
+uint16_t mdio_phy_read(PHYState *s, int addr);
+void mdio_phy_write(PHYState *s, int addr, uint16_t val);
+
+/* Bit-bang MDIO operation */
+static inline MDIOPin mdio_read_mdi_pin(MDIOState *s)
+{
+    return s->mdi_pin;
+}
+
+static inline void mdio_set_mdo_pin(MDIOState *s, MDIOPin mdo)
+{
+    s->mdo_pin = mdo;
+}
+
+void mdio_set_mdc_pin(MDIOState *s, int clk);
+
+#endif
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
new file mode 100644
index 0000000000..39670e70c6
--- /dev/null
+++ b/hw/net/mdio.c
@@ -0,0 +1,264 @@
+/*
+ *  Bit-bang MII emulation
+ *
+ *  Copyright 2020 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; under version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *  Contributions after 2012-01-13 are licensed under the terms of the
+ *  GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/net/mdio.h"
+
+void mdio_phy_set_link(PHYState *s, bool ok)
+{
+    if (ok) {
+        s->regs[MII_BMSR] |= MII_BMSR_LINK_ST;
+        s->regs[MII_ANLPAR] |= MDIO_ANLPAR_LINK;
+    } else {
+        s->regs[MII_BMSR] &= ~(MII_BMSR_LINK_ST | MII_BMSR_AUTONEG);
+        s->regs[MII_ANLPAR] &= MDIO_ANLPAR_LINK;
+    }
+    s->link_ok = ok;
+}
+
+static void mdio_phy_reset(PHYState *s)
+{
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[MII_BMSR] = s->bmsr;
+    s->regs[MII_ANLPAR] = s->anlpar;
+    s->regs[MII_PHYID1] = extract32(s->identifier, 16, 16);
+    s->regs[MII_PHYID2] = extract32(s->identifier, 0, 16);
+    mdio_phy_set_link(s, s->link_ok);
+}
+
+uint16_t mdio_phy_read(PHYState *s, int addr)
+{
+    if (addr >= 0 && addr < 32) {
+        return s->regs[addr];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mdio: Register %04x invalid address.\n", addr);
+        return 0;
+    }
+}
+
+int mdio_phy_linksta(PHYState *s)
+{
+    return s->link_ok ^ s->link_out_pol;
+}
+
+void mdio_phy_write(PHYState *s, int addr, uint16_t val)
+{
+    switch (addr) {
+    case MII_BMCR:
+        s->regs[MII_BMCR] = val & 0xfd80;
+        if (val & MII_BMCR_RESET) {
+            mdio_phy_reset(s);
+        }
+        break;
+    case MII_BMSR:
+    case MII_ANLPAR:
+        /* Read only */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mdio: Register %04x is read only register.\n", addr);
+        break;
+    case MII_PHYID1:
+    case MII_PHYID2:
+        s->regs[addr] = val;
+        break;
+    case MII_ANAR:
+        s->regs[addr] = val & 0x2dff;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "mdio: Register %04x not implemented\n", addr);
+        break;
+    }
+}
+
+static Property phy_properties[] = {
+    DEFINE_PROP_UINT32("phy-id", PHYState, identifier, 0),
+    DEFINE_PROP_UINT32("link-out-pol", PHYState, link_out_pol, 0),
+    DEFINE_PROP_UINT16("bmsr", PHYState, bmsr, 0),
+    DEFINE_PROP_UINT16("anlpar", PHYState, anlpar, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void phy_realize(DeviceState *dev, Error **errp)
+{
+    PHYState *s = EtherPHY(dev);
+    mdio_phy_reset(s);
+}
+
+static void phy_class_init(ObjectClass *klass, void *class_data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, phy_properties);
+    dc->realize = phy_realize;
+}
+
+/* shift in MDO */
+static void read_mdo(MDIOState *s)
+{
+    int op;
+    s->bits++;
+    switch (s->bb_state) {
+    case BB_PRE: /* preamble */
+        if (s->mdo_pin == 0) {
+            /* ST 1st bit found */
+            s->bb_state = BB_ST;
+        }
+        break;
+    case BB_ST: /* ST 2nd bit */
+        if (s->mdo_pin == 0) {
+            s->bb_state = BB_CMD;
+            s->cmd = 0;
+            s->bits = 2;
+            s->selphy = -1;
+            s->regad = -1;
+        } else {
+            s->bb_state = BB_PRE;
+        }
+        break;
+    case BB_CMD:
+        s->cmd <<= 1;
+        s->cmd |= (s->mdo_pin & 1);
+        if (s->bits == 14) {
+            op = extract32(s->cmd, 10, 2);
+            s->selphy = extract32(s->cmd, 5, 5);
+            s->regad = extract32(s->cmd, 0, 5);
+            switch (op) {
+            case 0x02: /* READ */
+                s->bb_state = BB_TA_R;
+                break;
+            case 0x01: /* WRITE */
+                s->bb_state = BB_TA_W;
+                break;
+            default:
+                s->bb_state = BB_INH;
+                break;
+            }
+        }
+        break;
+    case BB_TA_R:
+        s->mdi_pin = 0;
+        if (s->bits == 16) {
+            if (s->phyad == s->selphy) {
+                s->data = mdio_phy_read(s->phy, s->regad);
+                s->bb_state = BB_DATA_R;
+            } else {
+                s->bb_state = BB_INH;
+            }
+        }
+        break;
+    case BB_TA_W:
+        if (s->bits == 16) {
+            s->bb_state = BB_DATA_W;
+        }
+        break;
+    case BB_DATA_W:
+        s->data <<= 1;
+        s->data |= (s->mdo_pin & 1);
+        if (s->bits == 32) {
+            if (s->phyad == s->selphy) {
+                mdio_phy_write(s->phy, s->regad, s->data);
+            }
+            s->bb_state = BB_PRE;
+        }
+        break;
+    case BB_INH:
+    case BB_DATA_R:
+        if (s->bits == 32) {
+            s->bb_state = BB_PRE;
+        }
+        break;
+    }
+}
+
+/* shift out MDI */
+static void write_mdi(MDIOState *s)
+{
+    switch (s->bb_state) {
+    case BB_DATA_R:
+        s->mdi_pin = (s->data >> 15) & 1;
+        s->data <<= 1;
+        break;
+    case BB_TA_R:
+        s->mdi_pin = 0;
+        break;
+    default:
+        s->mdi_pin = mdio_z;
+        break;
+    }
+}
+
+/* MDIO pin operation */
+void mdio_set_mdc_pin(MDIOState *s, int clk)
+{
+    if (s->pclk ^ (clk & 1)) {
+        s->pclk = (clk & 1);
+        if (s->pclk == 1) {
+            /* rising edge */
+            read_mdo(s);
+        } else {
+            /* faling edge */
+            write_mdi(s);
+        }
+    }
+}
+
+static Property bb_properties[] = {
+    DEFINE_PROP_INT32("address", MDIOState, phyad, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bb_init(Object *obj)
+{
+    MDIOState *s = MDIO_BB(obj);
+
+    object_property_add_link(obj, "phy",
+                             TYPE_ETHER_PHY,
+                             (Object **)&s->phy,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void bb_class_init(ObjectClass *klass, void *class_data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, bb_properties);
+}
+
+static const TypeInfo phy_types_info[] = {
+    {
+        .name = TYPE_ETHER_PHY,
+        .parent = TYPE_DEVICE,
+        .class_init = phy_class_init,
+        .instance_size = sizeof(PHYState),
+    },
+    {
+        .name = TYPE_ETHER_MDIO_BB,
+        .parent = TYPE_DEVICE,
+        .class_init = bb_class_init,
+        .instance_size = sizeof(MDIOState),
+        .instance_init = bb_init,
+    },
+};
+
+DEFINE_TYPES(phy_types_info);
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index e43c96dae0..e6a32a2ab0 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -143,3 +143,6 @@ config CAN_SJA1000
     default y if PCI_DEVICES
     depends on PCI
     select CAN_BUS
+
+config MDIO_PHY
+    bool
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 4a7051b54a..faa4e3d2c0 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -64,4 +64,6 @@ softmmu_ss.add(when: 'CONFIG_ROCKER', if_true: files(
 ), if_false: files('rocker/qmp-norocker.c'))
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
 
+softmmu_ss.add(when: 'CONFIG_MDIO_PHY', if_true: files('mdio.c'))
+
 subdir('can')
-- 
2.20.1


