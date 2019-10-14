Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3764BECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E324C20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qA03vafN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E324C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Ug-00076h-QE
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qc-00052k-CZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qa-000847-DS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qa-00083V-6R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id b9so20413748wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Kc9SYaiOEnADleFNrui1oghbL5wdsg/3XBYIsNvSHsA=;
 b=qA03vafNUIOOz/84MeQFqXpXqVne6FMebdL+mCJFXFy8MugO9s0EFZbO8KBsO6M9Ne
 Jg2p+6ZhBXKSbaJHFhYkXvGSJtzD9nq/zcgN+3jOJ+Ghn3PV8ZahmXWHq464ac4xf3Th
 JMRum04ANE+iMRpCNaVeLhCn5b5tarqULJlcW/i/eko4dNP2eA59qtW9jsCTJt2X+x/3
 iw+25iUpvdb2QUay4dIjVZIsW/ul4Ww9nFB0W5FZx42xsjDxCRUiQpB+6y82vUef+7z7
 9A0FaYrocM3WiYG064J/w3dGsm3rOy0Jpyr16yptPgo0naSB3jEKDDHOGM8xIso8FvsM
 zCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kc9SYaiOEnADleFNrui1oghbL5wdsg/3XBYIsNvSHsA=;
 b=gayEZTPl3grFsBj3BwLyFGxcxktIXTcmtuSvapQzL1C3sRB8BstMaiyVIcDQ1UeV2k
 sEEB8m24Ql25/StavGlzVu+WQ73I0DDLzK03G3ro4sY/dR8haby/SIZlRG8QjHpmRXqG
 zOP9+DkJqDtXQieqPxMKyjQsn+HhNfrlM3aM5OURLdbZ1Wnnoa6uiKUBDM4kJJ97QiNa
 eHtFhKXnK3qJYyEthu4MTUXEourNlgCO0I+nB/5Q8zHzTwnJRSZgchYhVIPGJodgGbLh
 vCemGFWXBEII6z/V3Tx7gaZKTU0nCenCQcgNB+SPPpQSkuciJ41Ro6Ph7cxgUcp6L7Xf
 0+aQ==
X-Gm-Message-State: APjAAAXry0sEcCcHz5DQ1mh0nHYo/hBDvPN2rRrYt0uYXasQOS+B9kQh
 S/2go9J/8TD8f7XiSd1uj89z+LGI9Js0AQ==
X-Google-Smtp-Source: APXvYqw9ePMsbSp7aAd4yHXQfxfSpjeS/F3OU63PwaOyXYjg7ImVFliGjqO3oNxERokbT+PBOlP1RQ==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr3655733wrf.221.1571069122710; 
 Mon, 14 Oct 2019 09:05:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/68] aspeed/sdmc: Introduce an object class per SoC
Date: Mon, 14 Oct 2019 17:03:43 +0100
Message-Id: <20191014160404.19553-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

Use class handlers and class constants to differentiate the
characteristics of the memory controller and remove the 'silicon_rev'
property.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-9-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_sdmc.h |  19 +++-
 hw/arm/aspeed_soc.c           |   5 +-
 hw/misc/aspeed_sdmc.c         | 168 +++++++++++++++++++++-------------
 3 files changed, 122 insertions(+), 70 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index b3c926acae9..81156320c49 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -13,6 +13,8 @@
 
 #define TYPE_ASPEED_SDMC "aspeed.sdmc"
 #define ASPEED_SDMC(obj) OBJECT_CHECK(AspeedSDMCState, (obj), TYPE_ASPEED_SDMC)
+#define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
+#define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
 
 #define ASPEED_SDMC_NR_REGS (0x174 >> 2)
 
@@ -24,12 +26,21 @@ typedef struct AspeedSDMCState {
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SDMC_NR_REGS];
-    uint32_t silicon_rev;
-    uint32_t ram_bits;
     uint64_t ram_size;
     uint64_t max_ram_size;
-    uint32_t fixed_conf;
-
 } AspeedSDMCState;
 
+#define ASPEED_SDMC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedSDMCClass, (klass), TYPE_ASPEED_SDMC)
+#define ASPEED_SDMC_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedSDMCClass, (obj), TYPE_ASPEED_SDMC)
+
+typedef struct AspeedSDMCClass {
+    SysBusDeviceClass parent_class;
+
+    uint64_t max_ram_size;
+    uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
+    void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
+} AspeedSDMCClass;
+
 #endif /* ASPEED_SDMC_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 26e03486f9b..aaf18d3e42f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -205,10 +205,9 @@ static void aspeed_soc_init(Object *obj)
                               sizeof(s->spi[i]), typename);
     }
 
+    snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
-                          TYPE_ASPEED_SDMC);
-    qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
-                         sc->info->silicon_rev);
+                          typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size", &error_abort);
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index cb13c63ec84..60c99e77348 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -110,6 +110,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
                              unsigned int size)
 {
     AspeedSDMCState *s = ASPEED_SDMC(opaque);
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     addr >>= 2;
 
@@ -130,41 +131,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
         return;
     }
 
