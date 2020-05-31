Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A591C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1F120723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1F120723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfQpe-0003DM-32
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jfQlM-0004Dn-Nb
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:36014)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jfQlK-0004K1-17
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 4AB04105230;
 Mon,  1 Jun 2020 01:24:33 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id C54D51C0DB7;
 Mon,  1 Jun 2020 01:24:32 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] hw/timer: Renesas TMU/CMT module.
Date: Mon,  1 Jun 2020 01:24:20 +0900
Message-Id: <20200531162427.57410-4-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200531162427.57410-1-ysato@users.sourceforge.jp>
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:24:33
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

TMU - SH4 Timer module.
CMT - Compare and match timer used by some Renesas MCUs.

The two modules have similar interfaces and have been merged.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/timer/renesas_timer.h |  59 +++++
 hw/timer/renesas_timer.c         | 421 +++++++++++++++++++++++++++++++
 hw/timer/Kconfig                 |   3 +
 hw/timer/Makefile.objs           |   1 +
 4 files changed, 484 insertions(+)
 create mode 100644 include/hw/timer/renesas_timer.h
 create mode 100644 hw/timer/renesas_timer.c

diff --git a/include/hw/timer/renesas_timer.h b/include/hw/timer/renesas_timer.h
new file mode 100644
index 0000000000..f9a2661203
--- /dev/null
+++ b/include/hw/timer/renesas_timer.h
@@ -0,0 +1,59 @@
+/*
+ * Renesas Timer unit Object
+ *
+ * Copyright (c) 2020 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_TIMER_H
+#define HW_RENESAS_TIMER_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TIMER "renesas-timer"
+#define RTIMER(obj) OBJECT_CHECK(RTIMERState, (obj), TYPE_RENESAS_TIMER)
+
+enum {
+    TIMER_CH_CMT = 2,
+    /* TMU have 5channels. It separated 0-2 and 3-4. */
+    TIMER_CH_TMU = 3,
+};
+
+enum {
+    RTIMER_FEAT_CMT,
+    RTIMER_FEAT_TMU_LOW,
+    RTIMER_FEAT_TMU_HIGH,
+};
+
+struct RTIMERState;
+
+struct channel_rtimer {
+    uint32_t cnt;
+    uint32_t cor;
+    uint16_t ctrl;
+    qemu_irq irq;
+    int64_t base;
+    int64_t next;
+    uint64_t clk;
+    bool start;
+    QEMUTimer *timer;
+    struct RTIMERState *tmrp;
+};
+
+typedef struct RTIMERState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+    MemoryRegion memory_p4;
+    MemoryRegion memory_a7;
+
+    uint8_t tocr;
+    struct channel_rtimer ch[TIMER_CH_TMU];
+    uint32_t feature;
+    int num_ch;
+} RTIMERState;
+
+#endif
diff --git a/hw/timer/renesas_timer.c b/hw/timer/renesas_timer.c
new file mode 100644
index 0000000000..459c7a4708
--- /dev/null
+++ b/hw/timer/renesas_timer.c
@@ -0,0 +1,421 @@
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
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/timer/renesas_timer.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG32(TOCR, 0)
+  FIELD(TOCR, TCOE, 0, 1)
+REG32(TSTR, 4)
+REG32(TCOR, 8)
+REG32(TCNT, 12)
+REG32(TCR, 16)
+  FIELD(TCR, TPSC, 0, 3)
+  FIELD(TCR, CKEG, 3, 2)
+  FIELD(TCR, UNIE, 5, 1)
+  FIELD(TCR, ICPE, 6, 2)
+  FIELD(TCR, UNF, 8, 1)
+  FIELD(TCR, ICPF, 9, 1)
+REG32(CMCR, 16)
+  FIELD(CMCR, CKS, 0, 2)
+  FIELD(CMCR, CMIE, 6, 1)
+REG32(TCPR, 20)
+
+#define IS_CMT(t) (t->feature == RTIMER_FEAT_CMT)
+
+static int clkdiv(RTIMERState *tmr, int ch)
+{
+    if (IS_CMT(tmr)) {
+        return 8 << (2 * FIELD_EX16(tmr->ch[ch].ctrl, CMCR, CKS));
+    } else {
+        if (FIELD_EX16(tmr->ch[ch].ctrl, TCR, TPSC) <= 5) {
+            return 4 << (2 * FIELD_EX16(tmr->ch[ch].ctrl, TCR, TPSC));
+        } else {
+            return 0;
+        }
+    }
+}
+
+static void set_next_event(struct channel_rtimer *ch, int64_t now)
+{
+    int64_t next;
+    RTIMERState *tmr = ch->tmrp;
+    if (IS_CMT(tmr)) {
+        next = ch->cor - ch->cnt;
+    } else {
+        next = ch->cnt;
+    }
+    next *= ch->clk;
+    ch->base = now;
+    ch->next = now + next;
+    timer_mod(ch->timer, ch->next);
+}
+
+static void timer_event(void *opaque)
+{
+    struct channel_rtimer *ch = opaque;
+    RTIMERState *tmr = ch->tmrp;
+
+    if (IS_CMT(tmr)) {
+        ch->cnt = 0;
+        if (FIELD_EX16(ch->ctrl, CMCR, CMIE)) {
+            qemu_irq_pulse(ch->irq);
+        }
+    } else {
+        ch->cnt = ch->cor;
+        if (!FIELD_EX16(ch->ctrl, TCR, UNF)) {
+            ch->ctrl = FIELD_DP16(ch->ctrl, TCR, UNF, 1);
+            qemu_set_irq(ch->irq, FIELD_EX16(ch->ctrl, TCR, UNIE));
+        }
+    }
+    set_next_event(ch, ch->next);
+}
+
+static int64_t read_tcnt(RTIMERState *tmr, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (tmr->ch[ch].clk > 0) {
+        delta = (now - tmr->ch[ch].base);
+        delta /= tmr->ch[ch].clk;
+        if (IS_CMT(tmr)) {
+            return delta;
+        } else {
+            return tmr->ch[ch].cnt - delta;
+        }
+    } else {
+        return tmr->ch[ch].cnt;
+    }
+}
+
+static void tmr_start_stop(RTIMERState *tmr, int ch, int start)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    tmr->ch[ch].start = start;
+    if (start) {
+        if (!tmr->ch[ch].timer) {
+            tmr->ch[ch].timer =
+                timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event, &tmr->ch[ch]);
+        }
+        set_next_event(&tmr->ch[ch], now);
+    } else {
+        tmr->ch[ch].cnt = read_tcnt(tmr, ch);
+        tmr->ch[ch].next = 0;
+        if (tmr->ch[ch].timer) {
+            timer_del(tmr->ch[ch].timer);
+        }
+    }
+}
+
+static void timer_register(RTIMERState *tmr, hwaddr addr, int *ch, int *reg)
+{
+    if (IS_CMT(tmr)) {
+        /*  +0 - CMSTR (TSTR)  */
+        /*  +2 - CMCR0  (TCR)  */
+        /*  +4 - CMCNT0 (TCNT) */
+        /*  +6 - CMCOR0 (TCOR) */
+        /*  +8 - CMCR1  (TCR)  */
+        /* +10 - CMCNT1 (TCNT) */
+        /* +12 - CMCOR1 (TCOR) */
+        addr /= 2;
+        if (addr > 6) {
+            /* Out of register area */
+            *reg = -1;
+            return;
+        }
+        if (addr == 0) {
+            *ch = -1;
+            *reg = R_TSTR;
+        } else {
+            *ch = addr / 4;
+            if (addr < 4) {
+                /* skip CMSTR */
+                addr--;
+            }
+            *reg = 2 - (addr % 4);
+        }
+    } else {
+        /*  +0 - TCOR  */
+        /*  +4 - TSTR  */
+        /*  +8 - TCOR0 */
+        /* +12 - TCNT0 */
+        /* +16 - TCR0  */
+        /* +20 - TCOR1 */
+        /* +24 - TCNT1 */
+        /* +28 - TCR1  */
+        /* +32 - TCOR2 */
+        /* +36 - TCNT2 */
+        /* +40 - TCR2  */
+        /* +44 - TCPR2 */
+        if (tmr->feature == RTIMER_FEAT_TMU_HIGH && addr >= 8) {
+            *reg = -1;
+            return;
+        }
+        addr /= 4;
+        if (addr < 2) {
+            *ch = -1;
+            *reg = addr;
+        } else if (addr < 11) {
+            *ch = (addr - 2) / 3;
+            *reg = (addr - 2) % 3 + 2;
+        } else {
+            *ch = 2;
+            *reg = R_TCPR;
+        }
+    }
+}
+
+static uint64_t read_tstr(RTIMERState *tmr)
+{
+    uint64_t ret = 0;
+    int ch;
+    for (ch = 0; ch < tmr->num_ch; ch++) {
+        ret = deposit64(ret, ch, 1, tmr->ch[ch].start);
+    }
+    return ret;
+}
+
+static void update_clk(RTIMERState *tmr, int ch)
+{
+    int tpsc;
+    int t;
+    if (!IS_CMT(tmr)) {
+        /* Clock setting validation */
+        tpsc = FIELD_EX16(tmr->ch[ch].ctrl, TCR, TPSC);
+        switch (tpsc) {
+        case 5:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "renesas_timer: Invalid TPSC valule %d.", tpsc);
+            break;
+        case 6:
+        case 7:
+            qemu_log_mask(LOG_UNIMP,
+                          "renesas_timer: External clock not implemented.");
+            break;
+        }
+        /* Interrupt clear */
+        if (FIELD_EX16(tmr->ch[ch].ctrl, TCR, UNF) == 0) {
+            qemu_set_irq(tmr->ch[ch].irq, 0);
+        }
+    }
+    t = clkdiv(tmr, ch);
+    if (t > 0) {
+        t = tmr->input_freq / t;
+        tmr->ch[ch].clk = NANOSECONDS_PER_SECOND / t;
+    } else {
+        tmr->ch[ch].clk = 0;
+    }
+}
+
+static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RTIMERState *tmr = opaque;
+    int ch = -1, reg = -1;
+
+    timer_register(tmr, addr, &ch, &reg);
+    switch (reg) {
+    case R_TOCR:
+        return tmr->tocr;
+    case R_TSTR:
+        return read_tstr(tmr);
+    case R_TCR:
+        return tmr->ch[ch].ctrl;
+    case R_TCNT:
+        if (tmr->ch[ch].start) {
+            return read_tcnt(tmr, ch);
+        } else {
+            return tmr->ch[ch].cnt;
+        }
+    case R_TCOR:
+        return tmr->ch[ch].cor;
+    case R_TCPR:
+        qemu_log_mask(LOG_UNIMP,
+                      "renesas_timer: Input capture not implemented\n");
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_timer: Register 0x%"
+                      HWADDR_PRIX " not implemented\n", addr);
+    }
+    return UINT64_MAX;
+}
+
+static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RTIMERState *tmr = opaque;
+    int ch = -1, reg = -1;
+    uint16_t tcr_mask;
+
+    timer_register(tmr, addr, &ch, &reg);
+    switch (reg) {
+    case R_TOCR:
+        tmr->tocr = FIELD_DP8(tmr->tocr, TOCR, TCOE,
+                              FIELD_EX8(val, TOCR, TCOE));
+        break;
+    case R_TSTR:
+        for (ch = 0; ch < tmr->num_ch; ch++) {
+            tmr_start_stop(tmr, ch, extract32(val, ch, 1));
+        }
+        break;
+    case R_TCR:
+        switch (tmr->feature) {
+        case RTIMER_FEAT_CMT:
+            tcr_mask = 0x00a3;
+            /* bit7 always 1 */
+            val |= 0x0080;
+            break;
+        case RTIMER_FEAT_TMU_LOW:
+            tcr_mask = (ch < 2) ? 0x013f : 0x03ff;
+            break;
+        case RTIMER_FEAT_TMU_HIGH:
+            tcr_mask = 0x0127;
+            break;
+        default:
+            tcr_mask = 0x00ff;
+            break;
+        }
+        /* Upper byte write only 0 */
+        tmr->ch[ch].ctrl |= (tcr_mask & 0x00ff);
+        tmr->ch[ch].ctrl &= val & tcr_mask;
+        update_clk(tmr, ch);
+        break;
+    case R_TCNT:
+        tmr->ch[ch].cnt = val;
+        break;
+    case R_TCOR:
+        tmr->ch[ch].cor = val;
+        break;
+    case R_TCPR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_timer: TCPR is read only.");
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_timer: Register 0x%"
+                      HWADDR_PRIX " not implemented\n", addr);
+    }
+}
+
+static const MemoryRegionOps tmr_ops = {
+    .write = tmr_write,
+    .read  = tmr_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 4,
+    },
+};
+
+static void rtimer_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    RTIMERState *tmr = RTIMER(dev);
+    int i;
+    int ch;
+
+    if (tmr->input_freq == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_timer: input-freq property must be set.");
+        return;
+    }
+    if (IS_CMT(tmr)) {
+        memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                              tmr, "renesas-cmt", 0x10);
+        sysbus_init_mmio(d, &tmr->memory);
+
+        for (i = 0; i < TIMER_CH_CMT; i++) {
+            sysbus_init_irq(d, &tmr->ch[i].irq);
+        }
+        tmr->num_ch = 2;
+    } else {
+        memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                              tmr, "renesas-tmu", 0x30);
+        sysbus_init_mmio(d, &tmr->memory);
+        memory_region_init_alias(&tmr->memory_p4, NULL, "renesas-tmu-p4",
+                                 &tmr->memory, 0, 0x30);
+        sysbus_init_mmio(d, &tmr->memory_p4);
+        memory_region_init_alias(&tmr->memory_a7, NULL, "renesas-tmu-a7",
+                                 &tmr->memory, 0, 0x30);
+        sysbus_init_mmio(d, &tmr->memory_a7);
+        ch = (tmr->feature == RTIMER_FEAT_TMU_LOW) ?
+            TIMER_CH_TMU : TIMER_CH_TMU - 1;
+        for (i = 0; i < ch; i++) {
+            sysbus_init_irq(d, &tmr->ch[i].irq);
+        }
+        tmr->num_ch = (tmr->feature == RTIMER_FEAT_TMU_LOW) ? 3 : 2;
+    }
+    for (ch = 0; ch < tmr->num_ch; ch++) {
+        tmr->ch[ch].tmrp = tmr;
+        update_clk(tmr, ch);
+        if (IS_CMT(tmr)) {
+            tmr->ch[ch].cor = 0xffff;
+        } else {
+            tmr->ch[ch].cor = tmr->ch[ch].cnt = 0xffffffff;
+        }
+    }
+}
+
+static const VMStateDescription vmstate_rtimer = {
+    .name = "rx-cmt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rtimer_properties[] = {
+    DEFINE_PROP_UINT32("feature", RTIMERState, feature, 0),
+    DEFINE_PROP_UINT64("input-freq", RTIMERState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rtimer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rtimer;
+    dc->realize = rtimer_realize;
+    device_class_set_props(dc, rtimer_properties);
+}
+
+static const TypeInfo rtimer_info = {
+    .name       = TYPE_RENESAS_TIMER,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RTIMERState),
+    .class_init = rtimer_class_init,
+};
+
+static void rtimer_register_types(void)
+{
+    type_register_static(&rtimer_info);
+}
+
+type_init(rtimer_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 93f62999eb..ff4b0cd0bc 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -38,3 +38,6 @@ config CMSDK_APB_DUALTIMER
 
 config RENESAS_8TMR
     bool
+
+config RENESAS_TIMER
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 9ea88b964d..289b6b03ab 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -37,3 +37,4 @@ common-obj-$(CONFIG_MSF2) += mss-timer.o
 common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
 
 common-obj-$(CONFIG_RENESAS_8TMR) += renesas_8timer.o
+common-obj-$(CONFIG_RENESAS_TIMER) += renesas_timer.o
-- 
2.20.1


