Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC5C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C1320842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxJN2KZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSmm-0002NQ-B9
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSc0-0006S6-7g
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSby-000799-6W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:36 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbx-00078R-Ud
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:34 -0500
Received: by mail-wr1-x431.google.com with SMTP id c9so22913236wrw.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=StxoMZnanzslN7MfzXM5XBLfN5Z0+Kd+uHR/2EukZ40=;
 b=bxJN2KZGEOL2Iom4hhwqxeU11o4jsjFmlJwP8tQFekajIVI1tHtmmWaNLiMpE/9jEW
 kye0XVs/VVY0vb7TCUp2Vf5tcIsTehiEaOePWjc2qWdNBU+Jf7/XqkO1nB/hMMvJHoBz
 z08Q51KzScrCorHCAw/TQGHFZ40fKm92uxsma5x5la6MQ+CbSGUXyzE3Nqd8oeiCOFOS
 xBQnd9csj67l41t9gZFYajNewWfM5VhLs6itqJu/JqxdbQuuqVti+fGveBy0DHsJm3z0
 eUFmAeWH4hAoPrU6eS7QKZJ6klz7xVWITY/X6iFNTCSzgovX8b9n7QlVVVqyQyyfYWZQ
 niRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=StxoMZnanzslN7MfzXM5XBLfN5Z0+Kd+uHR/2EukZ40=;
 b=K78wvVC87txfw/wU6kil27ISYRDoMVNduLmYqUxo8bmsMHQkHGdz8HXuWyIPgCm4sc
 a/yEfnOnjzZ4RWLAvIbzolROHhtn2BwoN+FRF8zTKA+GCyD1Ci40W/JEUEwQOApHKq8Y
 uN+8kG0V9zJOLJcYxitJdMI3xAbwcKOdCihWBmKkdwuHxdl0fjL+HXIrjQgrPzgv1732
 rmdiZtoHX/eVFT4wdlqPvvkKgRkVcnVVYxQ2SwPqNNSQV46Ci2vp7b7K+//C45u6onfi
 E5muP5yNhr9/0OUy1lqEDRV/uRPzg3HUfQ1qoKO7sRcPH8hQLeVfzha/5Afu58RS2Z6n
 GR2Q==
X-Gm-Message-State: APjAAAXv9pifSaGZ4NrgE5WdnWmF7DG6E7Pc1k5QRSw6X5N1HYUR5gpy
 43eGcqUE02DlIf0sNh9WakgG/EYwy3MsKQ==
X-Google-Smtp-Source: APXvYqyvlbuLgKMDZHd3o844FFovAOYoVZyaO5IVIM8aJq4a9zGd+uHnptS6sywv9c7DsiKYxIYRbw==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr3324803wru.112.1579271312180; 
 Fri, 17 Jan 2020 06:28:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] i.MX: add an emulation for RNGC
Date: Fri, 17 Jan 2020 14:28:12 +0000
Message-Id: <20200117142816.15110-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

From: Martin Kaiser <martin@kaiser.cx>

Add an emulation for the RNGC random number generator and the compatible
RNGB variant. These peripherals are included (at least) in imx25 and
imx35 chipsets.

The emulation supports the initial self test, reseeding the prng and
reading random numbers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs      |   1 +
 include/hw/arm/fsl-imx25.h |   5 +
 include/hw/misc/imx_rngc.h |  35 +++++
 hw/arm/fsl-imx25.c         |  11 ++
 hw/misc/imx_rngc.c         | 278 +++++++++++++++++++++++++++++++++++++
 5 files changed, 330 insertions(+)
 create mode 100644 include/hw/misc/imx_rngc.h
 create mode 100644 hw/misc/imx_rngc.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c6ecbdd7b0e..da993f45b74 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -42,6 +42,7 @@ common-obj-$(CONFIG_IMX) += imx7_ccm.o
 common-obj-$(CONFIG_IMX) += imx2_wdt.o
 common-obj-$(CONFIG_IMX) += imx7_snvs.o
 common-obj-$(CONFIG_IMX) += imx7_gpr.o
