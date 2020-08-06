Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3702BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3172E22DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3172E22DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fsi-0007E1-5w
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpi-0001R2-6v; Thu, 06 Aug 2020 09:21:22 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:59591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpe-0000vI-0Y; Thu, 06 Aug 2020 09:21:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.26])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 025184DAE2D2;
 Thu,  6 Aug 2020 15:21:16 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 15:21:15 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0059b04b038-410e-4e46-9012-a74034209712,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-5.2 16/19] aspeed/sdmc: Perform memory training
Date: Thu, 6 Aug 2020 15:21:03 +0200
Message-ID: <20200806132106.747414-17-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200806132106.747414-1-clg@kaod.org>
References: <20200806132106.747414-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: dd7b190d-f999-4629-a625-a24f5cbec8b5
X-Ovh-Tracer-Id: 273312205742967590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgihesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehheefgeejiedtffefteejudevjeeufeeugfdtfeeuleeuteevleeihffhgfdtleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:21:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

This allows qemu to run the "normal" power on reset boot path through
u-boot, where the DDR is trained.

An enhancement would be to have the SCU bit stick across qemu reboots,
but be unset on initial boot.

Proper modelling would be to discard all writes to the phy setting regs
at offset 0x100 - 0x400 and to model the phy status regs at offset
0x400.

The status regs model would only need to account for offets 0x00,
0x50, 0x68 and 0x7c.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[ clg: checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_sdmc.h | 13 ++++++++++++-
 hw/misc/aspeed_scu.c          |  2 +-
 hw/misc/aspeed_sdmc.c         | 19 +++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index cea1e67fe365..c6226957dd3d 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -17,7 +17,18 @@
 #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
 #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
 
-#define ASPEED_SDMC_NR_REGS (0x174 >> 2)
+/*
+ * SDMC has 174 documented registers. In addition the u-boot device tree
+ * describes the following regions:
+ *  - PHY status regs at offset 0x400, length 0x200
+ *  - PHY setting regs at offset 0x100, length 0x300
+ *
+ * There are two sets of MRS (Mode Registers) configuration in ast2600 memory
+ * system: one is in the SDRAM MC (memory controller) which is used in run
+ * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
+ * training.
+ */
+#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
 
 typedef struct AspeedSDMCState {
     /*< private >*/
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 764222404bef..dc6dd87c22f4 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -656,7 +656,7 @@ static const uint32_t ast2600_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
     [AST2600_CLK_STOP_CTRL]     = 0xFFFF7F8A,
     [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
-    [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
+    [AST2600_SDRAM_HANDSHAKE]   = 0x00000000,
     [AST2600_HPLL_PARAM]        = 0x1000405F,
     [AST2600_CHIP_ID0]          = 0x1234ABCD,
     [AST2600_CHIP_ID1]          = 0x88884444,
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 855848b7d23a..ff2809a09965 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -113,7 +113,7 @@ static uint64_t aspeed_sdmc_read(void *opaque, hwaddr addr, unsigned size)
     if (addr >= ARRAY_SIZE(s->regs)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, addr);
+                      __func__, addr * 4);
         return 0;
     }
 
@@ -206,6 +206,19 @@ static void aspeed_sdmc_reset(DeviceState *dev)
 
     /* Set ram size bit and defaults values */
     s->regs[R_CONF] = asc->compute_conf(s, 0);
+
+    /*
+     * PHY status:
+     *  - set phy status ok (set bit 1)
+     *  - initial PVT calibration ok (clear bit 3)
+     *  - runtime calibration ok (clear bit 5)
+     */
+    s->regs[0x100] = BIT(1);
+
+    /* PHY eye window: set all as passing */
+    s->regs[0x100 | (0x68 / 4)] = 0xff;
+    s->regs[0x100 | (0x7c / 4)] = 0xff;
+    s->regs[0x100 | (0x50 / 4)] = 0xfffffff;
 }
 
 static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *name,
@@ -443,7 +456,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
     }
 
     if (reg != R_PROT && s->regs[R_PROT] == PROT_SOFTLOCKED) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SDMC is locked! (write to MCR%02x blocked)\n",
+                      __func__, reg * 4);
         return;
     }
 
-- 
2.25.4


