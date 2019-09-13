Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D9C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527AE2081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZqwTmuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527AE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ns1-0000wt-Nu
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npi-0007VM-4K
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npg-0000pB-OM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npg-0000or-HA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id x2so3297654wmj.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1Sl1J/OS8LWghz5QlTGlE0bH3B4/gCCk6zhNctlDdKI=;
 b=RZqwTmuygmTqha5mtmiUtypoF+2weJ8VVHIQVqOspstHunFDXx6JUpimxT/E0jkt26
 /bxn/e278dk3vV76pqJ0cK/Cl4uSpX2tPS9mGS5daRTpAgxq+wJAWoSGRRfpUtmxFsIZ
 PDla4jDxpNeIiC5Q1cRB7CAe56Ekk367YslTGqnl8KbbGByo3dw0bZDGOFsv6nUYtHMm
 tic58LIOt2uJ/sCjXkZ2nEQEUnhyrhhE5AjpUwmYtwfHA5nUjp3YvCtxLcpN24EbDrSy
 Xgv7qsknKhoRYPix3nPp8jfNfCC9zJ8iSgoBEOuVzjFxcZ9CmipEKMXiYXPf0+zZzCql
 UH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Sl1J/OS8LWghz5QlTGlE0bH3B4/gCCk6zhNctlDdKI=;
 b=iBjVtxFXTIStTnjqyIIbOIORIyg+xv4W5J5q3Wr94gEWKUY/sgguUR64hW9BQYGC9h
 wC9MP+fEnFGpSHelSqO8bJ9t+ZpKmVMn6KCfNe/IFrJwwehK8g4zqk8uSQPDGny8SDfC
 co5Ga7f2djnXvII/q59/v4cDDKTduqL6lwyxq6LVhdyRvmASFK2qlMcT5uFJV8DZ3nyG
 DTWrwc8O6WnhCobsor6iQTKTPMj+noXfnVCuIclOcRzJAASvFiMTa7cdszhL1cTfM3gU
 kLUJ2/h20LHRTWvUb2bX6snZtP29R01GtlF8Eh98QhlhCSYe3ZNiY0bchPs3clMheyj6
 3m8w==
X-Gm-Message-State: APjAAAUAdI1WCd6SbUENzwOFSAj7a1Jk1gC57BimYf48GveLFcKEfecn
 dix+1/R2baUfqLIe2deenaikl2RQoKjKYA==
X-Google-Smtp-Source: APXvYqykAz1sOPM1rQo4wiKKb+Ry8fQR6Q0+rf9KJ7seZn0tXFxbzPy9z5YzJwCR50i1LKC4nUlV5A==
X-Received: by 2002:a1c:7319:: with SMTP id d25mr3901877wmb.56.1568389799314; 
 Fri, 13 Sep 2019 08:49:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.49.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:49:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:44 +0100
Message-Id: <20190913154952.27724-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 04/12] aspeed: Use consistent typenames
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

From: Cédric Le Goater <clg@kaod.org>

Improve the naming of the different controller models to ease their
generation when initializing the SoC. The rename of the SMC types is
breaking migration compatibility.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190904070506.1052-5-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  3 ---
 hw/arm/aspeed_soc.c         | 25 ++++++++++++-------------
 hw/ssi/aspeed_smc.c         | 12 ++++++------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a56effebc16..ab5052b12cb 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -61,9 +61,6 @@ typedef struct AspeedSoCInfo {
     uint32_t silicon_rev;
     uint64_t sram_size;
     int spis_num;
-    const char *fmc_typename;
-    const char **spi_typename;
-    const char *gpio_typename;
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 3aa73d2438e..25dbc409d35 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -112,10 +112,6 @@ static const int aspeed_soc_ast2400_irqmap[] = {
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
 
-static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
-static const char *aspeed_soc_ast2500_typenames[] = {
-    "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
-
 static const AspeedSoCInfo aspeed_socs[] = {
     {
         .name         = "ast2400-a1",
@@ -123,9 +119,6 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .silicon_rev  = AST2400_A1_SILICON_REV,
         .sram_size    = 0x8000,
         .spis_num     = 1,
-        .fmc_typename = "aspeed.smc.fmc",
-        .spi_typename = aspeed_soc_ast2400_typenames,
-        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -136,9 +129,6 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .silicon_rev  = AST2500_A1_SILICON_REV,
         .sram_size    = 0x9000,
         .spis_num     = 2,
-        .fmc_typename = "aspeed.smc.ast2500-fmc",
-        .spi_typename = aspeed_soc_ast2500_typenames,
-        .gpio_typename = "aspeed.gpio-ast2500",
         .wdts_num     = 3,
         .irqmap       = aspeed_soc_ast2500_irqmap,
         .memmap       = aspeed_soc_ast2500_memmap,
@@ -158,6 +148,12 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
+    char socname[8];
+    char typename[64];
+
+    if (sscanf(sc->info->name, "%7s", socname) != 1) {
+        g_assert_not_reached();
+    }
 
     for (i = 0; i < sc->info->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
@@ -190,14 +186,16 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
                           TYPE_ASPEED_I2C);
 
+    snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
-                          sc->info->fmc_typename);
+                          typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
 
     for (i = 0; i < sc->info->spis_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
-                              sizeof(s->spi[i]), sc->info->spi_typename[i]);
+                              sizeof(s->spi[i]), typename);
     }
 
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
@@ -226,8 +224,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
                           TYPE_ASPEED_XDMA);
 
+    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
-                          sc->info->gpio_typename);
+                          typename);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9f3cff5fb6f..f4f7c181830 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -190,7 +190,7 @@ static const AspeedSegments aspeed_segments_ast2500_spi2[] = {
 
 static const AspeedSMCController controllers[] = {
     {
-        .name              = "aspeed.smc.smc",
+        .name              = "aspeed.smc-ast2400",
         .r_conf            = R_CONF,
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
@@ -203,7 +203,7 @@ static const AspeedSMCController controllers[] = {
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_SMC_MAX,
     }, {
-        .name              = "aspeed.smc.fmc",
+        .name              = "aspeed.fmc-ast2400",
         .r_conf            = R_CONF,
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
@@ -216,7 +216,7 @@ static const AspeedSMCController controllers[] = {
         .has_dma           = true,
         .nregs             = ASPEED_SMC_R_MAX,
     }, {
-        .name              = "aspeed.smc.spi",
+        .name              = "aspeed.spi1-ast2400",
         .r_conf            = R_SPI_CONF,
         .r_ce_ctrl         = 0xff,
         .r_ctrl0           = R_SPI_CTRL0,
@@ -229,7 +229,7 @@ static const AspeedSMCController controllers[] = {
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_SPI_MAX,
     }, {
-        .name              = "aspeed.smc.ast2500-fmc",
+        .name              = "aspeed.fmc-ast2500",
         .r_conf            = R_CONF,
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
@@ -242,7 +242,7 @@ static const AspeedSMCController controllers[] = {
         .has_dma           = true,
         .nregs             = ASPEED_SMC_R_MAX,
     }, {
-        .name              = "aspeed.smc.ast2500-spi1",
+        .name              = "aspeed.spi1-ast2500",
         .r_conf            = R_CONF,
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
@@ -255,7 +255,7 @@ static const AspeedSMCController controllers[] = {
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_MAX,
     }, {
-        .name              = "aspeed.smc.ast2500-spi2",
+        .name              = "aspeed.spi2-ast2500",
         .r_conf            = R_CONF,
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
-- 
2.20.1


