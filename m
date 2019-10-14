Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F66ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8481C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HExwyYsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK43B-0002In-3I
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qt-0005WA-Sz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qs-0008Fi-0C
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qr-0008FG-Pb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id b9so20414893wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XNiBn4X3d0rJzAFSTzHsptth+MKPz04rdh87xR5jgCE=;
 b=HExwyYsO0yxsTRTE+zuisqXOLo18knVcrvhiHYBfWcPHqauVTEqnDMfPIWsGjhg9uA
 8oKXPW2miw/Pdix6uqlXxm0/8wwyaFFy/1AbI3YgQBWm2yKPj362Px5gXt0tWFJrtqC2
 qsuX7oKyfwr8UVCnFGcvmuWQzsW25H6/48Qtkv8jTx7qoLH7ITMgnj2HRIRGGWqTdWJo
 5ZLqOYxpnI32dyI4z78G93Njx7tRdQJvdz9oL0i1RUQe2P3HJ9jNOSaby8Z65qOlQNHA
 n3wV8Yv4GAQ9iXbuNyVnZnUGofIqoSEdqLnPvmkBeQ4Q3BuLsbR4uXNRA2hTFPpuTRIF
 Ex/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XNiBn4X3d0rJzAFSTzHsptth+MKPz04rdh87xR5jgCE=;
 b=MrLpu3m4ghV1SadaytFgdAcgiLqIT2VLCN0dMabiSHgHtlfZLEthvhtZqEV3ijjLsU
 oC0qhU/eFYJssNglzLih3v1PfZn9NAQNFOgLTaXfExv6apJjvRQ4qRLxqCt5keIEFtU9
 hThjAbCx1Wb2AvCDTEvm+IGAdiw6fyyR5adL5RlakhFcEudlEbEzvQZG462B6Qx08sZU
 scGgSKTOTQOhyr/1o+t7edroyOUqgVxQflohoFguLq6ELe0OSnpzHt+KIn+r7bqBmWKt
 8rpprO049c3pif/jdZ4CN+OwJ1+2OOOCcXOBwnt7FWgiPJNfyEGtQAPZSid8k4gbWxAT
 zhmA==
X-Gm-Message-State: APjAAAXhRU46y+TdD4Ny6QO4YWy5mKZW8WV+BJU5kSLTqeAQNpybi+8K
 dP/hrIxWdq3QxDSnkjTb69vJNXoDHaCo9A==
X-Google-Smtp-Source: APXvYqx0EF7pU1LDDmZFCw8h1dQ6Q2uHOuLXIuQY1e9JiO9kwLXowXiS5eyNCv5aHjQdxJ2jQMiTvw==
X-Received: by 2002:adf:e688:: with SMTP id r8mr28623133wrm.342.1571069140222; 
 Mon, 14 Oct 2019 09:05:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/68] aspeed: add support for the Aspeed MII controller of the
 AST2600
Date: Mon, 14 Oct 2019 17:03:57 +0100
Message-Id: <20191014160404.19553-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

The AST2600 SoC has an extra controller to set the PHY registers.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-23-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |   5 ++
 include/hw/net/ftgmac100.h  |  17 ++++
 hw/arm/aspeed_ast2600.c     |  20 +++++
 hw/net/ftgmac100.c          | 162 ++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 088a5d10818..43478f61787 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -52,6 +52,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
+    AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
     AspeedSDHCIState sdhci;
@@ -117,6 +118,10 @@ enum {
     ASPEED_ETH2,
     ASPEED_ETH3,
     ASPEED_ETH4,
+    ASPEED_MII1,
+    ASPEED_MII2,
+    ASPEED_MII3,
+    ASPEED_MII4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
 };
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 94cfe053329..ab37e7b2b8a 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -66,4 +66,21 @@ typedef struct FTGMAC100State {
     uint32_t rxdes0_edorr;
 } FTGMAC100State;
 
+#define TYPE_ASPEED_MII "aspeed-mmi"
+#define ASPEED_MII(obj) OBJECT_CHECK(AspeedMiiState, (obj), TYPE_ASPEED_MII)
+
+/*
+ * AST2600 MII controller
+ */
+typedef struct AspeedMiiState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    FTGMAC100State *nic;
+
+    MemoryRegion iomem;
+    uint32_t phycr;
+    uint32_t phydata;
+} AspeedMiiState;
+
 #endif
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 25d2c2d05d6..af047463a35 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -31,6 +31,10 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_FMC]       = 0x1E620000,
     [ASPEED_SPI1]      = 0x1E630000,
     [ASPEED_SPI2]      = 0x1E641000,
+    [ASPEED_MII1]      = 0x1E650000,
+    [ASPEED_MII2]      = 0x1E650008,
+    [ASPEED_MII3]      = 0x1E650010,
+    [ASPEED_MII4]      = 0x1E650018,
     [ASPEED_ETH1]      = 0x1E660000,
     [ASPEED_ETH3]      = 0x1E670000,
     [ASPEED_ETH2]      = 0x1E680000,
@@ -181,6 +185,12 @@ static void aspeed_soc_ast2600_init(Object *obj)
     for (i = 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+
+        sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i]),
+                              TYPE_ASPEED_MII);
+        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
+                                       OBJECT(&s->ftgmac100[i]),
+                                       &error_abort);
     }
 
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
@@ -417,6 +427,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                         sc->memmap[ASPEED_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
+
+        object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->mii[i]), 0,
+                        sc->memmap[ASPEED_MII1 + i]);
     }
 
     /* XDMA */
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 04c78e85170..eb8b441461a 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/net/ftgmac100.h"
 #include "sysemu/dma.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/checksum.h"
