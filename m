Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED698C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0536206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBEQiYMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0536206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssgH-0005pY-U7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WMMEXwsKCu8YjbZeeVdfVeXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--hskinnemoen.bounces.google.com>)
 id 1jssdJ-0000WH-VG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:57 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:41478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WMMEXwsKCu8YjbZeeVdfVeXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--hskinnemoen.bounces.google.com>)
 id 1jssdG-0007b9-K2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:57 -0400
Received: by mail-yb1-xb49.google.com with SMTP id i4so22377859ybh.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=UwW/ulHwrSaFkbNaXRtduq4/uqpdDkuDsZbHdM+C1s0=;
 b=GBEQiYMHqCPtHowEZnV2qQ47gj2XTECTVToOyMi2e8d7DosvOYis7hrGNW0Fey/hdN
 ZVKNyw38ZuHQgMhDyo69mdM1349CYFm1oc3/N+Vft5WOz+rcbd3Bl9dQu0qLguC/pUJ5
 wgD3BkVpOGg3kLnlXy9kOQ+FE0tUsN1POewi3iF5x5G+N7XtWgr8TuCGFGxX4hbavlPv
 0aEo1z182zTyIM9PAH+xTAh4CxHPXQ5MKBdqfEz1JPZwDmcLGWOu5fDUtb2em3CQUFCd
 ztvZShYHiEw0G6ic79S76xKPGgi+n56qaH/ggeTJXliy1/ir9AcaSENu2LeztZQDEDAM
 sG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=UwW/ulHwrSaFkbNaXRtduq4/uqpdDkuDsZbHdM+C1s0=;
 b=Xa8H9rG7OBW1cdONJm7NR26qqmezzbBV4R/ugc8d8fdtNLMXz4wBTOHa4XqGt1iLfm
 5gbmpwSe39gKBTr+EnHWkIIDkyfV12mmRRoCpePKawUHg+pnOkMcEL/yp0o6zXMRkK/j
 POAYpEuyKoXiFwCaiXYxooEpfz3WBVB5zo0jBV+xaLaBfFfBBBgZT4CXpCbv2IKjxJhC
 I0/or6bIRMoEpuHK5BJrZszKyOOl/1uJKv65jFRagg24MM4HeHBcxzs6TYofuLKEf5dG
 C35BqGAx7+5Vv9kMnR4Ma7Cg8q/a9uchATNhhZSbgrOP8foyRCP+9it4qUs9sidCwROO
 FEAA==
X-Gm-Message-State: AOAM530EMJo8fDklqclCnaC2X85i6EQILeYQztggnxnJGbkBSA1NLwrY
 fZzKRS13DLfGp1ZU2Obo+OIX0M0h84mP/GH9Og==
X-Google-Smtp-Source: ABdhPJxkUhkuBRcZFbjR+NEKi6lswcHAJa1LSzQ+CDQffRn/v0D4/lHLcFsorBo5GDg1UCWHJeXxKBsCTylLiIF/pg==
X-Received: by 2002:a25:70c2:: with SMTP id l185mr28141118ybc.83.1594147672792; 
 Tue, 07 Jul 2020 11:47:52 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:26 -0700
In-Reply-To: <20200707184730.3047754-1-hskinnemoen@google.com>
Message-Id: <20200707184730.3047754-9-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 08/12] hw/nvram: NPCM7xx OTP device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>,
 Avi Fishman <avi.fishman@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3WMMEXwsKCu8YjbZeeVdfVeXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

This supports reading and writing OTP fuses and keys. Only fuse reading
has been tested. Protection is not implemented.

Reviewed-by: Avi Fishman <avi.fishman@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx.c               |  32 +++
 hw/nvram/Makefile.objs         |   1 +
 hw/nvram/npcm7xx_otp.c         | 405 +++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h       |   3 +
 include/hw/nvram/npcm7xx_otp.h |  94 ++++++++
 5 files changed, 535 insertions(+)
 create mode 100644 hw/nvram/npcm7xx_otp.c
 create mode 100644 include/hw/nvram/npcm7xx_otp.h

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 0a9e30f66f..71cc141f3c 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -37,6 +37,10 @@
 #define NPCM7XX_MMIO_BA         (0x80000000)
 #define NPCM7XX_MMIO_SZ         (0x7FFD0000)
 
