Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864FDC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB3C21D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB3C21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iztAP-0008Ij-Db
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvp-0006Te-MH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvj-0001Mm-NK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:45 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53171 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvj-00019s-4I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 91DBA1A2134;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1A02F1A20F5;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 19/32] hw/char: avr: Add limited support for USART
 peripheral
Date: Fri,  7 Feb 2020 02:57:47 +0100
Message-Id: <1581040680-308-20-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[rth: Squash I/O size fix and file rename from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 include/hw/char/avr_usart.h |  93 +++++++++++++
 hw/char/avr_usart.c         | 320 ++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS                 |  10 ++
 hw/char/Kconfig             |   3 +
 hw/char/Makefile.objs       |   1 +
 5 files changed, 427 insertions(+)
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 hw/char/avr_usart.c

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
new file mode 100644
index 0000000..5739aaf
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
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
new file mode 100644
index 0000000..fbe2a11
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
+    AVRUsartState *usart =3D opaque;
+
+    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
+        return 0;
+    }
+    return 1;
+}
+
+static void avr_usart_receive(void *opaque, const uint8_t *buffer, int s=
ize)
+{
+    AVRUsartState *usart =3D opaque;
+    assert(size =3D=3D 1);
+    assert(!usart->data_valid);
+    usart->data =3D buffer[0];
+    usart->data_valid =3D true;
+    usart->csra |=3D USART_CSRA_RXC;
+    if (usart->csrb & USART_CSRB_RXCIE) {
+        qemu_set_irq(usart->rxc_irq, 1);
+    }
+}
+
+static void update_char_mask(AVRUsartState *usart)
+{
+    uint8_t mode =3D ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
+        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
+        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
+    switch (mode) {
+    case 0:
+        usart->char_mask =3D 0b11111;
+        break;
+    case 1:
+        usart->char_mask =3D 0b111111;
+        break;
+    case 2:
+        usart->char_mask =3D 0b1111111;
+        break;
+    case 3:
+        usart->char_mask =3D 0b11111111;
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
+            "%s: Nine bit character size not supported (forcing eight)\n=
",
+            __func__);
+        usart->char_mask =3D 0b11111111;
+        break;
+    default:
+        assert(0);
+    }
+}
+
+static void avr_usart_reset(DeviceState *dev)
+{
+    AVRUsartState *usart =3D AVR_USART(dev);
+    usart->data_valid =3D false;
+    usart->csra =3D 0b00100000;
+    usart->csrb =3D 0b00000000;
+    usart->csrc =3D 0b00000110;
+    usart->brrl =3D 0;
+    usart->brrh =3D 0;
+    update_char_mask(usart);
+    qemu_set_irq(usart->rxc_irq, 0);
+    qemu_set_irq(usart->txc_irq, 0);
+    qemu_set_irq(usart->dre_irq, 0);
+}
+
+static uint64_t avr_usart_read(void *opaque, hwaddr addr, unsigned int s=
ize)
+{
+    AVRUsartState *usart =3D opaque;
+    uint8_t data;
+    assert(size =3D=3D 1);
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
+            data =3D usart->data & usart->char_mask;
+            usart->data_valid =3D false;
+        } else {
+            data =3D 0;
+        }
+        usart->csra &=3D 0xff ^ USART_CSRA_RXC;
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
+    AVRUsartState *usart =3D opaque;
+    uint8_t mask;
+    uint8_t data;
+    assert((value & 0xff) =3D=3D value);
+    assert(size =3D=3D 1);
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
+        usart->csra |=3D USART_CSRA_TXC;
+        usart->csra |=3D USART_CSRA_DRE;
+        if (usart->csrb & USART_CSRB_TXCIE) {
+            qemu_set_irq(usart->txc_irq, 1);
+            usart->csra &=3D 0xff ^ USART_CSRA_TXC;
+        }
+        if (usart->csrb & USART_CSRB_DREIE) {
+            qemu_set_irq(usart->dre_irq, 1);
+        }
+        data =3D value;
+        qemu_chr_fe_write_all(&usart->chr, &data, 1);
+        break;
+    case USART_CSRA:
+        mask =3D 0b01000011;
+        /* Mask read-only bits. */
+        value =3D (value & mask) | (usart->csra & (0xff ^ mask));
+        usart->csra =3D value;
+        if (value & USART_CSRA_TXC) {
+            usart->csra ^=3D USART_CSRA_TXC;
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
+        mask =3D 0b11111101;
+        /* Mask read-only bits. */
+        value =3D (value & mask) | (usart->csrb & (0xff ^ mask));
+        usart->csrb =3D value;
+        if (!(value & USART_CSRB_RXEN)) {
+            /* Receiver disabled, flush input buffer. */
+            usart->data_valid =3D false;
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
+        usart->csrc =3D value;
+        if ((value & USART_CSRC_MSEL1) && (value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: SPI mode not supported by USART\n",
+                __func__);
+        }
+        if ((value & USART_CSRC_MSEL1) && !(value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART mode\n", __fun=
c__);
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
+        usart->brrl =3D value;
+        break;
+    case USART_BRRH:
+        usart->brrh =3D value & 0b00001111;
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
+static const MemoryRegionOps avr_usart_ops =3D {
+    .read =3D avr_usart_read,
+    .write =3D avr_usart_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {.min_access_size =3D 1, .max_access_size =3D 1}
+};
+
+static Property avr_usart_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void avr_usart_pr(void *opaque, int irq, int level)
+{
+    AVRUsartState *s =3D AVR_USART(opaque);
+
+    s->enabled =3D !level;
+
+    if (!s->enabled) {
+        avr_usart_reset(DEVICE(s));
+    }
+}
+
+static void avr_usart_init(Object *obj)
+{
+    AVRUsartState *s =3D AVR_USART(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USA=
RT, 7);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
+    s->enabled =3D true;
+}
+
+static void avr_usart_realize(DeviceState *dev, Error **errp)
+{
+    AVRUsartState *s =3D AVR_USART(dev);
+    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
+                             avr_usart_receive, NULL, NULL,
+                             s, NULL, true);
+    avr_usart_reset(dev);
+}
+
+static void avr_usart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D avr_usart_reset;
+    device_class_set_props(dc, avr_usart_properties);
+    dc->realize =3D avr_usart_realize;
+}
+
+static const TypeInfo avr_usart_info =3D {
+    .name          =3D TYPE_AVR_USART,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AVRUsartState),
+    .instance_init =3D avr_usart_init,
+    .class_init    =3D avr_usart_class_init,
+};
+
+static void avr_usart_register_types(void)
+{
+    type_register_static(&avr_usart_info);
+}
+
+type_init(avr_usart_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index b7887e7..ffbb98c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,6 +905,16 @@ F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
=20
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
index 40e7a8b..331b209 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -46,3 +46,6 @@ config SCLPCONSOLE
=20
 config TERMINAL3270
     bool
+
+config AVR_USART
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 9e9a6c1..7a4539d 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -20,6 +20,7 @@ common-obj-$(CONFIG_SH4) +=3D sh_serial.o
 common-obj-$(CONFIG_DIGIC) +=3D digic-uart.o
 common-obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
 common-obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
+common-obj-$(CONFIG_AVR_USART) +=3D avr_usart.o
=20
 common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
--=20
2.7.4