+common-obj-$(CONFIG_IMX) += imx_rngc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 241efb52ae0..1c86bb55fbd 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -24,6 +24,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
 #include "hw/net/imx_fec.h"
+#include "hw/misc/imx_rngc.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "exec/memory.h"
@@ -50,6 +51,7 @@ typedef struct FslIMX25State {
     IMXGPTState    gpt[FSL_IMX25_NUM_GPTS];
     IMXEPITState   epit[FSL_IMX25_NUM_EPITS];
     IMXFECState    fec;
+    IMXRNGCState   rngc;
     IMXI2CState    i2c[FSL_IMX25_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
     MemoryRegion   rom[2];
@@ -211,6 +213,8 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO4_SIZE    0x4000
 #define FSL_IMX25_GPIO3_ADDR    0x53FA4000
 #define FSL_IMX25_GPIO3_SIZE    0x4000
+#define FSL_IMX25_RNGC_ADDR     0x53FB0000
+#define FSL_IMX25_RNGC_SIZE     0x4000
 #define FSL_IMX25_GPIO1_ADDR    0x53FCC000
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
@@ -238,6 +242,7 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_EPIT1_IRQ     28
 #define FSL_IMX25_EPIT2_IRQ     27
 #define FSL_IMX25_FEC_IRQ       57
+#define FSL_IMX25_RNGC_IRQ      22
 #define FSL_IMX25_I2C1_IRQ      3
 #define FSL_IMX25_I2C2_IRQ      4
 #define FSL_IMX25_I2C3_IRQ      10
diff --git a/include/hw/misc/imx_rngc.h b/include/hw/misc/imx_rngc.h
new file mode 100644
index 00000000000..f0d2b44d4f6
--- /dev/null
+++ b/include/hw/misc/imx_rngc.h
@@ -0,0 +1,35 @@
+/*
+ * Freescale i.MX RNGC emulation
+ *
+ * Copyright (C) 2020 Martin Kaiser <martin@kaiser.cx>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef IMX_RNGC_H
+#define IMX_RNGC_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_IMX_RNGC "imx.rngc"
+#define IMX_RNGC(obj) OBJECT_CHECK(IMXRNGCState, (obj), TYPE_IMX_RNGC)
+
+typedef struct IMXRNGCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion  iomem;
+
+    uint8_t op_self_test;
+    uint8_t op_seed;
+    uint8_t mask;
+    bool    auto_seed;
+
+    QEMUBH *self_test_bh;
+    QEMUBH *seed_bh;
+    qemu_irq irq;
+} IMXRNGCState;
+
+#endif /* IMX_RNGC_H */
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 3cb5a8fdfd7..da3471b3953 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -62,6 +62,9 @@ static void fsl_imx25_init(Object *obj)
 
     sysbus_init_child_obj(obj, "fec", &s->fec, sizeof(s->fec), TYPE_IMX_FEC);
 
+    sysbus_init_child_obj(obj, "rngc", &s->rngc, sizeof(s->rngc),
+                          TYPE_IMX_RNGC);
+
     for (i = 0; i < FSL_IMX25_NUM_I2CS; i++) {
         sysbus_init_child_obj(obj, "i2c[*]", &s->i2c[i], sizeof(s->i2c[i]),
                               TYPE_IMX_I2C);
@@ -188,6 +191,14 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fec), 0,
                        qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_FEC_IRQ));
 
