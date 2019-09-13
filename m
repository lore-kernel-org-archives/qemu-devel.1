Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49FFC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A2820640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLJrVCNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A2820640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nv2-0004iQ-57
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npo-0007f0-NR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npm-0000ux-JF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npm-0000uF-Co
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id u16so32628885wrr.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BWXq64j+jVGO6XK++EFhnMF/2taBEqtn7uBGUbXx0bQ=;
 b=sLJrVCNeVHcmsRqBi2+UQwIzg4tEaYlzjQdJZFFOex0O1BvhV9x+J/T4UL9FV8kwYv
 AswLqcww4gfXJ569JKFXB/ZHE+4BbGlRZ2BdFbpdCMXNsvFrsDwNh9H/uX70hcEC9RBY
 q9LtdAoaufdlL/YnUKsq5vt88HvwIBw9UUVOxp9oBwxOQt37Irh97pV6YwzWVAqlT774
 z7EWdZRy8Bt4KSHRU8a/LY29mBFwdXAkxC1vtbq2aDvm/0ePXf3HxpmMNaVCkALflZLO
 nTIyslStSbaS8CRixzOLkpob8FgtDoz989OjhPmSieh0q4lvjzxSOLLxZAArrj6lEr54
 1PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWXq64j+jVGO6XK++EFhnMF/2taBEqtn7uBGUbXx0bQ=;
 b=l+dSIoElhcKxmVUkuN20hM0LRgjDxwtxgGA8PB6C35cPYYHmdWmKT89MpV+phv5YbI
 pCnnv6wIlZLjFv9v62H8hwLFYVfvf96nWqevkL8K71IJgI463X4RnawhW5kBBbhx4KO+
 eXYVvPDxDB3SyJb1dZohxtW8FFtT6uIu4eejVaFVHUVeZtgf53MFR7l21WtweUHIQ01k
 oohWo16mUozO0ipcSQ6clin8ED3aBnWF0y4NwzhP+nCNXkxsBjjo69wIghtNS78KawYn
 Sd3VubBXdb0ohnYINKJv0ZPoaeYf1KXcMoa7AGZ7R76vpqEUUtcr469EHiWUkv5pHzj0
 9J4Q==
X-Gm-Message-State: APjAAAXuUcSqZ2lBxNH50um3oTzJN0Q7b5zyUkQxm1i7t8zu7L0wy1n/
 R0pBIgx6ZHA3Zi2U2x52LkvDnezkoaZlMQ==
X-Google-Smtp-Source: APXvYqzbQ++9KxMN9uaFfH6hK7BWN7gvtegS+j5jD0CAfxaFlYeCOps/NkjyHbHec+r7wd92ryD+0Q==
X-Received: by 2002:adf:b342:: with SMTP id k2mr2577853wrd.207.1568389805035; 
 Fri, 13 Sep 2019 08:50:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:49 +0100
Message-Id: <20190913154952.27724-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 09/12] aspeed/scu: Introduce per-SoC SCU types
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

and use a class AspeedSCUClass to define each SoC characteristics.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190904070506.1052-10-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h | 15 +++++++
 hw/arm/aspeed_soc.c          |  3 +-
 hw/misc/aspeed_scu.c         | 83 ++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 38996adc59f..90dd4dadede 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -15,6 +15,8 @@
 
 #define TYPE_ASPEED_SCU "aspeed.scu"
 #define ASPEED_SCU(obj) OBJECT_CHECK(AspeedSCUState, (obj), TYPE_ASPEED_SCU)
+#define TYPE_ASPEED_2400_SCU TYPE_ASPEED_SCU "-ast2400"
+#define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
 
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
 
@@ -45,6 +47,19 @@ typedef struct AspeedSCUState {
 
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
 
+#define ASPEED_SCU_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedSCUClass, (klass), TYPE_ASPEED_SCU)
+#define ASPEED_SCU_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedSCUClass, (obj), TYPE_ASPEED_SCU)
+
+typedef struct  AspeedSCUClass {
+    SysBusDeviceClass parent_class;
+
+    const uint32_t *resets;
+    uint32_t (*calc_hpll)(AspeedSCUState *s);
+    uint32_t apb_divider;
+}  AspeedSCUClass;
+
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
 
 /*
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index da508c99c33..cf1d0cf921b 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -161,8 +161,9 @@ static void aspeed_soc_init(Object *obj)
                                 &error_abort, NULL);
     }
 
+    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
-                          TYPE_ASPEED_SCU);
+                          typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 268cb24e565..d284458b9b3 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -166,23 +166,10 @@ static uint32_t aspeed_scu_get_random(void)
 
 static void aspeed_scu_set_apb_freq(AspeedSCUState *s)
 {
-    uint32_t apb_divider;
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        apb_divider = 2;
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        apb_divider = 4;
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(s);
 
     s->apb_freq = s->hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[CLK_SEL]) + 1)
-        / apb_divider;
+        / asc->apb_divider;
 }
 
 static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
@@ -303,7 +290,7 @@ static const uint32_t hpll_ast2400_freqs[][4] = {
     { 400, 375, 350, 425 }, /* 25MHz */
 };
 
