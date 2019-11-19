Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC7C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C29222A9
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C29222A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4Oy-0007yi-BX
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4Fy-0006Qp-L7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4Fw-0005R3-Hb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:26 -0500
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:60327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4Fv-0005Po-Hu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:24 -0500
Received: from player795.ha.ovh.net (unknown [10.108.57.211])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 85C9319BC9B
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:13:20 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 9BA1DC18AAE1;
 Tue, 19 Nov 2019 14:13:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/17] aspeed/scu: Fix W1C behavior
Date: Tue, 19 Nov 2019 15:12:01 +0100
Message-Id: <20191119141211.25716-8-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17906312122056477457
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeef
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.45.107
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

This models the clock write one to clear registers, and fixes up some
incorrect behavior in all of the write to clear registers.

There was also a typo in one of the register definitions.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: checkpatch.pl fixes ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/misc/aspeed_scu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 717509bc5460..f62fa25e3474 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -98,7 +98,7 @@
 #define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
 #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
 #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
-#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_CLK_STOP_CTRL2_CLR TO_REG(0x94)
 #define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
 #define AST2600_HPLL_PARAM        TO_REG(0x200)
 #define AST2600_HPLL_EXT          TO_REG(0x204)
@@ -532,11 +532,13 @@ static uint64_t aspeed_ast2600_scu_read(void *opaqu=
e, hwaddr offset,
     return s->regs[reg];
 }
=20
-static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64=
_t data,
-                                     unsigned size)
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data64, unsigned size)
 {
     AspeedSCUState *s =3D ASPEED_SCU(opaque);
     int reg =3D TO_REG(offset);
+    /* Truncate here so bitwise operations below behave as expected */
+    uint32_t data =3D data64;
=20
     if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -563,15 +565,22 @@ static void aspeed_ast2600_scu_write(void *opaque, =
hwaddr offset, uint64_t data,
         /* fall through */
     case AST2600_SYS_RST_CTRL:
     case AST2600_SYS_RST_CTRL2:
+    case AST2600_CLK_STOP_CTRL:
+    case AST2600_CLK_STOP_CTRL2:
         /* W1S (Write 1 to set) registers */
         s->regs[reg] |=3D data;
         return;
     case AST2600_SYS_RST_CTRL_CLR:
     case AST2600_SYS_RST_CTRL2_CLR:
+    case AST2600_CLK_STOP_CTRL_CLR:
+    case AST2600_CLK_STOP_CTRL2_CLR:
     case AST2600_HW_STRAP1_CLR:
     case AST2600_HW_STRAP2_CLR:
-        /* W1C (Write 1 to clear) registers */
-        s->regs[reg] &=3D ~data;
+        /*
+         * W1C (Write 1 to clear) registers are offset by one address fr=
om
+         * the data register
+         */
+        s->regs[reg - 1] &=3D ~data;
         return;
=20
     case AST2600_RNG_DATA:
--=20
2.21.0


