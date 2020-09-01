Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E5BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800FA206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800FA206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5jg-0004hO-Km
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fQ-0004dY-KS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:40 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fM-0001RE-C7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.108])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 33193563B958;
 Tue,  1 Sep 2020 14:45:33 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 14:45:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003c25efb09-f62d-462a-8264-0cbfbb349265,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PULL 07/20] aspeed/sdhci: Fix reset sequence
Date: Tue, 1 Sep 2020 14:45:12 +0200
Message-ID: <20200901124525.220252-8-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200901124525.220252-1-clg@kaod.org>
References: <20200901124525.220252-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 92f8a6a4-1429-4caa-8fbe-2208d6fb91b6
X-Ovh-Tracer-Id: 4786481982081633187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:45:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
the bit is cleared by HW.

Use the number of supported slots to define the default value of this
register (The AST2600 eMMC Controller only has one). Fix the reset
sequence by clearing automatically the RESET bit.

Cc: Eddie James <eajames@linux.ibm.com>
Fixes: 2bea128c3d0b ("hw/sd/aspeed_sdhci: New device")
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-Id: <20200819100956.2216690-9-clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/sd/aspeed_sdhci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 22cafce0fbdc..4f24b7d2f942 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -16,7 +16,9 @@
 #include "hw/qdev-properties.h"
 
 #define ASPEED_SDHCI_INFO            0x00
-#define  ASPEED_SDHCI_INFO_RESET     0x00030000
+#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
+#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
+#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
 #define ASPEED_SDHCI_DEBOUNCE        0x04
 #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
 #define ASPEED_SDHCI_BUS             0x08
@@ -67,6 +69,10 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
     AspeedSDHCIState *sdhci = opaque;
 
     switch (addr) {
+    case ASPEED_SDHCI_INFO:
+        /* The RESET bit automatically clears. */
+        sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
+        break;
     case ASPEED_SDHCI_SDIO_140:
         sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
         break;
@@ -155,7 +161,11 @@ static void aspeed_sdhci_reset(DeviceState *dev)
     AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
 
     memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
-    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
+
+    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_SLOT0;
+    if (sdhci->num_slots == 2) {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] |= ASPEED_SDHCI_INFO_SLOT1;
+    }
     sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
 }
 
-- 
2.25.4


