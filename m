Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5CAC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEDE206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbK7cbx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEDE206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWUv-0000EX-EG
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTJ-0006nT-HW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTH-0004vM-Df
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTH-0004vF-68; Mon, 07 Oct 2019 13:06:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so16239438wrt.2;
 Mon, 07 Oct 2019 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jSz3lu3Ei18RQg3y4i6HEF7/UO7Edvfr6eCMaBljwiQ=;
 b=vbK7cbx6/RPzArOaurIS//EaiIvrmzYKTJCLh9oQX7UFr7mRFZuZEUoYeTrkkFWKgv
 To2M5d7dLoijsWY7KRiWjAVugZxuRuzSFplVnOyzHSgI/vnrk49Z/3YpgCVV5gZ3pgbQ
 z+nEylQggiHGcxz5xwsFOEi8UMz7BOk9vgMyYGW3DZkI3a0i8AyBDD9bUdWCdBI8eztc
 cOK7EylFzCNVbmh+T/WM43JYFgS2710dv121VoXG5eE6r5ssD++4SFy8qy1sTIe9SiVt
 1ojt4nn+7CKF+QAC0gJVcPisBmRmuluci+gLrNRM54f0AH5SF3HVnNbA0xFkq/no8qrF
 YSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jSz3lu3Ei18RQg3y4i6HEF7/UO7Edvfr6eCMaBljwiQ=;
 b=kXa4H2MHPr/rWVJGjpNWpGklnSHWrQeH91gycjfMCpaf4rQNEcHSCoTKI62IYvAffl
 ltPEj2XXyCVQ4kXvA0wY+ZALwZJlXyU+rynPXj7HmQocfDghiWZmcCprhMk3HQDkmo2r
 AQzGpch06mFj5M0b8t+4/TxfBgiJtlOmCx3sWI45FrqKcNmkGtWm2qtj8VqLv2Hqfq7g
 qLSqWlSgebI0jsB2m292OJoIdHPyzBIJG2DhG2OKTHpNPjZrkss7CbUOL54ztbPsVCkC
 dS3W0aUEIUaK3UhbTumgSHVeZ+EoVEHUGwCVSZPozrE9GboycZSEt+FayFoyenWU6oMv
 dhGg==
X-Gm-Message-State: APjAAAX2oaYUxiWO3r/YeqK/f1kIpV4TwDpfxhOdu+LZyUCOTLBG7Hi2
 JtAV6RGDzQ9Gof9+qzFTQvudRy5YFRE=
X-Google-Smtp-Source: APXvYqxIZW+9x27Hr0+z526pq8Eusoar7405rju4jDGwmSGm2/Bzsb97YgNYO9G9itXvVU9itFMvrw==
X-Received: by 2002:a5d:574f:: with SMTP id q15mr11769311wrw.362.1570468013802; 
 Mon, 07 Oct 2019 10:06:53 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id x5sm14036603wrt.75.2019.10.07.10.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 10:06:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/char/bcm2835_aux: Use the BCM2835 miniuart block
Date: Mon,  7 Oct 2019 19:06:45 +0200
Message-Id: <20191007170646.14961-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007170646.14961-1-f4bug@amsat.org>
References: <20191007170646.14961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the previous commit we extracted the miniuart block. Time to
use it. It is mapped at offset 0x40 in the AUX block, and uses
the first IRQ.

Due to incomplete Clock Tree support, Linux kernel fails at
initializing the UART clock and disable this block. For now Disable
this feature with the 'aux_enable_supported' variable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/bcm2835_aux.c         | 280 +++++++++-------------------------
 hw/char/trace-events          |   4 +
 include/hw/char/bcm2835_aux.h |  10 +-
 3 files changed, 83 insertions(+), 211 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 3f855196e3..a1ca9741d6 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -2,19 +2,10 @@
  * BCM2835 (Raspberry Pi / Pi 2) Aux block (mini UART and SPI).
  * Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
- * Based on pl011.c, copyright terms below:
- *
- * Arm PrimeCell PL011 UART
- *
- * Copyright (c) 2006 CodeSourcery.
- * Written by Paul Brook
  *
  * This code is licensed under the GPL.
  *
- * At present only the core UART functions (data path for tx/rx) are
- * implemented. The following features/registers are unimplemented:
- *  - Line/modem control
- *  - Scratch register
+ * The following features/registers are unimplemented:
  *  - Extra control
  *  - Baudrate
  *  - SPI interfaces
@@ -24,189 +15,77 @@
 #include "hw/char/bcm2835_aux.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
 
-#define AUX_IRQ         0x0
-#define AUX_ENABLES     0x4
-#define AUX_MU_IO_REG   0x40
-#define AUX_MU_IER_REG  0x44
-#define AUX_MU_IIR_REG  0x48
-#define AUX_MU_LCR_REG  0x4c
-#define AUX_MU_MCR_REG  0x50
-#define AUX_MU_LSR_REG  0x54
-#define AUX_MU_MSR_REG  0x58
-#define AUX_MU_SCRATCH  0x5c
-#define AUX_MU_CNTL_REG 0x60
-#define AUX_MU_STAT_REG 0x64
-#define AUX_MU_BAUD_REG 0x68
+REG32(AUX_IRQ,      0x00)
+REG32(AUX_ENABLE,   0x04)
 
