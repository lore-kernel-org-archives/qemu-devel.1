Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA290C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80097205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80097205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHrf-0000Bx-Py
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHOV-0001UV-TR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHOQ-00061i-Oc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:37 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:51013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHOK-0005ne-1O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:30 -0400
Received: from player157.ha.ovh.net (unknown [10.108.57.72])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6EFCF1D0C52
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:55:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 204BA6EB54BC;
 Tue, 18 Jun 2019 16:55:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:53:07 +0200
Message-Id: <20190618165311.27066-18-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1691664611958819601
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.17
Subject: [Qemu-devel] [PATCH v2 17/21] aspeed/smc: inject errors in DMA
 checksum
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
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emulate read errors in the DMA Checksum Register for high frequencies
and optimistic settings of the Read Timing Compensation Register. This
will help in tuning the SPI timing calibration algorithm.

The values below are those to expect from the first flash device of
the FMC controller of a palmetto-bmc machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---

 Changes since v1:

 - introduced a "inject-failure" property as suggested by Philippe

 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 453357cc09bf..ba496956cd5e 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -87,6 +87,7 @@ typedef struct AspeedSMCState {
=20
     uint32_t num_cs;
     qemu_irq *cs_lines;
+    bool inject_failure;
=20
     SSIBus *spi;
=20
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 4a2e3a9135b6..5c017f631ffd 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -867,6 +867,36 @@ static void aspeed_smc_dma_calibration(AspeedSMCStat=
e *s)
     s->regs[s->r_ctrl0 + cs] |=3D CE_CTRL_CLOCK_FREQ(hclk_div);
 }
=20
+/*
+ * Emulate read errors in the DMA Checksum Register for high
+ * frequencies and optimistic settings of the Read Timing Compensation
+ * Register. This will help in tuning the SPI timing calibration
+ * algorithm.
+ */
+static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
+{
+    uint8_t delay =3D
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_M=
ASK;
+    uint8_t hclk_mask =3D
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MAS=
K;
+
+    /*
+     * Typical values of a palmetto-bmc machine.
+     */
+    switch (aspeed_smc_hclk_divisor(hclk_mask)) {
+    case 4 ... 16:
+        return false;
+    case 3: /* at least one HCLK cycle delay */
+        return (delay & 0x7) < 1;
+    case 2: /* at least two HCLK cycle delay */
+        return (delay & 0x7) < 2;
+    case 1: /* (> 100MHz) is above the max freq of the controller */
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Accumulate the result of the reads to provide a checksum that will
  * be used to validate the read timing settings.
@@ -904,6 +934,11 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *=
s)
         s->regs[R_DMA_FLASH_ADDR] +=3D 4;
         s->regs[R_DMA_LEN] -=3D 4;
     }
+
+    if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
+        s->regs[R_DMA_CHECKSUM] =3D 0xbadc0de;
+    }
+
 }
=20
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
@@ -1189,6 +1224,7 @@ static const VMStateDescription vmstate_aspeed_smc =
=3D {
=20
 static Property aspeed_smc_properties[] =3D {
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
+    DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, f=
alse),
     DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
     DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
--=20
2.21.0


