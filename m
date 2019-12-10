Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870EB20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="O67l5jMS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4ZmFT+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870EB20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTmn-0004HK-MN
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ieTkU-0001aE-NF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ieTkT-0000NY-GG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:34 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ieTkR-0000MU-1G; Mon, 09 Dec 2019 19:51:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id AF6FA22721;
 Mon,  9 Dec 2019 19:51:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 09 Dec 2019 19:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=H0aPY86yzeMQw
 fYD+h2g47JaRugDPvF0iktz1Pvolmc=; b=O67l5jMSiTknwr7IuFdXeQWoXPUdx
 pK4aDoyNDWGySxtClZwH5gXLTkZeen0M9BS9vMgFHLmaEjpvWTWZQid7s6nQzB0A
 Yna28SH/w2Q5X6xSFVwF2yQ/rjg4fJm/KdFAZ32BxnHkXZIkpfKbhJWxhTwX1JSS
 U9C/IfSHtHYIHF3jDkqPTaKhoZa2JDJAwJzQtylu3W8j0RvMvQqjDKk0JDCK2I8M
 ldz2/ze4JcIh2Cw3JP/1fJc6C80HEaCf2D78j9nGB+t65miQa4/eu03G0trjkF61
 yjPEKHIGGMWE9V4aOMH7tZj4P51glUXlyim8cN6SwhG10MRaKF+bSf4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=H0aPY86yzeMQwfYD+h2g47JaRugDPvF0iktz1Pvolmc=; b=B4ZmFT+A
 h6pTMgQJGXBRbwvM6zN3HCl+xREwwAgXeU+pzNQxJ71zfumn4wEuf6NjRE4KjvUk
 ciaxH27yfuzEAI2hjSeFXQU3HmbkMGZWSicNVuy/savCzE9YbCD7m5+9yFC2C67u
 0WOMXowkXIhAq68ZnkrM/JSwEcnyopRSXdqAcAFobmHdzyvqd+P0uHav6V9xDj0M
 CAdhuLiWwd1FNRhiTlmFJTlsfD8/wEuPKgm42saNNGH2rU27GgrgENOWmztvsW6b
 ENfdRuho0fs2JF60s/OjxvAfwsBohRV5w+ZkxiS1AmtXm4KrQRaYyGE9ovn1FDzT
 tYW08B3T+FNr/A==
X-ME-Sender: <xms:EuzuXQVHY1hK4CUmz4YnhzCVxYpwlQxobtmfl6p8cODnrmzNQg3kJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedu
X-ME-Proxy: <xmx:EuzuXeaV__B-aIAIPsTzhoXqVmIaWDZegXIgavgAMiF5cmPw9Vr6uw>
 <xmx:EuzuXf1zSrWodOIxB3aA-ywH_Puxb5LJvwnVmmMTGwk6EbGpBCaG1w>
 <xmx:EuzuXbs72oS5n0m0j_YENlWnx821IA1wxsIQyrRfQwb958Yuk1zYfg>
 <xmx:EuzuXTqCVrIEadM_spJwtoGAY6MpkVrkaicLyt-kde2dn2hSdD1IMA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7283330600BD;
 Mon,  9 Dec 2019 19:51:28 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 2/2] hw/arm: ast2600: Wire up the eMMC controller
Date: Tue, 10 Dec 2019 11:22:51 +1030
Message-Id: <5a93d2f9d375f92e9db6b1cf8687f86beaedcbb2.1575938234.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initialise another SDHCI model instance for the AST2600's eMMC
controller and use the SDHCI's num_slots value introduced previously to
determine whether we should create an SD card instance for the new slot.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed.c             | 13 +++++++++++++
 hw/arm/aspeed_ast2600.c     | 21 +++++++++++++++++++++
 include/hw/arm/aspeed_soc.h |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 862549b1f3a9..0e08d62e9ff3 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -272,6 +272,19 @@ static void aspeed_board_init(MachineState *machine,
         object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
     }
 
+    if (bmc->soc.emmc.num_slots) {
+        SDHCIState *emmc = &bmc->soc.emmc.slots[0];
+        DriveInfo *dinfo = drive_get_next(IF_SD);
+        BlockBackend *blk;
+        DeviceState *card;
+
+        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+        card = qdev_create(qdev_get_child_bus(DEVICE(emmc), "sd-bus"),
+                           TYPE_SD_CARD);
+        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931ee5aae183..723c8196c8a5 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_ADC]       = 0x1E6E9000,
     [ASPEED_VIDEO]     = 0x1E700000,
     [ASPEED_SDHCI]     = 0x1E740000,
+    [ASPEED_EMMC]      = 0x1E750000,
     [ASPEED_GPIO]      = 0x1E780000,
     [ASPEED_GPIO_1_8V] = 0x1E780800,
     [ASPEED_RTC]       = 0x1E781000,
@@ -64,6 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
 
 #define ASPEED_SOC_AST2600_MAX_IRQ 128
 
+/* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
 static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_UART1]     = 47,
     [ASPEED_UART2]     = 48,
@@ -77,6 +79,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ADC]       = 78,
     [ASPEED_XDMA]      = 6,
     [ASPEED_SDHCI]     = 43,
+    [ASPEED_EMMC]      = 15,
     [ASPEED_GPIO]      = 40,
     [ASPEED_GPIO_1_8V] = 11,
     [ASPEED_RTC]       = 13,
@@ -215,6 +218,14 @@ static void aspeed_soc_ast2600_init(Object *obj)
         sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
                               sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
     }
+
+    sysbus_init_child_obj(obj, "emmc", OBJECT(&s->emmc), sizeof(s->emmc),
+                          TYPE_ASPEED_SDHCI);
+
+    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
+
+    sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s->emmc.slots[0]),
+            sizeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
 }
 
 /*
@@ -487,6 +498,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
+
+    /* eMMC */
+    object_property_set_bool(OBJECT(&s->emmc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
+                       aspeed_soc_get_irq(s, ASPEED_EMMC));
 }
 
 static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 495c08be1b84..911443f4c071 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -56,6 +56,7 @@ typedef struct AspeedSoCState {
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
     AspeedSDHCIState sdhci;
+    AspeedSDHCIState emmc;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -125,6 +126,7 @@ enum {
     ASPEED_MII4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
+    ASPEED_EMMC,
 };
 
 #endif /* ASPEED_SOC_H */
-- 
git-series 0.9.1