+    object_property_set_bool(OBJECT(&s->rngc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rngc), 0, FSL_IMX25_RNGC_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rngc), 0,
+                       qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_RNGC_IRQ));
 
     /* Initialize all I2C */
     for (i = 0; i < FSL_IMX25_NUM_I2CS; i++) {
diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
new file mode 100644
index 00000000000..4c270df2db0
--- /dev/null
+++ b/hw/misc/imx_rngc.c
@@ -0,0 +1,278 @@
+/*
+ * Freescale i.MX RNGC emulation
+ *
+ * Copyright (C) 2020 Martin Kaiser <martin@kaiser.cx>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This driver provides the minimum functionality to initialize and seed
+ * an rngc and to read random numbers. The rngb that is found in imx25
+ * chipsets is also supported.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "qemu/guest-random.h"
+#include "hw/irq.h"
+#include "hw/misc/imx_rngc.h"
+#include "migration/vmstate.h"
+
+#define RNGC_NAME "i.MX RNGC"
+
+#define RNGC_VER_ID  0x00
+#define RNGC_COMMAND 0x04
+#define RNGC_CONTROL 0x08
+#define RNGC_STATUS  0x0C
+#define RNGC_FIFO    0x14
+
+/* These version info are reported by the rngb in an imx258 chip. */
+#define RNG_TYPE_RNGB 0x1
+#define V_MAJ 0x2
+#define V_MIN 0x40
+
+#define RNGC_CMD_BIT_SW_RST    0x40
+#define RNGC_CMD_BIT_CLR_ERR   0x20
+#define RNGC_CMD_BIT_CLR_INT   0x10
+#define RNGC_CMD_BIT_SEED      0x02
+#define RNGC_CMD_BIT_SELF_TEST 0x01
+
+#define RNGC_CTRL_BIT_MASK_ERR  0x40
+#define RNGC_CTRL_BIT_MASK_DONE 0x20
+#define RNGC_CTRL_BIT_AUTO_SEED 0x10
+
+/* the current status for self-test and seed operations */
+#define OP_IDLE 0
+#define OP_RUN  1
+#define OP_DONE 2
+
+static uint64_t imx_rngc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMXRNGCState *s = IMX_RNGC(opaque);
+    uint64_t val = 0;
+
+    switch (offset) {
+    case RNGC_VER_ID:
+        val |= RNG_TYPE_RNGB << 28 | V_MAJ << 8 | V_MIN;
+        break;
+
+    case RNGC_COMMAND:
+        if (s->op_seed == OP_RUN) {
+            val |= RNGC_CMD_BIT_SEED;
+        }
+        if (s->op_self_test == OP_RUN) {
+            val |= RNGC_CMD_BIT_SELF_TEST;
+        }
+        break;
+
+    case RNGC_CONTROL:
+        /*
+         * The CTL_ACC and VERIF_MODE bits are not supported yet.
+         * They read as 0.
+         */
+        val |= s->mask;
+        if (s->auto_seed) {
+            val |= RNGC_CTRL_BIT_AUTO_SEED;
+        }
+        /*
+         * We don't have an internal fifo like the real hardware.
+         * There's no need for strategy to handle fifo underflows.
+         * We return the FIFO_UFLOW_RESPONSE bits as 0.
+         */
+        break;
+
+    case RNGC_STATUS:
+        /*
+         * We never report any statistics test or self-test errors or any
+         * other errors. STAT_TEST_PF, ST_PF and ERROR are always 0.
+         */
+
+        /*
+         * We don't have an internal fifo, see above. Therefore, we
+         * report back the default fifo size (5 32-bit words) and
+         * indicate that our fifo is always full.
+         */
+        val |= 5 << 12 | 5 << 8;
+
+        /* We always have a new seed available. */
+        val |= 1 << 6;
+
+        if (s->op_seed == OP_DONE) {
+            val |= 1 << 5;
+        }
+        if (s->op_self_test == OP_DONE) {
+            val |= 1 << 4;
+        }
+        if (s->op_seed == OP_RUN || s->op_self_test == OP_RUN) {
+            /*
+             * We're busy if self-test is running or if we're
+             * seeding the prng.
+             */
+            val |= 1 << 1;
+        } else {
+            /*
+             * We're ready to provide secure random numbers whenever
+             * we're not busy.
+             */
+            val |= 1;
+        }
+        break;
+
+    case RNGC_FIFO:
+        qemu_guest_getrandom_nofail(&val, sizeof(val));
+        break;
+    }
+
+    return val;
+}
+
+static void imx_rngc_do_reset(IMXRNGCState *s)
+{
+    s->op_self_test = OP_IDLE;
+    s->op_seed = OP_IDLE;
+    s->mask = 0;
+    s->auto_seed = false;
+}
+
+static void imx_rngc_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    IMXRNGCState *s = IMX_RNGC(opaque);
+
+    switch (offset) {
+    case RNGC_COMMAND:
+        if (value & RNGC_CMD_BIT_SW_RST) {
+            imx_rngc_do_reset(s);
+        }
+
+        /*
+         * For now, both CLR_ERR and CLR_INT clear the interrupt. We
+         * don't report any errors yet.
+         */
+        if (value & (RNGC_CMD_BIT_CLR_ERR | RNGC_CMD_BIT_CLR_INT)) {
+            qemu_irq_lower(s->irq);
+        }
+
+        if (value & RNGC_CMD_BIT_SEED) {
+            s->op_seed = OP_RUN;
+            qemu_bh_schedule(s->seed_bh);
+        }
+
+        if (value & RNGC_CMD_BIT_SELF_TEST) {
+            s->op_self_test = OP_RUN;
+            qemu_bh_schedule(s->self_test_bh);
+        }
+        break;
+
+    case RNGC_CONTROL:
+        /*
+         * The CTL_ACC and VERIF_MODE bits are not supported yet.
+         * We ignore them if they're set by the caller.
+         */
+
+        if (value & RNGC_CTRL_BIT_MASK_ERR) {
+            s->mask |= RNGC_CTRL_BIT_MASK_ERR;
+        } else {
+            s->mask &= ~RNGC_CTRL_BIT_MASK_ERR;
+        }
+
+        if (value & RNGC_CTRL_BIT_MASK_DONE) {
+            s->mask |= RNGC_CTRL_BIT_MASK_DONE;
+        } else {
+            s->mask &= ~RNGC_CTRL_BIT_MASK_DONE;
+        }
+
+        if (value & RNGC_CTRL_BIT_AUTO_SEED) {
+            s->auto_seed = true;
+        } else {
+            s->auto_seed = false;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps imx_rngc_ops = {
+    .read  = imx_rngc_read,
+    .write = imx_rngc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void imx_rngc_self_test(void *opaque)
+{
+    IMXRNGCState *s = IMX_RNGC(opaque);
+
+    s->op_self_test = OP_DONE;
+    if (!(s->mask & RNGC_CTRL_BIT_MASK_DONE)) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void imx_rngc_seed(void *opaque)
+{
+    IMXRNGCState *s = IMX_RNGC(opaque);
+
+    s->op_seed = OP_DONE;
+    if (!(s->mask & RNGC_CTRL_BIT_MASK_DONE)) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void imx_rngc_realize(DeviceState *dev, Error **errp)
+{
+    IMXRNGCState *s = IMX_RNGC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &imx_rngc_ops, s,
+                          TYPE_IMX_RNGC, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    sysbus_init_irq(sbd, &s->irq);
+    s->self_test_bh = qemu_bh_new(imx_rngc_self_test, s);
+    s->seed_bh = qemu_bh_new(imx_rngc_seed, s);
+}
+
+static void imx_rngc_reset(DeviceState *dev)
+{
+    IMXRNGCState *s = IMX_RNGC(dev);
+
+    imx_rngc_do_reset(s);
+}
+
+static const VMStateDescription vmstate_imx_rngc = {
+    .name = RNGC_NAME,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(op_self_test, IMXRNGCState),
+        VMSTATE_UINT8(op_seed, IMXRNGCState),
+        VMSTATE_UINT8(mask, IMXRNGCState),
+        VMSTATE_BOOL(auto_seed, IMXRNGCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void imx_rngc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = imx_rngc_realize;
+    dc->reset = imx_rngc_reset;
+    dc->desc = RNGC_NAME,
+    dc->vmsd = &vmstate_imx_rngc;
+}
+
+static const TypeInfo imx_rngc_info = {
+    .name          = TYPE_IMX_RNGC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXRNGCState),
+    .class_init    = imx_rngc_class_init,
+};
+
+static void imx_rngc_register_types(void)
+{
+    type_register_static(&imx_rngc_info);
+}
+
+type_init(imx_rngc_register_types)
-- 
2.20.1


