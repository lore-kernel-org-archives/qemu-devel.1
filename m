Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B9C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084C0222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084C0222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iztCC-0003VB-2U
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvq-0006VJ-7v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvj-0001Kw-0n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:46 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53113 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvi-000199-Gf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8D02C1A2112;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 27E121A20F2;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 20/32] hw/timer: avr: Add limited support for 16-bit timer
 peripheral
Date: Fri,  7 Feb 2020 02:57:48 +0100
Message-Id: <1581040680-308-21-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ed Robbins <E.J.C.Robbins@kent.ac.uk>,
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
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Ed Robbins <E.J.C.Robbins@kent.ac.uk>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[rth: Squash info mtree fixes and a file rename from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 include/hw/timer/avr_timer16.h |  94 +++++++
 hw/timer/avr_timer16.c         | 609 +++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS                    |   2 +
 hw/timer/Kconfig               |   3 +
 hw/timer/Makefile.objs         |   2 +
 hw/timer/trace-events          |  12 +
 6 files changed, 722 insertions(+)
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 hw/timer/avr_timer16.c

diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/avr_timer1=
6.h
new file mode 100644
index 0000000..982019d
--- /dev/null
+++ b/include/hw/timer/avr_timer16.h
@@ -0,0 +1,94 @@
+/*
+ * AVR 16-bit timer
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Ed Robbins
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
+/*
+ * Driver for 16 bit timers on 8 bit AVR devices.
+ * Note:
+ * On ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 1=
6 bit
+ */
+
+#ifndef HW_TIMER_AVR_TIMER16_H
+#define HW_TIMER_AVR_TIMER16_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "hw/hw.h"
+
+enum NextInterrupt {
+    OVERFLOW,
+    COMPA,
+    COMPB,
+    COMPC,
+    CAPT
+};
+
+#define TYPE_AVR_TIMER16 "avr-timer16"
+#define AVR_TIMER16(obj) \
+    OBJECT_CHECK(AVRTimer16State, (obj), TYPE_AVR_TIMER16)
+
+typedef struct AVRTimer16State {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    MemoryRegion imsk_iomem;
+    MemoryRegion ifr_iomem;
+    QEMUTimer *timer;
+    qemu_irq capt_irq;
+    qemu_irq compa_irq;
+    qemu_irq compb_irq;
+    qemu_irq compc_irq;
+    qemu_irq ovf_irq;
+
+    bool enabled;
+
+    /* registers */
+    uint8_t cra;
+    uint8_t crb;
+    uint8_t crc;
+    uint8_t cntl;
+    uint8_t cnth;
+    uint8_t icrl;
+    uint8_t icrh;
+    uint8_t ocral;
+    uint8_t ocrah;
+    uint8_t ocrbl;
+    uint8_t ocrbh;
+    uint8_t ocrcl;
+    uint8_t ocrch;
+    /*
+     * Reads and writes to CNT and ICR utilise a bizarre temporary
+     * register, which we emulate
+     */
+    uint8_t rtmp;
+    uint8_t imsk;
+    uint8_t ifr;
+
+    uint8_t id;
+    uint64_t cpu_freq_hz;
+    uint64_t freq_hz;
+    uint64_t period_ns;
+    uint64_t reset_time_ns;
+    enum NextInterrupt next_interrupt;
+} AVRTimer16State;
+
+#endif /* HW_TIMER_AVR_TIMER16_H */
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
new file mode 100644
index 0000000..073f36a
--- /dev/null
+++ b/hw/timer/avr_timer16.c
@@ -0,0 +1,609 @@
+/*
+ * AVR 16-bit timer
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Ed Robbins
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
+/*
+ * Driver for 16 bit timers on 8 bit AVR devices.
+ * Note:
+ * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 b=
it
+ */
+
+/*
+ * XXX TODO: Power Reduction Register support
+ *           prescaler pause support
+ *           PWM modes, GPIO, output capture pins, input compare pin
+ */
+
+#include "qemu/osdep.h"
+#include "hw/timer/avr_timer16.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+/* Register offsets */
+#define T16_CRA     0x0
+#define T16_CRB     0x1
+#define T16_CRC     0x2
+#define T16_CNTL    0x4
+#define T16_CNTH    0x5
+#define T16_ICRL    0x6
+#define T16_ICRH    0x7
+#define T16_OCRAL   0x8
+#define T16_OCRAH   0x9
+#define T16_OCRBL   0xa
+#define T16_OCRBH   0xb
+#define T16_OCRCL   0xc
+#define T16_OCRCH   0xd
+
+/* Field masks */
+#define T16_CRA_WGM01   0x3
+#define T16_CRA_COMC    0xc
+#define T16_CRA_COMB    0x30
+#define T16_CRA_COMA    0xc0
+#define T16_CRA_OC_CONF \
+    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
+
+#define T16_CRB_CS      0x7
+#define T16_CRB_WGM23   0x18
+#define T16_CRB_ICES    0x40
+#define T16_CRB_ICNC    0x80
+
+#define T16_CRC_FOCC    0x20
+#define T16_CRC_FOCB    0x40
+#define T16_CRC_FOCA    0x80
+
+/* Fields masks both TIMSK and TIFR (interrupt mask/flag registers) */
+#define T16_INT_TOV    0x1 /* Timer overflow */
+#define T16_INT_OCA    0x2 /* Output compare A */
+#define T16_INT_OCB    0x4 /* Output compare B */
+#define T16_INT_OCC    0x8 /* Output compare C */
+#define T16_INT_IC     0x20 /* Input capture */
+
+/* Clock source values */
+#define T16_CLKSRC_STOPPED     0
+#define T16_CLKSRC_DIV1        1
+#define T16_CLKSRC_DIV8        2
+#define T16_CLKSRC_DIV64       3
+#define T16_CLKSRC_DIV256      4
+#define T16_CLKSRC_DIV1024     5
+#define T16_CLKSRC_EXT_FALLING 6
+#define T16_CLKSRC_EXT_RISING  7
+
+/* Timer mode values (not including PWM modes) */
+#define T16_MODE_NORMAL     0
+#define T16_MODE_CTC_OCRA   4
+#define T16_MODE_CTC_ICR    12
+
+/* Accessors */
+#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
+#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
+                     (t16->cra & T16_CRA_WGM01))
+#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
+#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
+#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
+#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
+#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
+
+/* Helper macros */
+#define VAL16(l, h) ((h << 8) | l)
+#define DB_PRINT(fmt, args...) /* Nothing */
+
+static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16, int6=
4_t t)
+{
+    if (t16->period_ns =3D=3D 0) {
+        return 0;
+    }
+    return t / t16->period_ns;
+}
+
+static void avr_timer16_update_cnt(AVRTimer16State *t16)
+{
+    uint16_t cnt;
+    cnt =3D avr_timer16_ns_to_ticks(t16, qemu_clock_get_ns(QEMU_CLOCK_VI=
RTUAL) -
+                                       t16->reset_time_ns);
+    t16->cntl =3D (uint8_t)(cnt & 0xff);
+    t16->cnth =3D (uint8_t)((cnt & 0xff00) >> 8);
+}
+
+static inline void avr_timer16_recalc_reset_time(AVRTimer16State *t16)
+{
+    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
+                         CNT(t16) * t16->period_ns;
+}
+
+static void avr_timer16_clock_reset(AVRTimer16State *t16)
+{
+    t16->cntl =3D 0;
+    t16->cnth =3D 0;
+    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void avr_timer16_clksrc_update(AVRTimer16State *t16)
+{
+    uint16_t divider =3D 0;
+    switch (CLKSRC(t16)) {
+    case T16_CLKSRC_EXT_FALLING:
+    case T16_CLKSRC_EXT_RISING:
+        qemu_log_mask(LOG_UNIMP, "%s: external clock source unsupported\=
n",
+                      __func__);
+        break;
+    case T16_CLKSRC_STOPPED:
+        break;
+    case T16_CLKSRC_DIV1:
+        divider =3D 1;
+        break;
+    case T16_CLKSRC_DIV8:
+        divider =3D 8;
+        break;
+    case T16_CLKSRC_DIV64:
+        divider =3D 64;
+        break;
+    case T16_CLKSRC_DIV256:
+        divider =3D 256;
+        break;
+    case T16_CLKSRC_DIV1024:
+        divider =3D 1024;
+        break;
+    default:
+        break;
+    }
+    if (divider) {
+        t16->freq_hz =3D t16->cpu_freq_hz / divider;
+        t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
+        trace_avr_timer16_clksrc_update(t16->freq_hz, t16->period_ns,
+                                        (uint64_t)(1e6 / t16->freq_hz));
+    }
+}
+
+static void avr_timer16_set_alarm(AVRTimer16State *t16)
+{
+    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
+        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
+        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
+        /* Timer is disabled or set to external clock source (unsupporte=
d) */
+        return;
+    }
+
+    uint64_t alarm_offset =3D 0xffff;
+    enum NextInterrupt next_interrupt =3D OVERFLOW;
+
+    switch (MODE(t16)) {
+    case T16_MODE_NORMAL:
+        /* Normal mode */
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
+            (t16->imsk & T16_INT_OCA)) {
+            alarm_offset =3D OCRA(t16);
+            next_interrupt =3D COMPA;
+        }
+        break;
+    case T16_MODE_CTC_OCRA:
+        /* CTC mode, top =3D ocra */
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
+            alarm_offset =3D OCRA(t16);
+            next_interrupt =3D COMPA;
+        }
+       break;
+    case T16_MODE_CTC_ICR:
+        /* CTC mode, top =3D icr */
+        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
+            alarm_offset =3D ICR(t16);
+            next_interrupt =3D CAPT;
+        }
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
+            (t16->imsk & T16_INT_OCA)) {
+            alarm_offset =3D OCRA(t16);
+            next_interrupt =3D COMPA;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: pwm modes are unsupported\n",
+                      __func__);
+        return;
+    }
+    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
+        (t16->imsk & T16_INT_OCB)) {
+        alarm_offset =3D OCRB(t16);
+        next_interrupt =3D COMPB;
+    }
+    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
+        (t16->imsk & T16_INT_OCC)) {
+        alarm_offset =3D OCRB(t16);
+        next_interrupt =3D COMPC;
+    }
+    alarm_offset -=3D CNT(t16);
+
+    t16->next_interrupt =3D next_interrupt;
+    uint64_t alarm_ns =3D
+        t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns=
);
+    timer_mod(t16->timer, alarm_ns);
+
+    trace_avr_timer16_next_alarm(alarm_offset * t16->period_ns);
+}
+
+static void avr_timer16_interrupt(void *opaque)
+{
+    AVRTimer16State *t16 =3D opaque;
+    uint8_t mode =3D MODE(t16);
+
+    avr_timer16_update_cnt(t16);
+
+    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
+        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
+        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
+        /* Timer is disabled or set to external clock source (unsupporte=
d) */
+        return;
+    }
+
+    trace_avr_timer16_interrupt_count(CNT(t16));
+
+    /* Counter overflow */
+    if (t16->next_interrupt =3D=3D OVERFLOW) {
+        trace_avr_timer16_interrupt_overflow("counter 0xffff");
+        avr_timer16_clock_reset(t16);
+        if (t16->imsk & T16_INT_TOV) {
+            t16->ifr |=3D T16_INT_TOV;
+            qemu_set_irq(t16->ovf_irq, 1);
+        }
+    }
+    /* Check for ocra overflow in CTC mode */
+    if (mode =3D=3D T16_MODE_CTC_OCRA && t16->next_interrupt =3D=3D COMP=
A) {
+        trace_avr_timer16_interrupt_overflow("CTC OCRA");
+        avr_timer16_clock_reset(t16);
+    }
+    /* Check for icr overflow in CTC mode */
+    if (mode =3D=3D T16_MODE_CTC_ICR && t16->next_interrupt =3D=3D CAPT)=
 {
+        trace_avr_timer16_interrupt_overflow("CTC ICR");
+        avr_timer16_clock_reset(t16);
+        if (t16->imsk & T16_INT_IC) {
+            t16->ifr |=3D T16_INT_IC;
+            qemu_set_irq(t16->capt_irq, 1);
+        }
+    }
+    /* Check for output compare interrupts */
+    if (t16->imsk & T16_INT_OCA && t16->next_interrupt =3D=3D COMPA) {
+        t16->ifr |=3D T16_INT_OCA;
+        qemu_set_irq(t16->compa_irq, 1);
+    }
+    if (t16->imsk & T16_INT_OCB && t16->next_interrupt =3D=3D COMPB) {
+        t16->ifr |=3D T16_INT_OCB;
+        qemu_set_irq(t16->compb_irq, 1);
+    }
+    if (t16->imsk & T16_INT_OCC && t16->next_interrupt =3D=3D COMPC) {
+        t16->ifr |=3D T16_INT_OCC;
+        qemu_set_irq(t16->compc_irq, 1);
+    }
+    avr_timer16_set_alarm(t16);
+}
+
+static void avr_timer16_reset(DeviceState *dev)
+{
+    AVRTimer16State *t16 =3D AVR_TIMER16(dev);
+
+    avr_timer16_clock_reset(t16);
+    avr_timer16_clksrc_update(t16);
+    avr_timer16_set_alarm(t16);
+
+    qemu_set_irq(t16->capt_irq, 0);
+    qemu_set_irq(t16->compa_irq, 0);
+    qemu_set_irq(t16->compb_irq, 0);
+    qemu_set_irq(t16->compc_irq, 0);
+    qemu_set_irq(t16->ovf_irq, 0);
+}
+
+static uint64_t avr_timer16_read(void *opaque, hwaddr offset, unsigned s=
ize)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    uint8_t retval =3D 0;
+
+    switch (offset) {
+    case T16_CRA:
+        retval =3D t16->cra;
+        break;
+    case T16_CRB:
+        retval =3D t16->crb;
+        break;
+    case T16_CRC:
+        retval =3D t16->crc;
+        break;
+    case T16_CNTL:
+        avr_timer16_update_cnt(t16);
+        t16->rtmp =3D t16->cnth;
+        retval =3D t16->cntl;
+        break;
+    case T16_CNTH:
+        retval =3D t16->rtmp;
+        break;
+    case T16_ICRL:
+        /*
+         * The timer copies cnt to icr when the input capture pin change=
s
+         * state or when the analog comparator has a match. We don't
+         * emulate this behaviour. We do support it's use for defining a
+         * TOP value in T16_MODE_CTC_ICR
+         */
+        t16->rtmp =3D t16->icrh;
+        retval =3D t16->icrl;
+        break;
+    case T16_ICRH:
+        retval =3D t16->rtmp;
+        break;
+    case T16_OCRAL:
+        retval =3D t16->ocral;
+        break;
+    case T16_OCRAH:
+        retval =3D t16->ocrah;
+        break;
+    case T16_OCRBL:
+        retval =3D t16->ocrbl;
+        break;
+    case T16_OCRBH:
+        retval =3D t16->ocrbh;
+        break;
+    case T16_OCRCL:
+        retval =3D t16->ocrcl;
+        break;
+    case T16_OCRCH:
+        retval =3D t16->ocrch;
+        break;
+    default:
+        break;
+    }
+    trace_avr_timer16_read(offset, retval);
+
+    return (uint64_t)retval;
+}
+
+static void avr_timer16_write(void *opaque, hwaddr offset,
+                              uint64_t val64, unsigned size)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    uint8_t val8 =3D (uint8_t)val64;
+    uint8_t prev_clk_src =3D CLKSRC(t16);
+
+    trace_avr_timer16_write(offset, val8);
+
+    switch (offset) {
+    case T16_CRA:
+        t16->cra =3D val8;
+        if (t16->cra & T16_CRA_OC_CONF) {
+            qemu_log_mask(LOG_UNIMP, "%s: output compare pins unsupporte=
d\n",
+                          __func__);
+        }
+        break;
+    case T16_CRB:
+        t16->crb =3D val8;
+        if (t16->crb & T16_CRB_ICNC) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: input capture noise canceller unsupported=
\n",
+                          __func__);
+        }
+        if (t16->crb & T16_CRB_ICES) {
+            qemu_log_mask(LOG_UNIMP, "%s: input capture unsupported\n",
+                          __func__);
+        }
+        if (CLKSRC(t16) !=3D prev_clk_src) {
+            avr_timer16_clksrc_update(t16);
+            if (prev_clk_src =3D=3D T16_CLKSRC_STOPPED) {
+                t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL);
+            }
+        }
+        break;
+    case T16_CRC:
+        t16->crc =3D val8;
+        qemu_log_mask(LOG_UNIMP, "%s: output compare pins unsupported\n"=
,
+                      __func__);
+        break;
+    case T16_CNTL:
+        /*
+         * CNT is the 16-bit counter value, it must be read/written via
+         * a temporary register (rtmp) to make the read/write atomic.
+         */
+        /* ICR also has this behaviour, and shares rtmp */
+        /*
+         * Writing CNT blocks compare matches for one clock cycle.
+         * Writing CNT to TOP or to an OCR value (if in use) will
+         * skip the relevant interrupt
+         */
+        t16->cntl =3D val8;
+        t16->cnth =3D t16->rtmp;
+        avr_timer16_recalc_reset_time(t16);
+        break;
+    case T16_CNTH:
+        t16->rtmp =3D val8;
+        break;
+    case T16_ICRL:
+        /* ICR can only be written in mode T16_MODE_CTC_ICR */
+        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
+            t16->icrl =3D val8;
+            t16->icrh =3D t16->rtmp;
+        }
+        break;
+    case T16_ICRH:
+        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
+            t16->rtmp =3D val8;
+        }
+        break;
+    case T16_OCRAL:
+        /*
+         * OCRn cause the relevant output compare flag to be raised, and
+         * trigger an interrupt, when CNT is equal to the value here
+         */
+        t16->ocral =3D val8;
+        break;
+    case T16_OCRAH:
+        t16->ocrah =3D val8;
+        break;
+    case T16_OCRBL:
+        t16->ocrbl =3D val8;
+        break;
+    case T16_OCRBH:
+        t16->ocrbh =3D val8;
+        break;
+    case T16_OCRCL:
+        t16->ocrcl =3D val8;
+        break;
+    case T16_OCRCH:
+        t16->ocrch =3D val8;
+        break;
+    default:
+        break;
+    }
+    avr_timer16_set_alarm(t16);
+}
+
+static uint64_t avr_timer16_imsk_read(void *opaque,
+                                      hwaddr offset,
+                                      unsigned size)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_read_imsk(offset ? 0 : t16->imsk);
+    if (offset !=3D 0) {
+        return 0;
+    }
+    return t16->imsk;
+}
+
+static void avr_timer16_imsk_write(void *opaque, hwaddr offset,
+                                   uint64_t val64, unsigned size)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_write_imsk(val64);
+    if (offset !=3D 0) {
+        return;
+    }
+    t16->imsk =3D (uint8_t)val64;
+}
+
+static uint64_t avr_timer16_ifr_read(void *opaque,
+                                     hwaddr offset,
+                                     unsigned size)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_read_ifr(offset ? 0 : t16->ifr);
+    if (offset !=3D 0) {
+        return 0;
+    }
+    return t16->ifr;
+}
+
+static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
+                                  uint64_t val64, unsigned size)
+{
+    assert(size =3D=3D 1);
+    AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_write_imsk(val64);
+    if (offset !=3D 0) {
+        return;
+    }
+    t16->ifr =3D (uint8_t)val64;
+}
+
+static const MemoryRegionOps avr_timer16_ops =3D {
+    .read =3D avr_timer16_read,
+    .write =3D avr_timer16_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {.max_access_size =3D 1}
+};
+
+static const MemoryRegionOps avr_timer16_imsk_ops =3D {
+    .read =3D avr_timer16_imsk_read,
+    .write =3D avr_timer16_imsk_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {.max_access_size =3D 1}
+};
+
+static const MemoryRegionOps avr_timer16_ifr_ops =3D {
+    .read =3D avr_timer16_ifr_read,
+    .write =3D avr_timer16_ifr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {.max_access_size =3D 1}
+};
+
+static Property avr_timer16_properties[] =3D {
+    DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
+    DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
+                       cpu_freq_hz, 20000000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void avr_timer16_pr(void *opaque, int irq, int level)
+{
+    AVRTimer16State *s =3D AVR_TIMER16(opaque);
+
+    s->enabled =3D !level;
+
+    if (!s->enabled) {
+        avr_timer16_reset(DEVICE(s));
+    }
+}
+
+static void avr_timer16_init(Object *obj)
+{
+    AVRTimer16State *s =3D AVR_TIMER16(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->capt_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compa_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compb_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compc_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ovf_irq);
+
+    memory_region_init_io(&s->iomem, obj, &avr_timer16_ops,
+                          s, "avr-timer16", 0xe);
+    memory_region_init_io(&s->imsk_iomem, obj, &avr_timer16_imsk_ops,
+                          s, "avr-timer16-intmask", 0x1);
+    memory_region_init_io(&s->ifr_iomem, obj, &avr_timer16_ifr_ops,
+                          s, "avr-timer16-intflag", 0x1);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->imsk_iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ifr_iomem);
+    qdev_init_gpio_in(DEVICE(s), avr_timer16_pr, 1);
+
+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, avr_timer16_interrupt,=
 s);