-/* bits in IER/IIR registers */
-#define RX_INT  0x1
-#define TX_INT  0x2
+static const bool aux_enable_supported = false;
 
 static void bcm2835_aux_update(BCM2835AuxState *s)
 {
-    /* signal an interrupt if either:
-     * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
-     * 2. the tx interrupt is enabled (since we instantly drain the tx fifo)
-     */
-    s->iir = 0;
-    if ((s->ier & RX_INT) && s->read_count != 0) {
-        s->iir |= RX_INT;
-    }
-    if (s->ier & TX_INT) {
-        s->iir |= TX_INT;
-    }
-    qemu_set_irq(s->irq, s->iir != 0);
+    qemu_set_irq(s->irq, !!(s->reg[R_AUX_IRQ] & s->reg[R_AUX_ENABLE]));
+}
+
+static void bcm2835_aux_set_irq(void *opaque, int irq, int level)
+{
+    BCM2835AuxState *s = opaque;
+
+    s->reg[R_AUX_IRQ] = deposit32(s->reg[R_AUX_IRQ], irq, 1, !!level);
+
+    bcm2835_aux_update(s);
 }
 
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 {
-    BCM2835AuxState *s = opaque;
-    uint32_t c, res;
+    BCM2835AuxState *s = BCM2835_AUX(opaque);
+    uint32_t res = 0;
 
     switch (offset) {
-    case AUX_IRQ:
-        return s->iir != 0;
+    case A_AUX_IRQ:
+        res = s->reg[R_AUX_IRQ];
+        break;
 
-    case AUX_ENABLES:
-        return 1; /* mini UART permanently enabled */
-
-    case AUX_MU_IO_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        c = s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            if (++s->read_pos == BCM2835_AUX_RX_FIFO_LEN) {
-                s->read_pos = 0;
-            }
-        }
-        qemu_chr_fe_accept_input(&s->chr);
-        bcm2835_aux_update(s);
-        return c;
-
-    case AUX_MU_IER_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        return 0xc0 | s->ier; /* FIFO enables always read 1 */
-
-    case AUX_MU_IIR_REG:
-        res = 0xc0; /* FIFO enables */
-        /* The spec is unclear on what happens when both tx and rx
-         * interrupts are active, besides that this cannot occur. At
-         * present, we choose to prioritise the rx interrupt, since
-         * the tx fifo is always empty. */
-        if (s->read_count != 0) {
-            res |= 0x4;
-        } else {
-            res |= 0x2;
-        }
-        if (s->iir == 0) {
-            res |= 0x1;
-        }
-        return res;
-
-    case AUX_MU_LCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __func__);
-        return 0;
-
-    case AUX_MU_MCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n", __func__);
-        return 0;
-
-    case AUX_MU_LSR_REG:
-        res = 0x60; /* tx idle, empty */
-        if (s->read_count != 0) {
-            res |= 0x1;
-        }
-        return res;
-
-    case AUX_MU_MSR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MSR_REG unsupported\n", __func__);
-        return 0;
-
-    case AUX_MU_SCRATCH:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n", __func__);
-        return 0;
-
-    case AUX_MU_CNTL_REG:
-        return 0x3; /* tx, rx enabled */
-
-    case AUX_MU_STAT_REG:
-        res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
-        if (s->read_count > 0) {
-            res |= 0x1; /* data in input buffer */
-            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
-            res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
-        }
-        return res;
-
-    case AUX_MU_BAUD_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __func__);
-        return 0;
+    case A_AUX_ENABLE:
+        res = s->reg[R_AUX_ENABLE];
+        break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
                       __func__, offset);
-        return 0;
+        break;
     }
+    trace_bcm2835_aux_read(offset, res);
+
+    return res;
 }
 
 static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
-    BCM2835AuxState *s = opaque;
-    unsigned char ch;
+    BCM2835AuxState *s = BCM2835_AUX(opaque);
 
+    trace_bcm2835_aux_write(offset, value);
     switch (offset) {
-    case AUX_ENABLES:
-        if (value != 1) {
-            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI "
-                          "or disable UART\n", __func__);
+    case A_AUX_ENABLE:
+        if (value <= 1) {
+            if (aux_enable_supported) {
+                memory_region_set_enabled(
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0),
+                        value);
+            }
+        } else {
+            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI:"
+                                     " 0x%"PRIx64"\n",
+                          __func__, value);
         }
         break;
 
