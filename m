Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A86AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9B322283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Qs6SB+jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9B322283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFR7-0006tv-5S
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFN2-000123-4H; Sat, 10 Oct 2020 09:57:12 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMz-0004JP-8F; Sat, 10 Oct 2020 09:57:11 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 93FC2C603D7;
 Sat, 10 Oct 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZVj10AFujvPZeDEOYBlWPdrZCZDe5HuOmVNdOSGfsA=;
 b=Qs6SB+jMt98w3YXw84L6r8myh/3WRj3mzgY/1Vf91XzJIdb11GpdNixjfBKRs3gCVSX9yE
 KfL2BSsvQjDSzYeqDRjvNjbkLCCYQPgdls8yUwm9c8ZZoQJY8gF4vQZsbpolcxX2nL+ESZ
 eMWvMut9R8Hhr0xzTwpCw6T965cWAYPbxE3V/Lff4c+s/dR5wS8N0ui+s1WDvknix+3DBc
 V+aXV3gv5yc/pzEnSk/34EdBeU/QUv2kdttW/1UUsONZ8LKaNeoxMmo0Y7gZere8ijffdJ
 aMmcupcbP8Ap0rtDpf0CUgrzY2J4SQWPuVuaIrglInzMxjO+15sZqo3ek5PL3Q==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/15] hw/arm/raspi: add a skeleton implementation of the
 CPRMAN
Date: Sat, 10 Oct 2020 15:57:49 +0200
Message-Id: <20201010135759.437903-6-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZVj10AFujvPZeDEOYBlWPdrZCZDe5HuOmVNdOSGfsA=;
 b=Wt/zLQXSqc9tSYmkcsmH7a1RV7VbmsM/daNO2aZ4/fnH+t3VmhyFWLltbQIIIuOLcm0YoP
 6THrEuJMhYSWdb/FikyXNlYeXiBaiUci6qI68xmHJQKOLnqBH44mwYMaUi/fCYEUm7EwS3
 lklc7pTVeqhx0eEVq2GWyNhAPQhTaLtZVY/HUbcnRXXmkfhow59Vy7elgCw4jg85ZNmboz
 Qd/XOmHteyZ3KJCCs5oFR4IiE7TdNmNKJCEU9afSdnydlyq1PNiYHcQIMArQNnlNGFPAmq
 YCh64q0Bc9d0zIa4McuepAmT4EKNRJpgpbFRYBxL0L00SlJwB6m7Y8lZnE7NZQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338223; a=rsa-sha256; cv=none;
 b=ar7u1xJgl3dPDD+1IwbNgKgOtsvlufP0MFq2S6w5tFuQizx5S/YpZm2CNfuRqw21OnvZv6yexoRQp3KCEuTdlaF0IsDJ0OKBQAfSmyod+2Giab1y/hsVuZ0eZs25BSDnHnMPCT+NAcQpx8geepbZH7XQLdgwVxwANzKHoYhZhQAHTWVg/hfLgK6i5VnBAnXO6eGVeaTFCpaF8sGD2Q/EHNvp+QWFr/+rozbzlhNOtldH8oJMluN1vldgu6Nxr1tILhQystKFxCASZ4q6pSb96z2C0W3UFWfCUWCe/ukTElpJ5RBK6c0z6HIJr80E2Uhyvy2yhGoVkcnOu6fb5mGzIA==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2835 CPRMAN is the clock manager of the SoC. It is composed of a
main oscillator, and several sub-components (PLLs, multiplexers, ...) to
generate the BCM2835 clock tree.

This commit adds a skeleton of the CPRMAN, with a dummy register
read/write implementation. It embeds the main oscillator (xosc) from
which all the clocks will be derived.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/arm/bcm2835_peripherals.h       |   3 +-
 include/hw/misc/bcm2835_cprman.h           |  37 +++++
 include/hw/misc/bcm2835_cprman_internals.h |  24 +++
 hw/arm/bcm2835_peripherals.c               |  11 +-
 hw/misc/bcm2835_cprman.c                   | 163 +++++++++++++++++++++
 hw/misc/meson.build                        |   1 +
 hw/misc/trace-events                       |   5 +
 7 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_cprman_internals.h
 create mode 100644 hw/misc/bcm2835_cprman.c

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 6aa94184eb..479e2346e8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -21,10 +21,11 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "hw/misc/bcm2835_mphi.h"
 #include "hw/misc/bcm2835_thermal.h"
