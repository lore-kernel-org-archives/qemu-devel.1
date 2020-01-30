Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DFDC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFB320707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrDR8JLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFB320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCXQ-0002TX-1B
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTn-0005EI-2q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTl-0002pW-Ms
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTl-0002ow-G8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id y17so4793650wrh.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jci5UMvt1t2+jMJhQKLKRFtdxDN9HBP2iHqJUzBoJJw=;
 b=PrDR8JLhJ5f0lrn7X4mPAYDy/K3eyihcetzFcbrCJUj+vfRPY7sn6PkQU323Kuxul0
 Ui3GJ8k0987U3UBuLPnL7cz2XJVh9XxH7L+4nonfZ6dEgtxa3lBmCeGfXStjlQEE2uK9
 BFh/eAX9bDQ/KEDWAskozbvFpwOnyTcH0pIKQ1nb+7K4cd1Pcat9KfOroD3wmJ8/Cpcq
 +5bS7WZBXeXLPJHQZh0lTNJpI4Xy6pWWqbJGggscfPW6siaOMQgQ9Z6x0u49XV70XUcP
 1UC9VuxPJcfYi9CUgTk/ibAke5ECzfHTMWLBFZJRm1Jrp+Pte4jaM3Ba+YeIQbgwHV1L
 3dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jci5UMvt1t2+jMJhQKLKRFtdxDN9HBP2iHqJUzBoJJw=;
 b=a54MEzEsqL8VSVcCu6RRs4gOSiIBdZvFVWaNKOFRHB8KRMw1kfXxLnkkKdVLsGIokY
 xLJxT9DgM+2SNhRWzlEKs15zs5L/6KQ6cHGwi74j0QBrzuiMpxMNT2UMD01EbN/GEOpb
 ngpts3dx6iF7jY9dr3aBPOeGAcHXzfThAUvjhVJSiGF1DgvLHL4vfz1HzN0zOiu8BtRL
 1OQRa0UezsGM9sdfRta2OrgG5ef7AYXUJcTV7BmOvRZTyi/kTcGGW3ivD1z0wFY0raKj
 8HcEsr9fZQ1M/jjPznZLeuvZnNovo0fdRphUUROltRiRu472hQIwztIE3WBoUUnEI2rn
 IzxA==
X-Gm-Message-State: APjAAAXqRjnLr57009Q8hUBPqbDxchVarBuojeYPP/5z2pWJT+mFLS9E
 OhEiyN3p1awAN8Iq6wYOv+T0Y593dBc7Ow==
X-Google-Smtp-Source: APXvYqzxt4UD5TCyKZU8AKpmscgWjo3qJPvHCEbjfPh3VfMZNX9CitKZvIZTArMNoilXkr2Bw4RUmg==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr6799941wrm.219.1580400940280; 
 Thu, 30 Jan 2020 08:15:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] hw/arm: ast2600: Wire up the eMMC controller
Date: Thu, 30 Jan 2020 16:15:11 +0000
Message-Id: <20200130161533.8180-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jeffery <andrew@aj.id.au>

Initialise another SDHCI model instance for the AST2600's eMMC
controller and use the SDHCI's num_slots value introduced previously to
determine whether we should create an SD card instance for the new slot.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200114103433.30534-3-clg@kaod.org
[ clg : - removed ternary operator from sdhci_attach_drive()
        - renamed SDHCI objects with a '-controller' prefix ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed.c             | 26 +++++++++++++++++---------
 hw/arm/aspeed_ast2600.c     | 29 ++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index e84380984f7..90ac7f7ffa3 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -57,6 +57,7 @@ typedef struct AspeedSoCState {
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
     AspeedSDHCIState sdhci;
+    AspeedSDHCIState emmc;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -126,6 +127,7 @@ enum {
     ASPEED_MII4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
+    ASPEED_EMMC,
 };
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4174e313cae..8702256af1b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -171,6 +171,19 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
+static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
+{
+        DeviceState *card;
+
+        card = qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                           TYPE_SD_CARD);
+        if (dinfo) {
+            qdev_prop_set_drive(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        }
+        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+}
+
 static void aspeed_machine_init(MachineState *machine)
 {
     AspeedBoardState *bmc;
@@ -264,16 +277,11 @@ static void aspeed_machine_init(MachineState *machine)
     }
 
     for (i = 0; i < bmc->soc.sdhci.num_slots; i++) {
-        SDHCIState *sdhci = &bmc->soc.sdhci.slots[i];
-        DriveInfo *dinfo = drive_get_next(IF_SD);
-        BlockBackend *blk;
-        DeviceState *card;
+        sdhci_attach_drive(&bmc->soc.sdhci.slots[i], drive_get_next(IF_SD));
+    }
 
-        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-        card = qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
-                           TYPE_SD_CARD);
-        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
-        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+    if (bmc->soc.emmc.num_slots) {
+        sdhci_attach_drive(&bmc->soc.emmc.slots[0], drive_get_next(IF_SD));
     }
 
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index fb73c4043ea..90cf1c755d3 100644
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
@@ -196,16 +199,26 @@ static void aspeed_soc_ast2600_init(Object *obj)
     sysbus_init_child_obj(obj, "gpio_1_8v", OBJECT(&s->gpio_1_8v),
                           sizeof(s->gpio_1_8v), typename);
 
-    sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
-                          TYPE_ASPEED_SDHCI);
+    sysbus_init_child_obj(obj, "sd-controller", OBJECT(&s->sdhci),
+                          sizeof(s->sdhci), TYPE_ASPEED_SDHCI);
 
     object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
 
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
-        sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
+        sysbus_init_child_obj(obj, "sd-controller.sdhci[*]",
+                              OBJECT(&s->sdhci.slots[i]),
                               sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
     }
+
+    sysbus_init_child_obj(obj, "emmc-controller", OBJECT(&s->emmc),
+                          sizeof(s->emmc), TYPE_ASPEED_SDHCI);
+
+    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
+
+    sysbus_init_child_obj(obj, "emmc-controller.sdhci",
+                          OBJECT(&s->emmc.slots[0]), sizeof(s->emmc.slots[0]),
+                          TYPE_SYSBUS_SDHCI);
 }
 
 /*
@@ -497,6 +510,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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
-- 
2.20.1


