Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6943D206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBHIvYQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6943D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVpD-0006hK-LY
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lrDiXgsKCn8kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com>)
 id 1jjVir-0004HF-1V
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:57 -0400
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a]:52094)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lrDiXgsKCn8kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com>)
 id 1jjVin-0004GL-TM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:56 -0400
Received: by mail-qk1-x74a.google.com with SMTP id g72so6444891qke.18
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=oiqDvibvzs+SLqLjSlPOlR+7pAShHYnfl0r0mdthEcA=;
 b=ZBHIvYQlaXLnpe1MSKfZDArpTTJuqVnhviVmGx9kwbhgXhMEzmyHme/XbQta6sDfVV
 Dd+r4PSDk6ylCmJgtTM293vmY3H953nfrVVOKQgTeeI4v5HbrjxvORChpbuSGr0Ov8XE
 M48Mf3JvVyzQVBFYkkVeGIXADyT3Zd+Gu6cyIUzySuWM3UVEsBFWp1iPQMW/XqLe8xSN
 KyozXleiGHs8Yo8NmMcQ+nh8nLzpvuYFpq7N+umCgDZL9++e9RpfmLtZYdd+tkCy7A/x
 nbrz5qii+D6579WI42mueR8GpyioqCDBq60OimeMIbUTIutkbbhwxpWiuaC9WvDWGF2X
 mQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=oiqDvibvzs+SLqLjSlPOlR+7pAShHYnfl0r0mdthEcA=;
 b=GouMjo3UfDyNqUjHnELwKkvbw2e4AvDmqGYOhUuRDI23i3ccyr544vUmK6UhfQRBXY
 Y+541Gn1cvu39BHYXEY9Ktis+b8uhUoqfy+sm571XMUR7SuHQCR+0MY6OP8Phu0kk3SY
 BOyI99R+FsozaJXueKNPgfRpKuteQBAQBd9rc8TQ+zDiPKUopAzdev954Vlp7aLbnDBJ
 dVtI1hHn1EL04U0IMfHzcLuyNHuwXcgZ3iGnGrFr20geewuAEfW3EeGH7GaM121SPU6Z
 Yso7Q8bhKvSVh4Bjgx4c0v45xHseLr9+1kzGpcUn61efx0H7sr4lH4M9Vkj+nIkrWcID
 rZ5g==
X-Gm-Message-State: AOAM530S5L4P0PRmsXN6vTK9gCgdTGDk9oV6/uzFNnfbwcNfQtV9bXOO
 ib1CLqQt42r7k2uZLs5agKejk4r45aJ+B5kQug==
X-Google-Smtp-Source: ABdhPJynnZhQz42knvpgEhQG226oy7wr03mH8KeG95qSdt8EUWkzE3mawAWxdppcOmVkj/74CFe8z/4DQHcK72YEYg==
X-Received: by 2002:a0c:f888:: with SMTP id u8mr9829677qvn.130.1591914646033; 
 Thu, 11 Jun 2020 15:30:46 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:14 -0700
In-Reply-To: <20200611223016.259837-1-hskinnemoen@google.com>
Message-Id: <20200611223016.259837-11-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 10/12] hw/ssi: NPCM7xx Flash Interface Unit device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::74a;
 envelope-from=3lrDiXgsKCn8kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com;
 helo=mail-qk1-x74a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements a device model for the NPCM7xx SPI flash controller.

Direct reads and writes, and user-mode transactions have been tested in
various modes. Protection features are not implemented yet.

All the FIU instances are available in the SoC's address space,
regardless of whether or not they're connected to actual flash chips.

