Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DED20756
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHyrG/Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DED20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbry9-0004fY-83
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <329TGXgsKCpwDOGEJJAIKAJCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--hskinnemoen.bounces.google.com>)
 id 1jbqla-0005kL-JY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:06 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:40003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <329TGXgsKCpwDOGEJJAIKAJCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlZ-0001jq-8q
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:06 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id 137so6522420ybf.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xRU7e/R7sgyuEWAcrfRWhfwQF6yfs7AUewHUwlXTLL0=;
 b=rHyrG/Tkw7xoDdf+y1S60fXGWoWs4Bobu66nWV9xO2Ri0Wd3R6sxGDYDER3b8JnFEi
 GlTkKoH5xXDPJhZxyZ+vFgz1qSX+3sUuUoldONaUwZ9XHS+e4viv2X865CWW6Cx9A4Cx
 kkEPfWiFw/dP+YrwnJe/FzMhdXASzMonvFUmiW+Q/wjbOUUIHXkHANeKf4tH/U9oNx4J
 UrPPI7NZlEkaCour7K06Ck8jAq7l9pPFTPSAmhvdP7mQcDf9ez+fRVRnqHWQhiWxg2Mb
 /5A0OmPyFgdt4RF4i1hhr/3inogCnkzatIW4qD5M2SRhLi00qAnwnvo5XjxcPxqST+YW
 xBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xRU7e/R7sgyuEWAcrfRWhfwQF6yfs7AUewHUwlXTLL0=;
 b=NMAYd5zfO9R/ev08LdDOXWmupaovE5q7INe4Br0s8I9BiCEydcTGpAwxmQbPtLOy7U
 aUT/lq3jOPManO/KCAnOVxTmkX73vBUJV3zzhxOd5Y+WVu5IthkS3+rJn8tzlt0/JzH/
 6ZyGr09x3IfehTSxSRGqn/6DeRvm8KlxpUdllOMeN+WZsOTmQuWdLLzNIUHxrabl17WT
 vXMrvW3ISMUHsjOMvFIgTstkPNWKLm5rUL8oJyr8St9BhPP5DitFkOh9xF1fBZv+/n/D
 4spWry9NO7PTacLLARsWRipO0XMu5lsz0LItQtNOVCu8Q4d8Gc0O774KL4HF8oN+0RyD
 vX/w==
X-Gm-Message-State: AOAM532qnjAflo0R+pNzlXrW6z9Tn/BzmJffq1wuyB2q0VmNhIOp5fUc
 I795RYcwY+n8gbn7fXKplOliy48xvKKDheMStA==
X-Google-Smtp-Source: ABdhPJyvkLtAvmKUDDYc/odRp5fe/i5qFTAmqCcgnLW/A9sJI9qH+M5wneub8ddkT4MZgR0cGOB1WiUNv5Ouxq6e4g==
X-Received: by 2002:a25:4ac7:: with SMTP id
 x190mr19393516yba.106.1590088923904; 
 Thu, 21 May 2020 12:22:03 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:30 -0700
In-Reply-To: <20200521192133.127559-1-hskinnemoen@google.com>
Message-Id: <20200521192133.127559-4-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 3/6] hw/misc: Add NPCM7xx Clock Controller device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=329TGXgsKCpwDOGEJJAIKAJCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:44 -0400
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

Enough functionality to boot the Linux kernel has been implemented. This
includes:

  - Correct power-on reset values so the various clock rates can be
    accurately calculated.
  - Clock enables stick around when written.

