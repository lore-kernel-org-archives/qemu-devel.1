Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE07EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6769F20678
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuE+ZIIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8o1Y-0002lf-FP
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npk-0007Zh-90
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npi-0000pj-4r
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8nph-0000pN-SW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so2173897wmc.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8mk0cHv84jDjRbcOm9wISaW6Wkm9Gb3IGBK+4Yevgv8=;
 b=BuE+ZIIRktK5uV66GKo3WquAG4rKDoAzCoWWi5zeql/AWa/gS7uRaaDM2UJ3GeQ3lN
 ppvjpQKM/KuTe0oXDlB573bn+kgqDbJZ6FTNBm+TrE/ptb3SKHO2F25wVSYnze47wQez
 CyAQUcNLiyIFeMF2/WZe978h19dH5QwAEFNmJlrps3JmcXMap7A1UB+0q6z+kDeXxzAA
 3icV8yhbKOJDau6dEipkzq6kD0JtQ9b2SfZIxHOsYNwV4b0fHkr5Y7Yv8XeHNUOgVCp8
 295J4ytYRjL9mDSKsB/C0scPvD9ET2Q5BP4XO2PUR3j9aWCZb3VdwV/qtjTf9Y2jjGcw
 CaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8mk0cHv84jDjRbcOm9wISaW6Wkm9Gb3IGBK+4Yevgv8=;
 b=piOOYtlnYt4wMIfRsQgMKlXcnYOOJm3r0PkC/tJfRLmUx+V//TovvP3BwL2Yzja7lk
 OWVBeZgzfOkz1m9NDLlq7/PNDn5SzBej1ihuLNDJ7pL6uGy9beLT8tK/SDyiRXZez6dJ
 i59Z2JKqgxzhtPF+8s8xYOcoyNlKqdzwXc7vm5zMBQjqwvjEODmSwaxXeSuFf1EbOMm5
 mSL2wtPKs1c25RNglMoe+d/zq+5PgPtErA/K4DRJWHcPwpaQQxTTLpbo2lMo+VXSEhmI
 G2Jn+JQEBL9YM/vdk+kQc+3KkOoUSrlzw2VPVHqOV0TjAC7x7rvWcqcD8kkiKrYr4gfh
 /CsA==
X-Gm-Message-State: APjAAAXLIP98vFjZN1rbggoCNOobKOeY3deqNyPN+yJj8Ypm7YqJqkuI
 a/co31ZUHR5WuC9SFg3eq8g6B3zpkHrk8Q==
X-Google-Smtp-Source: APXvYqwXTAw9CTqQCBNuIMeBOn+GEKbug1CpWSCiuY/d+Id3JjFbvdR5cX428fNgYtLsQtwJ1La4iQ==
X-Received: by 2002:a1c:2546:: with SMTP id l67mr4189025wml.10.1568389800388; 
 Fri, 13 Sep 2019 08:50:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.49.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:49:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:45 +0100
Message-Id: <20190913154952.27724-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 05/12] aspeed/smc: Add support for DMAs
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

The FMC controller on the Aspeed SoCs support DMA to access the flash
modules. It can operate in a normal mode, to copy to or from the flash
module mapping window, or in a checksum calculation mode, to evaluate
the best clock settings for reads.

The model introduces two custom address spaces for DMAs: one for the
AHB window of the FMC flash devices and one for the DRAM. The latter
is populated using a "dram" link set from the machine with the RAM
container region.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190904070506.1052-6-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |   6 +
 hw/arm/aspeed.c             |   2 +
 hw/arm/aspeed_soc.c         |   2 +
 hw/ssi/aspeed_smc.c         | 222 +++++++++++++++++++++++++++++++++++-
 4 files changed, 226 insertions(+), 6 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index aa07dac4fe3..32ce6916f6c 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -46,6 +46,8 @@ typedef struct AspeedSMCController {
     hwaddr flash_window_base;
     uint32_t flash_window_size;
     bool has_dma;
+    hwaddr dma_flash_mask;
+    hwaddr dma_dram_mask;
     uint32_t nregs;
 } AspeedSMCController;
 
@@ -101,6 +103,10 @@ typedef struct AspeedSMCState {
     /* for DMA support */
     uint64_t sdram_base;
 
+    AddressSpace flash_as;
+    MemoryRegion *dram_mr;
+    AddressSpace dram_as;
+
     AspeedSMCFlash *flashes;
 
     uint8_t snoop_index;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 13e208c78cc..aa72be309da 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -190,6 +190,8 @@ static void aspeed_board_init(MachineState *machine,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), machine->smp.cpus, "num-cpus",
                             &error_abort);
