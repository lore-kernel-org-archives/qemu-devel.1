Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4520AC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB5220726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="kzpsk9a+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuB49+zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB5220726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTlf-0002nW-8C
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ieTkT-0001Yf-LA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ieTkS-0000N8-Ah
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ieTkP-0000Ll-Lf; Mon, 09 Dec 2019 19:51:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0AB3B2274C;
 Mon,  9 Dec 2019 19:51:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 09 Dec 2019 19:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=rUFlEnpp1Xzck
 M6kcV2NqxDXgI9i9LAVjGAQGY512Q8=; b=kzpsk9a+FMdyP9JOh+u46xMxCCOWX
 /WJVA7FRXvTxX4shCMAb208r7cjsPxtelke/dA/6NurHBF6c3BEN3UIBtqKxrBLC
 x6MybfmPjyVazd3q3UjY2GPPkZoxD7V7+cFrY5jTpmllfP2/J6hqtw0HWUHxdkXo
 OMkrWBCy137S4mqTwMIbO18jL/Ud1cgh33BXJ6bWAazquZ8asPSPoBgIqw6J7ike
 9BeBnIwcDRIPTgEAN9Zfugs0LBdugix4QPfj/+QQQ0Hh1Z6ljwU/StBTOQmCns//
 VH6hlN1sD+aBVz0GPaZbvSZPUbOaihM/XVZ7aEWjYvJqyWdLq3itIbimw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=rUFlEnpp1XzckM6kcV2NqxDXgI9i9LAVjGAQGY512Q8=; b=kuB49+zX
 TByF//kQfk8ML5iLwfoo2LgALJGu0CGBDN5gGRxO1l9z/JRHo6EdImNLORc/CYhy
 HKiWxi3IIT5P1XR7vTaiI2G/VUpwkyf5wLxgyfH5w2khXYU2hbcVybsC8fmHMrCS
 pksc3WhGOXBwybnBPxRWGzu7bXYj7g3i7V5D1eMbzee1PIBKw/Jk6+V6jLhCnqDk
 sa5GX7TlOIuo4SJeLBQL9tBofrAQulV50gHwFuTZ4mqTQHt544YqRYAbYHqI1MhP
 GxRQaoMI9gYiSQBhEnbxwfhnSGJQZ9of8WenFUQsLBy03trzYnvEl7JGi/PrvbeG
 0WxkQ2aA865CQw==
X-ME-Sender: <xms:D-zuXW5GEG9LcH7SWK3E05iueKt3PWfEUL70_1NbeUJlQM8LYzfRBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedt
X-ME-Proxy: <xmx:D-zuXW0g6V7YfBIjP9qqAfp78rvSKx-q8jtDx-raMWK4JBIqOcjiNA>
 <xmx:D-zuXanYpwi4dEmKK6wFd08XQr678ArJtAizBEFtNSe5bLhOppicmQ>
 <xmx:D-zuXXikA3uRldeLDF-buaPJ7pliYAe8PzAqROZGsuUZgKXqc3gV-A>
 <xmx:EOzuXfyZPIhwjS3AGamOOU38ooHwgf9rYZnTHMEMIR9AzhkWNDnM6A>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id BE98B30600D4;
 Mon,  9 Dec 2019 19:51:25 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 1/2] hw/sd: Configure number of slots exposed by the ASPEED
 SDHCI model
Date: Tue, 10 Dec 2019 11:22:50 +1030
Message-Id: <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
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

The AST2600 includes a second cut-down version of the SD/MMC controller
found in the AST2500, named the eMMC controller. It's cut down in the
sense that it only supports one slot rather than two, but it brings the
total number of slots supported by the AST2600 to three.

The existing code assumed that the SD controller always provided two
slots. Rework the SDHCI object to expose the number of slots as a
property to be set by the SoC configuration.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed.c              |  2 +-
 hw/arm/aspeed_ast2600.c      |  2 ++
 hw/arm/aspeed_soc.c          |  3 +++
 hw/sd/aspeed_sdhci.c         | 11 +++++++++--
 include/hw/sd/aspeed_sdhci.h |  1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 028191ff36fc..862549b1f3a9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -259,7 +259,7 @@ static void aspeed_board_init(MachineState *machine,
         cfg->i2c_init(bmc);
     }
 
-    for (i = 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
+    for (i = 0; i < bmc->soc.sdhci.num_slots; i++) {
         SDHCIState *sdhci = &bmc->soc.sdhci.slots[i];
         DriveInfo *dinfo = drive_get_next(IF_SD);
         BlockBackend *blk;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931887ac681f..931ee5aae183 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -208,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
     sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
                           TYPE_ASPEED_SDHCI);
 
+    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
+
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
         sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index f4fe243458fd..3498f55603f2 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -215,6 +215,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
                           TYPE_ASPEED_SDHCI);
 
+    object_property_set_int(OBJECT(&s->sdhci), ASPEED_SDHCI_NUM_SLOTS,
+                            "num-slots", &error_abort);
+
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
         sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index cff3eb7dd21e..939d1510dedb 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 #define ASPEED_SDHCI_INFO            0x00
 #define  ASPEED_SDHCI_INFO_RESET     0x00030000
@@ -120,14 +121,14 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
 
     /* Create input irqs for the slots */
     qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
-                                        sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
+                                        sdhci, NULL, sdhci->num_slots);
 
     sysbus_init_irq(sbd, &sdhci->irq);
     memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
                           sdhci, TYPE_ASPEED_SDHCI, 0x1000);
     sysbus_init_mmio(sbd, &sdhci->iomem);
 
-    for (int i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+    for (int i = 0; i < sdhci->num_slots; ++i) {
         Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
         SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
 
@@ -174,6 +175,11 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
     },
 };
 
+static Property aspeed_sdhci_properties[] = {
+    DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
@@ -181,6 +187,7 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
     dc->realize = aspeed_sdhci_realize;
     dc->reset = aspeed_sdhci_reset;
     dc->vmsd = &vmstate_aspeed_sdhci;
+    dc->props = aspeed_sdhci_properties;
 }
 
 static TypeInfo aspeed_sdhci_info = {
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
index dfdab4379021..dffbb46946b9 100644
--- a/include/hw/sd/aspeed_sdhci.h
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -24,6 +24,7 @@ typedef struct AspeedSDHCIState {
     SysBusDevice parent;
 
     SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
+    uint8_t num_slots;
 
     MemoryRegion iomem;
     qemu_irq irq;
-- 
git-series 0.9.1