In addition, a best effort attempt to implement SECCNT and CNTR25M was
made even though I don't think the kernel needs them.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/misc/Makefile.objs         |   1 +
 hw/misc/npcm7xx_clk.c         | 210 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   4 +
 include/hw/misc/npcm7xx_clk.h |  65 +++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 hw/misc/npcm7xx_clk.c
 create mode 100644 include/hw/misc/npcm7xx_clk.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 4d83fa337b..1096a76457 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -51,6 +51,7 @@ common-obj-$(CONFIG_IMX) += imx_rngc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_clk.o
 common-obj-$(CONFIG_NPCM7XX) += npcm7xx_gcr.o
 common-obj-$(CONFIG_OMAP) += omap_clk.o
 common-obj-$(CONFIG_OMAP) += omap_gpmc.o
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
new file mode 100644
index 0000000000..b4ff85e8c2
--- /dev/null
+++ b/hw/misc/npcm7xx_clk.c
@@ -0,0 +1,210 @@
+/*
+ * Nuvoton NPCM7xx Clock Control Registers.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/misc/npcm7xx_clk.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+#define PLLCON_LOKI     BIT(31)
+#define PLLCON_LOKS     BIT(30)
+#define PLLCON_PWDEN    BIT(12)
+
+static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
+    [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
+    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
+    [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
+    [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
+    [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
+    [NPCM7XX_CLK_IPSRST1]       = 0x00001000,
+    [NPCM7XX_CLK_IPSRST2]       = 0x80000000,
+    [NPCM7XX_CLK_CLKEN2]        = 0xffffffff,
+    [NPCM7XX_CLK_CLKDIV2]       = 0xaa4f8f9f,
+    [NPCM7XX_CLK_CLKEN3]        = 0xffffffff,
+    [NPCM7XX_CLK_IPSRST3]       = 0x03000000,
+    [NPCM7XX_CLK_WD0RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_WD1RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_WD2RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_SWRSTC1]       = 0x00000003,
+    [NPCM7XX_CLK_PLLCON2]       = 0x00c02105 | PLLCON_LOKI,
+    [NPCM7XX_CLK_CORSTC]        = 0x04000003,
+    [NPCM7XX_CLK_PLLCONG]       = 0x01228606 | PLLCON_LOKI,
+    [NPCM7XX_CLK_AHBCKFI]       = 0x000000c8,
+};
+
+static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxCLKState *s = opaque;
+    int64_t now_ns;
+    uint32_t value = 0;
+
+    if (reg >= NPCM7XX_CLK_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return 0;
+    }
+
+    switch (reg) {
+    case NPCM7XX_CLK_SWRSTR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is write-only\n",
+                      __func__, (unsigned int)offset);
+        break;
+
+    case NPCM7XX_CLK_SECCNT:
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        value = (now_ns - s->ref_ns) / NANOSECONDS_PER_SECOND;
+        break;
+
+    case NPCM7XX_CLK_CNTR25M:
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        /*
+         * This register counts 25 MHz cycles, updating every 640 ns. It rolls
+         * over to zero every second.
+         *
+         * The 4 LSBs are always zero: (1e9 / 640) << 4 = 25000000.
+         */
+        value = (((now_ns - s->ref_ns) / 640) << 4) % 25000000;
+        break;
+
+    default:
+        value = s->regs[reg];
+        break;
+    };
+
+    trace_npcm7xx_clk_read(offset, value);
+
+    return value;
+}
+
+static void npcm7xx_clk_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxCLKState *s = opaque;
+    uint32_t value = v;
+
+    trace_npcm7xx_clk_write(offset, value);
+
+    if (reg >= NPCM7XX_CLK_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return;
+    }
+
+    switch (reg) {
+    case NPCM7XX_CLK_SWRSTR:
+        qemu_log_mask(LOG_UNIMP, "%s: SW reset not implemented: 0x%02x\n",
+                      __func__, value);
+        value = 0;
+        break;
+
+    case NPCM7XX_CLK_PLLCON0:
+    case NPCM7XX_CLK_PLLCON1:
+    case NPCM7XX_CLK_PLLCON2:
+    case NPCM7XX_CLK_PLLCONG:
+        if (value & PLLCON_PWDEN) {
+            /* Power down -- clear lock and indicate loss of lock */
+            value &= ~PLLCON_LOKI;
+            value |= PLLCON_LOKS;
+        } else {
+            /* Normal mode -- assume always locked */
+            value |= PLLCON_LOKI;
+            /* Keep LOKS unchanged unless cleared by writing 1 */
+            if (value & PLLCON_LOKS) {
+                value &= ~PLLCON_LOKS;
+            } else {
+                value |= (value & PLLCON_LOKS);
+            }
+        }
+        break;
+
+    case NPCM7XX_CLK_CNTR25M:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-only\n",
+                      __func__, (unsigned int)offset);
+        return;
+    }
+
+    s->regs[reg] = value;
+}
+
+static const struct MemoryRegionOps npcm7xx_clk_ops = {
+    .read       = npcm7xx_clk_read,
+    .write      = npcm7xx_clk_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+
+    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
+
+    switch (type) {
+    case RESET_TYPE_COLD:
+        memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+        s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        return;
+    }
+
+    /*
+     * A small number of registers need to be reset on a core domain reset,
+     * but no such reset type exists yet.
+     */
+    qemu_log_mask(LOG_UNIMP, "%s: reset type %d not implemented.",
+                  __func__, type);
+}
+
+static void npcm7xx_clk_init(Object *obj)
+{
+    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_clk_ops, s,
+                          TYPE_NPCM7XX_CLK, 4 * KiB);
+    sysbus_init_mmio(&s->parent, &s->iomem);
+}
+
+static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Clock Control Registers";
+    rc->phases.enter = npcm7xx_clk_enter_reset;
+}
+
+static const TypeInfo npcm7xx_clk_info = {
+    .name               = TYPE_NPCM7XX_CLK,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCM7xxCLKState),
+    .instance_init      = npcm7xx_clk_init,
+    .class_init         = npcm7xx_clk_class_init,
+};
+
+static void npcm7xx_clk_register_type(void)
+{
+    type_register_static(&npcm7xx_clk_info);
+}
+type_init(npcm7xx_clk_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index d200438dbf..ae97e8b091 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -103,6 +103,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# npcm7xx_clk.c
+npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+
 # npcm7xx_gcr.c
 npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm7xx_clk.h
new file mode 100644
index 0000000000..a678b50ede
--- /dev/null
+++ b/include/hw/misc/npcm7xx_clk.h
@@ -0,0 +1,65 @@
+/*
+ * Nuvoton NPCM7xx Clock Control Registers.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM7XX_CLK_H
+#define NPCM7XX_CLK_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+enum NPCM7xxCLKRegisters {
+    NPCM7XX_CLK_CLKEN1,
+    NPCM7XX_CLK_CLKSEL,
+    NPCM7XX_CLK_CLKDIV1,
+    NPCM7XX_CLK_PLLCON0,
+    NPCM7XX_CLK_PLLCON1,
+    NPCM7XX_CLK_SWRSTR,
+    NPCM7XX_CLK_IPSRST1         = 0x20 / sizeof(uint32_t),
+    NPCM7XX_CLK_IPSRST2,
+    NPCM7XX_CLK_CLKEN2,
+    NPCM7XX_CLK_CLKDIV2,
+    NPCM7XX_CLK_CLKEN3,
+    NPCM7XX_CLK_IPSRST3,
+    NPCM7XX_CLK_WD0RCR,
+    NPCM7XX_CLK_WD1RCR,
+    NPCM7XX_CLK_WD2RCR,
+    NPCM7XX_CLK_SWRSTC1,
+    NPCM7XX_CLK_SWRSTC2,
+    NPCM7XX_CLK_SWRSTC3,
+    NPCM7XX_CLK_SWRSTC4,
+    NPCM7XX_CLK_PLLCON2,
+    NPCM7XX_CLK_CLKDIV3,
+    NPCM7XX_CLK_CORSTC,
+    NPCM7XX_CLK_PLLCONG,
+    NPCM7XX_CLK_AHBCKFI,
+    NPCM7XX_CLK_SECCNT,
+    NPCM7XX_CLK_CNTR25M,
+    NPCM7XX_CLK_NR_REGS,
+};
+
+typedef struct NPCM7xxCLKState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[NPCM7XX_CLK_NR_REGS];
+
+    /* Time reference for SECCNT and CNTR25M, initialized by power on reset */
+    int64_t ref_ns;
+} NPCM7xxCLKState;
+
+#define TYPE_NPCM7XX_CLK "npcm7xx-clk"
+#define NPCM7XX_CLK(obj) OBJECT_CHECK(NPCM7xxCLKState, (obj), TYPE_NPCM7XX_CLK)
+
+#endif /* NPCM7XX_CLK_H */
-- 
2.27.0.rc0.183.gde8f92d652-goog


