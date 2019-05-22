Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD7AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AE520821
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AE520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSOo-0007Z0-HX
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:39:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSGA-0000E8-Q1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSG0-0007Wr-NL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:26 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:44415)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSFz-0007SB-Vj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:16 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail02.asahi-net.or.jp (Postfix) with ESMTPA id A3A013E8C6;
	Wed, 22 May 2019 23:30:09 +0900 (JST)
Received: from yo-satoh-debian.localdomain
	(v045049.dynamic.ppp.asahi-net.or.jp [124.155.45.49])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id DAB68240085; 
	Wed, 22 May 2019 23:30:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 23:29:52 +0900
Message-Id: <20190522142956.41916-9-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522142956.41916-1-ysato@users.sourceforge.jp>
References: <20190522142956.41916-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v15 08/12] hw/timer: RX62N internal timer
 modules
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

renesas_tmr: 8bit timer modules.
renesas_cmt: 16bit compare match timer modules.
This part use many renesas's CPU.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/timer/renesas_cmt.h |  44 ++++
 include/hw/timer/renesas_tmr.h |  50 +++++
 hw/timer/renesas_cmt.c         | 260 +++++++++++++++++++++++
 hw/timer/renesas_tmr.c         | 455 +++++++++++++++++++++++++++++++++++++++++
 hw/timer/Kconfig               |   6 +
 hw/timer/Makefile.objs         |   3 +
 6 files changed, 818 insertions(+)
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c

diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
new file mode 100644
index 0000000000..e5c071809a
--- /dev/null
+++ b/include/hw/timer/renesas_cmt.h
@@ -0,0 +1,44 @@
+/*
+ * Renesas Compare-match timer Object
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_CMT_H
+#define HW_RENESAS_CMT_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_CMT "renesas-cmt"
+#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
+
+enum {
+    CMT_CH = 2,
+};
+
+struct RCMTChannelState {
+    uint16_t cmcr;
+    uint16_t cmcnt;
+    uint16_t cmcor;
+
+    bool start;
+    int64_t tick;
+    int64_t clk_per_ns;
+    qemu_irq cmi;
+    QEMUTimer *timer;
+};
+
+typedef struct RCMTState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint16_t cmstr;
+    struct RCMTChannelState c[CMT_CH];
+} RCMTState;
+
+#endif
diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
new file mode 100644
index 0000000000..de394e64d0
--- /dev/null
+++ b/include/hw/timer/renesas_tmr.h
@@ -0,0 +1,50 @@
+/*
+ * Renesas 8bit timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_TMR_H
+#define HW_RENESAS_TMR_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TMR "renesas-tmr"
+#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
+
+enum timer_event {cmia = 0,
+                  cmib = 1,
+                  ovi = 2,
+                  none = 3,
+                  TMR_NR_EVENTS = 4};
+enum {
+    TMR_CH = 2,
+    TMR_NR_IRQ = 3 * TMR_CH,
+};
+
+typedef struct RTMRState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint8_t tcnt[TMR_CH];
+    uint8_t tcora[TMR_CH];
+    uint8_t tcorb[TMR_CH];
+    uint8_t tcr[TMR_CH];
+    uint8_t tccr[TMR_CH];
+    uint8_t tcor[TMR_CH];
+    uint8_t tcsr[TMR_CH];
+    int64_t tick;
+    int64_t div_round[TMR_CH];
+    enum timer_event next[TMR_CH];
+    qemu_irq cmia[TMR_CH];
+    qemu_irq cmib[TMR_CH];
+    qemu_irq ovi[TMR_CH];
+    QEMUTimer *timer[TMR_CH];
+} RTMRState;
+
+#endif
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
new file mode 100644
index 0000000000..100136e89a
--- /dev/null
+++ b/hw/timer/renesas_cmt.c
@@ -0,0 +1,260 @@
+/*
+ * Renesas 16bit Compare-match timer
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/timer/renesas_cmt.h"
+#include "qemu/error-report.h"
+
+/*
+ *  +0 CMSTR - common control
+ *  +2 CMCR  - ch0
+ *  +4 CMCNT - ch0
+ *  +6 CMCOR - ch0
+ *  +8 CMCR  - ch1
+ * +10 CMCNT - ch1
+ * +12 CMCOR - ch1
+ * If we think that the address of CH 0 has an offset of +2,
+ * we can treat it with the same address as CH 1, so define it like that.
+ */
+REG16(CMSTR, 0)
+  FIELD(CMSTR, STR0, 0, 1)
+  FIELD(CMSTR, STR1, 1, 1)
+  FIELD(CMSTR, STR,  0, 2)
+/* This addeess is channel offset */
+REG16(CMCR, 0)
+  FIELD(CMCR, CKS, 0, 2)
+  FIELD(CMCR, CMIE, 6, 1)
+REG16(CMCNT, 2)
+REG16(CMCOR, 4)
+
+static void update_events(struct RCMTChannelState *c)
+{
+    int64_t next_time;
+
+    next_time = c->clk_per_ns * (c->cmcor - c->cmcnt);
+    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(c->timer, next_time);
+}
+
+static int64_t read_cmcnt(struct RCMTChannelState *c)
+{
+    int64_t delta = 0;
+    int64_t now;
+
+    if (c->start) {
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        delta = (now - c->tick) / c->clk_per_ns;
+        c->tick = now;
+    }
+    return c->cmcnt + delta;
+}
+
+static uint64_t cmt_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RCMTState *cmt = opaque;
+    int ch = addr / 0x08;
+    uint64_t ret;
+
+    if (addr == A_CMSTR) {
+        ret = 0;
+        ret = FIELD_DP16(ret, CMSTR, STR,
+                         FIELD_EX16(cmt->cmstr, CMSTR, STR));
+        return ret;
+    } else {
+        addr &= 0x07;
+        if (ch == 0) {
+            addr -= 0x02;
+        }
+        switch (addr) {
+        case A_CMCR:
+            ret = 0;
+            ret = FIELD_DP16(ret, CMCR, CKS,
+                             FIELD_EX16(cmt->cmstr, CMCR, CKS));
+            ret = FIELD_DP16(ret, CMCR, CMIE,
+                             FIELD_EX16(cmt->cmstr, CMCR, CMIE));
+            return ret;
+        case A_CMCNT:
+            return read_cmcnt(&cmt->c[ch]);
+        case A_CMCOR:
+            return cmt->c[ch].cmcor;
+        }
+    }
+    qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%"
+                  HWADDR_PRIX " not implemented\n", addr);
+    return UINT64_MAX;
+}
+
+static void start_stop(RCMTState *cmt, int ch, int st)
+{
+    if (st) {
+        cmt->c[ch].start = true;
+        update_events(&cmt->c[ch]);
+    } else {
+        cmt->c[ch].start = false;
+        timer_del(cmt->c[ch].timer);
+    }
+}
+
+static void cmt_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RCMTState *cmt = opaque;
+    int ch = addr / 0x08;
+    int div;
+
+    if (addr == A_CMSTR) {
+        cmt->cmstr = FIELD_EX16(val, CMSTR, STR);
+        start_stop(cmt, 0, FIELD_EX16(cmt->cmstr, CMSTR, STR0));
+        start_stop(cmt, 1, FIELD_EX16(cmt->cmstr, CMSTR, STR1));
+    } else {
+        addr &= 0x07;
+        if (ch == 0) {
+            addr -= 0x02;
+        }
+        switch (addr) {
+        case A_CMCR:
+            cmt->c[ch].cmcr = FIELD_DP16(cmt->c[ch].cmcr, CMCR, CKS,
+                                       FIELD_EX16(val, CMCR, CKS));
+            cmt->c[ch].cmcr = FIELD_DP16(cmt->c[ch].cmcr, CMCR, CMIE,
+                                       FIELD_EX16(val, CMCR, CMIE));
+            /*
+             * CKS -> div rate
+             *  0 -> 8 (1 << 3)
+             *  1 -> 32 (1 << 5)
+             *  2 -> 128 (1 << 7)
+             *  3 -> 512 (1 << 9)
+             */
+            div = 1 << (3 + 2 * FIELD_EX16(cmt->c[ch].cmcr, CMCR, CKS));
+            cmt->c[ch].clk_per_ns = NANOSECONDS_PER_SECOND / cmt->input_freq;
+            cmt->c[ch].clk_per_ns *= div;
+            break;
+        case A_CMCNT:
+            cmt->c[ch].cmcnt = val;
+            break;
+        case A_CMCOR:
+            cmt->c[ch].cmcor = val;
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register -0x%" HWADDR_PRIX
+                          " not implemented\n", addr);
+            return;
+        }
+        if (FIELD_EX16(cmt->cmstr, CMSTR, STR) & (1 << ch)) {
+            update_events(&cmt->c[ch]);
+        }
+    }
+}
+
+static const MemoryRegionOps cmt_ops = {
+    .write = cmt_write,
+    .read  = cmt_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+    },
+};
+
+static void timer_event(void *opaque)
+{
+    struct RCMTChannelState *c = opaque;
+
+    c->cmcnt = 0;
+    c->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    update_events(c);
+    if (FIELD_EX16(c->cmcr, CMCR, CMIE)) {
+        qemu_irq_pulse(c->cmi);
+    }
+}
+
+static void rcmt_reset(DeviceState *dev)
+{
+    RCMTState *cmt = RCMT(dev);
+    cmt->cmstr = 0;
+    cmt->c[0].start = cmt->c[1].start = false;
+    cmt->c[0].cmcr = cmt->c[1].cmcr = 0;
+    cmt->c[0].cmcnt = cmt->c[1].cmcnt = 0;
+    cmt->c[0].cmcor = cmt->c[1].cmcor = 0xffff;
+}
+
+static void rcmt_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RCMTState *cmt = RCMT(obj);
+    int i;
+
+    memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
+                          cmt, "renesas-cmt", 0x10);
+    sysbus_init_mmio(d, &cmt->memory);
+
+    for (i = 0; i < CMT_CH; i++) {
+        sysbus_init_irq(d, &cmt->c[i].cmi);
+    }
+    cmt->c[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                   timer_event, &cmt->c[0]);
+    cmt->c[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                   timer_event, &cmt->c[1]);
+}
+
+static const VMStateDescription vmstate_rcmt = {
+    .name = "rx-cmt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rcmt_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rcmt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = rcmt_properties;
+    dc->vmsd = &vmstate_rcmt;
+    dc->reset = rcmt_reset;
+}
+
+static const TypeInfo rcmt_info = {
+    .name       = TYPE_RENESAS_CMT,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RCMTState),
+    .instance_init = rcmt_init,
+    .class_init = rcmt_class_init,
+};
+
+static void rcmt_register_types(void)
+{
+    type_register_static(&rcmt_info);
+}
+
+type_init(rcmt_register_types)
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
new file mode 100644
index 0000000000..aa12ca7726
--- /dev/null
+++ b/hw/timer/renesas_tmr.c
@@ -0,0 +1,455 @@
+/*
+ * Renesas 8bit timer
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/timer/renesas_tmr.h"
+#include "qemu/error-report.h"
+
+REG8(TCR, 0)
+  FIELD(TCR, CCLR, 3, 2)
+  FIELD(TCR, OVIE, 5, 1)
+  FIELD(TCR, CMIEA, 6, 1)
+  FIELD(TCR, CMIEB, 7, 1)
+REG8(TCSR, 2)
+  FIELD(TCSR, OSA, 0, 2)
+  FIELD(TCSR, OSB, 2, 2)
+  FIELD(TCSR, ADTE, 4, 2)
+REG8(TCORA, 4)
+REG8(TCORB, 6)
+REG8(TCNT, 8)
+REG8(TCCR, 10)
+  FIELD(TCCR, CKS, 0, 3)
+  FIELD(TCCR, CSS, 3, 2)
+  FIELD(TCCR, TMRIS, 7, 1)
+
+#define INTERNAL  0x01
+#define CASCADING 0x03
+#define CCLR_A    0x01
+#define CCLR_B    0x02
+
+static const int clkdiv[] = {0, 1, 2, 8, 32, 64, 1024, 8192};
+
+#define concat_reg(reg) ((reg[0] << 8) | reg[1])
+static void update_events(RTMRState *tmr, int ch)
+{
+    uint16_t diff[TMR_NR_EVENTS], min;
+    int64_t next_time;
+    int i, event;
+
+    if (tmr->tccr[ch] == 0) {
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[ch], TCCR, CSS) == 0) {
+        /* external clock mode */
+        /* event not happened */
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) == CASCADING) {
+        /* cascading mode */
+        if (ch == 1) {
+            tmr->next[ch] = none;
+            return ;
+        }
+        diff[cmia] = concat_reg(tmr->tcora) - concat_reg(tmr->tcnt);
+        diff[cmib] = concat_reg(tmr->tcorb) - concat_reg(tmr->tcnt);
+        diff[ovi] = 0x10000 - concat_reg(tmr->tcnt);
+    } else {
+        /* separate mode */
+        diff[cmia] = tmr->tcora[ch] - tmr->tcnt[ch];
+        diff[cmib] = tmr->tcorb[ch] - tmr->tcnt[ch];
+        diff[ovi] = 0x100 - tmr->tcnt[ch];
+    }
+    /* Search for the most recently occurring event. */
+    for (event = 0, min = diff[0], i = 1; i < none; i++) {
+        if (min > diff[i]) {
+            event = i;
+            min = diff[i];
+        }
+    }
+    tmr->next[ch] = event;
+    next_time = diff[event];
+    next_time *= clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    next_time *= NANOSECONDS_PER_SECOND;
+    next_time /= tmr->input_freq;
+    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(tmr->timer[ch], next_time);
+}
+
+
+static inline int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
+{
+    int divrate = clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    int et;
+
+    tmr->div_round[ch] += delta;
+    if (divrate > 0) {
+        et = tmr->div_round[ch] / divrate;
+        tmr->div_round[ch] %= divrate;
+    } else {
+        /* disble clock. so no update */
+        et = 0;
+    }
+    return et;
+}
+static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int elapsed, ovf = 0;
+    uint16_t tcnt[2];
+    uint32_t ret;
+
+    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
+    if (delta > 0) {
+        tmr->tick = now;
+
+        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
+            /* timer1 count update */
+            elapsed = elapsed_time(tmr, 1, delta);
+            if (elapsed >= 0x100) {
+                ovf = elapsed >> 8;
+            }
+            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
+        }
+        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
+        case INTERNAL:
+            elapsed = elapsed_time(tmr, 0, delta);
+            tcnt[0] = tmr->tcnt[0] + elapsed;
+            break;
+        case CASCADING:
+            if (ovf > 0) {
+                tcnt[0] = tmr->tcnt[0] + ovf;
+            }
+            break;
+        }
+    } else {
+        tcnt[0] = tmr->tcnt[0];
+        tcnt[1] = tmr->tcnt[1];
+    }
+    if (size == 1) {
+        return tcnt[ch];
+    } else {
+        ret = 0;
+        ret = deposit32(ret, 0, 8, tcnt[1]);
+        ret = deposit32(ret, 8, 8, tcnt[0]);
+        return ret;
+    }
+}
+
+static inline uint8_t read_tccr(uint8_t r)
+{
+    uint8_t tccr = 0;
+    tccr = FIELD_DP8(tccr, TCCR, TMRIS,
+                     FIELD_EX8(r, TCCR, TMRIS));
+    tccr = FIELD_DP8(tccr, TCCR, CSS,
+                     FIELD_EX8(r, TCCR, CSS));
+    tccr = FIELD_DP8(tccr, TCCR, CKS,
+                     FIELD_EX8(r, TCCR, CKS));
+    return tccr;
+}
+
+static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RTMRState *tmr = opaque;
+    int ch = addr & 1;
+    uint64_t ret;
+
+    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr: Invalid read size 0x%"
+                      HWADDR_PRIX "\n", addr);
+        return UINT64_MAX;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        ret = 0;
+        ret = FIELD_DP8(ret, TCR, CCLR,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
+        ret = FIELD_DP8(ret, TCR, OVIE,
+                        FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
+        ret = FIELD_DP8(ret, TCR, CMIEA,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
+        ret = FIELD_DP8(ret, TCR, CMIEB,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
+        return ret;
+    case A_TCSR:
+        ret = 0;
+        ret = FIELD_DP8(ret, TCSR, OSA,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
+        ret = FIELD_DP8(ret, TCSR, OSB,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
+        switch (ch) {
+        case 0:
+            ret = FIELD_DP8(ret, TCSR, ADTE,
+                            FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
+            break;
+        case 1: /* CH1 ADTE unimplement always 1 */
+            ret = FIELD_DP8(ret, TCSR, ADTE, 1);
+            break;
+        }
+        return ret;
+    case A_TCORA:
+        if (size == 1) {
+            return tmr->tcora[ch];
+        } else if (ch == 0) {
+            return concat_reg(tmr->tcora);
+        }
+    case A_TCORB:
+        if (size == 1) {
+            return tmr->tcorb[ch];
+        } else {
+            return concat_reg(tmr->tcorb);
+        }
+    case A_TCNT:
+        return read_tcnt(tmr, size, ch);
+    case A_TCCR:
+        if (size == 1) {
+            return read_tccr(tmr->tccr[ch]);
+        } else {
+            return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]);
+        }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+#define COUNT_WRITE(reg, val)                   \
+    do {                                        \
+        if (size == 1) {                        \
+            tmr->reg[ch] = val;                 \
+            update_events(tmr, ch);             \
+        } else {                                \
+            tmr->reg[0] = extract32(val, 8, 8); \
+            tmr->reg[1] = extract32(val, 0, 8); \
+            update_events(tmr, 0);              \
+            update_events(tmr, 1);              \
+        }                                       \
+    } while (0)
+
+static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RTMRState *tmr = opaque;
+    int ch = addr & 1;
+
+    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_tmr: Invalid write size 0x%" HWADDR_PRIX
+                      "\n", addr);
+        return;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        tmr->tcr[ch] = val;
+        break;
+    case A_TCSR:
+        tmr->tcsr[ch] = val;
+        break;
+    case A_TCORA:
+        COUNT_WRITE(tcora, val);
+        break;
+    case A_TCORB:
+        COUNT_WRITE(tcorb, val);
+        break;
+    case A_TCNT:
+        COUNT_WRITE(tcnt, val);
+        break;
+    case A_TCCR:
+        COUNT_WRITE(tccr, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps tmr_ops = {
+    .write = tmr_write,
+    .read  = tmr_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void timer_events(RTMRState *tmr, int ch);
+
+static uint16_t issue_event(RTMRState *tmr, int ch, int sz,
+                        uint16_t tcnt, uint16_t tcora, uint16_t tcorb)
+{
+    uint16_t ret = tcnt;
+
+    switch (tmr->next[ch]) {
+    case none:
+        break;
+    case cmia:
+        if (tcnt >= tcora) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_A) {
+                ret = tcnt - tcora;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEA)) {
+                qemu_irq_pulse(tmr->cmia[ch]);
+            }
+            if (sz == 8 && ch == 0 &&
+                FIELD_EX8(tmr->tccr[1], TCCR, CSS) == CASCADING) {
+                tmr->tcnt[1]++;
+                timer_events(tmr, 1);
+            }
+        }
+        break;
+    case cmib:
+        if (tcnt >= tcorb) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_B) {
+                ret = tcnt - tcorb;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEB)) {
+                qemu_irq_pulse(tmr->cmib[ch]);
+            }
+        }
+        break;
+    case ovi:
+        if ((tcnt >= (1 << sz)) && FIELD_EX8(tmr->tcr[ch], TCR, OVIE)) {
+            qemu_irq_pulse(tmr->ovi[ch]);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
+static void timer_events(RTMRState *tmr, int ch)
+{
+    uint16_t tcnt;
+    tmr->tcnt[ch] = read_tcnt(tmr, 1, ch);
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) != CASCADING) {
+        tmr->tcnt[ch] = issue_event(tmr, ch, 8,
+                                    tmr->tcnt[ch],
+                                    tmr->tcora[ch], tmr->tcorb[ch]) & 0xff;
+    } else {
+        if (ch == 1) {
+            return ;
+        }
+        tcnt = issue_event(tmr, ch, 16,
+                           concat_reg(tmr->tcnt),
+                           concat_reg(tmr->tcora),
+                           concat_reg(tmr->tcorb));
+        tmr->tcnt[0] = (tcnt >> 8) & 0xff;
+        tmr->tcnt[1] = tcnt & 0xff;
+    }
+    update_events(tmr, ch);
+}
+
+static void timer_event0(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 1);
+}
+
+static void rtmr_reset(DeviceState *dev)
+{
+    RTMRState *tmr = RTMR(dev);
+    tmr->tcr[0]   = tmr->tcr[1]   = 0x00;
+    tmr->tcsr[0]  = 0x00;
+    tmr->tcsr[1]  = 0x10;
+    tmr->tcnt[0]  = tmr->tcnt[1]  = 0x00;
+    tmr->tcora[0] = tmr->tcora[1] = 0xff;
+    tmr->tcorb[0] = tmr->tcorb[1] = 0xff;
+    tmr->tccr[0]  = tmr->tccr[1]  = 0x00;
+    tmr->next[0]  = tmr->next[1]  = none;
+    tmr->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void rtmr_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RTMRState *tmr = RTMR(obj);
+    int i;
+
+    memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                          tmr, "renesas-tmr", 0x10);
+    sysbus_init_mmio(d, &tmr->memory);
+
+    for (i = 0; i < ARRAY_SIZE(tmr->ovi); i++) {
+        sysbus_init_irq(d, &tmr->cmia[i]);
+        sysbus_init_irq(d, &tmr->cmib[i]);
+        sysbus_init_irq(d, &tmr->ovi[i]);
+    }
+    tmr->timer[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, tmr);
+    tmr->timer[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1, tmr);
+}
+
+static const VMStateDescription vmstate_rtmr = {
+    .name = "rx-tmr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rtmr_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rtmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = rtmr_properties;
+    dc->vmsd = &vmstate_rtmr;
+    dc->reset = rtmr_reset;
+}
+
+static const TypeInfo rtmr_info = {
+    .name       = TYPE_RENESAS_TMR,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RTMRState),
+    .instance_init = rtmr_init,
+    .class_init = rtmr_class_init,
+};
+
+static void rtmr_register_types(void)
+{
+    type_register_static(&rtmr_info);
+}
+
+type_init(rtmr_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 51921eb63f..2249458f42 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -61,3 +61,9 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config RENESAS_TMR8
+    bool
+
+config RENESAS_CMT
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f8..86a75bc8d8 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -40,6 +40,9 @@ obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 
 obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
+obj-$(CONFIG_RENESAS_TMR8) += renesas_tmr.o
+obj-$(CONFIG_RENESAS_CMT) += renesas_cmt.o
+
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
 
-- 
2.11.0