+    object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_container),
+                             "dram", &error_abort);
     if (machine->kernel_filename) {
         /*
          * When booting with a -kernel command line there is no u-boot
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 25dbc409d35..da508c99c33 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -191,6 +191,8 @@ static void aspeed_soc_init(Object *obj)
                           typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
+    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
+                              &error_abort);
 
     for (i = 0; i < sc->info->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f4f7c181830..c1a45c10dc1 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -28,6 +28,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -112,8 +114,8 @@
 #define   DMA_CTRL_FREQ_SHIFT   4
 #define   DMA_CTRL_MODE         (1 << 3)
 #define   DMA_CTRL_CKSUM        (1 << 2)
-#define   DMA_CTRL_DIR          (1 << 1)
-#define   DMA_CTRL_EN           (1 << 0)
+#define   DMA_CTRL_WRITE        (1 << 1)
+#define   DMA_CTRL_ENABLE       (1 << 0)
 
 /* DMA Flash Side Address */
 #define R_DMA_FLASH_ADDR  (0x84 / 4)
@@ -145,6 +147,24 @@
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
 #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
 
+/*
+ * DMA DRAM addresses should be 4 bytes aligned and the valid address
+ * range is 0x40000000 - 0x5FFFFFFF (AST2400)
+ *          0x80000000 - 0xBFFFFFFF (AST2500)
+ *
+ * DMA flash addresses should be 4 bytes aligned and the valid address
+ * range is 0x20000000 - 0x2FFFFFFF.
+ *
+ * DMA length is from 4 bytes to 32MB
+ *   0: 4 bytes
+ *   0x7FFFFF: 32M bytes
+ */
+#define DMA_DRAM_ADDR(s, val)   ((s)->sdram_base | \
+                                 ((val) & (s)->ctrl->dma_dram_mask))
+#define DMA_FLASH_ADDR(s, val)  ((s)->ctrl->flash_window_base | \
+                                ((val) & (s)->ctrl->dma_flash_mask))
+#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
+
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
 