+/* OTP key storage and fuse strap array */
+#define NPCM7XX_OTP1_BA         (0xF0189000)
+#define NPCM7XX_OTP2_BA         (0xF018A000)
+
 /* Core system modules. */
 #define NPCM7XX_L2C_BA          (0xF03FC000)
 #define NPCM7XX_CPUP_BA         (0xF03FE000)
@@ -123,6 +127,15 @@ void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_info *info)
                        NPCM7XX_SMP_LOADER_START);
 }
 
+static void npcm7xx_init_fuses(NPCM7xxState *s)
+{
+    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
+    uint32_t value;
+
+    value = tswap32(nc->disabled_modules);
+    npcm7xx_otp_array_write(&s->fuse_array, &value, 64, sizeof(value));
+}
+
 static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
 {
     return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
@@ -143,6 +156,10 @@ static void npcm7xx_init(Object *obj)
     object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
                               "power-on-straps");
     object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM7XX_CLK);
+    object_initialize_child(obj, "otp1", &s->key_storage,
+                            TYPE_NPCM7XX_KEY_STORAGE);
+    object_initialize_child(obj, "otp2", &s->fuse_array,
+                            TYPE_NPCM7XX_FUSE_ARRAY);
 
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
@@ -223,6 +240,21 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
 
+    /* OTP key storage and fuse strap array */
+    sysbus_realize(SYS_BUS_DEVICE(&s->key_storage), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->key_storage), 0, NPCM7XX_OTP1_BA);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fuse_array), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
+    npcm7xx_init_fuses(s);
+
     /* Timer Modules (TIM) */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index f3ad921382..0270f0bbf7 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -4,5 +4,6 @@ common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
 common-obj-y += fw_cfg.o
 common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_otp.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