Change-Id: Ia4985761931714c6ca35b505f47aef3f4008c1d8
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 MAINTAINERS                  |   2 +
 hw/arm/Kconfig               |   1 +
 hw/arm/npcm7xx.c             |  59 +++++
 hw/ssi/Makefile.objs         |   1 +
 hw/ssi/npcm7xx_fiu.c         | 497 +++++++++++++++++++++++++++++++++++
 hw/ssi/trace-events          |   9 +
 include/hw/arm/npcm7xx.h     |   2 +
 include/hw/ssi/npcm7xx_fiu.h |  99 +++++++
 8 files changed, 670 insertions(+)
 create mode 100644 hw/ssi/npcm7xx_fiu.c
 create mode 100644 include/hw/ssi/npcm7xx_fiu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a289366ba..8a5c08c2c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -730,11 +730,13 @@ F: hw/arm/npcm7xx*
 F: hw/mem/npcm7xx*
 F: hw/misc/npcm7xx*
 F: hw/nvram/npcm7xx*
+F: hw/ssi/npcm7xx*
 F: hw/timer/npcm7xx*
 F: include/hw/arm/npcm7xx*
 F: include/hw/mem/npcm7xx*
 F: include/hw/misc/npcm7xx*
 F: include/hw/nvram/npcm7xx*
+F: include/hw/ssi/npcm7xx*
 F: include/hw/timer/npcm7xx*
 
 nSeries
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3738c1f5cd..8cc99f6190 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -360,6 +360,7 @@ config NPCM7XX
     select ARM_GIC
     select PL310  # cache controller
     select SERIAL
+    select SSI
     select UNIMP
 
 config FSL_IMX25
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 54d84bafa1..50319d0d33 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -98,6 +98,37 @@ static const hwaddr npcm7xx_uart_addr[] = {
     0xF0004000,
 };
 