+    s->enabled =3D true;
+}
+
+static void avr_timer16_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D avr_timer16_reset;
+    device_class_set_props(dc, avr_timer16_properties);
+}
+
+static const TypeInfo avr_timer16_info =3D {
+    .name          =3D TYPE_AVR_TIMER16,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AVRTimer16State),
+    .instance_init =3D avr_timer16_init,
+    .class_init    =3D avr_timer16_class_init,
+};
+
+static void avr_timer16_register_types(void)
+{
+    type_register_static(&avr_timer16_info);
+}
+
+type_init(avr_timer16_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index ffbb98c..576038b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -914,6 +914,8 @@ R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
 F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
+F: include/hw/timer/avr_timer16.h
+F: hw/timer/avr_timer16.c
=20
 CRIS Machines
 -------------
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 59b3f44..2521056 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -35,3 +35,6 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config AVR_TIMER16
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index dece235..af0913c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-tim=
er.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
 common-obj-$(CONFIG_RASPI) +=3D bcm2835_systmr.o
+
+obj-$(CONFIG_AVR_TIMER16) +=3D avr_timer16.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 29fda78..5d9f4c9 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -74,3 +74,15 @@ nrf51_timer_write(uint64_t addr, uint32_t value, unsig=
ned size) "write addr 0x%"
 bcm2835_systmr_irq(bool enable) "timer irq state %u"
 bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset =
0x%" PRIx64 " data 0x%" PRIx64
 bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offse=
t 0x%" PRIx64 " data 0x%" PRIx64
+
+# avr_timer16.c
+avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u valu=
e:%u"
+avr_timer16_read_ifr(uint8_t value) "timer16 read addr:ifr value:%u"
+avr_timer16_read_imsk(uint8_t value) "timer16 read addr:imsk value:%u"
+avr_timer16_write(uint8_t addr, uint8_t value) "timer16 write addr:%u va=
lue:%u"
+avr_timer16_write_ifr(uint8_t value) "timer16 write addr:ifr value:%u"
+avr_timer16_write_imsk(uint8_t value) "timer16 write addr:imsk value:%u"
+avr_timer16_interrupt_count(uint8_t cnt) "count: %u"
+avr_timer16_interrupt_overflow(const char *reason) "overflow: %s"
+avr_timer16_next_alarm(uint64_t delay_ns) "next alarm: %" PRIu64 " ns fr=
om now"
+avr_timer16_clksrc_update(uint64_t freq_hz, uint64_t period_ns, uint64_t=
 delay_s) "timer frequency: %" PRIu64 " Hz, period: %" PRIu64 " ns (%" PR=
Id64 " us)"
--=20
2.7.4


