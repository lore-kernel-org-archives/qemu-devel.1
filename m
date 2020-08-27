Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3663C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3E322CAE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3E322CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHJC-0005fm-Qg
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBT-00083F-RO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:15 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:39211)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBN-0005uV-Vh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:15 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 9380A26B17;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 3009B1C0696;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/20] hw/timer: Renesas 8bit timer emulation.
Date: Thu, 27 Aug 2020 21:38:45 +0900
Message-Id: <20200827123859.81793-7-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rewrite for clock API.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/timer/renesas_tmr.h  |  55 ----
 include/hw/timer/renesas_tmr8.h |  67 ++++
 hw/timer/renesas_tmr.c          | 477 ----------------------------
 hw/timer/renesas_tmr8.c         | 540 ++++++++++++++++++++++++++++++++
 hw/timer/Kconfig                |   3 +-
 hw/timer/meson.build            |   2 +-
 6 files changed, 610 insertions(+), 534 deletions(-)
 delete mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 include/hw/timer/renesas_tmr8.h
 delete mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 hw/timer/renesas_tmr8.c

diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
deleted file mode 100644
index cf3baa7a28..0000000000
--- a/include/hw/timer/renesas_tmr.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Renesas 8bit timer Object
- *
- * Copyright (c) 2018 Yoshinori Sato
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_TIMER_RENESAS_TMR_H
-#define HW_TIMER_RENESAS_TMR_H
-
-#include "qemu/timer.h"
-#include "hw/sysbus.h"
-
-#define TYPE_RENESAS_TMR "renesas-tmr"
-#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
-
-enum timer_event {
-    cmia = 0,
-    cmib = 1,
-    ovi = 2,
-    none = 3,
-    TMR_NR_EVENTS = 4
-};
-
-enum {
-    TMR_CH = 2,
-    TMR_NR_IRQ = 3 * TMR_CH
-};
-
-typedef struct RTMRState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    uint64_t input_freq;
-    MemoryRegion memory;
-
-    int64_t tick;
-    uint8_t tcnt[TMR_CH];
-    uint8_t tcora[TMR_CH];
-    uint8_t tcorb[TMR_CH];
-    uint8_t tcr[TMR_CH];
-    uint8_t tccr[TMR_CH];
-    uint8_t tcor[TMR_CH];
-    uint8_t tcsr[TMR_CH];
-    int64_t div_round[TMR_CH];
-    uint8_t next[TMR_CH];
-    qemu_irq cmia[TMR_CH];
-    qemu_irq cmib[TMR_CH];
-    qemu_irq ovi[TMR_CH];
-    QEMUTimer timer[TMR_CH];
-} RTMRState;
-
-#endif
diff --git a/include/hw/timer/renesas_tmr8.h b/include/hw/timer/renesas_tmr8.h
new file mode 100644
index 0000000000..23935bd4a3
--- /dev/null
+++ b/include/hw/timer/renesas_tmr8.h
@@ -0,0 +1,67 @@
+/*
+ * Renesas 8bit timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_TMR8_H
+#define HW_RENESAS_TMR8_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TMR8 "renesas-tmr8"
+#define RenesasTMR8(obj) \
+    OBJECT_CHECK(RenesasTMR8State, (obj), TYPE_RENESAS_TMR8)
+
+enum {
+    TMR_CH = 2,
+};
+
+enum {
+    IRQ_CMIA, IRQ_CMIB, IRQ_OVI,
+    TMR_NR_IRQ,
+};
+
+enum timer_event {
+    EVT_NONE, EVT_CMIA, EVT_CMIB, EVT_OVI, EVT_WOVI,
+    TMR_NR_EVENTS,
+};
+
+enum cor {
+    REG_A, REG_B, NR_COR,
+};
+
+struct RenesasTMR8State;
+
+struct tmr8_ch {
+    uint16_t cnt;
+    uint16_t cor[NR_COR];
+    uint8_t tcr;
+    uint8_t tccr;
+    uint8_t tcsr;
+    qemu_irq irq[TMR_NR_IRQ];
+    QEMUTimer *timer;
+    int64_t base;
+    int64_t next;
+    int64_t clk;
+    enum timer_event event;
+    int id;
+    struct RenesasTMR8State *tmrp;
+    bool word;
+};
+
+typedef struct RenesasTMR8State {
+    SysBusDevice parent_obj;
+
+    uint32_t unit;
+    Clock *pck;
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    struct tmr8_ch ch[TMR_CH];
+} RenesasTMR8State;
+
+#endif
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
deleted file mode 100644
index 446f2eacdd..0000000000
--- a/hw/timer/renesas_tmr.c
+++ /dev/null
@@ -1,477 +0,0 @@
-/*
- * Renesas 8bit timer
- *
- * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
- *            (Rev.1.40 R01UH0033EJ0140)
- *
- * Copyright (c) 2019 Yoshinori Sato
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "hw/irq.h"
-#include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
-#include "hw/timer/renesas_tmr.h"
-#include "migration/vmstate.h"
-
-REG8(TCR, 0)
-  FIELD(TCR, CCLR,  3, 2)
-  FIELD(TCR, OVIE,  5, 1)
-  FIELD(TCR, CMIEA, 6, 1)
-  FIELD(TCR, CMIEB, 7, 1)
-REG8(TCSR, 2)
-  FIELD(TCSR, OSA,  0, 2)
-  FIELD(TCSR, OSB,  2, 2)
-  FIELD(TCSR, ADTE, 4, 2)
-REG8(TCORA, 4)
-REG8(TCORB, 6)
-REG8(TCNT, 8)
-REG8(TCCR, 10)
-  FIELD(TCCR, CKS,   0, 3)
-  FIELD(TCCR, CSS,   3, 2)
-  FIELD(TCCR, TMRIS, 7, 1)
-
-#define INTERNAL  0x01
-#define CASCADING 0x03
-#define CCLR_A    0x01
-#define CCLR_B    0x02
-
-static const int clkdiv[] = {0, 1, 2, 8, 32, 64, 1024, 8192};
-
-static uint8_t concat_reg(uint8_t *reg)
-{
-    return (reg[0] << 8) | reg[1];
-}
-
-static void update_events(RTMRState *tmr, int ch)
-{
-    uint16_t diff[TMR_NR_EVENTS], min;
-    int64_t next_time;
-    int i, event;
-
-    if (tmr->tccr[ch] == 0) {
-        return ;
-    }
-    if (FIELD_EX8(tmr->tccr[ch], TCCR, CSS) == 0) {
-        /* external clock mode */
-        /* event not happened */
-        return ;
-    }
-    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) == CASCADING) {
-        /* cascading mode */
-        if (ch == 1) {
-            tmr->next[ch] = none;
-            return ;
-        }
-        diff[cmia] = concat_reg(tmr->tcora) - concat_reg(tmr->tcnt);
-        diff[cmib] = concat_reg(tmr->tcorb) - concat_reg(tmr->tcnt);
-        diff[ovi] = 0x10000 - concat_reg(tmr->tcnt);
-    } else {
-        /* separate mode */
-        diff[cmia] = tmr->tcora[ch] - tmr->tcnt[ch];
-        diff[cmib] = tmr->tcorb[ch] - tmr->tcnt[ch];
-        diff[ovi] = 0x100 - tmr->tcnt[ch];
-    }
-    /* Search for the most recently occurring event. */
-    for (event = 0, min = diff[0], i = 1; i < none; i++) {
-        if (min > diff[i]) {
-            event = i;
-            min = diff[i];
-        }
-    }
-    tmr->next[ch] = event;
-    next_time = diff[event];
-    next_time *= clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
-    next_time *= NANOSECONDS_PER_SECOND;
-    next_time /= tmr->input_freq;
-    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    timer_mod(&tmr->timer[ch], next_time);
-}
-
-static int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
-{
-    int divrate = clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
-    int et;
-
-    tmr->div_round[ch] += delta;
-    if (divrate > 0) {
-        et = tmr->div_round[ch] / divrate;
-        tmr->div_round[ch] %= divrate;
-    } else {
-        /* disble clock. so no update */
-        et = 0;
-    }
-    return et;
-}
-
-static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
-{
-    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int elapsed, ovf = 0;
-    uint16_t tcnt[2];
-    uint32_t ret;
-
-    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
-    if (delta > 0) {
-        tmr->tick = now;
-
-        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
-            /* timer1 count update */
-            elapsed = elapsed_time(tmr, 1, delta);
-            if (elapsed >= 0x100) {
-                ovf = elapsed >> 8;
-            }
-            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
-        }
-        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
-        case INTERNAL:
-            elapsed = elapsed_time(tmr, 0, delta);
-            tcnt[0] = tmr->tcnt[0] + elapsed;
-            break;
-        case CASCADING:
-            if (ovf > 0) {
-                tcnt[0] = tmr->tcnt[0] + ovf;
-            }
-            break;
-        }
-    } else {
-        tcnt[0] = tmr->tcnt[0];
-        tcnt[1] = tmr->tcnt[1];
-    }
-    if (size == 1) {
-        return tcnt[ch];
-    } else {
-        ret = 0;
-        ret = deposit32(ret, 0, 8, tcnt[1]);
-        ret = deposit32(ret, 8, 8, tcnt[0]);
-        return ret;
-    }
-}
-
-static uint8_t read_tccr(uint8_t r)
-{
-    uint8_t tccr = 0;
-    tccr = FIELD_DP8(tccr, TCCR, TMRIS,
-                     FIELD_EX8(r, TCCR, TMRIS));
-    tccr = FIELD_DP8(tccr, TCCR, CSS,
-                     FIELD_EX8(r, TCCR, CSS));
-    tccr = FIELD_DP8(tccr, TCCR, CKS,
-                     FIELD_EX8(r, TCCR, CKS));
-    return tccr;
-}
-
-static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
-{
-    RTMRState *tmr = opaque;
-    int ch = addr & 1;
-    uint64_t ret;
-
-    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr: Invalid read size 0x%"
-                                       HWADDR_PRIX "\n",
-                      addr);
-        return UINT64_MAX;
-    }
-    switch (addr & 0x0e) {
-    case A_TCR:
-        ret = 0;
-        ret = FIELD_DP8(ret, TCR, CCLR,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
-        ret = FIELD_DP8(ret, TCR, OVIE,
-                        FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
-        ret = FIELD_DP8(ret, TCR, CMIEA,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
-        ret = FIELD_DP8(ret, TCR, CMIEB,
-                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
-        return ret;
-    case A_TCSR:
-        ret = 0;
-        ret = FIELD_DP8(ret, TCSR, OSA,
-                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
-        ret = FIELD_DP8(ret, TCSR, OSB,
-                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
-        switch (ch) {
-        case 0:
-            ret = FIELD_DP8(ret, TCSR, ADTE,
-                            FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
-            break;
-        case 1: /* CH1 ADTE unimplement always 1 */
-            ret = FIELD_DP8(ret, TCSR, ADTE, 1);
-            break;
-        }
-        return ret;
-    case A_TCORA:
-        if (size == 1) {
-            return tmr->tcora[ch];
-        } else if (ch == 0) {
-            return concat_reg(tmr->tcora);
-        }
-    case A_TCORB:
-        if (size == 1) {
-            return tmr->tcorb[ch];
-        } else {
-            return concat_reg(tmr->tcorb);
-        }
-    case A_TCNT:
-        return read_tcnt(tmr, size, ch);
-    case A_TCCR:
-        if (size == 1) {
-            return read_tccr(tmr->tccr[ch]);
-        } else {
-            return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]);
-        }
-    default:
-        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
-                                 " not implemented\n",
-                      addr);
-        break;
-    }
-    return UINT64_MAX;
-}
-
-static void tmr_write_count(RTMRState *tmr, int ch, unsigned size,
-                            uint8_t *reg, uint64_t val)
-{
-    if (size == 1) {
-        reg[ch] = val;
-        update_events(tmr, ch);
-    } else {
-        reg[0] = extract32(val, 8, 8);
-        reg[1] = extract32(val, 0, 8);
-        update_events(tmr, 0);
-        update_events(tmr, 1);
-    }
-}
-
-static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
-{
-    RTMRState *tmr = opaque;
-    int ch = addr & 1;
-
-    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "renesas_tmr: Invalid write size 0x%" HWADDR_PRIX "\n",
-                      addr);
-        return;
-    }
-    switch (addr & 0x0e) {
-    case A_TCR:
-        tmr->tcr[ch] = val;
-        break;
-    case A_TCSR:
-        tmr->tcsr[ch] = val;
-        break;
-    case A_TCORA:
-        tmr_write_count(tmr, ch, size, tmr->tcora, val);
-        break;
-    case A_TCORB:
-        tmr_write_count(tmr, ch, size, tmr->tcorb, val);
-        break;
-    case A_TCNT:
-        tmr_write_count(tmr, ch, size, tmr->tcnt, val);
-        break;
-    case A_TCCR:
-        tmr_write_count(tmr, ch, size, tmr->tccr, val);
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
-                                 " not implemented\n",
-                      addr);
-        break;
-    }
-}
-
-static const MemoryRegionOps tmr_ops = {
-    .write = tmr_write,
-    .read  = tmr_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 2,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 2,
-    },
-};
-
-static void timer_events(RTMRState *tmr, int ch);
-
-static uint16_t issue_event(RTMRState *tmr, int ch, int sz,
-                        uint16_t tcnt, uint16_t tcora, uint16_t tcorb)
-{
-    uint16_t ret = tcnt;
-
-    switch (tmr->next[ch]) {
-    case none:
-        break;
-    case cmia:
-        if (tcnt >= tcora) {
-            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_A) {
-                ret = tcnt - tcora;
-            }
-            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEA)) {
-                qemu_irq_pulse(tmr->cmia[ch]);
-            }
-            if (sz == 8 && ch == 0 &&
-                FIELD_EX8(tmr->tccr[1], TCCR, CSS) == CASCADING) {
-                tmr->tcnt[1]++;
-                timer_events(tmr, 1);
-            }
-        }
-        break;
-    case cmib:
-        if (tcnt >= tcorb) {
-            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_B) {
-                ret = tcnt - tcorb;
-            }
-            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEB)) {
-                qemu_irq_pulse(tmr->cmib[ch]);
-            }
-        }
-        break;
-    case ovi:
-        if ((tcnt >= (1 << sz)) && FIELD_EX8(tmr->tcr[ch], TCR, OVIE)) {
-            qemu_irq_pulse(tmr->ovi[ch]);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return ret;
-}
-
-static void timer_events(RTMRState *tmr, int ch)
-{
-    uint16_t tcnt;
-
-    tmr->tcnt[ch] = read_tcnt(tmr, 1, ch);
-    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) != CASCADING) {
-        tmr->tcnt[ch] = issue_event(tmr, ch, 8,
-                                    tmr->tcnt[ch],
-                                    tmr->tcora[ch],
-                                    tmr->tcorb[ch]) & 0xff;
-    } else {
-        if (ch == 1) {
-            return ;
-        }
-        tcnt = issue_event(tmr, ch, 16,
-                           concat_reg(tmr->tcnt),
-                           concat_reg(tmr->tcora),
-                           concat_reg(tmr->tcorb));
-        tmr->tcnt[0] = (tcnt >> 8) & 0xff;
-        tmr->tcnt[1] = tcnt & 0xff;
-    }
-    update_events(tmr, ch);
-}
-
-static void timer_event0(void *opaque)
-{
-    RTMRState *tmr = opaque;
-
-    timer_events(tmr, 0);
-}
-
-static void timer_event1(void *opaque)
-{
-    RTMRState *tmr = opaque;
-
-    timer_events(tmr, 1);
-}
-
-static void rtmr_reset(DeviceState *dev)
-{
-    RTMRState *tmr = RTMR(dev);
-    tmr->tcr[0]   = tmr->tcr[1]   = 0x00;
-    tmr->tcsr[0]  = 0x00;
-    tmr->tcsr[1]  = 0x10;
-    tmr->tcnt[0]  = tmr->tcnt[1]  = 0x00;
-    tmr->tcora[0] = tmr->tcora[1] = 0xff;
-    tmr->tcorb[0] = tmr->tcorb[1] = 0xff;
-    tmr->tccr[0]  = tmr->tccr[1]  = 0x00;
-    tmr->next[0]  = tmr->next[1]  = none;
-    tmr->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-}
-
-static void rtmr_init(Object *obj)
-{
-    SysBusDevice *d = SYS_BUS_DEVICE(obj);
-    RTMRState *tmr = RTMR(obj);
-    int i;
-
-    memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
-                          tmr, "renesas-tmr", 0x10);
-    sysbus_init_mmio(d, &tmr->memory);
-
-    for (i = 0; i < ARRAY_SIZE(tmr->ovi); i++) {
-        sysbus_init_irq(d, &tmr->cmia[i]);
-        sysbus_init_irq(d, &tmr->cmib[i]);
-        sysbus_init_irq(d, &tmr->ovi[i]);
-    }
-    timer_init_ns(&tmr->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, tmr);
-    timer_init_ns(&tmr->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, tmr);
-}
-
-static const VMStateDescription vmstate_rtmr = {
-    .name = "rx-tmr",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT64(tick, RTMRState),
-        VMSTATE_UINT8_ARRAY(tcnt, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tcora, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tcorb, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tcr, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tccr, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tcor, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(tcsr, RTMRState, TMR_CH),
-        VMSTATE_INT64_ARRAY(div_round, RTMRState, TMR_CH),
-        VMSTATE_UINT8_ARRAY(next, RTMRState, TMR_CH),
-        VMSTATE_TIMER_ARRAY(timer, RTMRState, TMR_CH),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property rtmr_properties[] = {
-    DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void rtmr_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_rtmr;
-    dc->reset = rtmr_reset;
-    device_class_set_props(dc, rtmr_properties);
-}
-
-static const TypeInfo rtmr_info = {
-    .name = TYPE_RENESAS_TMR,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RTMRState),
-    .instance_init = rtmr_init,
-    .class_init = rtmr_class_init,
-};
-
-static void rtmr_register_types(void)
-{
-    type_register_static(&rtmr_info);
-}
-
-type_init(rtmr_register_types)
diff --git a/hw/timer/renesas_tmr8.c b/hw/timer/renesas_tmr8.c
new file mode 100644
index 0000000000..39deabce47
--- /dev/null
+++ b/hw/timer/renesas_tmr8.c
@@ -0,0 +1,540 @@
+/*
+ * Renesas 8bit timer
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ *            (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2020 Yoshinori Sato
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
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "hw/timer/renesas_tmr8.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG8(TCR, 0)
+  FIELD(TCR, CCLR, 3, 2)
+  FIELD(TCR, OVIE, 5, 1)
+  FIELD(TCR, CMIEA, 6, 1)
+  FIELD(TCR, CMIEB, 7, 1)
+  FIELD(TCR, CMIE, 6, 2)
+  FIELD(TCR, ALLIE, 5, 3)
+REG8(TCSR, 2)
+  FIELD(TCSR, OSA, 0, 2)
+  FIELD(TCSR, OSB, 2, 2)
+  FIELD(TCSR, ADTE, 4, 1)
+REG8(TCORA, 4)
+REG8(TCORB, 6)
+REG8(TCNT, 8)
+REG8(TCCR, 10)
+  FIELD(TCCR, CKS, 0, 3)
+  FIELD(TCCR, CSS, 3, 2)
+  FIELD(TCCR, TMRIS, 7, 1)
+
+#define CLK_EVT -1
+
+enum CSS {
+    CSS_EXT = 0,        /* extarnal clock */
+    CSS_INT = 1,        /* internal clock */
+    CSS_UND = 2,        /* undefined */
+    CSS_EVT = 3,        /* event count */
+};
+
+static void update_clk(RenesasTMR8State *tmr, int ch)
+{
+    int64_t t;
+    static const int divlist[] = {1, 2, 8, 32, 64, 1024, 8192, 0};
+    switch (FIELD_EX8(tmr->ch[ch].tccr, TCCR, CSS)) {
+    case CSS_EXT:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_tmr8: External clock not implemented.\n");
+        tmr->ch[ch].clk = 0;
+        break;
+    case CSS_INT:
+        t = divlist[FIELD_EX8(tmr->ch[ch].tccr, TCCR, CKS)];
+        if (t > 0 && clock_is_enabled(tmr->pck)) {
+            t = tmr->input_freq / t;
+            tmr->ch[ch].clk = NANOSECONDS_PER_SECOND / t;
+        } else {
+            tmr->ch[ch].clk = 0;
+        }
+        break;
+    case CSS_UND:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_8timer: CSS undefined.");
+        tmr->ch[ch].clk = 0;
+        break;
+    case CSS_EVT:
+        tmr->ch[ch].clk = CLK_EVT;
+        break;
+    }
+}
+
+static uint16_t catreg(uint8_t hi, uint8_t lo)
+{
+    uint16_t ret = 0;
+    ret = deposit32(ret, 8, 8, hi);
+    ret = deposit32(ret, 0, 8, lo);
+    return ret;
+}
+
+static bool is_clr_count(uint8_t tcr, enum timer_event event)
+{
+    switch (event) {
+    case EVT_CMIA:
+    case EVT_CMIB:
+        return FIELD_EX8(tcr, TCR, CCLR) == event;
+    case EVT_OVI:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool is_irq_enabled(uint8_t tcr, enum timer_event event)
+{
+    switch (event) {
+    case EVT_CMIA:
+        return FIELD_EX8(tcr, TCR, CMIEA);
+    case EVT_CMIB:
+        return FIELD_EX8(tcr, TCR, CMIEB);
+    case EVT_OVI:
+        return FIELD_EX8(tcr, TCR, OVIE);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool event_enabled(uint8_t tcr, enum timer_event event)
+{
+    return is_clr_count(tcr, event) || is_irq_enabled(tcr, event);
+}
+
+static int event_cor(struct tmr8_ch *ch, enum timer_event event)
+{
+    switch (event) {
+    case EVT_CMIA:
+        return ch->cor[REG_A];
+    case EVT_CMIB:
+        return ch->cor[REG_B];
+    default:
+        return 0xff;
+    }
+}
+
+static bool is_word_mode(RenesasTMR8State *tmr)
+{
+    /*
+     * If the following conditions are met, it is treated as a 16-bit counter.
+     * ch0 - free running and no compare match event
+     * ch1 - free running no event
+     */
+    return tmr->ch[0].clk == CLK_EVT &&
+        tmr->ch[1].clk > 0 &&
+        FIELD_EX8(tmr->ch[0].tcr, TCR, CCLR) == 0 &&
+        FIELD_EX8(tmr->ch[0].tcr, TCR, CMIE) == 0 &&
+        FIELD_EX8(tmr->ch[0].tccr, TCCR, CSS) == CSS_EVT &&
+        FIELD_EX8(tmr->ch[1].tcr, TCR, CCLR) == 0 &&
+        FIELD_EX8(tmr->ch[1].tcr, TCR, ALLIE) == 0;
+}
+
+static void set_next_event(RenesasTMR8State *tmr, int ch)
+{
+    int64_t next = 0;
+    enum timer_event evt;
+    int cor;
+    int min;
+    if (ch == 1 && is_word_mode(tmr)) {
+        /* 16bit count mode */
+        next = 0x10000 - catreg(tmr->ch[0].cnt, tmr->ch[1].cnt);
+        next *= tmr->ch[1].clk;
+        tmr->ch[0].event = tmr->ch[1].event = EVT_WOVI;
+    } else if (tmr->ch[ch].clk > 0) {
+        /* Find the next event. */
+        min = 0x100 + 1;
+        for (evt = EVT_CMIA; evt < EVT_WOVI; evt++) {
+            cor = event_cor(&tmr->ch[ch], evt);
+            /* event happen in next count up */
+            cor++;
+            if (tmr->ch[ch].cnt < cor && min > cor &&
+                event_enabled(tmr->ch[ch].tcr, evt)) {
+                    min = cor;
+                    next = cor - tmr->ch[ch].cnt;
+                    next *= tmr->ch[ch].clk;
+                    tmr->ch[ch].event = evt;
+            }
+        }
+    }
+    if (next > 0) {
+        tmr->ch[ch].base = tmr->ch[ch].next;
+        tmr->ch[ch].next += next;
+        timer_mod(tmr->ch[ch].timer, tmr->ch[ch].next);
+    } else {
+        timer_del(tmr->ch[ch].timer);
+    }
+}
+
+static void sent_irq(struct tmr8_ch *ch, enum timer_event evt)
+{
+    if (is_irq_enabled(ch->tcr, evt)) {
+        qemu_irq_pulse(ch->irq[evt - 1]);
+    }
+}
+
+static void event_countup(struct tmr8_ch *ch)
+{
+    enum timer_event evt;
+    int cor;
+
+    ch->cnt++;
+    for (evt = EVT_CMIA; evt < EVT_WOVI; evt++) {
+        cor = event_cor(ch, evt) + 1;
+        if (ch->cnt == cor) {
+            if (is_clr_count(ch->tcr, evt)) {
+                ch->cnt = 0;
+            }
+            sent_irq(ch, evt);
+        }
+    }
+}
+
+static void timer_event(void *opaque)
+{
+    struct tmr8_ch *ch = opaque;
+    RenesasTMR8State *tmr = ch->tmrp;
+
+    switch (ch->event) {
+    case EVT_CMIA:
+        if (ch->id == 0 && tmr->ch[1].clk == CLK_EVT) {
+            /* CH1 event count */
+            event_countup(&tmr->ch[1]);
+        }
+        /* Falls through. */
+    case EVT_CMIB:
+        if (FIELD_EX8(ch->tcr, TCR, CCLR) == ch->event) {
+            ch->cnt = 0;
+        } else {
+        /* update current value */
+            ch->cnt = ch->cor[ch->event] + 1;
+        }
+        sent_irq(ch, ch->event);
+        break;
+    case EVT_OVI:
+        ch->cnt = 0;
+        sent_irq(ch, EVT_OVI);
+        if (ch->id == 1 && tmr->ch[0].clk == CLK_EVT) {
+            /* CH0 event count */
+            event_countup(&tmr->ch[0]);
+        }
+        break;
+    case EVT_WOVI:
+        tmr->ch[0].cnt = tmr->ch[1].cnt = 0;
+        sent_irq(ch, EVT_OVI);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    set_next_event(tmr, ch->id);
+}
+
+static uint16_t read_tcnt(RenesasTMR8State *tmr, unsigned int size, int ch)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t delta;
+    uint8_t ret[2];
+    int i;
+
+    switch (size) {
+    case 1:
+        if (tmr->ch[ch].clk > 0) {
+            delta = now - tmr->ch[ch].base;
+            delta /= tmr->ch[ch].clk;
+        } else {
+            delta = 0;
+        }
+        return tmr->ch[ch].cnt + delta;
+    case 2:
+        if (is_word_mode(tmr)) {
+            /* 16bit count mode */
+            delta = now - tmr->ch[1].base;
+            delta /= tmr->ch[1].clk;
+            return catreg(tmr->ch[0].cnt, tmr->ch[1].cnt) + delta;
+        } else {
+            for (i = 0; i < TMR_CH; i++) {
+                if (tmr->ch[i].clk > 0) {
+                    delta = now - tmr->ch[i].base;
+                    delta /= tmr->ch[i].clk;
+                } else {
+                    delta = 0;
+                }
+                ret[i] = tmr->ch[i].cnt + delta;
+            }
+            return catreg(ret[0], ret[1]);
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tmr_pck_update(void *opaque)
+{
+    RenesasTMR8State *tmr = opaque;
+    int i;
+    uint16_t tcnt = read_tcnt(tmr, 2, 0);
+
+    tmr->ch[0].cnt = extract16(tcnt, 8, 8);
+    tmr->ch[1].cnt = extract16(tcnt, 0, 8);
+
+    tmr->input_freq = clock_get_hz(tmr->pck);
+    for (i = 0; i < TMR_CH; i++) {
+        if (clock_is_enabled(tmr->pck)) {
+            update_clk(tmr, i);
+            set_next_event(tmr, i);
+        } else {
+            if (tmr->ch[i].timer) {
+                timer_del(tmr->ch[i].timer);
+            }
+        }
+    }
+}
+
+static int validate_access(hwaddr addr, unsigned int size)
+{
+    /* Byte access always OK */
+    if (size == 1) {
+        return 1;
+    }
+    /* word access allowed TCNT / TCOR / TCCR */
+    return ((addr & 1) == 0 && addr >= A_TCORA);
+}
+
+static uint64_t tmr8_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    RenesasTMR8State *tmr = opaque;
+    int ch = addr & 1;
+    int cor;
+
+    if (!validate_access(addr, size)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr8: Invalid read size 0x%"
+                      HWADDR_PRIX "\n", addr);
+        return UINT64_MAX;
+    }
+    if (!clock_is_enabled(tmr->pck)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr8: Unit %d is stopped.\n",
+                      tmr->unit);
+        return UINT64_MAX;
+    }
+    switch (addr & ~1) {
+    case A_TCR:
+        return tmr->ch[ch].tcr;
+    case A_TCSR:
+        return tmr->ch[ch].tcsr;
+    case A_TCORA:
+    case A_TCORB:
+        cor = extract32(addr, 1, 1);
+        if (size == 1) {
+            /* 8bit read - single register */
+            return tmr->ch[ch].cor[cor];
+        } else {
+            /* 16bit read - high byte ch0 reg, low byte ch1 reg */
+            return catreg(tmr->ch[0].cor[cor], tmr->ch[1].cor[cor]);
+        }
+    case A_TCNT:
+        return read_tcnt(tmr, size, ch);
+    case A_TCCR:
+        if (size == 1) {
+            return tmr->ch[ch].tccr;
+        } else {
+            return catreg(tmr->ch[0].tccr, tmr->ch[1].tccr);
+        }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr8: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+static void tmr8_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RenesasTMR8State *tmr = opaque;
+    int ch = addr & 1;
+    int cor;
+    int64_t now;
+
+    if (!validate_access(addr, size)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_tmr: Invalid write size 0x%" HWADDR_PRIX
+                      "\n", addr);
+        return;
+    }
+    if (!clock_is_enabled(tmr->pck)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr8: Unit %d is stopped.\n",
+                      tmr->unit);
+        return;
+    }
+    switch (addr & ~1) {
+    case A_TCR:
+        tmr->ch[ch].tcr = val;
+        break;
+    case A_TCSR:
+        if (ch == 1) {
+            /* CH1 ADTR always 1 */
+            val = FIELD_DP8(val, TCSR, ADTE, 1);
+        }
+        tmr->ch[ch].tcsr = val;
+        break;
+    case A_TCORA:
+    case A_TCORB:
+        cor = extract32(addr, 1, 1);
+        if (size == 1) {
+            tmr->ch[ch].cor[cor] = val;
+        } else {
+            tmr->ch[0].cor[cor] = extract32(val, 0, 8);
+            tmr->ch[1].cor[cor] = extract32(val, 8, 8);
+        }
+        break;
+    case A_TCNT:
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (size == 1) {
+            tmr->ch[ch].base = now;
+            tmr->ch[ch].cnt = val;
+        } else {
+            tmr->ch[0].base = tmr->ch[1].base = now;
+            tmr->ch[0].cnt = extract32(val, 0, 8);
+            tmr->ch[1].cnt = extract32(val, 8, 8);
+        }
+        break;
+    case A_TCCR:
+        val &= ~0x6060;
+        if (size == 1) {
+            tmr->ch[ch].tccr = val;
+            update_clk(tmr, ch);
+        } else {
+            tmr->ch[0].tccr = extract32(val, 0, 8);
+            tmr->ch[1].tccr = extract32(val, 8, 8);
+            update_clk(tmr, 0);
+            update_clk(tmr, 1);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        return;
+    }
+    if (size == 1) {
+        set_next_event(tmr, ch);
+    } else {
+        set_next_event(tmr, 0);
+        set_next_event(tmr, 1);
+    }
+}
+
+static const MemoryRegionOps tmr_ops = {
+    .write = tmr8_write,
+    .read  = tmr8_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void tmr8_realize(DeviceState *dev, Error **errp)
+{
+    RenesasTMR8State *tmr = RenesasTMR8(dev);
+    int i;
+
+    for (i = 0; i < TMR_CH; i++) {
+        tmr->ch[i].id = i;
+        tmr->ch[i].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        timer_event, &tmr->ch[i]);
+        tmr->ch[i].tmrp = tmr;
+        tmr->ch[i].tcr = 0x00;
+        tmr->ch[i].tcsr = (i == 0) ? 0x00 : 0x10;
+        tmr->ch[i].cnt = 0x00;
+        tmr->ch[i].cor[0] = 0xff;
+        tmr->ch[i].cor[1] = 0xff;
+        tmr->ch[i].tccr = 0x00;
+    }
+}
+
+static void tmr8_init(Object *obj)
+{
+    RenesasTMR8State *tmr = RenesasTMR8(obj);
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    int i;
+
+    memory_region_init_io(&tmr->memory, obj, &tmr_ops,
+                          tmr, "renesas-tmr8", 0x10);
+    sysbus_init_mmio(d, &tmr->memory);
+
+    for (i = 0; i < TMR_CH; i++) {
+        sysbus_init_irq(d, &tmr->ch[i].irq[IRQ_CMIA]);
+        sysbus_init_irq(d, &tmr->ch[i].irq[IRQ_CMIB]);
+        sysbus_init_irq(d, &tmr->ch[i].irq[IRQ_OVI]);
+    }
+    tmr->pck = qdev_init_clock_in(DEVICE(d), "pck",
+                                  tmr_pck_update, tmr);
+}
+
+static const VMStateDescription vmstate_rtmr = {
+    .name = "renesas-8tmr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property tmr8_properties[] = {
+    DEFINE_PROP_UINT32("unit", RenesasTMR8State, unit, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tmr8_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rtmr;
+    dc->realize = tmr8_realize;
+    device_class_set_props(dc, tmr8_properties);
+}
+
+static const TypeInfo tmr8_info = {
+    .name       = TYPE_RENESAS_TMR8,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RenesasTMR8State),
+    .instance_init = tmr8_init,
+    .class_init = tmr8_class_init,
+};
+
+static void tmr8_register_types(void)
+{
+    type_register_static(&tmr8_info);
+}
+
+type_init(tmr8_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 8749edfb6a..5288660cda 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -36,7 +36,7 @@ config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
 
-config RENESAS_TMR
+config RENESAS_TMR8
     bool
 
 config RENESAS_CMT
@@ -44,3 +44,4 @@ config RENESAS_CMT
 
 config AVR_TIMER16
     bool
+
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 9f0a267c83..a02e45fdbd 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -8,7 +8,7 @@ softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_timer.c'))
 softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_ttc.c'))
 softmmu_ss.add(when: 'CONFIG_CMSDK_APB_DUALTIMER', if_true: files('cmsdk-apb-dualtimer.c'))
 softmmu_ss.add(when: 'CONFIG_CMSDK_APB_TIMER', if_true: files('cmsdk-apb-timer.c'))
-softmmu_ss.add(when: 'CONFIG_RENESAS_TMR', if_true: files('renesas_tmr.c'))
+softmmu_ss.add(when: 'CONFIG_RENESAS_TMR8', if_true: files('renesas_tmr8.c'))
 softmmu_ss.add(when: 'CONFIG_RENESAS_CMT', if_true: files('renesas_cmt.c'))
 softmmu_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
 softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_timer.c'))
-- 
2.20.1