+static const hwaddr npcm7xx_fiu0_flash_addr[] = {
+    0x80000000,
+    0x88000000,
+};
+
+static const hwaddr npcm7xx_fiu3_flash_addr[] = {
+    0xa0000000,
+    0xa8000000,
+    0xb0000000,
+    0xb8000000,
+};
+
+static const struct {
+    const char *name;
+    hwaddr regs_addr;
+    int cs_count;
+    const hwaddr *flash_addr;
+} npcm7xx_fiu[] = {
+    {
+        .name = "fiu0",
+        .regs_addr = 0xfb000000,
+        .cs_count = ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
+        .flash_addr = npcm7xx_fiu0_flash_addr,
+    }, {
+        .name = "fiu3",
+        .regs_addr = 0xc0000000,
+        .cs_count = ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
+        .flash_addr = npcm7xx_fiu3_flash_addr,
+    },
+};
+
 void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     /*
@@ -169,6 +200,13 @@ static void npcm7xx_init(Object *obj)
         sysbus_init_child_obj(obj, "tim[*]", OBJECT(&s->tim[i]),
                               sizeof(s->tim[i]), TYPE_NPCM7XX_TIMER);
     }
+
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) != ARRAY_SIZE(s->fiu));
+    for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
+        sysbus_init_child_obj(obj, npcm7xx_fiu[i].name,
+                              OBJECT(&s->fiu[i]), sizeof(s->fiu[i]),
+                              TYPE_NPCM7XX_FIU);
+    }
 }
 
 static void npcm7xx_realize(DeviceState *dev, Error **errp)
@@ -297,6 +335,27 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
                        serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
 
+    /* Flash Interface Unit (FIU) */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) != ARRAY_SIZE(s->fiu));
+    for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
+        Object *o = OBJECT(&s->fiu[i]);
+        int j;
+
+        object_property_set_int(o, npcm7xx_fiu[i].cs_count, "cs-count",
+                                &error_abort);
+        object_property_set_bool(o, true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(o), 0, npcm7xx_fiu[i].regs_addr);
+        for (j = 0; j < npcm7xx_fiu[i].cs_count; j++) {
+            sysbus_mmio_map(SYS_BUS_DEVICE(o), j + 1,
+                            npcm7xx_fiu[i].flash_addr[j]);
+        }
+    }
+
     /* RAM2 (SRAM) */
     memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
                            NPCM7XX_RAM2_SZ, &err);
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
index 07a85f1967..cab48e72c9 100644
--- a/hw/ssi/Makefile.objs
+++ b/hw/ssi/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_XILINX_SPIPS) += xilinx_spips.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
 common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
 common-obj-$(CONFIG_MSF2) += mss-spi.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_fiu.o
 
 common-obj-$(CONFIG_OMAP) += omap_spi.o
 common-obj-$(CONFIG_IMX) += imx_spi.o
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
new file mode 100644
index 0000000000..dd7e1c8a4e
--- /dev/null
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -0,0 +1,497 @@
+/*
+ * Nuvoton NPCM7xx Flash Interface Unit (FIU)
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
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/ssi/npcm7xx_fiu.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#include "trace.h"
+
+/* Up to 128 MiB of flash may be accessed directly as memory. */
+#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
+
+/* Each module has 4 KiB of register space. Only a fraction of it is used. */
+#define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
+
+/* FIU_{DRD,DWR,UMA,PTR}_CFG cannot be written when this bit is set. */
+#define NPCM7XX_FIU_CFG_LCK BIT(31)
+
+/* Direct Read configuration register fields. */
+#define FIU_DRD_CFG_ADDSIZ(rv) extract32(rv, 16, 2)
+#define FIU_ADDSIZ_3BYTES 0
+#define FIU_ADDSIZ_4BYTES 1
+#define FIU_DRD_CFG_DBW(rv) extract32(rv, 12, 2)
+#define FIU_DRD_CFG_ACCTYPE(rv) extract32(rv, 8, 2)
+#define FIU_DRD_CFG_RDCMD(rv) extract32(rv, 0, 8)
+
+/* Direct Write configuration register fields. */
+#define FIU_DWR_CFG_ADDSIZ(rv) extract32(rv, 16, 2)
+#define FIU_DWR_CFG_WRCMD(rv) extract32(rv, 0, 8)
+
+/* User-Mode Access register fields. */
+
+/* Command Mode Lock and the bits protected by it. */
+#define FIU_UMA_CFG_CMMLCK BIT(30)
+#define FIU_UMA_CFG_CMMLCK_MASK 0x00000403
+
+#define FIU_UMA_CFG_RDATSIZ(rv) extract32(rv, 24, 5)
+#define FIU_UMA_CFG_DBSIZ(rv) extract32(rv, 21, 3)
+#define FIU_UMA_CFG_WDATSIZ(rv) extract32(rv, 16, 5)
+#define FIU_UMA_CFG_ADDSIZ(rv) extract32(rv, 11, 3)
+#define FIU_UMA_CFG_CMDSIZ(rv) extract32(rv, 10, 1)
+#define FIU_UMA_CFG_DBPCK(rv) extract32(rv, 6, 2)
+
+#define FIU_UMA_CTS_RDYIE BIT(25)
+#define FIU_UMA_CTS_RDYST BIT(24)
+#define FIU_UMA_CTS_SW_CS BIT(16)
+#define FIU_UMA_CTS_DEV_NUM(rv) extract32(rv, 8, 2)
+#define FIU_UMA_CTS_EXEC_DONE BIT(0)
+
+/* Direct flash memory read handler. */
+static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    NPCM7xxFIUFlash *f = opaque;
+    NPCM7xxFIUState *fiu = f->fiu;
+    int cs_id = f - fiu->flash;
+    uint64_t value = 0;
+    uint32_t drd_cfg;
+    int dummy_cycles;
+    int i;
+
+    drd_cfg = fiu->regs[NPCM7XX_FIU_DRD_CFG];
+
+    qemu_irq_lower(fiu->cs_lines[cs_id]);
+    ssi_transfer(fiu->spi, FIU_DRD_CFG_RDCMD(drd_cfg));
+
+    switch (FIU_DRD_CFG_ADDSIZ(drd_cfg)) {
+    case FIU_ADDSIZ_4BYTES:
+        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
+        /* fall through */
+    case FIU_ADDSIZ_3BYTES:
+        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
+        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
+        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
+                      DEVICE(fiu)->canonical_path, FIU_DRD_CFG_ADDSIZ(drd_cfg));
+        break;
+    }
+
+    /* Flash chip model expects one transfer per dummy bit, not byte */
+    dummy_cycles =
+        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
+    for (i = 0; i < dummy_cycles; i++) {
+        ssi_transfer(fiu->spi, 0);
+    }
+
+    for (i = 0; i < size; i++) {
+        value |= ssi_transfer(fiu->spi, 0) << (8 * i);
+    }
+
+    qemu_irq_raise(fiu->cs_lines[cs_id]);
+
+    trace_npcm7xx_fiu_flash_read(DEVICE(fiu)->canonical_path, cs_id, addr, size,
+                                 value);
+
+    return value;
+}
+
+/* Direct flash memory write handler. */
+static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
+                                    unsigned int size)
+{
+    NPCM7xxFIUFlash *f = opaque;
+    NPCM7xxFIUState *fiu = f->fiu;
+    int cs_id = f - fiu->flash;
+    uint32_t dwr_cfg;
+    int i;
+
+    trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, cs_id, addr,
+                                  size, v);
+
+    dwr_cfg = fiu->regs[NPCM7XX_FIU_DWR_CFG];
+
+    qemu_irq_lower(fiu->cs_lines[cs_id]);
+    ssi_transfer(fiu->spi, FIU_DWR_CFG_WRCMD(dwr_cfg));
+
+    switch (FIU_DWR_CFG_ADDSIZ(dwr_cfg)) {
+    case FIU_ADDSIZ_4BYTES:
+        ssi_transfer(fiu->spi, extract32(addr, 24, 8));
+        /* fall through */
+    case FIU_ADDSIZ_3BYTES:
+        ssi_transfer(fiu->spi, extract32(addr, 16, 8));
+        ssi_transfer(fiu->spi, extract32(addr, 8, 8));
+        ssi_transfer(fiu->spi, extract32(addr, 0, 8));
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
+                      DEVICE(fiu)->canonical_path, FIU_DWR_CFG_ADDSIZ(dwr_cfg));
+        break;
+    }
+
+    for (i = 0; i < size; i++) {
+        ssi_transfer(fiu->spi, v & 0xff);
+        v >>= 8;
+    }
+
+    qemu_irq_raise(fiu->cs_lines[cs_id]);
+}
+
+static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
+    .read = npcm7xx_fiu_flash_read,
+    .write = npcm7xx_fiu_flash_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
+/* Control register read handler. */
+static uint64_t npcm7xx_fiu_ctrl_read(void *opaque, hwaddr addr,
+                                      unsigned int size)
+{
+    hwaddr reg = addr / sizeof(uint32_t);
+    NPCM7xxFIUState *s = opaque;
+    uint32_t value;
+
+    if (reg < NPCM7XX_FIO_NR_REGS) {
+        value = s->regs[reg];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" PRIx64 "\n",
+                      DEVICE(s)->canonical_path, addr);
+        value = 0;
+    }
+
+    trace_npcm7xx_fiu_ctrl_read(DEVICE(s)->canonical_path, addr, value);
+
+    return value;
+}
+
+/* Send the specified number of address bytes from the UMA address register. */
+static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
+{
+    /* All cases fall through */
+    switch (addsiz) {
+    case 4:
+        ssi_transfer(spi, extract32(addr, 24, 8));
+    case 3:
+        ssi_transfer(spi, extract32(addr, 16, 8));
+    case 2:
+        ssi_transfer(spi, extract32(addr, 8, 8));
+    case 1:
+        ssi_transfer(spi, extract32(addr, 0, 8));
+    case 0:
+        break;
+    }
+}
+
+/* Send the number of dummy bits specified in the UMA config register. */
+static void send_dummy_bits(SSIBus *spi, uint32_t uma_cfg, uint32_t uma_cmd)
+{
+    unsigned int bits_per_clock = 1U << FIU_UMA_CFG_DBPCK(uma_cfg);
+    unsigned int i;
+
+    for (i = 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
+        /* Use bytes 0 and 1 first, then keep repeating byte 2 */
+        unsigned int field = (i < 2) ? ((i + 1) * 8) : 24;
+        unsigned int j;
+
+        for (j = 0; j < 8; j += bits_per_clock) {
+            ssi_transfer(spi, extract32(uma_cmd, field + j, bits_per_clock));
+        }
+    }
+}
+
+/* Assert the chip select specified in the UMA Control/Status Register. */
+static void npcm7xx_fiu_select(NPCM7xxFIUState *s)
+{
+    int cs_id;
+
+    cs_id = FIU_UMA_CTS_DEV_NUM(s->regs[NPCM7XX_FIU_UMA_CTS]);
+    if (cs_id < s->cs_count) {
+        qemu_irq_lower(s->cs_lines[cs_id]);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: UMA to CS%d; this module has only %d chip selects",
+                      DEVICE(s)->canonical_path, cs_id, s->cs_count);
+        cs_id = -1;
+    }
+
+    s->active_cs = cs_id;
+}
+
+/* Deassert the currently active chip select. */
+static void npcm7xx_fiu_deselect(NPCM7xxFIUState *s)
+{
+    if (s->active_cs < 0) {
+        return;
+    }
+
+    qemu_irq_raise(s->cs_lines[s->active_cs]);
+    s->active_cs = -1;
+}
+
+/* Perform a User-Mode Access transaction. */
+static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
+{
+    uint32_t uma_cts = s->regs[NPCM7XX_FIU_UMA_CTS];
+    uint32_t uma_cfg;
+    unsigned int i;
+
+    /* SW_CS means the CS is already forced low, so don't touch it. */
+    if (uma_cts & FIU_UMA_CTS_SW_CS) {
+        npcm7xx_fiu_select(s);
+    }
+
+    /* Send command, if present. */
+    uma_cfg = s->regs[NPCM7XX_FIU_UMA_CFG];
+    if (FIU_UMA_CFG_CMDSIZ(uma_cfg) > 0) {
+        ssi_transfer(s->spi, extract32(s->regs[NPCM7XX_FIU_UMA_CMD], 0, 8));
+    }
+
+    /* Send address, if present. */
+    send_address(s->spi, FIU_UMA_CFG_ADDSIZ(uma_cfg),
+                 s->regs[NPCM7XX_FIU_UMA_ADDR]);
+
+    /* Write data, if present. */
+    for (i = 0; i < FIU_UMA_CFG_WDATSIZ(uma_cfg); i++) {
+        unsigned int reg =
+            (i < 16) ? (NPCM7XX_FIU_UMA_DW0 + i / 4) : NPCM7XX_FIU_UMA_DW3;
+        unsigned int field = (i % 4) * 8;
+
+        ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
+    }
+
+    /* Send aummy bits, if present. */
+    send_dummy_bits(s->spi, uma_cfg, s->regs[NPCM7XX_FIU_UMA_CMD]);
+
+    /* Read data, if present. */
+    for (i = 0; i < FIU_UMA_CFG_RDATSIZ(uma_cfg); i++) {
+        unsigned int reg = NPCM7XX_FIU_UMA_DR0 + i / 4;
+        unsigned int field = (i % 4) * 8;
+        uint8_t c;
+
+        c = ssi_transfer(s->spi, 0);
+        if (reg <= NPCM7XX_FIU_UMA_DR3) {
+            s->regs[reg] = deposit32(s->regs[reg], field, 8, c);
+        }
+    }
+
+    /* Again, don't touch CS if the user is forcing it low. */
+    if (uma_cts & FIU_UMA_CTS_SW_CS) {
+        npcm7xx_fiu_deselect(s);
+    }
+
+    /* RDYST means a command has completed since it was cleared. */
+    s->regs[NPCM7XX_FIU_UMA_CTS] |= FIU_UMA_CTS_RDYST;
+    /* EXEC_DONE means Execute Command / Not Done, so clear it here. */
+    s->regs[NPCM7XX_FIU_UMA_CTS] &= ~FIU_UMA_CTS_EXEC_DONE;
+}
+
+/* Control register write handler. */
+static void npcm7xx_fiu_ctrl_write(void *opaque, hwaddr addr, uint64_t v,
+                                   unsigned int size)
+{
+    hwaddr reg = addr / sizeof(uint32_t);
+    NPCM7xxFIUState *s = opaque;
+    uint32_t value = v;
+
+    trace_npcm7xx_fiu_ctrl_write(DEVICE(s)->canonical_path, addr, value);
+
+    switch (reg) {
+    case NPCM7XX_FIU_UMA_CFG:
+        if (s->regs[reg] & FIU_UMA_CFG_CMMLCK) {
+            value &= ~FIU_UMA_CFG_CMMLCK_MASK;
+            value |= (s->regs[reg] & FIU_UMA_CFG_CMMLCK_MASK);
+        }
+        /* fall through */
+    case NPCM7XX_FIU_DRD_CFG:
+    case NPCM7XX_FIU_DWR_CFG:
+        if (s->regs[reg] & NPCM7XX_FIU_CFG_LCK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to locked register @ 0x%" PRIx64 "\n",
+                          DEVICE(s)->canonical_path, addr);
+            return;
+        }
+        s->regs[reg] = value;
+        break;
+
+    case NPCM7XX_FIU_UMA_CTS:
+        if (value & FIU_UMA_CTS_RDYST) {
+            value &= ~FIU_UMA_CTS_RDYST;
+        } else {
+            value |= s->regs[reg] & FIU_UMA_CTS_RDYST;
+        }
+        if ((s->regs[reg] ^ value) & FIU_UMA_CTS_SW_CS) {
+            if (value & FIU_UMA_CTS_SW_CS) {
+                /*
+                 * Don't drop CS if there's a transfer in progress, or we're
+                 * about to start one.
+                 */
+                if (!((value | s->regs[reg]) & FIU_UMA_CTS_EXEC_DONE)) {
+                    npcm7xx_fiu_deselect(s);
+                }
+            } else {
+                npcm7xx_fiu_select(s);
+            }
+        }
+        s->regs[reg] = value | (s->regs[reg] & FIU_UMA_CTS_EXEC_DONE);
+        if (value & FIU_UMA_CTS_EXEC_DONE) {
+            npcm7xx_fiu_uma_transaction(s);
+        }
+        break;
+
+    case NPCM7XX_FIU_UMA_DR0 ... NPCM7XX_FIU_UMA_DR3:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only register @ 0x%" PRIx64 "\n",
+                      DEVICE(s)->canonical_path, addr);
+        return;
+
+    case NPCM7XX_FIU_PRT_CFG:
+    case NPCM7XX_FIU_PRT_CMD0 ... NPCM7XX_FIU_PRT_CMD9:
+        qemu_log_mask(LOG_UNIMP, "%s: PRT is not implemented\n", __func__);
+        break;
+
+    case NPCM7XX_FIU_UMA_CMD:
+    case NPCM7XX_FIU_UMA_ADDR:
+    case NPCM7XX_FIU_UMA_DW0 ... NPCM7XX_FIU_UMA_DW3:
+    case NPCM7XX_FIU_CFG:
+        s->regs[reg] = value;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" PRIx64 "\n",
+                      DEVICE(s)->canonical_path, addr);
+        return;
+    }
+}
+
+static const MemoryRegionOps npcm7xx_fiu_ctrl_ops = {
+    .read = npcm7xx_fiu_ctrl_read,
+    .write = npcm7xx_fiu_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm7xx_fiu_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxFIUState *s = NPCM7XX_FIU(obj);
+
+    trace_npcm7xx_fiu_enter_reset(DEVICE(obj)->canonical_path, type);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[NPCM7XX_FIU_DRD_CFG] = 0x0300100b;
+    s->regs[NPCM7XX_FIU_DWR_CFG] = 0x03000002;
+    s->regs[NPCM7XX_FIU_UMA_CFG] = 0x00000400;
+    s->regs[NPCM7XX_FIU_UMA_CTS] = 0x00010000;
+    s->regs[NPCM7XX_FIU_UMA_CMD] = 0x0000000b;
+    s->regs[NPCM7XX_FIU_PRT_CFG] = 0x00000400;
+    s->regs[NPCM7XX_FIU_CFG] = 0x0000000b;
+}
+
+static void npcm7xx_fiu_hold_reset(Object *obj)
+{
+    NPCM7xxFIUState *s = NPCM7XX_FIU(obj);
+    int i;
+
+    trace_npcm7xx_fiu_hold_reset(DEVICE(obj)->canonical_path);
+
+    for (i = 0; i < s->cs_count; i++) {
+        qemu_irq_raise(s->cs_lines[i]);
+    }
+}
+
+static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxFIUState *s = NPCM7XX_FIU(dev);
+    SysBusDevice *sbd = &s->parent;
+    int i;
+
+    if (s->cs_count <= 0) {
+        error_setg(errp, "%s: %d chip selects specified, need at least one",
+                   dev->canonical_path, s->cs_count);
+        return;
+    }
+
+    s->spi = ssi_create_bus(dev, "spi");
+    s->cs_lines = g_new0(qemu_irq, s->cs_count);
+    ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
+    s->flash = g_new0(NPCM7xxFIUFlash, s->cs_count);
+
+    /*
+     * Register the control registers region first. It may be followed by one
+     * or more direct flash access regions.
+     */
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_fiu_ctrl_ops, s, "ctrl",
+                          NPCM7XX_FIU_CTRL_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+    for (i = 0; i < s->cs_count; i++) {
+        NPCM7xxFIUFlash *flash = &s->flash[i];
+        sysbus_init_irq(sbd, &s->cs_lines[i]);
+        flash->fiu = s;
+        memory_region_init_io(&flash->direct_access, OBJECT(s),
+                              &npcm7xx_fiu_flash_ops, &s->flash[i], "flash",
+                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
+        sysbus_init_mmio(sbd, &flash->direct_access);
+    }
+}
+
+static Property npcm7xx_fiu_properties[] = {
+    DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Flash Interface Unit";
+    dc->realize = npcm7xx_fiu_realize;
+    rc->phases.enter = npcm7xx_fiu_enter_reset;
+    rc->phases.hold = npcm7xx_fiu_hold_reset;
+    device_class_set_props(dc, npcm7xx_fiu_properties);
+}
+
+static const TypeInfo npcm7xx_fiu_types[] = {
+    {
+        .name = TYPE_NPCM7XX_FIU,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxFIUState),
+        .class_init = npcm7xx_fiu_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_fiu_types);
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 0ea498de91..8024253c1f 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -9,3 +9,12 @@ aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
 aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
 aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