-static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSCUState *s)
+static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s)
 {
     uint32_t hpll_reg = s->regs[HPLL_PARAM];
     uint8_t freq_select;
@@ -334,7 +321,7 @@ static uint32_t aspeed_scu_calc_hpll_ast2400(AspeedSCUState *s)
     return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
 }
 
-static uint32_t aspeed_scu_calc_hpll_ast2500(AspeedSCUState *s)
+static uint32_t aspeed_2500_scu_calc_hpll(AspeedSCUState *s)
 {
     uint32_t hpll_reg   = s->regs[HPLL_PARAM];
     uint32_t multiplier = 1;
@@ -357,25 +344,9 @@ static uint32_t aspeed_scu_calc_hpll_ast2500(AspeedSCUState *s)
 static void aspeed_scu_reset(DeviceState *dev)
 {
     AspeedSCUState *s = ASPEED_SCU(dev);
-    const uint32_t *reset;
-    uint32_t (*calc_hpll)(AspeedSCUState *s);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
 
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        reset = ast2400_a0_resets;
-        calc_hpll = aspeed_scu_calc_hpll_ast2400;
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        reset = ast2500_a1_resets;
-        calc_hpll = aspeed_scu_calc_hpll_ast2500;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    memcpy(s->regs, reset, sizeof(s->regs));
+    memcpy(s->regs, asc->resets, sizeof(s->regs));
     s->regs[SILICON_REV] = s->silicon_rev;
     s->regs[HW_STRAP1] = s->hw_strap1;
     s->regs[HW_STRAP2] = s->hw_strap2;
@@ -385,7 +356,7 @@ static void aspeed_scu_reset(DeviceState *dev)
      * All registers are set. Now compute the frequencies of the main clocks
      */
     s->clkin = aspeed_scu_get_clkin(s);
-    s->hpll = calc_hpll(s);
+    s->hpll = asc->calc_hpll(s);
     aspeed_scu_set_apb_freq(s);
 }
 
@@ -459,11 +430,51 @@ static const TypeInfo aspeed_scu_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedSCUState),
     .class_init = aspeed_scu_class_init,
+    .class_size    = sizeof(AspeedSCUClass),
+    .abstract      = true,
+};
+
+static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
+
+    dc->desc = "ASPEED 2400 System Control Unit";
+    asc->resets = ast2400_a0_resets;
+    asc->calc_hpll = aspeed_2400_scu_calc_hpll;
+    asc->apb_divider = 2;
+}
+
+static const TypeInfo aspeed_2400_scu_info = {
+    .name = TYPE_ASPEED_2400_SCU,
+    .parent = TYPE_ASPEED_SCU,
+    .instance_size = sizeof(AspeedSCUState),
+    .class_init = aspeed_2400_scu_class_init,
+};
+
+static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
+
+    dc->desc = "ASPEED 2500 System Control Unit";
+    asc->resets = ast2500_a1_resets;
+    asc->calc_hpll = aspeed_2500_scu_calc_hpll;
+    asc->apb_divider = 4;
+}
+
+static const TypeInfo aspeed_2500_scu_info = {
+    .name = TYPE_ASPEED_2500_SCU,
+    .parent = TYPE_ASPEED_SCU,
+    .instance_size = sizeof(AspeedSCUState),
+    .class_init = aspeed_2500_scu_class_init,
 };
 
 static void aspeed_scu_register_types(void)
 {
     type_register_static(&aspeed_scu_info);
+    type_register_static(&aspeed_2400_scu_info);
+    type_register_static(&aspeed_2500_scu_info);
 }
 
 type_init(aspeed_scu_register_types);
-- 
2.20.1


