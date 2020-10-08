Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B798EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090022224C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YRtM9pTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090022224C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfJU-0000gA-2P
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KJ9_XwsKCmcMXPNSSJRTJSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--hskinnemoen.bounces.google.com>)
 id 1kQfF3-0003x4-It
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:35 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449]:40935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KJ9_XwsKCmcMXPNSSJRTJSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEr-0002t5-2m
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:31 -0400
Received: by mail-pf1-x449.google.com with SMTP id q16so4971705pfj.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=r4SAjlygl0GuuZ7c7BWC+Eo/ai2RUKjZSkaICKNPRLU=;
 b=YRtM9pTf1qQkoO4Kf74rKdg6/k41qtFoUEvoJqBUmsZuNOcbvIuw/Ux8uALSP7TUp3
 TjcsNH3UyB/o9Xy+zXgC+YmUv0sDI9zUkTRoibNQnXE/7gBddgpix/nus+gft5EW7UL8
 dhpxQwYLc9iDbwzbFaW5P8BCE0E1ACYEQVtdGqdoby9LRKGZ+7UlAMzMQHQvM9dlQGsM
 PLZVSBFhq/Ef5DFQa5R3BWTm5krOnr7ZW9grr/COxaF9BR08Lgudsg2JiUnOxj4nf2Mn
 FCaXsb3KXsFnUrbc81NSP3gkYrFLXMzopRL0kML/VjWB+vhfLu1gxIscwTNlPvm6L9pi
 qT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=r4SAjlygl0GuuZ7c7BWC+Eo/ai2RUKjZSkaICKNPRLU=;
 b=T9w9BiX5x4YNt0VpJ0P8d4URh5tDCob/HIuuIT98jln8AVINsWF0VlDohSA8XQPZdJ
 zB3yFq/eVzy0nRjUJyu0QFP4J9OvZ6tHmFIW39Jz4ogKtFMn789rgN0IT7gI4PQ1UBfR
 dwxzkQVDjJvFxb06dJ61bAp/7+Mzx1tfqaHs7glxoFgt9ruBdV9qXI8zT1Z+idmIW8UY
 JevC3iGH+vHXL/Gv+qv3KAjKn+ahHjYgNqXmpMwPYS8P1GKbmxh2zmYPg6TUjOx8SqVw
 qYa9t8q8bJG+CW1YH1m5zwEVVn0cjiZLJZaZxup82fwT1SC3Z1iMf7jSYBcHEzftAfy7
 sa0g==
X-Gm-Message-State: AOAM530yGPKSLQrshaeb6nxkgzWTqnGyUALCUh6yMOM2BEivkNfvzzcz
 6HlLXKBk1HBc+GPERkBkbVq2C2/DQUTlQHOae2f435qfmsNBH/wCOlm3fuuBcA9gRcVytdo+rAf
 XCJjsyrcP/PGaF9GW/R63dyh1bNmTgjYTm+U7UPI680Yja8gagWJLiSvF5uZ047NMMNZp6v6rhg
 ==
X-Google-Smtp-Source: ABdhPJyyUZ78lFtTAO0C5r3K3RQSGrK9HLK1nT94cbGAvGH4xivcQkWjPeKKhaGk/UWFcRbnRvNva3AonS5x/9PYNA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a62:7f07:0:b029:155:2b57:7398 with
 SMTP id a7-20020a627f070000b02901552b577398mr7853336pfd.17.1602199336801;
 Thu, 08 Oct 2020 16:22:16 -0700 (PDT)
Date: Thu,  8 Oct 2020 16:21:52 -0700
In-Reply-To: <20201008232154.94221-1-hskinnemoen@google.com>
Message-Id: <20201008232154.94221-5-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 4/6] hw/misc: Add npcm7xx random number generator
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, f4bug@amsat.org, clg@kaod.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3KJ9_XwsKCmcMXPNSSJRTJSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

The RNG module returns a byte of randomness when the Data Valid bit is
set.