-    if (addr == R_CONF) {
-        /* Make sure readonly bits are kept */
-        switch (s->silicon_rev) {
-        case AST2400_A0_SILICON_REV:
-        case AST2400_A1_SILICON_REV:
-            data &= ~ASPEED_SDMC_READONLY_MASK;
-            data |= s->fixed_conf;
-            break;
-        case AST2500_A0_SILICON_REV:
-        case AST2500_A1_SILICON_REV:
-            data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
-            data |= s->fixed_conf;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-    if (s->silicon_rev == AST2500_A0_SILICON_REV ||
-            s->silicon_rev == AST2500_A1_SILICON_REV) {
-        switch (addr) {
-        case R_STATUS1:
-            /* Will never return 'busy' */
-            data &= ~PHY_BUSY_STATE;
-            break;
-        case R_ECC_TEST_CTRL:
-            /* Always done, always happy */
-            data |= ECC_TEST_FINISHED;
-            data &= ~ECC_TEST_FAIL;
-            break;
-        default:
-            break;
-        }
-    }
-
-    s->regs[addr] = data;
+    asc->write(s, addr, data);
 }
 
 static const MemoryRegionOps aspeed_sdmc_ops = {
@@ -222,44 +189,21 @@ static int ast2500_rambits(AspeedSDMCState *s)
 static void aspeed_sdmc_reset(DeviceState *dev)
 {
     AspeedSDMCState *s = ASPEED_SDMC(dev);
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     memset(s->regs, 0, sizeof(s->regs));
 
     /* Set ram size bit and defaults values */
-    s->regs[R_CONF] = s->fixed_conf;
+    s->regs[R_CONF] = asc->compute_conf(s, 0);
 }
 
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedSDMCState *s = ASPEED_SDMC(dev);
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
-    if (!is_supported_silicon_rev(s->silicon_rev)) {
-        error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
-                s->silicon_rev);
-        return;
-    }
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        s->ram_bits = ast2400_rambits(s);
-        s->max_ram_size = 512 << 20;
-        s->fixed_conf = ASPEED_SDMC_VGA_COMPAT |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        s->ram_bits = ast2500_rambits(s);
-        s->max_ram_size = 1024 << 20;
-        s->fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
-            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-            ASPEED_SDMC_CACHE_INITIAL_DONE |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    s->max_ram_size = asc->max_ram_size;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
                           TYPE_ASPEED_SDMC, 0x1000);
@@ -277,7 +221,6 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
 };
 
 static Property aspeed_sdmc_properties[] = {
-    DEFINE_PROP_UINT32("silicon-rev", AspeedSDMCState, silicon_rev, 0),
     DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -298,11 +241,110 @@ static const TypeInfo aspeed_sdmc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedSDMCState),
     .class_init = aspeed_sdmc_class_init,
+    .class_size = sizeof(AspeedSDMCClass),
+    .abstract   = true,
+};
+
+static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
+{
+    uint32_t fixed_conf = ASPEED_SDMC_VGA_COMPAT |
+        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
+
+    /* Make sure readonly bits are kept */
+    data &= ~ASPEED_SDMC_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    switch (reg) {
+    case R_CONF:
+        data = aspeed_2400_sdmc_compute_conf(s, data);
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] = data;
+}
+
+static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
+
+    dc->desc = "ASPEED 2400 SDRAM Memory Controller";
+    asc->max_ram_size = 512 << 20;
+    asc->compute_conf = aspeed_2400_sdmc_compute_conf;
+    asc->write = aspeed_2400_sdmc_write;
+}
+
+static const TypeInfo aspeed_2400_sdmc_info = {
+    .name = TYPE_ASPEED_2400_SDMC,
+    .parent = TYPE_ASPEED_SDMC,
+    .class_init = aspeed_2400_sdmc_class_init,
+};
+
+static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
+{
+    uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
+        ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+        ASPEED_SDMC_CACHE_INITIAL_DONE |
+        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
+
+    /* Make sure readonly bits are kept */
+    data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    switch (reg) {
+    case R_CONF:
+        data = aspeed_2500_sdmc_compute_conf(s, data);
+        break;
+    case R_STATUS1:
+        /* Will never return 'busy' */
+        data &= ~PHY_BUSY_STATE;
+        break;
+    case R_ECC_TEST_CTRL:
+        /* Always done, always happy */
+        data |= ECC_TEST_FINISHED;
+        data &= ~ECC_TEST_FAIL;
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] = data;
+}
+
+static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
+
+    dc->desc = "ASPEED 2500 SDRAM Memory Controller";
+    asc->max_ram_size = 1024 << 20;
+    asc->compute_conf = aspeed_2500_sdmc_compute_conf;
+    asc->write = aspeed_2500_sdmc_write;
+}
+
+static const TypeInfo aspeed_2500_sdmc_info = {
+    .name = TYPE_ASPEED_2500_SDMC,
+    .parent = TYPE_ASPEED_SDMC,
+    .class_init = aspeed_2500_sdmc_class_init,
 };
 
 static void aspeed_sdmc_register_types(void)
 {
     type_register_static(&aspeed_sdmc_info);
+    type_register_static(&aspeed_2400_sdmc_info);
+    type_register_static(&aspeed_2500_sdmc_info);
 }
 
 type_init(aspeed_sdmc_register_types);
-- 
2.20.1