+#include "hw/misc/bcm2835_cprman.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/timer/bcm2835_systmr.h"
 #include "hw/usb/hcd-dwc2.h"
@@ -46,11 +47,11 @@ struct BCM2835PeripheralState {
     BCM2835SystemTimerState systmr;
     BCM2835MphiState mphi;
     UnimplementedDeviceState txp;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState powermgt;
-    UnimplementedDeviceState cprman;
+    BCM2835CprmanState cprman;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
     BCM2835DMAState dma;
     BCM2835ICState ic;
diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
new file mode 100644
index 0000000000..8ae2d4d17c
--- /dev/null
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -0,0 +1,37 @@
+/*
+ * BCM2835 CPRMAN clock manager
+ *
+ * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_CPRMAN_H
+#define HW_MISC_CPRMAN_H
+
+#include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
+
+#define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
+
+typedef struct BCM2835CprmanState BCM2835CprmanState;
+
+DECLARE_INSTANCE_CHECKER(BCM2835CprmanState, CPRMAN,
+                         TYPE_BCM2835_CPRMAN)
+
+#define CPRMAN_NUM_REGS (0x2000 / sizeof(uint32_t))
+
+struct BCM2835CprmanState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+
+    uint32_t regs[CPRMAN_NUM_REGS];
+    uint32_t xosc_freq;
+
+    Clock *xosc;
+};
+
+#endif
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
new file mode 100644
index 0000000000..8fcc6d1d09
--- /dev/null
+++ b/include/hw/misc/bcm2835_cprman_internals.h
@@ -0,0 +1,24 @@
+/*
+ * BCM2835 CPRMAN clock manager
+ *
+ * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_CPRMAN_INTERNALS_H
+#define HW_MISC_CPRMAN_INTERNALS_H
+
+#include "hw/registerfields.h"
+#include "hw/misc/bcm2835_cprman.h"
+
+/* Register map */
+
+/*
+ * This field is common to all registers. Each register write value must match
+ * the CPRMAN_PASSWORD magic value in its 8 MSB.
+ */
+FIELD(CPRMAN, PASSWORD, 24, 8)
+#define CPRMAN_PASSWORD 0x5a
+
+#endif
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 10e9f501d2..9d6190042d 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -119,10 +119,13 @@ static void bcm2835_peripherals_init(Object *obj)
     object_initialize_child(obj, "mphi", &s->mphi, TYPE_BCM2835_MPHI);
 
     /* DWC2 */
     object_initialize_child(obj, "dwc2", &s->dwc2, TYPE_DWC2_USB);
 
+    /* CPRMAN clock manager */
+    object_initialize_child(obj, "cprman", &s->cprman, TYPE_BCM2835_CPRMAN);
+
     object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -158,10 +161,17 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* Interrupt Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), errp)) {
         return;
     }
 
+    /* CPRMAN clock manager */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cprman), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
+
     memory_region_add_subregion(&s->peri_mr, ARMCTRL_IC_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* Sys Timer */
@@ -344,11 +354,10 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_USB));
 
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->powermgt, "bcm2835-powermgt", PM_OFFSET, 0x114);
-    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x2000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
     create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
