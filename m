Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9586DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6544F206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6544F206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPBA-0000cp-KA
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kDP6v-0001NB-95; Wed, 02 Sep 2020 05:31:21 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:47811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kDP6r-0004Yx-CS; Wed, 02 Sep 2020 05:31:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.217])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 8EC1E5D1903C;
 Wed,  2 Sep 2020 11:31:14 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 2 Sep 2020
 11:31:12 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001ce88ab86-4e22-48a0-9d8a-6ba7b98f6063,
 725C0B02AD5EA5A9EE23B5614217EC25792C566F) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 9/9] aspeed/smc: Add support for RDSFDP command
Date: Wed, 2 Sep 2020 11:31:07 +0200
Message-ID: <20200902093107.608000-10-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200902093107.608000-1-clg@kaod.org>
References: <20200902093107.608000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: c2758f96-87f8-4361-8a7c-1be6f7f0f2b0
X-Ovh-Tracer-Id: 7376896193109461868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 04:59:26
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify the snooping routine to handle RDSFDP, 1 dummy and 3 bytes
address space.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 6fbbb238f158..5f477eb9cf97 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -115,6 +115,7 @@ typedef struct AspeedSMCState {
 
     AspeedSMCFlash *flashes;
 
+    uint8_t snoop_addr_width;
     uint8_t snoop_index;
     uint8_t snoop_dummies;
 } AspeedSMCState;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 795784e5f364..594f34668e7a 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -778,10 +778,15 @@ typedef enum {
     PP = 0x2,           PP_4 = 0x12,
     DPP = 0xa2,
     QPP = 0x32,         QPP_4 = 0x34,
+    RDSFDP = 0x5a,
 } FlashCMD;
 
-static int aspeed_smc_num_dummies(uint8_t command)
+static int aspeed_smc_num_dummies(AspeedSMCFlash *fl, uint8_t command)
 {
+    AspeedSMCState *s = fl->controller;
+
+    s->snoop_addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
+
     switch (command) { /* check for dummies */
     case READ: /* no dummy bytes/cycles */
     case PP:
@@ -798,6 +803,9 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case DOR_4:
     case QOR_4:
         return 1;
+    case RDSFDP:
+        s->snoop_addr_width = 3;
+        return 1;
     case DIOR:
     case DIOR_4:
         return 2;
@@ -813,8 +821,6 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
                                 unsigned size)
 {
     AspeedSMCState *s = fl->controller;
-    uint8_t addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
-
     trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
                               (uint8_t) data & 0xff);
 
@@ -823,7 +829,7 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
 
     } else if (s->snoop_index == SNOOP_START) {
         uint8_t cmd = data & 0xff;
-        int ndummies = aspeed_smc_num_dummies(cmd);
+        int ndummies = aspeed_smc_num_dummies(fl, cmd);
 
         /*
          * No dummy cycles are expected with the current command. Turn
@@ -836,7 +842,7 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
 
         s->snoop_dummies = ndummies * 8;
 
-    } else if (s->snoop_index >= addr_width + 1) {
+    } else if (s->snoop_index >= s->snoop_addr_width + 1) {
 
         /* The SPI transfer has reached the dummy cycles sequence */
         for (; s->snoop_dummies; s->snoop_dummies--) {
@@ -1407,10 +1413,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
+        VMSTATE_UINT8(snoop_addr_width, AspeedSMCState),
         VMSTATE_UINT8(snoop_index, AspeedSMCState),
         VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
         VMSTATE_END_OF_LIST()
-- 
2.25.4


