Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9015D206E9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015D206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpdpU-0007oL-RH
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 16:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpdnu-0005mR-Dp
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:21:30 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jpdns-0004EE-HR
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:21:30 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2709EFF804;
 Sun, 28 Jun 2020 20:21:25 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au,
 f4bug@amsat.org
Subject: [PATCH 1/3] Add a phy-num property to the i.MX FEC emulator
Date: Sun, 28 Jun 2020 22:20:56 +0200
Message-Id: <a1a5c0e139d1c763194b8020573dcb6025daeefa.1593296112.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1593296112.git.jcd@tribudubois.net>
References: <cover.1593296112.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.199; envelope-from=jcd@tribudubois.net;
 helo=relay9-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 16:21:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need a solution to use an Ethernet PHY that is not the first device
on the MDIO bus (device 0 on MDIO bus).

As an example with the i.MX6UL the NXP SOC has 2 Ethernet devices but
only one MDIO bus on which the 2 related PHY are connected but at unique
addresses.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/net/imx_fec.c         | 24 +++++++++++++++++-------
 hw/net/trace-events      |  4 ++--
 include/hw/net/imx_fec.h |  1 +
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eefedc252de..2c148040414 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -280,12 +280,16 @@ static void imx_phy_reset(IMXFECState *s)
 static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
     uint32_t val;
+    uint32_t phy = reg / 32;
 
-    if (reg > 31) {
-        /* we only advertise one phy */
+    if (phy != s->phy_num) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad phy num %u\n",
+                      TYPE_IMX_FEC, __func__, phy);
         return 0;
     }
 
+    reg %= 32;
+
     switch (reg) {
     case 0:     /* Basic Control */
         val = s->phy_control;
@@ -331,20 +335,25 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
         break;
     }
 
-    trace_imx_phy_read(val, reg);
+    trace_imx_phy_read(val, phy, reg);
 
     return val;
 }
 
 static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 {
-    trace_imx_phy_write(val, reg);
+    uint32_t phy = reg / 32;
 
-    if (reg > 31) {
-        /* we only advertise one phy */
+    if (phy != s->phy_num) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad phy num %u\n",
+                      TYPE_IMX_FEC, __func__, phy);
         return;
     }
 
+    reg %= 32;
+
+    trace_imx_phy_write(val, phy, reg);
+
     switch (reg) {
     case 0:     /* Basic Control */
         if (val & 0x8000) {
@@ -926,7 +935,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                                                        extract32(value,
                                                                  18, 10)));
         } else {
-            /* This a write operation */
+            /* This is a write operation */
             imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
         }
         /* raise the interrupt as the PHY operation is done */
@@ -1315,6 +1324,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 static Property imx_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(IMXFECState, conf),
     DEFINE_PROP_UINT32("tx-ring-num", IMXFECState, tx_ring_num, 1),
+    DEFINE_PROP_UINT32("phy-num", IMXFECState, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e6875c4c0f6..5db45456d92 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -413,8 +413,8 @@ i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
 
 # imx_fec.c
-imx_phy_read(uint32_t val, int reg) "0x%04"PRIx32" <= reg[%d]"
-imx_phy_write(uint32_t val, int reg) "0x%04"PRIx32" => reg[%d]"
+imx_phy_read(uint32_t val, int phy, int reg) "0x%04"PRIx32" <= phy[%d].reg[%d]"
+imx_phy_write(uint32_t val, int phy, int reg) "0x%04"PRIx32" => phy[%d].reg[%d]"
 imx_phy_update_link(const char *s) "%s"
 imx_phy_reset(void) ""
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 7b3faa40194..9f03034b893 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -268,6 +268,7 @@ typedef struct IMXFECState {
     uint32_t phy_advertise;
     uint32_t phy_int;
     uint32_t phy_int_mask;
+    uint32_t phy_num;
 
     bool is_fec;
 
-- 
2.25.1


