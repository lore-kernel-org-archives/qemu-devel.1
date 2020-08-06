Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4583DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8202312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8202312D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fz5-0002Y8-7P
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpk-0001Zc-Qy; Thu, 06 Aug 2020 09:21:24 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:41181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpe-0000vM-4S; Thu, 06 Aug 2020 09:21:24 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.103])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 88D484DAE2D3;
 Thu,  6 Aug 2020 15:21:16 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 15:21:15 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005c266ca87-773d-4879-bd29-332383e74056,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-5.2 17/19] aspeed/sdmc: Allow writes to unprotected
 registers
Date: Thu, 6 Aug 2020 15:21:04 +0200
Message-ID: <20200806132106.747414-18-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200806132106.747414-1-clg@kaod.org>
References: <20200806132106.747414-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: c528cd45-ae84-42f7-b36e-0db5c2e7c388
X-Ovh-Tracer-Id: 273593680521628454
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

A subset of registers are not protected by the lock behaviour, so allow
unconditionally writing to those.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/misc/aspeed_sdmc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index ff2809a09965..81c73450ab5d 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -33,15 +33,28 @@
 /* Configuration Register */
 #define R_CONF            (0x04 / 4)
 
+/* Interrupt control/status */
+#define R_ISR             (0x50 / 4)
+
 /* Control/Status Register #1 (ast2500) */
 #define R_STATUS1         (0x60 / 4)
 #define   PHY_BUSY_STATE      BIT(0)
 #define   PHY_PLL_LOCK_STATUS BIT(4)
 
+/* Reserved */
+#define R_MCR6C           (0x6c / 4)
+
 #define R_ECC_TEST_CTRL   (0x70 / 4)
 #define   ECC_TEST_FINISHED   BIT(12)
 #define   ECC_TEST_FAIL       BIT(13)
 
+#define R_TEST_START_LEN  (0x74 / 4)
+#define R_TEST_FAIL_DQ    (0x78 / 4)
+#define R_TEST_INIT_VAL   (0x7c / 4)
+#define R_DRAM_SW         (0x88 / 4)
+#define R_DRAM_TIME       (0x8c / 4)
+#define R_ECC_ERR_INJECT  (0xb4 / 4)
+
 /*
  * Configuration register Ox4 (for Aspeed AST2400 SOC)
  *
@@ -449,6 +462,20 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
+    /* Unprotected registers */
+    switch (reg) {
+    case R_ISR:
+    case R_MCR6C:
+    case R_TEST_START_LEN:
+    case R_TEST_FAIL_DQ:
+    case R_TEST_INIT_VAL:
+    case R_DRAM_SW:
+    case R_DRAM_TIME:
+    case R_ECC_ERR_INJECT:
+        s->regs[reg] = data;
+        return;
+    }
+
     if (s->regs[R_PROT] == PROT_HARDLOCKED) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked until system reset!\n",
                 __func__);
-- 
2.25.4