This implementation ignores the prescaler setting, and loads a new value
into RNGD every time RNGCS is read while the RNG is enabled and random
data is available.

A qtest featuring some simple randomness tests is included.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst    |   2 +-
 include/hw/arm/npcm7xx.h       |   2 +
 include/hw/misc/npcm7xx_rng.h  |  34 ++++
 hw/arm/npcm7xx.c               |   7 +-
 hw/misc/npcm7xx_rng.c          | 179 +++++++++++++++++++++
 tests/qtest/npcm7xx_rng-test.c | 278 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 hw/misc/trace-events           |   4 +
 tests/qtest/meson.build        |   1 +
 9 files changed, 506 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/misc/npcm7xx_rng.h
 create mode 100644 hw/misc/npcm7xx_rng.c
 create mode 100644 tests/qtest/npcm7xx_rng-test.c

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index e3e1a3a3a7..4342434df4 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -38,6 +38,7 @@ Supported devices
  * DDR4 memory controller (dummy interface indicating memory training is done)
  * OTP controllers (no protection features)
  * Flash Interface Unit (FIU; no protection features)
+ * Random Number Generator (RNG)
 
 Missing devices
 ---------------
@@ -59,7 +60,6 @@ Missing devices
  * Peripheral SPI controller (PSPI)
  * Analog to Digital Converter (ADC)
  * SD/MMC host
- * Random Number Generator (RNG)
  * PECI interface
  * Pulse Width Modulation (PWM)
  * Tachometer
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 13106af215..761f9b987e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -21,6 +21,7 @@
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm7xx_rng.h"
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/ssi/npcm7xx_fiu.h"
@@ -75,6 +76,7 @@ typedef struct NPCM7xxState {
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
     NPCM7xxMCState      mc;
+    NPCM7xxRNGState     rng;
     NPCM7xxFIUState     fiu[2];
 } NPCM7xxState;
 
diff --git a/include/hw/misc/npcm7xx_rng.h b/include/hw/misc/npcm7xx_rng.h
new file mode 100644
index 0000000000..5e85fd439d
--- /dev/null
+++ b/include/hw/misc/npcm7xx_rng.h
@@ -0,0 +1,34 @@
+/*
+ * Nuvoton NPCM7xx Random Number Generator.
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
+#ifndef NPCM7XX_RNG_H
+#define NPCM7XX_RNG_H
+
+#include "hw/sysbus.h"
+
+typedef struct NPCM7xxRNGState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint8_t rngcs;
+    uint8_t rngd;
+    uint8_t rngmode;
+} NPCM7xxRNGState;
+
+#define TYPE_NPCM7XX_RNG "npcm7xx-rng"
+#define NPCM7XX_RNG(obj) OBJECT_CHECK(NPCM7xxRNGState, (obj), TYPE_NPCM7XX_RNG)
+
+#endif /* NPCM7XX_RNG_H */
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 472efeaf3d..c4bbf3c7d5 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -44,6 +44,7 @@
 #define NPCM7XX_GCR_BA          (0xf0800000)
 #define NPCM7XX_CLK_BA          (0xf0801000)
 #define NPCM7XX_MC_BA           (0xf0824000)
+#define NPCM7XX_RNG_BA          (0xf000b000)
 
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
@@ -256,6 +257,7 @@ static void npcm7xx_init(Object *obj)
     object_initialize_child(obj, "otp2", &s->fuse_array,
                             TYPE_NPCM7XX_FUSE_ARRAY);
     object_initialize_child(obj, "mc", &s->mc, TYPE_NPCM7XX_MC);
+    object_initialize_child(obj, "rng", &s->rng, TYPE_NPCM7XX_RNG);
 
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
@@ -373,6 +375,10 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
                        serial_hd(i), DEVICE_LITTLE_ENDIAN);
     }
 
