Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591B42074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="MqbPYRpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591B42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt3e-00078B-Vd
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kMpRG-00070a-D9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:27:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:36791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kMpR8-0003qh-L5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:27:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id b17so300624pji.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y/kSum0EA/plO9SVgJExaxOoOw0fBp1exDKCZt+0Evg=;
 b=MqbPYRpnKL/tgriF3GXia0hOVS5T5gfE1dnK21eg8v7quEuSKsJrgVTna+1eilRyBy
 Yeg9uULxEq5pd01U0Tcpjh6aed9/PlFtRoJknf2PwrFvJhtwe/qDs31/lFC5Ug4ACmAi
 de5k7S8bVdlgS8hGWLCd4wRbwTJFQkRPstViXlpQm3tK1jJ6Z+Tg+1gFG1zEcQcI2oYj
 eBZANm2Ha2+tywrPJnKILu8gGRRjtkl0SuNcB21wSxeWJt5qcqSTiD23KMoXrCc6FZ7S
 C8o0aiuWSG2iRMzcsDd0fjvvtWMWs1G3iT0xAAxYvhX5sBP7kqZsdUfBJkn4+kgO3Xac
 PNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y/kSum0EA/plO9SVgJExaxOoOw0fBp1exDKCZt+0Evg=;
 b=bYnXPO/2oV1h9ARm/wPaWhIgkNyl0ierXIqAR0WJCVt0zir0KwS03Hjp2SRIh987cY
 zE/PLPOE0A4vZiERAqeiO7rZ2pllNawsgerVUImzuJt+KoScuhNw9+i8QW6fjV0rWeTL
 itJKolNmc7KS73F8+1eF6BCfsRvoDOfkWPgmr5GF6VnDD8EGePpMvMrspiD81XAtvQR8
 q/8lsPYG2UFNfsKZVff4z6iSmZ/7SDbLEOjFnONY1fu7+riv6nE48ywM27ccl6tV7+py
 pSytgRLyLUph1Ndh3wn9K+O/5KMoahmru1UbUesjOKcoOtMZJ0EjfFmOjIen4e0fdyi8
 baxQ==
X-Gm-Message-State: AOAM533YgOmdpWj1VILFGxtorhDnfaCumYLJWSxa9hLh1d26X1TUBuE7
 1NRexznefCrV7KLxBTvuhNVugQ==
X-Google-Smtp-Source: ABdhPJwkJtjrHxxnaNSuf4yHXc0a8uKv8feNHI0vo74NZffrNOdDNzY/mLAwTGzKUiSxsL47H88t7Q==
X-Received: by 2002:a17:90a:b00e:: with SMTP id
 x14mr515547pjq.212.1601285228491; 
 Mon, 28 Sep 2020 02:27:08 -0700 (PDT)
Received: from localhost ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id e10sm719178pgb.45.2020.09.28.02.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 02:27:08 -0700 (PDT)
From: John Wang <wangzhiqiang.bj@bytedance.com>
To: yulei.sh@bytedance.com,
	xuxiaohan@bytedance.com
Subject: [PATCH v2] aspeed: Add support for the g220a-bmc board
Date: Mon, 28 Sep 2020 17:27:05 +0800
Message-Id: <20200928092705.3730-1-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2020 09:12:19 -0400
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

G220A is a 2 socket x86 motherboard supported by OpenBMC.
Strapping configuration was obtained from hardware.

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
v2:
  - Add macs_mask
---
 hw/arm/aspeed.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bdb981d2f8..1dcb72b315 100644
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
 
@@ -798,6 +812,24 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
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
+    amc->i2c_init  = NULL;
+    mc->default_ram_size = 1024 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
+};
+
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
@@ -835,6 +867,10 @@ static const TypeInfo aspeed_machine_types[] = {
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


