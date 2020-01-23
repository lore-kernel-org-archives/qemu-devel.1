Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33148C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0585F21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTSpFQt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0585F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhCT-0003ed-4i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRl-0000Uy-KF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRj-0003xP-QE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRh-0003s1-VG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id a5so3022696wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A4I+VF355k3jsisxBlTLttI/lpdyrdQbQaCIU3RplcU=;
 b=aTSpFQt//TWlyU8KeQC3749oyZfVDTA2S5ScqKqENlPeKu+0cxq+j/js/radwKcAW1
 qs/oBaM5sDd/NGDQ6Gns2YGr2ZsL66LclYgTAGT6PfFFJI5RgdNP5bEkF2q+xKrpu+jx
 iPmtcqaXOSDzJRnvXrJF4L9mpgt8nW3bvRYv2xmFyU/aBWqd6guq3D9/Nc6sB9XpD2dl
 P/MLFttz5bfLvX0O6bI9aaXMx3qNZmHLYObCba2B/Ebqd9zbcMCHk2DL78ExeCipiQF9
 FJkPnPG3PFYbsjEtkmkhY8ONyIpkVwAi5AtzVCjtc7XLx4ByH51bmbykIFpUz71zh+ei
 tVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A4I+VF355k3jsisxBlTLttI/lpdyrdQbQaCIU3RplcU=;
 b=mDk+R4T86tPMqxn66SypViUaPUEpUpJL2++0CvRU32F/m+UyqmWdTDN8TTbIeF0BcV
 Vojfi6XFsMLFwXsm/SZua6qZhadS7IXQVYL29+a8lNSSUkF4JAWzgcUa0oO78NSd+lKj
 V6P/tac66QfT+Mj7GVOOoSYi55JOlyzxF48xgQVKxvFM/OARrArj3YjunCH0zk7fUnCK
 7uXShbgbWGAhO1+RiKLMZVxIapCATBS07BmM+GA5Nn/SnqjTzgNCs8RjRpIIb+Ec8D47
 NcgSOzBvLMa+kxPSG+drwJVUTmiCISKVzJ+MoKT5HdUPAxqymj2pjb2tgda1ILqTuhOi
 1cYA==
X-Gm-Message-State: APjAAAXFfE6JdsSHbVNqmQyjDc2hYktnCQZfyr4V9dGz5pkK7SwUA6yI
 SbngBfPE3tGaqJ4SNPV0qTy9QXxHGMqLuA==
X-Google-Smtp-Source: APXvYqyNgbM8e289MTVorCCIZhxXEfTlHiKlL4znNHSANU1FfnC1rVzc1GB1OLVYGWfVt2xo+FIc0w==
X-Received: by 2002:a1c:3d8b:: with SMTP id k133mr4720186wma.161.1579793459370; 
 Thu, 23 Jan 2020 07:30:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] hw/arm/exynos4210: Fix DMA initialization
Date: Thu, 23 Jan 2020 15:30:36 +0000
Message-Id: <20200123153041.4248-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

From: Guenter Roeck <linux@roeck-us.net>

First parameter to exynos4210_get_irq() is not the SPI port number,
but the interrupt group number. Interrupt groups are 20 for mdma
and 21 for pdma. Interrupts are not inverted. Controllers support 32
events (pdma) or 31 events (mdma). Events must all be routed to a single
interrupt line. Set other parameters as documented in Exynos4210 datasheet,
section 8 (DMA controller).

Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-4-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/exynos4210.h |  4 +++
 hw/arm/exynos4210.c         | 51 +++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index f0f23b0e9b2..55260394af6 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -24,6 +24,7 @@
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
 
+#include "hw/or-irq.h"
 #include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
 
@@ -74,6 +75,8 @@
 
 #define EXYNOS4210_I2C_NUMBER               9
 
+#define EXYNOS4210_NUM_DMA      3
+
 typedef struct Exynos4210Irq {
     qemu_irq int_combiner_irq[EXYNOS4210_MAX_INT_COMBINER_IN_IRQ];
     qemu_irq ext_combiner_irq[EXYNOS4210_MAX_EXT_COMBINER_IN_IRQ];
@@ -97,6 +100,7 @@ typedef struct Exynos4210State {
     MemoryRegion boot_secondary;
     MemoryRegion bootreg_mem;
     I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
+    qemu_or_irq pl330_irq_orgate[EXYNOS4210_NUM_DMA];
 } Exynos4210State;
 
 #define TYPE_EXYNOS4210_SOC "exynos4210"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 77fbe1baabc..7701a3fa8bd 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -166,17 +166,36 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
+static void pl330_create(uint32_t base, qemu_or_irq *orgate, qemu_irq irq,
+                         int nreq, int nevents, int width)
 {
     SysBusDevice *busdev;
     DeviceState *dev;
+    int i;
 
     dev = qdev_create(NULL, "pl330");
+    qdev_prop_set_uint8(dev, "num_events", nevents);
+    qdev_prop_set_uint8(dev, "num_chnls",  8);
     qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
+
+    qdev_prop_set_uint8(dev, "wr_cap", 4);
+    qdev_prop_set_uint8(dev, "wr_q_dep", 8);
+    qdev_prop_set_uint8(dev, "rd_cap", 4);
+    qdev_prop_set_uint8(dev, "rd_q_dep", 8);
+    qdev_prop_set_uint8(dev, "data_width", width);
+    qdev_prop_set_uint16(dev, "data_buffer_dep", width);
     qdev_init_nofail(dev);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, base);
-    sysbus_connect_irq(busdev, 0, irq);
+
+    object_property_set_int(OBJECT(orgate), nevents + 1, "num-lines",
+                            &error_abort);
+    object_property_set_bool(OBJECT(orgate), true, "realized", &error_abort);
+
+    for (i = 0; i < nevents + 1; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(DEVICE(orgate), i));
+    }
+    qdev_connect_gpio_out(DEVICE(orgate), 0, irq);
 }
 
 static void exynos4210_realize(DeviceState *socdev, Error **errp)
@@ -431,12 +450,27 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
-    pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(35, 1)]), 32);
-    pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]), 32);
-    pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]), 1);
+    pl330_create(EXYNOS4210_PL330_BASE0_ADDR, &s->pl330_irq_orgate[0],
+                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 32, 32);
+    pl330_create(EXYNOS4210_PL330_BASE1_ADDR, &s->pl330_irq_orgate[1],
+                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 32, 32);
+    pl330_create(EXYNOS4210_PL330_BASE2_ADDR, &s->pl330_irq_orgate[2],
+                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 31, 64);
+}
+
+static void exynos4210_init(Object *obj)
+{
+    Exynos4210State *s = EXYNOS4210_SOC(obj);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->pl330_irq_orgate); i++) {
+        char *name = g_strdup_printf("pl330-irq-orgate%d", i);
+        qemu_or_irq *orgate = &s->pl330_irq_orgate[i];
+
+        object_initialize_child(obj, name, orgate, sizeof(*orgate),
+                                TYPE_OR_IRQ, &error_abort, NULL);
+        g_free(name);
+    }
 }
 
 static void exynos4210_class_init(ObjectClass *klass, void *data)
@@ -450,6 +484,7 @@ static const TypeInfo exynos4210_info = {
     .name = TYPE_EXYNOS4210_SOC,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Exynos4210State),
+    .instance_init = exynos4210_init,
     .class_init = exynos4210_class_init,
 };
 
-- 
2.20.1


