Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94254C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593DC20723
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593DC20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5V6-00029b-If
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FC-0007bZ-HX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:46 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FA-0008KQ-3m
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:46 -0400
Received: by mail-ed1-f46.google.com with SMTP id h28so32284397edz.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6+pMLn/ybvlcn7Bd1pPKE9LG0hVXLg6HtJS6RKgScRA=;
 b=tw/soqWR/LeKRY8cold/RXuUJucWs3TqCU1GzeibO1vOFaV6O/5J4Momg4DV565rLA
 lqWONAhxqbfPh67FfLCBn/zfjSrnUtOlip5qSPRiuNLKKuSiJOATCa8eDQbTN6fe+8SL
 sCyGob2XLirz0WwqRAE3XJH2UnnCTfGB+YYnPStySLgxFk/LpnaPwObmArp/Dro9iREe
 5KPQU8djAbkzNa+HR1e4YccFCNAZwGGAtsJtzMGdyVYwXcxjTpA1aqekeUvMwsyB+/gP
 lK9BwlLuULzkCT9M5HRegTAMAvazTPUgpDRPmknycbwLS3P8bXXZTXhRyNCEnj7YnInt
 Dl0Q==
X-Gm-Message-State: AOAM533iT1dxlBXWImcaehJrn8W976Q0FNw0BUPiX1Y2kd3mThd669wx
 r2YhwMelQNi/7Y9rJ4rNvJaKtg6K
X-Google-Smtp-Source: ABdhPJw70b59sGeiriPrhS11bt4D54OLX0+KJM/6FidyUJlCdLuE5bWmy7d4W9fJi2XarGvniy7hug==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id
 be28mr40903956edb.140.1593957822127; 
 Sun, 05 Jul 2020 07:03:42 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:41 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 19/30] hw/char: avr: Add limited support for USART
 peripheral
Date: Sun,  5 Jul 2020 16:03:04 +0200
Message-Id: <20200705140315.260514-20-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

These were designed to facilitate testing but should provide enough
function to be useful in other contexts.  Only a subset of the functions
of each peripheral is implemented, mainly due to the lack of a standard
way to handle electrical connections (like GPIO pins).

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash I/O size fix and file rename from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS                 |  10 ++
 hw/char/Kconfig             |   3 +
 hw/char/Makefile.objs       |   1 +
 hw/char/avr_usart.c         | 320 ++++++++++++++++++++++++++++++++++++
 include/hw/char/avr_usart.h |  93 +++++++++++
 5 files changed, 427 insertions(+)
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 include/hw/char/avr_usart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 11a0611b3e..8c0cc4fbc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,16 @@ F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 
+AVR Machines
+-------------
+
+AVR MCUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: include/hw/char/avr_usart.h
+F: hw/char/avr_usart.c
+
 CRIS Machines
 -------------
 Axis Dev88
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 874627520c..b7e0e4d5fa 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -49,3 +49,6 @@ config TERMINAL3270
 
 config RENESAS_SCI
     bool
+
+config AVR_USART
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 8306c4a789..bf177ac41d 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -22,6 +22,7 @@ common-obj-$(CONFIG_DIGIC) += digic-uart.o
 common-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 common-obj-$(CONFIG_RASPI) += bcm2835_aux.o
 common-obj-$(CONFIG_RENESAS_SCI) += renesas_sci.o
