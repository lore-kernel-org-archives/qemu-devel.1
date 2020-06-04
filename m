Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7907D2063A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7907D2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpCm-0003pD-NN
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jgp9f-000824-Bo; Thu, 04 Jun 2020 08:39:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jgp9e-0001h4-FF; Thu, 04 Jun 2020 08:39:31 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2EE69E0005;
 Thu,  4 Jun 2020 12:39:26 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Subject: [PATCH v5 2/3] hw/net/imx_fec: Allow phy not to be the first device
 on the mii bus.
Date: Thu,  4 Jun 2020 14:39:09 +0200
Message-Id: <a6223b7b5c1564afc5fb3c2a9ad514bdb41be5a5.1591272275.git.jcd@tribudubois.net>
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

Up to now we were allowing only one PHY device and it had to be the
first device on the bus.

The i.MX6UL has 2 Ethernet devices and can therefore have several
PHY devices on the bus (and not necessarilly as device 0).

This patch allows for PHY devices on 2nd, 3rd or any position.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 v2: Not present
 v3: Not present
 v4: Not present
 v5: Allow phy not to be the first device on the mii bus.

 hw/net/imx_fec.c    | 19 ++++++++-----------
 hw/net/trace-events |  4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eefedc252de..29e613699ee 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -280,11 +280,9 @@ static void imx_phy_reset(IMXFECState *s)
 static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
     uint32_t val;
+    uint32_t phy = reg / 32;
 
-    if (reg > 31) {
-        /* we only advertise one phy */
-        return 0;
-    }
+    reg %= 32;
 
     switch (reg) {
     case 0:     /* Basic Control */
@@ -331,19 +329,18 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
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
-        return;
-    }
+    reg %= 32;
+
+    trace_imx_phy_write(val, phy, reg);
 
     switch (reg) {
     case 0:     /* Basic Control */
@@ -926,7 +923,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                                                        extract32(value,
                                                                  18, 10)));
         } else {
-            /* This a write operation */
+            /* This is a write operation */
             imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
         }
         /* raise the interrupt as the PHY operation is done */
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 26700dad997..27dfa0ef775 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -410,8 +410,8 @@ i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
 
 # imx_fec.c
-imx_phy_read(uint32_t val, int reg) "0x%04"PRIx32" <= reg[%d]"
-imx_phy_write(uint32_t val, int reg) "0x%04"PRIx32" => reg[%d]"
+imx_phy_read(uint32_t val, int phy, int reg) "0x%04"PRIx32" <= phy[%d].reg[%d]"
+imx_phy_write(uint32_t val, int phy, int reg) "0x%04"PRIx32" => phy[%d].reg[%d]"
 imx_phy_update_link(const char *s) "%s"
 imx_phy_reset(void) ""
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
-- 
2.25.1


