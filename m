Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B8C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E8A20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="h8qaL6OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E8A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8bc-0005Yx-JN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 01:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kN8Zk-00045x-Kw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:53:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:40616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kN8Zh-0005lu-JM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:53:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id x123so3440910pfc.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iaqxygqh0sAXKPaEqsfokpUsC+kEzlNVGmu10uaREI4=;
 b=h8qaL6OB4G22zx/uD7Y+LlroUsoEgbSOE7WoiFcfdT3j6n8ngwz2HJLWtgfbZVbN3k
 qgy1UnKDOKSVOFRDpPK3sgKQSjo5an7BRuxF7McPfR78bTSctrbUKY6B63/8rBpmxRap
 WwviFsYyZr/fxKIsCyUQIqAnQe0Vfa4E6UNcbZhXAGXuAB2dUBp1txJpD3lJUeaFpLcy
 n3TIo6JHwxSg+XAqUPtCJQvxI/F9hgYqAtwCiCIXeASGEKkOfDK8UnmB3NV2RLcsIPGz
 rDcFFhd//PD+bgxqgmOtzH7CPOHOl77jwnLXoWs3Ax8RtCvnb0POlzAArd4Sn3SY2i0x
 RU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iaqxygqh0sAXKPaEqsfokpUsC+kEzlNVGmu10uaREI4=;
 b=SOWnPvS2GYUuk7o96+o1fjtoVO1FmGEPWF9cRvDpmWif0HvnzgauZPJ1NxCTVLYWtO
 BZHOMdjPTu2zn4vJwAKNg/xtheQdJu9LH73lQY2o+Mb7PufSEDukN4rby1ih5hhOBcVq
 FWmbJaNU2lTMOQCO9WDqhCkd5Q8BgCNvaODaABj6KARWgIRZQSggwc0A/Ypzhmt7BOqJ
 ydMIZzC3Uoc4njOFYhBYYHrnVLCJn5C2Dj3LTYxxkgwTTeMA0MwVKCqjHF3x++QT4gNR
 AscyBmWQby7SGr36ZrAu4KfXQsXma2aEWOLBYDs5//LS/8fZgEzdbj4fYNRhbSTNWIVD
 Lq5A==
X-Gm-Message-State: AOAM5333aGaEHCtE/kFFj5+Am59U5moN2ONkidG1/jkWfnfEi84FYZUn
 Rqk9EM77meI/8WvEPJKTtnUuAg==
X-Google-Smtp-Source: ABdhPJyVhrohQrS8aUOOoZz8gXsMBTk1vk9f+ziniT9kwR+fc/4BzhhRq0P2fhRgv6bMxU0Gta7qKg==
X-Received: by 2002:a17:902:8b89:b029:d2:4345:5dd with SMTP id
 ay9-20020a1709028b89b02900d2434505ddmr3058889plb.57.1601358796108; 
 Mon, 28 Sep 2020 22:53:16 -0700 (PDT)
Received: from localhost ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id 99sm3095625pjo.40.2020.09.28.22.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 22:53:15 -0700 (PDT)
From: John Wang <wangzhiqiang.bj@bytedance.com>
To: clkg@kaod.org, yulei.sh@bytedance.com, xuxiaohan@bytedance.com,
 joel@jms.id.au
Subject: [PATCH 2/2] aspeed: Add support for the g220a-bmc board
Date: Tue, 29 Sep 2020 13:53:09 +0800
Message-Id: <20200929055309.509-2-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

G220A is a 2 socket x86 motherboard supported by OpenBMC.
Strapping configuration was obtained from hardware.

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 hw/arm/aspeed.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bdb981d2f8..04c8ad2bcd 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -120,6 +120,20 @@ struct AspeedMachineState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+#define G220A_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_2ND_BOOT_WDT |                                     \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -559,6 +573,30 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 11: TODO ucd90160@64 */
 }
 
+static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+    DeviceState *dev;
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+}
+
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
 {
     return ASPEED_MACHINE(obj)->mmio_exec;
@@ -798,6 +836,24 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
+static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Bytedance G220A BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = G220A_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q512a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON;
+    amc->i2c_init  = g220a_bmc_i2c_init;
+    mc->default_ram_size = 1024 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
+};
+
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
@@ -835,6 +891,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("tacoma-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tacoma_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("g220a-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_g220a_class_init,
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.25.1


