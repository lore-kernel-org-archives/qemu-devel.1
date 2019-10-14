Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE77C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08F62133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgouXHn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08F62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3rg-0003yQ-JC
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qW-0004rT-Nh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qU-0007yP-Lk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qU-0007xe-Dv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id r19so17863319wmh.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z87K1A4AtAr1SWatzIx6AlN8HdAIvYdTN2erflZQfyY=;
 b=bgouXHn3eOkotzEMPajKiSKWrolWSYZcYKNMpf/2w0uzengfy03/jHw9mrz6dmWyjh
 nYG9ZQT+r7+OF6PGYjsotI/Ze1LZF7iqj3BmRD96Y6+ZV6SBxf70vo/Je4R2bWuXcvoO
 aYMB+I4soxxIi454ly87pA/+Oxo41jXCO30chli6UcKAr3cxFlSvQD+x3hVEoBpBlAmd
 XMGSKhrE6ZKOlKl71oNe00szdoz9aOBTsWS9PPsH6dTiPtnLWFOUoZ21JqQlt8fzFRRD
 Bb0Yej2QgeZ6saXZXO/F5byavv/koD35L8RUe26hZyQzbjIMefI5HHtUxS9rNmE/dQzi
 JUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z87K1A4AtAr1SWatzIx6AlN8HdAIvYdTN2erflZQfyY=;
 b=TTTGFsV0hD7iDprBXwHic6qqTvA3MBcgT14xrRWxdZd7rHz9Aaz4q4FYLi1mcxEx2T
 +E9oH2uHmuN0tvEAqjiLC2xfttrbLV+CmjlUnMQV0HKY86X5jzl+/w5jOAfkm+dAc/zY
 FBsvf/CzrNL0lfBkK7xh/CZFOxumWhAlcOQaFqPe78eFEJma6ENrOma3ns0H7yfMuwm6
 cHQcgKkbZGLhi7MRdE1W9EvvtPd6TAU14/Dg4m8Iu4tO7z2Gz1aIxWufTKv0Ppk83VeY
 Kobhs8K0+k/rPaTvcvv5euPmnYM5vebQ+aYG8xTuJJT8YhBk0e8HOL87orKwNguS5BMe
 YU3Q==
X-Gm-Message-State: APjAAAVqSe381AR8kCb6Vt+oZ0lPvHuilGpqfCwtsMaSMI/EXv7NrzEt
 Xfr9vPbr9Z2ALwTpciQlHU0rWpP+qlI6Ow==
X-Google-Smtp-Source: APXvYqyN810KZi+osdRo7fVOGcxkp+sNq3JARc+TA4jWDzuKvxzUrICGLrwn8UHPn3aEp5k08XIwmw==
X-Received: by 2002:a1c:55c4:: with SMTP id
 j187mr15778680wmb.155.1571069116920; 
 Mon, 14 Oct 2019 09:05:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/68] hw: aspeed_scu: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:38 +0100
Message-Id: <20191014160404.19553-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Joel Stanley <joel@jms.id.au>