+
+# npcm7xx_fiu.c
+
+npcm7xx_fiu_enter_reset(const char *id, int reset_type) "%s reset type: %d"
+npcm7xx_fiu_hold_reset(const char *id) "%s"
+npcm7xx_fiu_ctrl_read(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08x"
+npcm7xx_fiu_ctrl_write(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08x"
+npcm7xx_fiu_flash_read(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
+npcm7xx_fiu_flash_write(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 8f49f7015c..e357f4bf59 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -22,6 +22,7 @@
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/timer/npcm7xx_timer.h"
+#include "hw/ssi/npcm7xx_fiu.h"
 #include "target/arm/cpu.h"
 
 #define NPCM7XX_MAX_NUM_CPUS    (2)
@@ -67,6 +68,7 @@ typedef struct NPCM7xxState {
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
     NPCM7xxMCState      mc;
+    NPCM7xxFIUState     fiu[2];
 } NPCM7xxState;
 
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.h
new file mode 100644
index 0000000000..88bfd4ba8e
--- /dev/null
+++ b/include/hw/ssi/npcm7xx_fiu.h
@@ -0,0 +1,99 @@
+/*
+ * Nuvoton NPCM7xx Flash Interface Unit (FIU)
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
+#ifndef NPCM7XX_FIU_H
+#define NPCM7XX_FIU_H
+
+#include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
+
+/**
+ * enum NPCM7xxFIURegister - 32-bit FIU register indices.
+ */
+enum NPCM7xxFIURegister {
+    NPCM7XX_FIU_DRD_CFG,
+    NPCM7XX_FIU_DWR_CFG,
+    NPCM7XX_FIU_UMA_CFG,
+    NPCM7XX_FIU_UMA_CTS,
+    NPCM7XX_FIU_UMA_CMD,
+    NPCM7XX_FIU_UMA_ADDR,
+    NPCM7XX_FIU_PRT_CFG,
+    NPCM7XX_FIU_UMA_DW0 = 0x0020 / sizeof(uint32_t),
+    NPCM7XX_FIU_UMA_DW1,
+    NPCM7XX_FIU_UMA_DW2,
+    NPCM7XX_FIU_UMA_DW3,
+    NPCM7XX_FIU_UMA_DR0,
+    NPCM7XX_FIU_UMA_DR1,
+    NPCM7XX_FIU_UMA_DR2,
+    NPCM7XX_FIU_UMA_DR3,
+    NPCM7XX_FIU_PRT_CMD0,
+    NPCM7XX_FIU_PRT_CMD1,
+    NPCM7XX_FIU_PRT_CMD2,
+    NPCM7XX_FIU_PRT_CMD3,
+    NPCM7XX_FIU_PRT_CMD4,
+    NPCM7XX_FIU_PRT_CMD5,
+    NPCM7XX_FIU_PRT_CMD6,
+    NPCM7XX_FIU_PRT_CMD7,
+    NPCM7XX_FIU_PRT_CMD8,
+    NPCM7XX_FIU_PRT_CMD9,
+    NPCM7XX_FIU_CFG = 0x78 / sizeof(uint32_t),
+    NPCM7XX_FIO_NR_REGS,
+};
+
+typedef struct NPCM7xxFIUState NPCM7xxFIUState;
+
+/**
+ * struct NPCM7xxFIUFlash - Per-chipselect flash controller state.
+ * @direct_access: Memory region for direct flash access.
+ * @fiu: Pointer to flash controller shared state.
+ */
+typedef struct NPCM7xxFIUFlash {
+    MemoryRegion direct_access;
+    NPCM7xxFIUState *fiu;
+} NPCM7xxFIUFlash;
+
+/**
+ * NPCM7xxFIUState - Device state for one Flash Interface Unit.
+ * @parent: System bus device.
+ * @mmio: Memory region for register access.
+ * @cs_count: Number of flash chips that may be connected to this module.
+ * @active_cs: Currently active chip select, or -1 if no chip is selected.
+ * @cs_lines: GPIO lines that may be wired to flash chips.
+ * @flash: Array of @cs_count per-flash-chip state objects.
+ * @spi: The SPI bus mastered by this controller.
+ * @regs: Register contents.
+ *
+ * Each FIU has a shared bank of registers, and controls up to four chip
+ * selects. Each chip select has a dedicated memory region which may be used to
+ * read and write the flash connected to that chip select as if it were memory.
+ */
+struct NPCM7xxFIUState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+
+    int32_t cs_count;
+    int32_t active_cs;
+    qemu_irq *cs_lines;
+    NPCM7xxFIUFlash *flash;
+
+    SSIBus *spi;
+
+    uint32_t regs[NPCM7XX_FIO_NR_REGS];
+};
+
+#define TYPE_NPCM7XX_FIU "npcm7xx-fiu"
+#define NPCM7XX_FIU(obj) OBJECT_CHECK(NPCM7xxFIUState, (obj), TYPE_NPCM7XX_FIU)
+
+#endif /* NPCM7XX_FIU_H */
-- 
2.27.0.290.gba653c62da-goog