new file mode 100644
index 0000000000..57ab9910b5
--- /dev/null
+++ b/hw/misc/bcm2835_cprman.c
@@ -0,0 +1,163 @@
+/*
+ * BCM2835 CPRMAN clock manager
+ *
+ * Copyright (c) 2020 Luc Michel <luc@lmichel.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * This peripheral is roughly divided into 3 main parts:
+ *   - the PLLs
+ *   - the PLL channels
+ *   - the clock muxes
+ *
+ * A main oscillator (xosc) feeds all the PLLs. Each PLLs has one or more
+ * channels. Those channel are then connected to the clock muxes. Each mux has
+ * multiples sources (usually the xosc, some of the PLL channels and some "test
+ * debug" clocks). A mux is configured to select a given source through its
+ * control register. Each mux has one output clock that also goes out of the
+ * CPRMAN. This output clock usually connects to another peripheral in the SoC
+ * (so a given mux is dedicated to a peripheral).
+ *
+ * At each level (PLL, channel and mux), the clock can be altered through
+ * dividers (and multipliers in case of the PLLs), and can be disabled (in this
+ * case, the next levels see no clock).
+ *
+ * This can be sum-up as follows (this is an example and not the actual BCM2835
+ * clock tree):
+ *
+ *          /-->[PLL]-|->[PLL channel]--...            [mux]--> to peripherals
+ *          |         |->[PLL channel]  muxes takes    [mux]
+ *          |         \->[PLL channel]  inputs from    [mux]
+ *          |                           some channels  [mux]
+ * [xosc]---|-->[PLL]-|->[PLL channel]  and other srcs [mux]
+ *          |         \->[PLL channel]           ...-->[mux]
+ *          |                                          [mux]
+ *          \-->[PLL]--->[PLL channel]                 [mux]
+ *
+ * The page at https://elinux.org/The_Undocumented_Pi gives the actual clock
+ * tree configuration.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/bcm2835_cprman.h"
+#include "hw/misc/bcm2835_cprman_internals.h"
+#include "trace.h"
+
+/* CPRMAN "top level" model */
+
+static uint64_t cprman_read(void *opaque, hwaddr offset,
+                            unsigned size)
+{
+    BCM2835CprmanState *s = CPRMAN(opaque);
+    uint64_t r = 0;
+    size_t idx = offset / sizeof(uint32_t);
+
+    switch (idx) {
+    default:
+        r = s->regs[idx];
+    }
+
+    trace_bcm2835_cprman_read(offset, r);
+    return r;
+}
+
+static void cprman_write(void *opaque, hwaddr offset,
+                         uint64_t value, unsigned size)
+{
+    BCM2835CprmanState *s = CPRMAN(opaque);
+    size_t idx = offset / sizeof(uint32_t);
+
+    if (FIELD_EX32(value, CPRMAN, PASSWORD) != CPRMAN_PASSWORD) {
+        trace_bcm2835_cprman_write_invalid_magic(offset, value);
+        return;
+    }
+
+    value &= ~R_CPRMAN_PASSWORD_MASK;
+
+    trace_bcm2835_cprman_write(offset, value);
+    s->regs[idx] = value;
+
+}
+
+static const MemoryRegionOps cprman_ops = {
+    .read = cprman_read,
+    .write = cprman_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        /*
+         * Although this hasn't been checked against real hardware, nor the
+         * information can be found in a datasheet, it seems reasonable because
+         * of the "PASSWORD" magic value found in every registers.
+         */
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+    .impl = {
+        .max_access_size = 4,
+    },
+};
+
+static void cprman_reset(DeviceState *dev)
+{
+    BCM2835CprmanState *s = CPRMAN(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    clock_update_hz(s->xosc, s->xosc_freq);
+}
+
+static void cprman_init(Object *obj)
+{
+    BCM2835CprmanState *s = CPRMAN(obj);
+
+    s->xosc = clock_new(obj, "xosc");
+
+    memory_region_init_io(&s->iomem, obj, &cprman_ops,
+                          s, "bcm2835-cprman", 0x2000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription cprman_vmstate = {
+    .name = TYPE_BCM2835_CPRMAN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, BCM2835CprmanState, CPRMAN_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property cprman_properties[] = {
+    DEFINE_PROP_UINT32("xosc-freq-hz", BCM2835CprmanState, xosc_freq, 19200000),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void cprman_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = cprman_reset;
+    dc->vmsd = &cprman_vmstate;
+    device_class_set_props(dc, cprman_properties);
+}
+
+static const TypeInfo cprman_info = {
+    .name = TYPE_BCM2835_CPRMAN,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835CprmanState),
+    .class_init = cprman_class_init,
+    .instance_init = cprman_init,
+};
+
+static void cprman_register_types(void)
+{
+    type_register_static(&cprman_info);
+}
+
+type_init(cprman_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 793d45b1dc..c94cf70e82 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -71,10 +71,11 @@ softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_mbox.c',
   'bcm2835_mphi.c',
   'bcm2835_property.c',
   'bcm2835_rng.c',
   'bcm2835_thermal.c',
+  'bcm2835_cprman.c',
 ))
 softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 softmmu_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c', 'zynq-xadc.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6054f9adf3..d718a2b177 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -224,5 +224,10 @@ grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx6
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
 pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
+
+# bcm2835_cprman.c
+bcm2835_cprman_read(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
+bcm2835_cprman_write(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
+bcm2835_cprman_write_invalid_magic(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
-- 
2.28.0


