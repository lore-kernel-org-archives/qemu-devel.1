Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC03C207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC03C207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpDN-0005B5-1L
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jgp9g-00085b-Qm; Thu, 04 Jun 2020 08:39:32 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jgp9f-0001i1-Lk; Thu, 04 Jun 2020 08:39:32 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4A988E0018;
 Thu,  4 Jun 2020 12:39:28 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Subject: [PATCH v5 3/3] hw/net/imx_fec: improve PHY implementation.
Date: Thu,  4 Jun 2020 14:39:10 +0200
Message-Id: <cbafa49a59659051387e43b7b35d8f280e59f1a3.1591272275.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591272275.git.jcd@tribudubois.net>
References: <cover.1591272275.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.196; envelope-from=jcd@tribudubois.net;
 helo=relay4-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 08:39:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, peter.chubb@nicta.com.au,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

improve the PHY implementation with more generic code.

This patch remove a lot of harcoded values to replace them with
generic symbols from header files.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 v2: Not present
 v3: Not present
 v4: Not present
 v5: improve PHY implementation.

 hw/net/imx_fec.c     | 76 +++++++++++++++++++++++++++-----------------
 include/hw/net/mii.h |  4 +++
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 29e613699ee..bf9583a93f4 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/net/imx_fec.h"
+#include "hw/net/mii.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
@@ -231,6 +232,9 @@ static const VMStateDescription vmstate_imx_eth = {
 #define PHY_INT_PARFAULT            (1 << 2)
 #define PHY_INT_AUTONEG_PAGE        (1 << 1)
 
+#define MII_SMC911X_ISF             29
+#define MII_SMC911X_IM              30
+
 static void imx_eth_update(IMXFECState *s);
 
 /*
@@ -249,11 +253,11 @@ static void imx_phy_update_link(IMXFECState *s)
     /* Autonegotiation status mirrors link status.  */
     if (qemu_get_queue(s->nic)->link_down) {
         trace_imx_phy_update_link("down");
-        s->phy_status &= ~0x0024;
+        s->phy_status &= ~(MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
         s->phy_int |= PHY_INT_DOWN;
     } else {
         trace_imx_phy_update_link("up");
-        s->phy_status |= 0x0024;
+        s->phy_status |= MII_BMSR_LINK_ST | MII_BMSR_AN_COMP;
         s->phy_int |= PHY_INT_ENERGYON;
         s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
     }
@@ -269,9 +273,11 @@ static void imx_phy_reset(IMXFECState *s)
 {
     trace_imx_phy_reset();
 
-    s->phy_status = 0x7809;
-    s->phy_control = 0x3000;
-    s->phy_advertise = 0x01e1;
+    s->phy_status = MII_BMSR_100TX_FD | MII_BMSR_100TX_HD | MII_BMSR_10T_FD |
+                    MII_BMSR_10T_HD | MII_BMSR_AUTONEG | MII_BMSR_EXTCAP;
+    s->phy_control = MII_BMCR_AUTOEN | MII_BMCR_SPEED100;
+    s->phy_advertise = MII_ANAR_CSMACD | MII_ANAR_TX | MII_ANAR_10FD |
+                       MII_ANAR_10 | MII_ANAR_TXFD;
     s->phy_int_mask = 0;
     s->phy_int = 0;
     imx_phy_update_link(s);
@@ -285,37 +291,42 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
     reg %= 32;
 
     switch (reg) {
-    case 0:     /* Basic Control */
+    case MII_BMCR:     /* Basic Control */
         val = s->phy_control;
         break;
-    case 1:     /* Basic Status */
+    case MII_BMSR:     /* Basic Status */
         val = s->phy_status;
         break;
-    case 2:     /* ID1 */
-        val = 0x0007;
+    case MII_PHYID1:     /* ID1 */
+        val = LAN911x_PHYID1;
         break;
-    case 3:     /* ID2 */
-        val = 0xc0d1;
+    case MII_PHYID2:     /* ID2 */
+        val = LAN911x_PHYID2;
         break;
-    case 4:     /* Auto-neg advertisement */
+    case MII_ANAR:     /* Auto-neg advertisement */
         val = s->phy_advertise;
         break;
-    case 5:     /* Auto-neg Link Partner Ability */
-        val = 0x0f71;
+    case MII_ANLPAR:     /* Auto-neg Link Partner Ability */
+        val = MII_ANLPAR_CSMACD | MII_ANLPAR_10 | MII_ANLPAR_10FD |
+              MII_ANLPAR_TX | MII_ANLPAR_TXFD | MII_ANLPAR_PAUSE |
+              MII_ANLPAR_PAUSEASY;
         break;
-    case 6:     /* Auto-neg Expansion */
-        val = 1;
+    case MII_ANER:     /* Auto-neg Expansion */
+        val = MII_ANER_NWAY;
         break;
-    case 29:    /* Interrupt source.  */
+    case MII_SMC911X_ISF:    /* Interrupt source.  */
         val = s->phy_int;
         s->phy_int = 0;
         imx_phy_update_irq(s);
         break;
-    case 30:    /* Interrupt mask */
+    case MII_SMC911X_IM:    /* Interrupt mask */
         val = s->phy_int_mask;
         break;
-    case 17:
-    case 18:
+    case MII_NSR:
+        val = 1 << 6;
+        break;
+    case MII_LBREMR:
+    case MII_REC:
     case 27:
     case 31:
         qemu_log_mask(LOG_UNIMP, "[%s.phy]%s: reg %d not implemented\n",
@@ -343,26 +354,31 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
     trace_imx_phy_write(val, phy, reg);
 
     switch (reg) {
-    case 0:     /* Basic Control */
-        if (val & 0x8000) {
+    case MII_BMCR:     /* Basic Control */
+        if (val & MII_BMCR_RESET) {
             imx_phy_reset(s);
         } else {
-            s->phy_control = val & 0x7980;
+            s->phy_control = val & (MII_BMCR_LOOPBACK | MII_BMCR_SPEED100 |
+                                    MII_BMCR_AUTOEN | MII_BMCR_PDOWN |
+                                    MII_BMCR_FD | MII_BMCR_CTST);
             /* Complete autonegotiation immediately.  */
-            if (val & 0x1000) {
-                s->phy_status |= 0x0020;
+            if (val & MII_BMCR_AUTOEN) {
+                s->phy_status |= MII_BMSR_AN_COMP;
             }
         }
         break;
-    case 4:     /* Auto-neg advertisement */
-        s->phy_advertise = (val & 0x2d7f) | 0x80;
+    case MII_ANAR:     /* Auto-neg advertisement */
+        s->phy_advertise = (val & (MII_ANAR_PAUSE_ASYM | MII_ANAR_PAUSE |
+                                   MII_ANAR_TXFD | MII_ANAR_TX |
+                                   MII_ANAR_10FD | MII_ANAR_10 | 0x1f)) |
+                                   MII_ANAR_TX;
         break;
-    case 30:    /* Interrupt mask */
+    case MII_SMC911X_IM:    /* Interrupt mask */
         s->phy_int_mask = val & 0xff;
         imx_phy_update_irq(s);
         break;
-    case 17:
-    case 18:
+    case MII_LBREMR:
+    case MII_REC:
     case 27:
     case 31:
         qemu_log_mask(LOG_UNIMP, "[%s.phy)%s: reg %d not implemented\n",
diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index 4ae4dcce7e3..d2001bd859b 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -112,4 +112,8 @@
 #define DP83848_PHYID1      0x2000
 #define DP83848_PHYID2      0x5c90
 
+/* SMSC LAN911x Internal PHY */
+#define LAN911x_PHYID1      0x0007
+#define LAN911x_PHYID2      0xc0d1
+
 #endif /* MII_H */
-- 
2.25.1