-    case AUX_MU_IO_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        ch = value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        break;
-
-    case AUX_MU_IER_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        s->ier = value & (TX_INT | RX_INT);
-        bcm2835_aux_update(s);
-        break;
-
-    case AUX_MU_IIR_REG:
-        if (value & 0x2) {
-            s->read_count = 0;
-        }
-        break;
-
-    case AUX_MU_LCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __func__);
-        break;
-
-    case AUX_MU_MCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n", __func__);
-        break;
-
-    case AUX_MU_SCRATCH:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n", __func__);
-        break;
-
-    case AUX_MU_CNTL_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_CNTL_REG unsupported\n", __func__);
-        break;
-
-    case AUX_MU_BAUD_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __func__);
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
                       __func__, offset);
@@ -215,35 +94,6 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
     bcm2835_aux_update(s);
 }
 
-static int bcm2835_aux_can_receive(void *opaque)
-{
-    BCM2835AuxState *s = opaque;
-
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
-}
-
-static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
-{
-    BCM2835AuxState *s = opaque;
-    int slot;
-
-    slot = s->read_pos + s->read_count;
-    if (slot >= BCM2835_AUX_RX_FIFO_LEN) {
-        slot -= BCM2835_AUX_RX_FIFO_LEN;
-    }
-    s->read_fifo[slot] = value;
-    s->read_count++;
-    if (s->read_count == BCM2835_AUX_RX_FIFO_LEN) {
-        /* buffer full */
-    }
-    bcm2835_aux_update(s);
-}
-
-static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
-{
-    bcm2835_aux_put_fifo(opaque, *buf);
-}
-
 static const MemoryRegionOps bcm2835_aux_ops = {
     .read = bcm2835_aux_read,
     .write = bcm2835_aux_write,
@@ -254,15 +104,9 @@ static const MemoryRegionOps bcm2835_aux_ops = {
 
 static const VMStateDescription vmstate_bcm2835_aux = {
     .name = TYPE_BCM2835_AUX,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835AuxState,
-                            BCM2835_AUX_RX_FIFO_LEN),
-        VMSTATE_UINT8(read_pos, BCM2835AuxState),
-        VMSTATE_UINT8(read_count, BCM2835AuxState),
-        VMSTATE_UINT8(ier, BCM2835AuxState),
-        VMSTATE_UINT8(iir, BCM2835AuxState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -276,18 +120,45 @@ static void bcm2835_aux_init(Object *obj)
                           TYPE_BCM2835_AUX, 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+
+    qdev_init_gpio_in_named(DEVICE(obj), bcm2835_aux_set_irq, "aux-irq", 3);
+
+    sysbus_init_child_obj(obj, "miniuart", &s->uart, sizeof(s->uart),
+                          TYPE_BCM2835_MINIUART);
+    object_property_add_alias(obj, "chardev", OBJECT(&s->uart), "chardev",
+                              &error_abort);
 }
 
 static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
 {
     BCM2835AuxState *s = BCM2835_AUX(dev);
+    Error *err = NULL;
 
-    qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
-                             bcm2835_aux_receive, NULL, NULL, s, NULL, true);
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->iomem, 0x40,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
+                qdev_get_gpio_in_named(dev, "aux-irq", 0));
+}
+
+static void bcm2835_aux_reset(DeviceState *dev)
+{
+    BCM2835AuxState *s = BCM2835_AUX(dev);
+
+    s->reg[R_AUX_IRQ] = s->reg[R_AUX_ENABLE] = 0;
+
+    if (aux_enable_supported) {
+        memory_region_set_enabled(
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0),
+                    false);
+    }
 }
 
 static Property bcm2835_aux_props[] = {
-    DEFINE_PROP_CHR("chardev", BCM2835AuxState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -296,8 +167,9 @@ static void bcm2835_aux_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = bcm2835_aux_realize;
+    dc->reset = bcm2835_aux_reset;
     dc->vmsd = &vmstate_bcm2835_aux;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = bcm2835_aux_props;
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index f1e6dd9918..0c86a907df 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# bcm2835_aux.c
+bcm2835_aux_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+bcm2835_aux_write(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+
 # bcm2835_miniuart.c
 bcm2835_miniuart_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
 bcm2835_miniuart_write(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.h
index cdbf7e3e37..a7b3a6ac60 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,25 +9,21 @@
 #define BCM2835_AUX_H
 
 #include "hw/sysbus.h"
-#include "chardev/char-fe.h"
+#include "hw/char/bcm2835_miniuart.h"
 
 #define TYPE_BCM2835_AUX "bcm2835-aux"
 #define BCM2835_AUX(obj) OBJECT_CHECK(BCM2835AuxState, (obj), TYPE_BCM2835_AUX)
 
-#define BCM2835_AUX_RX_FIFO_LEN 8
-
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
 
     MemoryRegion iomem;
-    CharBackend chr;
     qemu_irq irq;
 
-    uint8_t read_fifo[BCM2835_AUX_RX_FIFO_LEN];
-    uint8_t read_pos, read_count;
-    uint8_t ier, iir;
+    uint32_t reg[2];
+    BCM2835MiniUartState uart;
 } BCM2835AuxState;
 
 #endif
-- 
2.21.0


