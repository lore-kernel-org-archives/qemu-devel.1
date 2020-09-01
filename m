Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BEC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8493A206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8493A206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5oV-0006Gh-Lk
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fe-00056E-3G
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:54 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fa-0001Uf-Md
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:53 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.131])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 1A006563B99D;
 Tue,  1 Sep 2020 14:45:39 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 14:45:36 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003b618e4ae-2cdc-4408-9c0a-d1cff65a76d9,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PULL 17/20] aspeed/sdmc: Simplify calculation of RAM bits
Date: Tue, 1 Sep 2020 14:45:22 +0200
Message-ID: <20200901124525.220252-18-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200901124525.220252-1-clg@kaod.org>
References: <20200901124525.220252-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 736c19d0-dcee-434a-9e9d-c63ba3baf843
X-Ovh-Tracer-Id: 4787326407273581536
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in commit 533eb415df2e ("arm/aspeed: actually check RAM size")
introduced a 'valid_ram_sizes' array which can be used to compute the
associated bit field value encoding the RAM size. The field is simply
the index of the array.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-Id: <20200819100956.2216690-19-clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/misc/aspeed_sdmc.c | 79 ++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 54 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 81c73450ab5d..08f856cbda7e 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -159,57 +159,6 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
     .valid.max_access_size = 4,
 };
 
-static int ast2400_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 64:
-        return ASPEED_SDMC_DRAM_64MB;
-    case 128:
-        return ASPEED_SDMC_DRAM_128MB;
-    case 256:
-        return ASPEED_SDMC_DRAM_256MB;
-    case 512:
-        return ASPEED_SDMC_DRAM_512MB;
-    default:
-        g_assert_not_reached();
-        break;
-    }
-}
-
-static int ast2500_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 128:
-        return ASPEED_SDMC_AST2500_128MB;
-    case 256:
-        return ASPEED_SDMC_AST2500_256MB;
-    case 512:
-        return ASPEED_SDMC_AST2500_512MB;
-    case 1024:
-        return ASPEED_SDMC_AST2500_1024MB;
-    default:
-        g_assert_not_reached();
-        break;
-    }
-}
-
-static int ast2600_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 256:
-        return ASPEED_SDMC_AST2600_256MB;
-    case 512:
-        return ASPEED_SDMC_AST2600_512MB;
-    case 1024:
-        return ASPEED_SDMC_AST2600_1024MB;
-    case 2048:
-        return ASPEED_SDMC_AST2600_2048MB;
-    default:
-        g_assert_not_reached();
-        break;
-    }
-}
-
 static void aspeed_sdmc_reset(DeviceState *dev)
 {
     AspeedSDMCState *s = ASPEED_SDMC(dev);
@@ -324,10 +273,32 @@ static const TypeInfo aspeed_sdmc_info = {
     .abstract   = true,
 };
 
+static int aspeed_sdmc_get_ram_bits(AspeedSDMCState *s)
+{
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
+    int i;
+
+    /*
+     * The bitfield value encoding the RAM size is the index of the
+     * possible RAM size array
+     */
+    for (i = 0; asc->valid_ram_sizes[i]; i++) {
+        if (s->ram_size == asc->valid_ram_sizes[i]) {
+            return i;
+        }
+    }
+
+    /*
+     * Invalid RAM sizes should have been excluded when setting the
+     * SoC RAM size.
+     */
+    g_assert_not_reached();
+}
+
 static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 {
     uint32_t fixed_conf = ASPEED_SDMC_VGA_COMPAT |
-        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
+        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
 
     /* Make sure readonly bits are kept */
     data &= ~ASPEED_SDMC_READONLY_MASK;
@@ -385,7 +356,7 @@ static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
     uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
         ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
         ASPEED_SDMC_CACHE_INITIAL_DONE |
-        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
+        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
 
     /* Make sure readonly bits are kept */
     data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
@@ -451,7 +422,7 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 {
     uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(3) |
         ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-        ASPEED_SDMC_DRAM_SIZE(ast2600_rambits(s));
+        ASPEED_SDMC_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
 
     /* Make sure readonly bits are kept (use ast2500 mask) */
     data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
-- 
2.25.4