+common-obj-$(CONFIG_AVR_USART) += avr_usart.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
new file mode 100644
index 0000000000..fbe2a112b7
--- /dev/null
+++ b/hw/char/avr_usart.c
@@ -0,0 +1,320 @@
+/*
+ * AVR USART
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Sarah Harris
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/avr_usart.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+static int avr_usart_can_receive(void *opaque)
+{
+    AVRUsartState *usart = opaque;
+
+    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
+        return 0;
+    }
+    return 1;
+}
+
+static void avr_usart_receive(void *opaque, const uint8_t *buffer, int size)
+{
+    AVRUsartState *usart = opaque;
+    assert(size == 1);
+    assert(!usart->data_valid);
+    usart->data = buffer[0];
+    usart->data_valid = true;
+    usart->csra |= USART_CSRA_RXC;
+    if (usart->csrb & USART_CSRB_RXCIE) {
+        qemu_set_irq(usart->rxc_irq, 1);
+    }
+}
+
+static void update_char_mask(AVRUsartState *usart)
+{
+    uint8_t mode = ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
+        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
+        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
+    switch (mode) {
+    case 0:
+        usart->char_mask = 0b11111;
+        break;
+    case 1:
+        usart->char_mask = 0b111111;
+        break;
+    case 2:
+        usart->char_mask = 0b1111111;
+        break;
+    case 3:
+        usart->char_mask = 0b11111111;
+        break;
+    case 4:
+        /* Fallthrough. */
+    case 5:
+        /* Fallthrough. */
+    case 6:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Reserved character size 0x%x\n",
+            __func__,
+            mode);
+        break;
+    case 7:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Nine bit character size not supported (forcing eight)\n",
+            __func__);
+        usart->char_mask = 0b11111111;
+        break;
+    default:
+        assert(0);
+    }
+}
+
+static void avr_usart_reset(DeviceState *dev)
+{
+    AVRUsartState *usart = AVR_USART(dev);
+    usart->data_valid = false;
+    usart->csra = 0b00100000;
+    usart->csrb = 0b00000000;
+    usart->csrc = 0b00000110;
+    usart->brrl = 0;
+    usart->brrh = 0;
+    update_char_mask(usart);
+    qemu_set_irq(usart->rxc_irq, 0);
+    qemu_set_irq(usart->txc_irq, 0);
+    qemu_set_irq(usart->dre_irq, 0);
+}
+
+static uint64_t avr_usart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    AVRUsartState *usart = opaque;
+    uint8_t data;
+    assert(size == 1);
+
+    if (!usart->enabled) {
+        return 0;
+    }
+
+    switch (addr) {
+    case USART_DR:
+        if (!(usart->csrb & USART_CSRB_RXEN)) {
+            /* Receiver disabled, ignore. */
+            return 0;
+        }
+        if (usart->data_valid) {
+            data = usart->data & usart->char_mask;
+            usart->data_valid = false;
+        } else {
+            data = 0;
+        }
+        usart->csra &= 0xff ^ USART_CSRA_RXC;
+        qemu_set_irq(usart->rxc_irq, 0);
+        qemu_chr_fe_accept_input(&usart->chr);
+        return data;
+    case USART_CSRA:
+        return usart->csra;
+    case USART_CSRB:
+        return usart->csrb;
+    case USART_CSRC:
+        return usart->csrc;
+    case USART_BRRL:
+        return usart->brrl;
+    case USART_BRRH:
+        return usart->brrh;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+            __func__,
+            addr);
+    }
+    return 0;
+}
+
+static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
+                                unsigned int size)
+{
+    AVRUsartState *usart = opaque;
+    uint8_t mask;
+    uint8_t data;
+    assert((value & 0xff) == value);
+    assert(size == 1);
+
+    if (!usart->enabled) {
+        return;
+    }
+
+    switch (addr) {
+    case USART_DR:
+        if (!(usart->csrb & USART_CSRB_TXEN)) {
+            /* Transmitter disabled, ignore. */
+            return;
+        }
+        usart->csra |= USART_CSRA_TXC;
+        usart->csra |= USART_CSRA_DRE;
+        if (usart->csrb & USART_CSRB_TXCIE) {
+            qemu_set_irq(usart->txc_irq, 1);
+            usart->csra &= 0xff ^ USART_CSRA_TXC;
+        }
+        if (usart->csrb & USART_CSRB_DREIE) {
+            qemu_set_irq(usart->dre_irq, 1);
+        }
+        data = value;
+        qemu_chr_fe_write_all(&usart->chr, &data, 1);
+        break;
+    case USART_CSRA:
+        mask = 0b01000011;
+        /* Mask read-only bits. */
+        value = (value & mask) | (usart->csra & (0xff ^ mask));
+        usart->csra = value;
+        if (value & USART_CSRA_TXC) {
+            usart->csra ^= USART_CSRA_TXC;
+            qemu_set_irq(usart->txc_irq, 0);
+        }
+        if (value & USART_CSRA_MPCM) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: MPCM not supported by USART\n",
+                __func__);
+        }
+        break;
+    case USART_CSRB:
+        mask = 0b11111101;
+        /* Mask read-only bits. */
+        value = (value & mask) | (usart->csrb & (0xff ^ mask));
+        usart->csrb = value;
+        if (!(value & USART_CSRB_RXEN)) {
+            /* Receiver disabled, flush input buffer. */
+            usart->data_valid = false;
+        }
+        qemu_set_irq(usart->rxc_irq,
+            ((value & USART_CSRB_RXCIE) &&
+            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
+        qemu_set_irq(usart->txc_irq,
+            ((value & USART_CSRB_TXCIE) &&
+            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
+        qemu_set_irq(usart->dre_irq,
+            ((value & USART_CSRB_DREIE) &&
+            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
+        update_char_mask(usart);
+        break;
+    case USART_CSRC:
+        usart->csrc = value;
+        if ((value & USART_CSRC_MSEL1) && (value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: SPI mode not supported by USART\n",
+                __func__);
+        }
+        if ((value & USART_CSRC_MSEL1) && !(value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART mode\n", __func__);
+        }
+        if (!(value & USART_CSRC_PM1) && (value & USART_CSRC_PM0)) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: Bad USART parity mode\n",
+                __func__);
+        }
+        update_char_mask(usart);
+        break;
+    case USART_BRRL:
+        usart->brrl = value;
+        break;
+    case USART_BRRH:
+        usart->brrh = value & 0b00001111;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+            __func__,
+            addr);
+    }
+}
+
+static const MemoryRegionOps avr_usart_ops = {
+    .read = avr_usart_read,
+    .write = avr_usart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.min_access_size = 1, .max_access_size = 1}
+};
+
+static Property avr_usart_properties[] = {
+    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void avr_usart_pr(void *opaque, int irq, int level)
+{
+    AVRUsartState *s = AVR_USART(opaque);
+
+    s->enabled = !level;
+
+    if (!s->enabled) {
+        avr_usart_reset(DEVICE(s));
+    }
+}
+
+static void avr_usart_init(Object *obj)
+{
+    AVRUsartState *s = AVR_USART(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 7);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
+    s->enabled = true;
+}
+
+static void avr_usart_realize(DeviceState *dev, Error **errp)
+{
+    AVRUsartState *s = AVR_USART(dev);
+    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
+                             avr_usart_receive, NULL, NULL,
+                             s, NULL, true);
+    avr_usart_reset(dev);
+}
+
+static void avr_usart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_usart_reset;
+    device_class_set_props(dc, avr_usart_properties);
+    dc->realize = avr_usart_realize;
+}
+
+static const TypeInfo avr_usart_info = {
+    .name          = TYPE_AVR_USART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRUsartState),
+    .instance_init = avr_usart_init,
+    .class_init    = avr_usart_class_init,
+};
+
+static void avr_usart_register_types(void)
+{
+    type_register_static(&avr_usart_info);
+}
+
+type_init(avr_usart_register_types)
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
new file mode 100644
index 0000000000..5739aaf26f
--- /dev/null
+++ b/include/hw/char/avr_usart.h
@@ -0,0 +1,93 @@
+/*
+ * AVR USART
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Sarah Harris
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#ifndef HW_CHAR_AVR_USART_H
+#define HW_CHAR_AVR_USART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "hw/hw.h"
+
+/* Offsets of registers. */
+#define USART_DR   0x06
+#define USART_CSRA  0x00
+#define USART_CSRB  0x01
+#define USART_CSRC  0x02
+#define USART_BRRH 0x05
+#define USART_BRRL 0x04
+
+/* Relevant bits in regiters. */
+#define USART_CSRA_RXC    (1 << 7)
+#define USART_CSRA_TXC    (1 << 6)
+#define USART_CSRA_DRE    (1 << 5)
+#define USART_CSRA_MPCM   (1 << 0)
+
+#define USART_CSRB_RXCIE  (1 << 7)
+#define USART_CSRB_TXCIE  (1 << 6)
+#define USART_CSRB_DREIE  (1 << 5)
+#define USART_CSRB_RXEN   (1 << 4)
+#define USART_CSRB_TXEN   (1 << 3)
+#define USART_CSRB_CSZ2   (1 << 2)
+#define USART_CSRB_RXB8   (1 << 1)
+#define USART_CSRB_TXB8   (1 << 0)
+
+#define USART_CSRC_MSEL1  (1 << 7)
+#define USART_CSRC_MSEL0  (1 << 6)
+#define USART_CSRC_PM1    (1 << 5)
+#define USART_CSRC_PM0    (1 << 4)
+#define USART_CSRC_CSZ1   (1 << 2)
+#define USART_CSRC_CSZ0   (1 << 1)
+
+#define TYPE_AVR_USART "avr-usart"
+#define AVR_USART(obj) \
+    OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    CharBackend chr;
+
+    bool enabled;
+
+    uint8_t data;
+    bool data_valid;
+    uint8_t char_mask;
+    /* Control and Status Registers */
+    uint8_t csra;
+    uint8_t csrb;
+    uint8_t csrc;
+    /* Baud Rate Registers (low/high byte) */
+    uint8_t brrh;
+    uint8_t brrl;
+
+    /* Receive Complete */
+    qemu_irq rxc_irq;
+    /* Transmit Complete */
+    qemu_irq txc_irq;
+    /* Data Register Empty */
+    qemu_irq dre_irq;
+} AVRUsartState;
+
+#endif /* HW_CHAR_AVR_USART_H */
-- 
2.26.2