@@ -1087,9 +1088,170 @@ static const TypeInfo ftgmac100_info = {
     .class_init = ftgmac100_class_init,
 };
 
+/*
+ * AST2600 MII controller
+ */
+#define ASPEED_MII_PHYCR_FIRE        BIT(31)
+#define ASPEED_MII_PHYCR_ST_22       BIT(28)
+#define ASPEED_MII_PHYCR_OP(x)       ((x) & (ASPEED_MII_PHYCR_OP_WRITE | \
+                                             ASPEED_MII_PHYCR_OP_READ))
+#define ASPEED_MII_PHYCR_OP_WRITE    BIT(26)
+#define ASPEED_MII_PHYCR_OP_READ     BIT(27)
+#define ASPEED_MII_PHYCR_DATA(x)     (x & 0xffff)
+#define ASPEED_MII_PHYCR_PHY(x)      (((x) >> 21) & 0x1f)
+#define ASPEED_MII_PHYCR_REG(x)      (((x) >> 16) & 0x1f)
+
+#define ASPEED_MII_PHYDATA_IDLE      BIT(16)
+
+static void aspeed_mii_transition(AspeedMiiState *s, bool fire)
+{
+    if (fire) {
+        s->phycr |= ASPEED_MII_PHYCR_FIRE;
+        s->phydata &= ~ASPEED_MII_PHYDATA_IDLE;
+    } else {
+        s->phycr &= ~ASPEED_MII_PHYCR_FIRE;
+        s->phydata |= ASPEED_MII_PHYDATA_IDLE;
+    }
+}
+
+static void aspeed_mii_do_phy_ctl(AspeedMiiState *s)
+{
+    uint8_t reg;
+    uint16_t data;
+
+    if (!(s->phycr & ASPEED_MII_PHYCR_ST_22)) {
+        aspeed_mii_transition(s, !ASPEED_MII_PHYCR_FIRE);
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported ST code\n", __func__);
+        return;
+    }
+
+    /* Nothing to do */
+    if (!(s->phycr & ASPEED_MII_PHYCR_FIRE)) {
+        return;
+    }
+
+    reg = ASPEED_MII_PHYCR_REG(s->phycr);
+    data = ASPEED_MII_PHYCR_DATA(s->phycr);
+
+    switch (ASPEED_MII_PHYCR_OP(s->phycr)) {
+    case ASPEED_MII_PHYCR_OP_WRITE:
+        do_phy_write(s->nic, reg, data);
+        break;
+    case ASPEED_MII_PHYCR_OP_READ:
+        s->phydata = (s->phydata & ~0xffff) | do_phy_read(s->nic, reg);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid OP code %08x\n",
+                      __func__, s->phycr);
+    }
+
+    aspeed_mii_transition(s, !ASPEED_MII_PHYCR_FIRE);
+}
+
+static uint64_t aspeed_mii_read(void *opaque, hwaddr addr, unsigned size)
+{
+    AspeedMiiState *s = ASPEED_MII(opaque);
+
+    switch (addr) {
+    case 0x0:
+        return s->phycr;
+    case 0x4:
+        return s->phydata;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void aspeed_mii_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    AspeedMiiState *s = ASPEED_MII(opaque);
+
+    switch (addr) {
+    case 0x0:
+        s->phycr = value & ~(s->phycr & ASPEED_MII_PHYCR_FIRE);
+        break;
+    case 0x4:
+        s->phydata = value & ~(0xffff | ASPEED_MII_PHYDATA_IDLE);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    aspeed_mii_transition(s, !!(s->phycr & ASPEED_MII_PHYCR_FIRE));
+    aspeed_mii_do_phy_ctl(s);
+}
+
+static const MemoryRegionOps aspeed_mii_ops = {
+    .read = aspeed_mii_read,
+    .write = aspeed_mii_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void aspeed_mii_reset(DeviceState *dev)
+{
+    AspeedMiiState *s = ASPEED_MII(dev);
+
+    s->phycr = 0;
+    s->phydata = 0;
+
+    aspeed_mii_transition(s, !!(s->phycr & ASPEED_MII_PHYCR_FIRE));
+};
+
+static void aspeed_mii_realize(DeviceState *dev, Error **errp)
+{
+    AspeedMiiState *s = ASPEED_MII(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Object *obj;
+    Error *local_err = NULL;
+
+    obj = object_property_get_link(OBJECT(dev), "nic", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'nic' not found: ");
+        return;
+    }
+
+    s->nic = FTGMAC100(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
+                          TYPE_ASPEED_MII, 0x8);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_aspeed_mii = {
+    .name = TYPE_ASPEED_MII,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(phycr, FTGMAC100State),
+        VMSTATE_UINT32(phydata, FTGMAC100State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+static void aspeed_mii_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_aspeed_mii;
+    dc->reset = aspeed_mii_reset;
+    dc->realize = aspeed_mii_realize;
+    dc->desc = "Aspeed MII controller";
+}
+
+static const TypeInfo aspeed_mii_info = {
+    .name = TYPE_ASPEED_MII,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedMiiState),
+    .class_init = aspeed_mii_class_init,
+};
+
 static void ftgmac100_register_types(void)
 {
     type_register_static(&ftgmac100_info);
+    type_register_static(&aspeed_mii_info);
 }
 
 type_init(ftgmac100_register_types)
-- 
2.20.1