The SCU controller on the AST2600 SoC has extra registers. Increase
the number of regs of the model and introduce a new field in the class
to customize the MemoryRegion operations depending on the SoC model.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-4-clg@kaod.org
[clg: - improved commit log
      - changed vmstate version
      - reworked model integration into new object class
      - included AST2600_HPLL_PARAM value ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h |   7 +-
 hw/misc/aspeed_scu.c         | 192 +++++++++++++++++++++++++++++++++--
 2 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 239e94fe2c4..1d7f7ffc159 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -17,8 +17,10 @@
 #define ASPEED_SCU(obj) OBJECT_CHECK(AspeedSCUState, (obj), TYPE_ASPEED_SCU)
 #define TYPE_ASPEED_2400_SCU TYPE_ASPEED_SCU "-ast2400"
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
+#define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"
 
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
+#define ASPEED_AST2600_SCU_NR_REGS (0xE20 >> 2)
 
 typedef struct AspeedSCUState {
     /*< private >*/
@@ -27,7 +29,7 @@ typedef struct AspeedSCUState {
     /*< public >*/
     MemoryRegion iomem;
 
-    uint32_t regs[ASPEED_SCU_NR_REGS];
+    uint32_t regs[ASPEED_AST2600_SCU_NR_REGS];
     uint32_t silicon_rev;
     uint32_t hw_strap1;
     uint32_t hw_strap2;
@@ -38,6 +40,7 @@ typedef struct AspeedSCUState {
 #define AST2400_A1_SILICON_REV   0x02010303U
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
+#define AST2600_A0_SILICON_REV   0x05000303U
 
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
 
@@ -54,6 +57,8 @@ typedef struct  AspeedSCUClass {
     const uint32_t *resets;
     uint32_t (*calc_hpll)(AspeedSCUState *s, uint32_t hpll_reg);
     uint32_t apb_divider;
+    uint32_t nr_regs;
+    const MemoryRegionOps *ops;
 }  AspeedSCUClass;
 
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 620b25c2047..84699b78d4c 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -88,6 +88,35 @@
 #define BMC_REV              TO_REG(0x19C)
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
+#define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_SILICON_REV       TO_REG(0x04)
+#define AST2600_SILICON_REV2      TO_REG(0x14)
+#define AST2600_SYS_RST_CTRL      TO_REG(0x40)
+#define AST2600_SYS_RST_CTRL_CLR  TO_REG(0x44)
+#define AST2600_SYS_RST_CTRL2     TO_REG(0x50)
+#define AST2600_SYS_RST_CTRL2_CLR TO_REG(0x54)
+#define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
+#define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
+#define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
+#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_HPLL_PARAM        TO_REG(0x200)
+#define AST2600_HPLL_EXT          TO_REG(0x204)
+#define AST2600_MPLL_EXT          TO_REG(0x224)
+#define AST2600_EPLL_EXT          TO_REG(0x244)
+#define AST2600_CLK_SEL           TO_REG(0x300)
+#define AST2600_CLK_SEL2          TO_REG(0x304)
+#define AST2600_CLK_SEL3          TO_REG(0x310)
+#define AST2600_HW_STRAP1         TO_REG(0x500)
+#define AST2600_HW_STRAP1_CLR     TO_REG(0x504)
+#define AST2600_HW_STRAP1_PROT    TO_REG(0x508)
+#define AST2600_HW_STRAP2         TO_REG(0x510)
+#define AST2600_HW_STRAP2_CLR     TO_REG(0x514)
+#define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
+#define AST2600_RNG_CTRL          TO_REG(0x524)
+#define AST2600_RNG_DATA          TO_REG(0x540)
+
+#define AST2600_CLK TO_REG(0x40)
+
 #define SCU_IO_REGION_SIZE 0x1000
 
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] = {
@@ -178,7 +207,7 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
 
-    if (reg >= ARRAY_SIZE(s->regs)) {
+    if (reg >= ASPEED_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -208,7 +237,7 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
 
-    if (reg >= ARRAY_SIZE(s->regs)) {
+    if (reg >= ASPEED_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -346,7 +375,7 @@ static void aspeed_scu_reset(DeviceState *dev)
     AspeedSCUState *s = ASPEED_SCU(dev);
     AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
 
-    memcpy(s->regs, asc->resets, sizeof(s->regs));
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
     s->regs[SILICON_REV] = s->silicon_rev;
     s->regs[HW_STRAP1] = s->hw_strap1;
     s->regs[HW_STRAP2] = s->hw_strap2;
@@ -358,6 +387,7 @@ static uint32_t aspeed_silicon_revs[] = {
     AST2400_A1_SILICON_REV,
     AST2500_A0_SILICON_REV,
     AST2500_A1_SILICON_REV,
+    AST2600_A0_SILICON_REV,
 };
 
 bool is_supported_silicon_rev(uint32_t silicon_rev)
@@ -377,6 +407,7 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedSCUState *s = ASPEED_SCU(dev);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
 
     if (!is_supported_silicon_rev(s->silicon_rev)) {
         error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
@@ -384,7 +415,7 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_scu_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(s), asc->ops, s,
                           TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
 
     sysbus_init_mmio(sbd, &s->iomem);
@@ -392,10 +423,10 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_scu = {
     .name = "aspeed.scu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_SCU_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_REGS),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -436,6 +467,8 @@ static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
     asc->resets = ast2400_a0_resets;
     asc->calc_hpll = aspeed_2400_scu_calc_hpll;
     asc->apb_divider = 2;
+    asc->nr_regs = ASPEED_SCU_NR_REGS;
+    asc->ops = &aspeed_scu_ops;
 }
 
 static const TypeInfo aspeed_2400_scu_info = {
@@ -454,6 +487,8 @@ static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
     asc->resets = ast2500_a1_resets;
     asc->calc_hpll = aspeed_2500_scu_calc_hpll;
     asc->apb_divider = 4;
+    asc->nr_regs = ASPEED_SCU_NR_REGS;
+    asc->ops = &aspeed_scu_ops;
 }
 
 static const TypeInfo aspeed_2500_scu_info = {
@@ -463,11 +498,154 @@ static const TypeInfo aspeed_2500_scu_info = {
     .class_init = aspeed_2500_scu_class_init,
 };
 
+static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+
+    if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    switch (reg) {
+    case AST2600_HPLL_EXT:
+    case AST2600_EPLL_EXT:
+    case AST2600_MPLL_EXT:
+        /* PLLs are always "locked" */
+        return s->regs[reg] | BIT(31);
+    case AST2600_RNG_DATA:
+        /*
+         * On hardware, RNG_DATA works regardless of the state of the
+         * enable bit in RNG_CTRL
+         *
+         * TODO: Check this is true for ast2600
+         */
+        s->regs[AST2600_RNG_DATA] = aspeed_scu_get_random();
+        break;
+    }
+
+    return s->regs[reg];
+}
+
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
+                                     unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+
+    if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+    }
+
+    trace_aspeed_scu_write(offset, size, data);
+
+    switch (reg) {
+    case AST2600_PROT_KEY:
+        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        return;
+    case AST2600_HW_STRAP1:
+    case AST2600_HW_STRAP2:
+        if (s->regs[reg + 2]) {
+            return;
+        }
+        /* fall through */
+    case AST2600_SYS_RST_CTRL:
+    case AST2600_SYS_RST_CTRL2:
+        /* W1S (Write 1 to set) registers */
+        s->regs[reg] |= data;
+        return;
+    case AST2600_SYS_RST_CTRL_CLR:
+    case AST2600_SYS_RST_CTRL2_CLR:
+    case AST2600_HW_STRAP1_CLR:
+    case AST2600_HW_STRAP2_CLR:
+        /* W1C (Write 1 to clear) registers */
+        s->regs[reg] &= ~data;
+        return;
+
+    case AST2600_RNG_DATA:
+    case AST2600_SILICON_REV:
+    case AST2600_SILICON_REV2:
+        /* Add read only registers here */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    s->regs[reg] = data;
+}
+
+static const MemoryRegionOps aspeed_ast2600_scu_ops = {
+    .read = aspeed_ast2600_scu_read,
+    .write = aspeed_ast2600_scu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
+    [AST2600_SILICON_REV]       = AST2600_SILICON_REV,
+    [AST2600_SILICON_REV2]      = AST2600_SILICON_REV,
+    [AST2600_SYS_RST_CTRL]      = 0xF7CFFEDC | 0x100,
+    [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
+    [AST2600_CLK_STOP_CTRL]     = 0xEFF43E8B,
+    [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
+    [AST2600_HPLL_PARAM]        = 0x1000405F,
+};
+
+static void aspeed_ast2600_scu_reset(DeviceState *dev)
+{
+    AspeedSCUState *s = ASPEED_SCU(dev);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
+
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
+
+    s->regs[AST2600_SILICON_REV] = s->silicon_rev;
+    s->regs[AST2600_SILICON_REV2] = s->silicon_rev;
+    s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
+    s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
+    s->regs[PROT_KEY] = s->hw_prot_key;
+}
+
+static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
+
+    dc->desc = "ASPEED 2600 System Control Unit";
+    dc->reset = aspeed_ast2600_scu_reset;
+    asc->resets = ast2600_a0_resets;
+    asc->calc_hpll = aspeed_2500_scu_calc_hpll; /* No change since AST2500 */
+    asc->apb_divider = 4;
+    asc->nr_regs = ASPEED_AST2600_SCU_NR_REGS;
+    asc->ops = &aspeed_ast2600_scu_ops;
+}
+
+static const TypeInfo aspeed_2600_scu_info = {
+    .name = TYPE_ASPEED_2600_SCU,
+    .parent = TYPE_ASPEED_SCU,
+    .instance_size = sizeof(AspeedSCUState),
+    .class_init = aspeed_2600_scu_class_init,
+};
+
 static void aspeed_scu_register_types(void)
 {
     type_register_static(&aspeed_scu_info);
     type_register_static(&aspeed_2400_scu_info);
     type_register_static(&aspeed_2500_scu_info);
+    type_register_static(&aspeed_2600_scu_info);
 }
 
 type_init(aspeed_scu_register_types);
-- 
2.20.1