@@ -214,6 +234,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = true,
+        .dma_flash_mask    = 0x0FFFFFFC,
+        .dma_dram_mask     = 0x1FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
     }, {
         .name              = "aspeed.spi1-ast2400",
@@ -240,6 +262,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = true,
+        .dma_flash_mask    = 0x0FFFFFFC,
+        .dma_dram_mask     = 0x3FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
     }, {
         .name              = "aspeed.spi1-ast2500",
@@ -732,9 +756,6 @@ static void aspeed_smc_reset(DeviceState *d)
 
     memset(s->regs, 0, sizeof s->regs);
 
-    /* Pretend DMA is done (u-boot initialization) */
-    s->regs[R_INTR_CTRL] = INTR_CTRL_DMA_STATUS;
-
     /* Unselect all slaves */
     for (i = 0; i < s->num_cs; ++i) {
         s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;
@@ -775,6 +796,11 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         addr == s->r_ce_ctrl ||
         addr == R_INTR_CTRL ||
         addr == R_DUMMY_DATA ||
+        (s->ctrl->has_dma && addr == R_DMA_CTRL) ||
+        (s->ctrl->has_dma && addr == R_DMA_FLASH_ADDR) ||
+        (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
+        (s->ctrl->has_dma && addr == R_DMA_LEN) ||
+        (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
         (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
         (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
         return s->regs[addr];
@@ -785,6 +811,149 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
     }
 }
 
+/*
+ * Accumulate the result of the reads to provide a checksum that will
+ * be used to validate the read timing settings.
+ */
+static void aspeed_smc_dma_checksum(AspeedSMCState *s)
+{
+    MemTxResult result;
+    uint32_t data;
+
+    if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid direction for DMA checksum\n",  __func__);
+        return;
+    }
+
+    while (s->regs[R_DMA_LEN]) {
+        data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
+                                    MEMTXATTRS_UNSPECIFIED, &result);
+        if (result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed @%08x\n",
+                          __func__, s->regs[R_DMA_FLASH_ADDR]);
+            return;
+        }
+
+        /*
+         * When the DMA is on-going, the DMA registers are updated
+         * with the current working addresses and length.
+         */
+        s->regs[R_DMA_CHECKSUM] += data;
+        s->regs[R_DMA_FLASH_ADDR] += 4;
+        s->regs[R_DMA_LEN] -= 4;
+    }
+}
+
+static void aspeed_smc_dma_rw(AspeedSMCState *s)
+{
+    MemTxResult result;
+    uint32_t data;
+
+    while (s->regs[R_DMA_LEN]) {
+        if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
+            data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+                                        MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed @%08x\n",
+                              __func__, s->regs[R_DMA_DRAM_ADDR]);
+                return;
+            }
+
+            address_space_stl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
+                                 data, MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash write failed @%08x\n",
+                              __func__, s->regs[R_DMA_FLASH_ADDR]);
+                return;
+            }
+        } else {
+            data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
+                                        MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed @%08x\n",
+                              __func__, s->regs[R_DMA_FLASH_ADDR]);
+                return;
+            }
+
+            address_space_stl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
+                                 data, MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed @%08x\n",
+                              __func__, s->regs[R_DMA_DRAM_ADDR]);
+                return;
+            }
+        }
+
+        /*
+         * When the DMA is on-going, the DMA registers are updated
+         * with the current working addresses and length.
+         */
+        s->regs[R_DMA_FLASH_ADDR] += 4;
+        s->regs[R_DMA_DRAM_ADDR] += 4;
+        s->regs[R_DMA_LEN] -= 4;
+    }
+}
+
+static void aspeed_smc_dma_stop(AspeedSMCState *s)
+{
+    /*
+     * When the DMA is disabled, INTR_CTRL_DMA_STATUS=0 means the
+     * engine is idle
+     */
+    s->regs[R_INTR_CTRL] &= ~INTR_CTRL_DMA_STATUS;
+    s->regs[R_DMA_CHECKSUM] = 0;
+
+    /*
+     * Lower the DMA irq in any case. The IRQ control register could
+     * have been cleared before disabling the DMA.
+     */
+    qemu_irq_lower(s->irq);
+}
+
+/*
+ * When INTR_CTRL_DMA_STATUS=1, the DMA has completed and a new DMA
+ * can start even if the result of the previous was not collected.
+ */
+static bool aspeed_smc_dma_in_progress(AspeedSMCState *s)
+{
+    return s->regs[R_DMA_CTRL] & DMA_CTRL_ENABLE &&
+        !(s->regs[R_INTR_CTRL] & INTR_CTRL_DMA_STATUS);
+}
+
+static void aspeed_smc_dma_done(AspeedSMCState *s)
+{
+    s->regs[R_INTR_CTRL] |= INTR_CTRL_DMA_STATUS;
+    if (s->regs[R_INTR_CTRL] & INTR_CTRL_DMA_EN) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void aspeed_smc_dma_ctrl(AspeedSMCState *s, uint64_t dma_ctrl)
+{
+    if (!(dma_ctrl & DMA_CTRL_ENABLE)) {
+        s->regs[R_DMA_CTRL] = dma_ctrl;
+
+        aspeed_smc_dma_stop(s);
+        return;
+    }
+
+    if (aspeed_smc_dma_in_progress(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA in progress\n",  __func__);
+        return;
+    }
+
+    s->regs[R_DMA_CTRL] = dma_ctrl;
+
+    if (s->regs[R_DMA_CTRL] & DMA_CTRL_CKSUM) {
+        aspeed_smc_dma_checksum(s);
+    } else {
+        aspeed_smc_dma_rw(s);
+    }
+
+    aspeed_smc_dma_done(s);
+}
+
 static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
                              unsigned int size)
 {
@@ -810,6 +979,16 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         }
     } else if (addr == R_DUMMY_DATA) {
         s->regs[addr] = value & 0xff;
+    } else if (addr == R_INTR_CTRL) {
+        s->regs[addr] = value;
+    } else if (s->ctrl->has_dma && addr == R_DMA_CTRL) {
+        aspeed_smc_dma_ctrl(s, value);
+    } else if (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) {
+        s->regs[addr] = DMA_DRAM_ADDR(s, value);
+    } else if (s->ctrl->has_dma && addr == R_DMA_FLASH_ADDR) {
+        s->regs[addr] = DMA_FLASH_ADDR(s, value);
+    } else if (s->ctrl->has_dma && addr == R_DMA_LEN) {
+        s->regs[addr] = DMA_LENGTH(value);
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
@@ -824,6 +1003,28 @@ static const MemoryRegionOps aspeed_smc_ops = {
     .valid.unaligned = true,
 };
 
+
+/*
+ * Initialize the custom address spaces for DMAs
+ */
+static void aspeed_smc_dma_setup(AspeedSMCState *s, Error **errp)
+{
+    char *name;
+
+    if (!s->dram_mr) {
+        error_setg(errp, TYPE_ASPEED_SMC ": 'dram' link not set");
+        return;
+    }
+
+    name = g_strdup_printf("%s-dma-flash", s->ctrl->name);
+    address_space_init(&s->flash_as, &s->mmio_flash, name);
+    g_free(name);
+
+    name = g_strdup_printf("%s-dma-dram", s->ctrl->name);
+    address_space_init(&s->dram_as, s->dram_mr, name);
+    g_free(name);
+}
+
 static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -849,10 +1050,12 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
         s->num_cs = s->ctrl->max_slaves;
     }
 
+    /* DMA irq. Keep it first for the initialization in the SoC */
+    sysbus_init_irq(sbd, &s->irq);
+
     s->spi = ssi_create_bus(dev, "spi");
 
     /* Setup cs_lines for slaves */
-    sysbus_init_irq(sbd, &s->irq);
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
     ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
 
@@ -899,6 +1102,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
         memory_region_add_subregion(&s->mmio_flash, offset, &fl->mmio);
         offset += fl->size;
     }
+
+    /* DMA support */
+    if (s->ctrl->has_dma) {
+        aspeed_smc_dma_setup(s, errp);
+    }
 }
 
 static const VMStateDescription vmstate_aspeed_smc = {
@@ -916,6 +1124,8 @@ static const VMStateDescription vmstate_aspeed_smc = {
 static Property aspeed_smc_properties[] = {
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
     DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
+    DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