new file mode 100644
index 0000000000..18908bc839
--- /dev/null
+++ b/hw/nvram/npcm7xx_otp.c
@@ -0,0 +1,405 @@
+/*
+ * Nuvoton NPCM7xx OTP (Fuse Array) Interface
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/nvram/npcm7xx_otp.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+/* Each module has 4 KiB of register space. Only a fraction of it is used. */
+#define NPCM7XX_OTP_REGS_SIZE (4 * KiB)
+
+/* Register field definitions. */
+#define FST_RIEN BIT(2)
+#define FST_RDST BIT(1)
+#define FST_RDY BIT(0)
+#define FST_RO_MASK (FST_RDST | FST_RDY)
+
+#define FADDR_BYTEADDR(rv) extract32((rv), 0, 10)
+#define FADDR_BITPOS(rv) extract32((rv), 10, 3)
+
+#define FDATA_CLEAR 0x00000001
+
+#define FCFG_FDIS BIT(31)
+#define FCFG_FCFGLK_MASK 0x00ff0000
+
+#define FCTL_PROG_CMD1 0x00000001
+#define FCTL_PROG_CMD2 0xbf79e5d0
+#define FCTL_READ_CMD 0x00000002
+
+static uint8_t ecc_encode_nibble(uint8_t n)
+{
+    uint8_t result = n;
+
+    result |= (((n >> 0) & 1) ^ ((n >> 1) & 1)) << 4;
+    result |= (((n >> 2) & 1) ^ ((n >> 3) & 1)) << 5;
+    result |= (((n >> 0) & 1) ^ ((n >> 2) & 1)) << 6;
+    result |= (((n >> 1) & 1) ^ ((n >> 3) & 1)) << 7;
+
+    return result;
+}
+
+void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
+                             unsigned int offset, unsigned int len)
+{
+    const uint8_t *src = data;
+    uint8_t *dst = &s->array[offset];
+
+    while (len-- > 0) {
+        uint8_t c = *src++;
+
+        *dst++ = ecc_encode_nibble(extract8(c, 0, 4));
+        *dst++ = ecc_encode_nibble(extract8(c, 4, 4));
+    }
+}
+
+/* Common register read handler for both OTP classes. */
+static uint64_t npcm7xx_otp_read(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg)
+{
+    uint32_t value = 0;
+
+    switch (reg) {
+    case NPCM7XX_OTP_FST:
+    case NPCM7XX_OTP_FADDR:
+    case NPCM7XX_OTP_FDATA:
+    case NPCM7XX_OTP_FCFG:
+        value = s->regs[reg];
+        break;
+
+    case NPCM7XX_OTP_FCTL:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from write-only FCTL register\n",
+                      DEVICE(s)->canonical_path);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read from invalid offset 0x%zx\n",
+                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
+        break;
+    }
+
+    return value;
+}
+
+/* Read a byte from the OTP array into the data register. */
+static void npcm7xx_otp_read_array(NPCM7xxOTPState *s)
+{
+    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
+
+    s->regs[NPCM7XX_OTP_FDATA] = s->array[FADDR_BYTEADDR(faddr)];
+    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
+}
+
+/* Program a byte from the data register into the OTP array. */
+static void npcm7xx_otp_program_array(NPCM7xxOTPState *s)
+{
+    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
+
+    /* Bits can only go 0->1, never 1->0. */
+    s->array[FADDR_BYTEADDR(faddr)] |= (1U << FADDR_BITPOS(faddr));
+    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
+}
+
+/* Compute the next value of the FCFG register. */
+static uint32_t npcm7xx_otp_compute_fcfg(uint32_t cur_value, uint32_t new_value)
+{
+    uint32_t lock_mask;
+    uint32_t value;
+
+    /*
+     * FCFGLK holds sticky bits 16..23, indicating which bits in FPRGLK (8..15)
+     * and FRDLK (0..7) that are read-only.
+     */
+    lock_mask = (cur_value & FCFG_FCFGLK_MASK) >> 8;
+    lock_mask |= lock_mask >> 8;
+    /* FDIS and FCFGLK bits are sticky (write 1 to set; can't clear). */
+    value = cur_value & (FCFG_FDIS | FCFG_FCFGLK_MASK);
+    /* Preserve read-only bits in FPRGLK and FRDLK */
+    value |= cur_value & lock_mask;
+    /* Set all bits that aren't read-only. */
+    value |= new_value & ~lock_mask;
+
+    return value;
+}
+
+/* Common register write handler for both OTP classes. */
+static void npcm7xx_otp_write(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg,
+                              uint32_t value)
+{
+    switch (reg) {
+    case NPCM7XX_OTP_FST:
+        /* RDST is cleared by writing 1 to it. */
+        if (value & FST_RDST) {
+            s->regs[NPCM7XX_OTP_FST] &= ~FST_RDST;
+        }
+        /* Preserve read-only and write-one-to-clear bits */
+        value =
+            (value & ~FST_RO_MASK) | (s->regs[NPCM7XX_OTP_FST] & FST_RO_MASK);
+        break;
+
+    case NPCM7XX_OTP_FADDR:
+        break;
+
+    case NPCM7XX_OTP_FDATA:
+        /*
+         * This register is cleared by writing a magic value to it; no other
+         * values can be written.
+         */
+        if (value == FDATA_CLEAR) {
+            value = 0;
+        } else {
+            value = s->regs[NPCM7XX_OTP_FDATA];
+        }
+        break;
+
+    case NPCM7XX_OTP_FCFG:
+        value = npcm7xx_otp_compute_fcfg(s->regs[NPCM7XX_OTP_FCFG], value);
+        break;
+
+    case NPCM7XX_OTP_FCTL:
+        switch (value) {
+        case FCTL_READ_CMD:
+            npcm7xx_otp_read_array(s);
+            break;
+
+        case FCTL_PROG_CMD1:
+            /*
+             * Programming requires writing two separate magic values to this
+             * register; this is the first one. Just store it so it can be
+             * verified later when the second magic value is received.
+             */
+            break;
+
+        case FCTL_PROG_CMD2:
+            /*
+             * Only initiate programming if we received the first half of the
+             * command immediately before this one.
+             */
+            if (s->regs[NPCM7XX_OTP_FCTL] == FCTL_PROG_CMD1) {
+                npcm7xx_otp_program_array(s);
+            }
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: unrecognized FCNTL value 0x%" PRIx32 "\n",
+                          DEVICE(s)->canonical_path, value);
+            break;
+        }
+        if (value != FCTL_PROG_CMD1) {
+            value = 0;
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to invalid offset 0x%zx\n",
+                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
+        return;
+    }
+
+    s->regs[reg] = value;
+}
+
+/* Register read handler specific to the fuse array OTP module. */
+static uint64_t npcm7xx_fuse_array_read(void *opaque, hwaddr addr,
+                                        unsigned int size)
+{
+    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
+    NPCM7xxOTPState *s = opaque;
+    uint32_t value;
+
+    /*
+     * Only the Fuse Strap register needs special handling; all other registers
+     * work the same way for both kinds of OTP modules.
+     */
+    if (reg != NPCM7XX_OTP_FUSTRAP) {
+        value = npcm7xx_otp_read(s, reg);
+    } else {
+        /* FUSTRAP is stored as three copies in the OTP array. */
+        uint32_t fustrap[3];
+
+        memcpy(fustrap, &s->array[0], sizeof(fustrap));
+
+        /* Determine value by a majority vote on each bit. */
+        value = (fustrap[0] & fustrap[1]) | (fustrap[0] & fustrap[2]) |
+                (fustrap[1] & fustrap[2]);
+    }
+
+    return value;
+}
+
+/* Register write handler specific to the fuse array OTP module. */
+static void npcm7xx_fuse_array_write(void *opaque, hwaddr addr, uint64_t v,
+                                     unsigned int size)
+{
+    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
+    NPCM7xxOTPState *s = opaque;
+
+    /*
+     * The Fuse Strap register is read-only. Other registers are handled by
+     * common code.
+     */
+    if (reg != NPCM7XX_OTP_FUSTRAP) {
+        npcm7xx_otp_write(s, reg, v);
+    }
+}
+
+static const MemoryRegionOps npcm7xx_fuse_array_ops = {
+    .read       = npcm7xx_fuse_array_read,
+    .write      = npcm7xx_fuse_array_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+/* Register read handler specific to the key storage OTP module. */
+static uint64_t npcm7xx_key_storage_read(void *opaque, hwaddr addr,
+                                         unsigned int size)
+{
+    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
+    NPCM7xxOTPState *s = opaque;
+
+    /*
+     * Only the Fuse Key Index register needs special handling; all other
+     * registers work the same way for both kinds of OTP modules.
+     */
+    if (reg != NPCM7XX_OTP_FKEYIND) {
+        return npcm7xx_otp_read(s, reg);
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
+
+    return s->regs[NPCM7XX_OTP_FKEYIND];
+}
+
+/* Register write handler specific to the key storage OTP module. */
+static void npcm7xx_key_storage_write(void *opaque, hwaddr addr, uint64_t v,
+                                      unsigned int size)
+{
+    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
+    NPCM7xxOTPState *s = opaque;
+
+    /*
+     * Only the Fuse Key Index register needs special handling; all other
+     * registers work the same way for both kinds of OTP modules.
+     */
+    if (reg != NPCM7XX_OTP_FKEYIND) {
+        npcm7xx_otp_write(s, reg, v);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
+
+    s->regs[NPCM7XX_OTP_FKEYIND] = v;
+}
+
+static const MemoryRegionOps npcm7xx_key_storage_ops = {
+    .read       = npcm7xx_key_storage_read,
+    .write      = npcm7xx_key_storage_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+static void npcm7xx_otp_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxOTPState *s = NPCM7XX_OTP(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[NPCM7XX_OTP_FST] = 0x00000001;
+    s->regs[NPCM7XX_OTP_FCFG] = 0x20000000;
+}
+
+static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxOTPClass *oc = NPCM7XX_OTP_GET_CLASS(dev);
+    NPCM7xxOTPState *s = NPCM7XX_OTP(dev);
+    SysBusDevice *sbd = &s->parent;
+
+    memset(s->array, 0, sizeof(s->array));
+
+    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "regs",
+                          NPCM7XX_OTP_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static const VMStateDescription vmstate_npcm7xx_otp = {
+    .name = "npcm7xx-otp",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxOTPState, NPCM7XX_OTP_NR_REGS),
+        VMSTATE_UINT8_ARRAY(array, NPCM7xxOTPState, NPCM7XX_OTP_ARRAY_BYTES),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = npcm7xx_otp_realize;
+    dc->vmsd = &vmstate_npcm7xx_otp;
+    rc->phases.enter = npcm7xx_otp_enter_reset;
+}
+
+static void npcm7xx_key_storage_class_init(ObjectClass *klass, void *data)
+{
+    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
+
+    oc->mmio_ops = &npcm7xx_key_storage_ops;
+}
+
+static void npcm7xx_fuse_array_class_init(ObjectClass *klass, void *data)
+{
+    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
+
+    oc->mmio_ops = &npcm7xx_fuse_array_ops;
+}
+
+static const TypeInfo npcm7xx_otp_types[] = {
+    {
+        .name = TYPE_NPCM7XX_OTP,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxOTPState),
+        .class_init = npcm7xx_otp_class_init,
+        .abstract = true,
+    },
+    {
+        .name = TYPE_NPCM7XX_KEY_STORAGE,
+        .parent = TYPE_NPCM7XX_OTP,
+        .class_init = npcm7xx_key_storage_class_init,
+    },
+    {
+        .name = TYPE_NPCM7XX_FUSE_ARRAY,
+        .parent = TYPE_NPCM7XX_OTP,
+        .class_init = npcm7xx_fuse_array_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_otp_types);
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index e25f5752d7..2f2d44aad7 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -20,6 +20,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
+#include "hw/nvram/npcm7xx_otp.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "target/arm/cpu.h"
 
@@ -63,6 +64,8 @@ typedef struct NPCM7xxState {
     NPCM7xxGCRState     gcr;
     NPCM7xxCLKState     clk;
     NPCM7xxTimerCtrlState tim[3];
+    NPCM7xxOTPState     key_storage;
+    NPCM7xxOTPState     fuse_array;
 } NPCM7xxState;
 
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
new file mode 100644
index 0000000000..b52330dadc
--- /dev/null
+++ b/include/hw/nvram/npcm7xx_otp.h
@@ -0,0 +1,94 @@
+/*
+ * Nuvoton NPCM7xx OTP (Fuse Array) Interface
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+#ifndef NPCM7XX_OTP_H
+#define NPCM7XX_OTP_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/* Each OTP module holds 8192 bits of one-time programmable storage */
+#define NPCM7XX_OTP_ARRAY_BITS (8192)
+#define NPCM7XX_OTP_ARRAY_BYTES (NPCM7XX_OTP_ARRAY_BITS / 8)
+
+/**
+ * enum NPCM7xxOTPRegister - 32-bit register indices.
+ */
+typedef enum NPCM7xxOTPRegister {
+    NPCM7XX_OTP_FST,
+    NPCM7XX_OTP_FADDR,
+    NPCM7XX_OTP_FDATA,
+    NPCM7XX_OTP_FCFG,
+    /* Offset 0x10 is FKEYIND in OTP1, FUSTRAP in OTP2 */
+    NPCM7XX_OTP_FKEYIND = 0x0010 / sizeof(uint32_t),
+    NPCM7XX_OTP_FUSTRAP = 0x0010 / sizeof(uint32_t),
+    NPCM7XX_OTP_FCTL,
+    NPCM7XX_OTP_NR_REGS,
+} NPCM7xxOTPRegister;
+
+/**
+ * struct NPCM7xxOTPState - Device state for one OTP module.
+ * @parent: System bus device.
+ * @mmio: Memory region through which registers are accessed.
+ * @regs: Register contents.
+ * @array: OTP storage array.
+ */
+typedef struct NPCM7xxOTPState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+    uint32_t regs[NPCM7XX_OTP_NR_REGS];
+    uint8_t array[NPCM7XX_OTP_ARRAY_BYTES];
+} NPCM7xxOTPState;
+
+#define TYPE_NPCM7XX_OTP "npcm7xx-otp"
+#define NPCM7XX_OTP(obj) OBJECT_CHECK(NPCM7xxOTPState, (obj), TYPE_NPCM7XX_OTP)
+
+#define TYPE_NPCM7XX_KEY_STORAGE "npcm7xx-key-storage"
+#define TYPE_NPCM7XX_FUSE_ARRAY "npcm7xx-fuse-array"
+
+/**
+ * struct NPCM7xxOTPClass - OTP module class.
+ * @parent: System bus device class.
+ * @mmio_ops: MMIO register operations for this type of module.
+ *
+ * The two OTP modules (key-storage and fuse-array) have slightly different
+ * behavior, so we give them different MMIO register operations.
+ */
+typedef struct NPCM7xxOTPClass {
+    SysBusDeviceClass parent;
+
+    const MemoryRegionOps *mmio_ops;
+} NPCM7xxOTPClass;
+
+#define NPCM7XX_OTP_CLASS(klass) \
+    OBJECT_CLASS_CHECK(NPCM7xxOTPClass, (klass), TYPE_NPCM7XX_OTP)
+#define NPCM7XX_OTP_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(NPCM7xxOTPClass, (obj), TYPE_NPCM7XX_OTP)
+
+/**
+ * npcm7xx_otp_array_write - ECC encode and write data to OTP array.
+ * @s: OTP module.
+ * @data: Data to be encoded and written.
+ * @offset: Offset of first byte to be written in the OTP array.
+ * @len: Number of bytes before ECC encoding.
+ *
+ * Each nibble of data is encoded into a byte, so the number of bytes written
+ * to the array will be @len * 2.
+ */
+extern void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
+                                    unsigned int offset, unsigned int len);
+
+#endif /* NPCM7XX_OTP_H */
-- 
2.27.0.212.ge8ba1cc988-goog