+    /* Random Number Generator. Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rng), 0, NPCM7XX_RNG_BA);
+
     /*
      * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
      * specified, but this is a programming error.
@@ -411,7 +417,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.vdmx",         0xe0800000,   4 * KiB);
     create_unimplemented_device("npcm7xx.pcierc",       0xe1000000,  64 * KiB);
     create_unimplemented_device("npcm7xx.kcs",          0xf0007000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.rng",          0xf000b000,   4 * KiB);
     create_unimplemented_device("npcm7xx.adc",          0xf000c000,   4 * KiB);
     create_unimplemented_device("npcm7xx.gfxi",         0xf000e000,   4 * KiB);
     create_unimplemented_device("npcm7xx.gpio[0]",      0xf0010000,   4 * KiB);
diff --git a/hw/misc/npcm7xx_rng.c b/hw/misc/npcm7xx_rng.c
new file mode 100644
index 0000000000..a4453382fb
--- /dev/null
+++ b/hw/misc/npcm7xx_rng.c
@@ -0,0 +1,179 @@
+/*
+ * Nuvoton NPCM7xx Flash Interface Unit (FIU)
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
+#include "hw/misc/npcm7xx_rng.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#include "trace.h"
+
+#define NPCM7XX_RNG_REGS_SIZE   (4 * KiB)
+
+#define NPCM7XX_RNGCS           (0x00)
+#define NPCM7XX_RNGCS_CLKP(rv)      extract32(rv, 2, 4)
+#define NPCM7XX_RNGCS_DVALID        BIT(1)
+#define NPCM7XX_RNGCS_RNGE          BIT(0)
+
+#define NPCM7XX_RNGD            (0x04)
+#define NPCM7XX_RNGMODE         (0x08)
+#define NPCM7XX_RNGMODE_NORMAL      (0x02)
+
+static bool npcm7xx_rng_is_enabled(NPCM7xxRNGState *s)
+{
+    return (s->rngcs & NPCM7XX_RNGCS_RNGE) &&
+        (s->rngmode == NPCM7XX_RNGMODE_NORMAL);
+}
+
+static uint64_t npcm7xx_rng_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCM7xxRNGState *s = opaque;
+    uint64_t value = 0;
+
+    switch (offset) {
+    case NPCM7XX_RNGCS:
+        /*
+         * If the RNG is enabled, but we don't have any valid random data, try
+         * obtaining some and update the DVALID bit accordingly.
+         */
+        if (!npcm7xx_rng_is_enabled(s)) {
+            s->rngcs &= ~NPCM7XX_RNGCS_DVALID;
+        } else if (!(s->rngcs & NPCM7XX_RNGCS_DVALID)) {
+            uint8_t byte = 0;
+
+            if (qemu_guest_getrandom(&byte, sizeof(byte), NULL) == 0) {
+                s->rngd = byte;
+                s->rngcs |= NPCM7XX_RNGCS_DVALID;
+            }
+        }
+        value = s->rngcs;
+        break;
+    case NPCM7XX_RNGD:
+        if (npcm7xx_rng_is_enabled(s) && s->rngcs & NPCM7XX_RNGCS_DVALID) {
+            s->rngcs &= ~NPCM7XX_RNGCS_DVALID;
+            value = s->rngd;
+            s->rngd = 0;
+        }
+        break;
+    case NPCM7XX_RNGMODE:
+        value = s->rngmode;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+
+    trace_npcm7xx_rng_read(offset, value, size);
+
+    return value;
+}
+
+static void npcm7xx_rng_write(void *opaque, hwaddr offset, uint64_t value,
+                              unsigned size)
+{
+    NPCM7xxRNGState *s = opaque;
+
+    trace_npcm7xx_rng_write(offset, value, size);
+
+    switch (offset) {
+    case NPCM7XX_RNGCS:
+        s->rngcs &= NPCM7XX_RNGCS_DVALID;
+        s->rngcs |= value & ~NPCM7XX_RNGCS_DVALID;
+        break;
+    case NPCM7XX_RNGD:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only register @ 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    case NPCM7XX_RNGMODE:
+        s->rngmode = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps npcm7xx_rng_ops = {
+    .read = npcm7xx_rng_read,
+    .write = npcm7xx_rng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm7xx_rng_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxRNGState *s = NPCM7XX_RNG(obj);
+
+    s->rngcs = 0;
+    s->rngd = 0;
+    s->rngmode = 0;
+}
+
+static void npcm7xx_rng_init(Object *obj)
+{
+    NPCM7xxRNGState *s = NPCM7XX_RNG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_rng_ops, s, "regs",
+                          NPCM7XX_RNG_REGS_SIZE);
+    sysbus_init_mmio(&s->parent, &s->iomem);
+}
+
+static const VMStateDescription vmstate_npcm7xx_rng = {
+    .name = "npcm7xx-rng",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(rngcs, NPCM7xxRNGState),
+        VMSTATE_UINT8(rngd, NPCM7xxRNGState),
+        VMSTATE_UINT8(rngmode, NPCM7xxRNGState),
+    },
+};
+
+static void npcm7xx_rng_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Random Number Generator";
+    dc->vmsd = &vmstate_npcm7xx_rng;
+    rc->phases.enter = npcm7xx_rng_enter_reset;
+}
+
+static const TypeInfo npcm7xx_rng_types[] = {
+    {
+        .name = TYPE_NPCM7XX_RNG,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxRNGState),
+        .class_init = npcm7xx_rng_class_init,
+        .instance_init = npcm7xx_rng_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_rng_types);
diff --git a/tests/qtest/npcm7xx_rng-test.c b/tests/qtest/npcm7xx_rng-test.c
new file mode 100644
index 0000000000..43f6dd1088
--- /dev/null
+++ b/tests/qtest/npcm7xx_rng-test.c
@@ -0,0 +1,278 @@
+/*
+ * QTest testcase for the Nuvoton NPCM7xx Random Number Generator
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
+#include <math.h>
+
+#include "qemu/osdep.h"
+
+#include "libqtest-single.h"
+#include "qemu/bitops.h"
+
+#define RNG_BASE_ADDR   0xf000b000
+
+/* Control and Status Register */
+#define RNGCS   0x00
+# define DVALID     BIT(1)  /* Data Valid */
+# define RNGE       BIT(0)  /* RNG Enable */
+/* Data Register */
+#define RNGD    0x04
+/* Mode Register */
+#define RNGMODE 0x08
+# define ROSEL_NORMAL   (2) /* RNG only works in this mode */
+
+/* Number of bits to collect for randomness tests. */
+#define TEST_INPUT_BITS  (128)
+
+static void rng_writeb(unsigned int offset, uint8_t value)
+{
+    writeb(RNG_BASE_ADDR + offset, value);
+}
+
+static uint8_t rng_readb(unsigned int offset)
+{
+    return readb(RNG_BASE_ADDR + offset);
+}
+
+/* Disable RNG and set normal ring oscillator mode. */
+static void rng_reset(void)
+{
+    rng_writeb(RNGCS, 0);
+    rng_writeb(RNGMODE, ROSEL_NORMAL);
+}
+
+/* Reset RNG and then enable it. */
+static void rng_reset_enable(void)
+{
+    rng_reset();
+    rng_writeb(RNGCS, RNGE);
+}
+
+/* Wait until Data Valid bit is set. */
+static bool rng_wait_ready(void)
+{
+    /* qemu_guest_getrandom may fail. Assume it won't fail 10 times in a row. */
+    int retries = 10;
+
+    while (retries-- > 0) {
+        if (rng_readb(RNGCS) & DVALID) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/*
+ * Perform a frequency (monobit) test, as defined by NIST SP 800-22, on the
+ * sequence in buf and return the P-value. This represents the probability of a
+ * truly random sequence having the same proportion of zeros and ones as the
+ * sequence in buf.
+ *
+ * An RNG which always returns 0x00 or 0xff, or has some bits stuck at 0 or 1,
+ * will fail this test. However, an RNG which always returns 0x55, 0xf0 or some
+ * other value with an equal number of zeroes and ones will pass.
+ */
+static double calc_monobit_p(const uint8_t *buf, unsigned int len)
+{
+    unsigned int i;
+    double s_obs;
+    int sn = 0;
+
+    for (i = 0; i < len; i++) {
+        /*
+         * Each 1 counts as 1, each 0 counts as -1.
+         * s = cp - (8 - cp) = 2 * cp - 8
+         */
+        sn += 2 * ctpop8(buf[i]) - 8;
+    }
+
+    s_obs = abs(sn) / sqrt(len * BITS_PER_BYTE);
+
+    return erfc(s_obs / sqrt(2));
+}
+
+/*
+ * Perform a runs test, as defined by NIST SP 800-22, and return the P-value.
+ * This represents the probability of a truly random sequence having the same
+ * number of runs (i.e. uninterrupted sequences of identical bits) as the
+ * sequence in buf.
+ */
+static double calc_runs_p(const unsigned long *buf, unsigned int nr_bits)
+{
+    unsigned int j;
+    unsigned int k;
+    int nr_ones = 0;
+    int vn_obs = 0;
+    double pi;
+
+    g_assert(nr_bits % BITS_PER_LONG == 0);
+
+    for (j = 0; j < nr_bits / BITS_PER_LONG; j++) {
+        nr_ones += __builtin_popcountl(buf[j]);
+    }
+    pi = (double)nr_ones / nr_bits;
+
+    for (k = 0; k < nr_bits - 1; k++) {
+        vn_obs += !(test_bit(k, buf) ^ test_bit(k + 1, buf));
+    }
+    vn_obs += 1;
+
+    return erfc(fabs(vn_obs - 2 * nr_bits * pi * (1.0 - pi))
+                / (2 * sqrt(2 * nr_bits) * pi * (1.0 - pi)));
+}
+
+/*
+ * Verifies that DVALID is clear, and RNGD reads zero, when RNGE is cleared,
+ * and DVALID eventually becomes set when RNGE is set.
+ */
+static void test_enable_disable(void)
+{
+    /* Disable: DVALID should not be set, and RNGD should read zero */
+    rng_reset();
+    g_assert_cmphex(rng_readb(RNGCS), ==, 0);
+    g_assert_cmphex(rng_readb(RNGD), ==, 0);
+
+    /* Enable: DVALID should be set, but we can't make assumptions about RNGD */
+    rng_writeb(RNGCS, RNGE);
+    g_assert_true(rng_wait_ready());
+    g_assert_cmphex(rng_readb(RNGCS), ==, DVALID | RNGE);
+
+    /* Disable: DVALID should not be set, and RNGD should read zero */
+    rng_writeb(RNGCS, 0);
+    g_assert_cmphex(rng_readb(RNGCS), ==, 0);
+    g_assert_cmphex(rng_readb(RNGD), ==, 0);
+}
+
+/*
+ * Verifies that the RNG only produces data when RNGMODE is set to 'normal'
+ * ring oscillator mode.
+ */
+static void test_rosel(void)
+{
+    rng_reset_enable();
+    g_assert_true(rng_wait_ready());
+    rng_writeb(RNGMODE, 0);
+    g_assert_false(rng_wait_ready());
+    rng_writeb(RNGMODE, ROSEL_NORMAL);
+    g_assert_true(rng_wait_ready());
+    rng_writeb(RNGMODE, 0);
+    g_assert_false(rng_wait_ready());
+}
+
+/*
+ * Verifies that a continuous sequence of bits collected after enabling the RNG
+ * satisfies a monobit test.
+ */
+static void test_continuous_monobit(void)
+{
+    uint8_t buf[TEST_INPUT_BITS / BITS_PER_BYTE];
+    unsigned int i;
+
+    rng_reset_enable();
+    for (i = 0; i < sizeof(buf); i++) {
+        g_assert_true(rng_wait_ready());
+        buf[i] = rng_readb(RNGD);
+    }
+
+    g_assert_cmpfloat(calc_monobit_p(buf, sizeof(buf)), >, 0.01);
+}
+
+/*
+ * Verifies that a continuous sequence of bits collected after enabling the RNG
+ * satisfies a runs test.
+ */
+static void test_continuous_runs(void)
+{
+    union {
+        unsigned long l[TEST_INPUT_BITS / BITS_PER_LONG];
+        uint8_t c[TEST_INPUT_BITS / BITS_PER_BYTE];
+    } buf;
+    unsigned int i;
+
+    rng_reset_enable();
+    for (i = 0; i < sizeof(buf); i++) {
+        g_assert_true(rng_wait_ready());
+        buf.c[i] = rng_readb(RNGD);
+    }
+
+    g_assert_cmpfloat(calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE), >, 0.01);
+}
+
+/*
+ * Verifies that the first data byte collected after enabling the RNG satisfies
+ * a monobit test.
+ */
+static void test_first_byte_monobit(void)
+{
+    /* Enable, collect one byte, disable. Repeat until we have 100 bits. */
+    uint8_t buf[TEST_INPUT_BITS / BITS_PER_BYTE];
+    unsigned int i;
+
+    rng_reset();
+    for (i = 0; i < sizeof(buf); i++) {
+        rng_writeb(RNGCS, RNGE);
+        g_assert_true(rng_wait_ready());
+        buf[i] = rng_readb(RNGD);
+        rng_writeb(RNGCS, 0);
+    }
+
+    g_assert_cmpfloat(calc_monobit_p(buf, sizeof(buf)), >, 0.01);
+}
+
+/*
+ * Verifies that the first data byte collected after enabling the RNG satisfies
+ * a runs test.
+ */
+static void test_first_byte_runs(void)
+{
+    /* Enable, collect one byte, disable. Repeat until we have 100 bits. */
+    union {
+        unsigned long l[TEST_INPUT_BITS / BITS_PER_LONG];
+        uint8_t c[TEST_INPUT_BITS / BITS_PER_BYTE];
+    } buf;
+    unsigned int i;
+
+    rng_reset();
+    for (i = 0; i < sizeof(buf); i++) {
+        rng_writeb(RNGCS, RNGE);
+        g_assert_true(rng_wait_ready());
+        buf.c[i] = rng_readb(RNGD);
+        rng_writeb(RNGCS, 0);
+    }
+
+    g_assert_cmpfloat(calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE), >, 0.01);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("npcm7xx_rng/enable_disable", test_enable_disable);
+    qtest_add_func("npcm7xx_rng/rosel", test_rosel);
+    qtest_add_func("npcm7xx_rng/continuous/monobit", test_continuous_monobit);
+    qtest_add_func("npcm7xx_rng/continuous/runs", test_continuous_runs);
+    qtest_add_func("npcm7xx_rng/first_byte/monobit", test_first_byte_monobit);
+    qtest_add_func("npcm7xx_rng/first_byte/runs", test_first_byte_runs);
+
+    qtest_start("-machine npcm750-evb");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 793d45b1dc..7ffb44b587 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -59,6 +59,7 @@ softmmu_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
 softmmu_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
   'npcm7xx_gcr.c',
+  'npcm7xx_rng.c',
 ))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6054f9adf3..b2f060ad77 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -118,6 +118,10 @@ npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " valu
 npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
+# npcm7xx_rng.c
+npcm7xx_rng_read(uint64_t offset, uint64_t value, unsigned size) "offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
+npcm7xx_rng_write(uint64_t offset, uint64_t value, unsigned size) "offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
+
 # stm32f4xx_syscfg.c
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 03e4f116b6..796553e16e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -139,6 +139,7 @@ qtests_arm = \
    'm25p80-test',
    'npcm7xx_timer-test',
    'npcm7xx_watchdog_timer-test',
+   'npcm7xx_rng-test',
    'test-arm-mptimer',
    'boot-serial-test',
    'hexloader-test']
-- 
2.28.0.1011.ga647a8990f-goog


