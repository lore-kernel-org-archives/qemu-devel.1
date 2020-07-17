Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1D1206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAcMuXrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1D1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJWR-0000Y0-HW
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JD8RXwsKCuUOZRPUULTVLUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSr-0003PS-4o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:21 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:53281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JD8RXwsKCuUOZRPUULTVLUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSo-0005EM-F7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:20 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id d27so10092010ybe.20
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=H0eIDQzJJdz5R8/ksmV97usqmY+YDzuGYi8npQpmCBE=;
 b=kAcMuXrpm9kjH74HMbo72enPjU1yBADXnupxrit9iBsAfzgFiyS5RgoVXqhbd09Bzh
 tO1hnZfPnRHzNhUdiE0DEEJUmDQcwDjckHry6uDmDdG4PEhHgtMVoy13D6wKItkVCCKB
 +kHOr8HtQXrMOq+VLAeHjRUtJwKq8icow8PHp4l35klBWHiO1xvUIBPSh3H0UCXUftgM
 Ko/vJDyWMGurNgW5/eHRKQrgBLpnUq4qAN0W70Ks227/JNE/BDBBCxNVWLCzW44RAj/c
 DRAdMU6M2a94GNFaRCcxFLT+siANqnf1WmYr20h/6TV+ZKudK1XFG7JAcSUUhzqV+Dp8
 HadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=H0eIDQzJJdz5R8/ksmV97usqmY+YDzuGYi8npQpmCBE=;
 b=njyLYrpxT7GhFmA7N0yKT1m3rF9br1Zz3ZroXlmEckDX5jhbSAbrnNis5RH/D4niZ6
 k5qMd8RgwUp0jdW0X4yASpQtX8wjvkWpWIjeHOTQv7MqkuSFG9yVOf5fx3/WqM1XT96X
 trQW31m454r1SQJnQ+TOeSAiVJL9dGAGTkWUD8WmJsIazxF8mAt+MMF6VpvxVUgBaTJm
 maMqrrFJJeEJK3TUsK72FHjw65k+i931vYPa+bW+W9ncHlXGJ2l4wT8idv2VDYbV9bqU
 rImofg6v+t2AFnXhKs7JzPiZVUSQwFUk9V5uUhDE7bD/5e6qnBPD459GFMk0wBSLHSd7
 siAw==
X-Gm-Message-State: AOAM531TSOHRS0f7ypfR1JyThD33bEXCj5NbNpNXC18+Zwdg9+H42VN6
 DoJOaEPW8FCS1NI4+Y4YiYxwD5aJUMW4qXpkNVqdhYlW48M7MKRz4vmztPBlytiUEq7RZn/xJt+
 jqHc8faOwD8hlnSfSxIqyjLIUtDb1MbgYwRlz0k2UVUlLaKtdEntDg9wqN7n1AbyKKnCWEzWOhQ
 ==
X-Google-Smtp-Source: ABdhPJyLSMdwg7I2sbtd4bJie9Nc7FDNgWVYSRbmPv2BEcsbkX28HcXqaNIVA8FOyavGg6TkKOd3i2e/TD7PZCvxPg==
X-Received: by 2002:a25:9c44:: with SMTP id x4mr11616569ybo.510.1594965796970; 
 Thu, 16 Jul 2020 23:03:16 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:48 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-4-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 03/13] hw/timer: Add NPCM7xx Timer device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3JD8RXwsKCuUOZRPUULTVLUNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The NPCM730 and NPCM750 SoCs have three timer modules each holding five
timers and some shared registers (e.g. interrupt status).

Each timer runs at 25 MHz divided by a prescaler, and counts down from a
configurable initial value to zero. When zero is reached, the interrupt
flag for the timer is set, and the timer is disabled (one-shot mode) or
reloaded from its initial value (periodic mode).

This implementation is sufficient to boot a Linux kernel configured for
NPCM750. Note that the kernel does not seem to actually turn on the
interrupts.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 include/hw/timer/npcm7xx_timer.h |  96 ++++++
 hw/timer/npcm7xx_timer.c         | 489 +++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs           |   1 +
 hw/timer/trace-events            |   5 +
 4 files changed, 591 insertions(+)
 create mode 100644 include/hw/timer/npcm7xx_timer.h
 create mode 100644 hw/timer/npcm7xx_timer.c

diff --git a/include/hw/timer/npcm7xx_timer.h b/include/hw/timer/npcm7xx_timer.h
new file mode 100644
index 0000000000..94900a7877
--- /dev/null
+++ b/include/hw/timer/npcm7xx_timer.h
@@ -0,0 +1,96 @@
+/*
+ * Nuvoton NPCM7xx Timer Controller
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
+#ifndef NPCM7XX_TIMER_H
+#define NPCM7XX_TIMER_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+
+/* Each Timer Module (TIM) instance holds five 25 MHz timers. */
+#define NPCM7XX_TIMERS_PER_CTRL (5)
+
+/**
+ * enum NPCM7xxTimerRegisters - 32-bit register indices.
+ */
+enum NPCM7xxTimerRegisters {
+    NPCM7XX_TIMER_TCSR0,
+    NPCM7XX_TIMER_TCSR1,
+    NPCM7XX_TIMER_TICR0,
+    NPCM7XX_TIMER_TICR1,
+    NPCM7XX_TIMER_TDR0,
+    NPCM7XX_TIMER_TDR1,
+    NPCM7XX_TIMER_TISR,
+    NPCM7XX_TIMER_WTCR,
+    NPCM7XX_TIMER_TCSR2,
+    NPCM7XX_TIMER_TCSR3,
+    NPCM7XX_TIMER_TICR2,
+    NPCM7XX_TIMER_TICR3,
+    NPCM7XX_TIMER_TDR2,
+    NPCM7XX_TIMER_TDR3,
+    NPCM7XX_TIMER_TCSR4         = 0x0040 / sizeof(uint32_t),
+    NPCM7XX_TIMER_TICR4         = 0x0048 / sizeof(uint32_t),
+    NPCM7XX_TIMER_TDR4          = 0x0050 / sizeof(uint32_t),
+    NPCM7XX_TIMER_NR_REGS,
+};
+
+typedef struct NPCM7xxTimerCtrlState NPCM7xxTimerCtrlState;
+
+/**
+ * struct NPCM7xxTimer - Individual timer state.
+ * @irq: GIC interrupt line to fire on expiration (if enabled).
+ * @qtimer: QEMU timer that notifies us on expiration.
+ * @expires_ns: Absolute virtual expiration time.
+ * @remaining_ns: Remaining time until expiration if timer is paused.
+ * @tcsr: The Timer Control and Status Register.
+ * @ticr: The Timer Initial Count Register.
+ */
+typedef struct NPCM7xxTimer {
+    NPCM7xxTimerCtrlState *ctrl;
+
+    qemu_irq    irq;
+    QEMUTimer   qtimer;
+    int64_t     expires_ns;
+    int64_t     remaining_ns;
+
+    uint32_t    tcsr;
+    uint32_t    ticr;
+} NPCM7xxTimer;
+
+/**
+ * struct NPCM7xxTimerCtrlState - Timer Module device state.
+ * @parent: System bus device.
+ * @iomem: Memory region through which registers are accessed.
+ * @tisr: The Timer Interrupt Status Register.
+ * @wtcr: The Watchdog Timer Control Register.
+ * @timer: The five individual timers managed by this module.
+ */
+struct NPCM7xxTimerCtrlState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint32_t    tisr;
+    uint32_t    wtcr;
+
+    NPCM7xxTimer timer[NPCM7XX_TIMERS_PER_CTRL];
+};
+
+#define TYPE_NPCM7XX_TIMER "npcm7xx-timer"
+#define NPCM7XX_TIMER(obj)                                              \
+    OBJECT_CHECK(NPCM7xxTimerCtrlState, (obj), TYPE_NPCM7XX_TIMER)
+
+#endif /* NPCM7XX_TIMER_H */
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
new file mode 100644
index 0000000000..9f9a7048f2
--- /dev/null
+++ b/hw/timer/npcm7xx_timer.c
@@ -0,0 +1,489 @@
+/*
+ * Nuvoton NPCM7xx Timer Controller
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
+#include "hw/irq.h"
+#include "hw/misc/npcm7xx_clk.h"
+#include "hw/timer/npcm7xx_timer.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+/* Register field definitions. */
+#define NPCM7XX_TCSR_CEN                BIT(30)
+#define NPCM7XX_TCSR_IE                 BIT(29)
+#define NPCM7XX_TCSR_PERIODIC           BIT(27)
+#define NPCM7XX_TCSR_CRST               BIT(26)
+#define NPCM7XX_TCSR_CACT               BIT(25)
+#define NPCM7XX_TCSR_RSVD               0x21ffff00
+#define NPCM7XX_TCSR_PRESCALE_START     0
+#define NPCM7XX_TCSR_PRESCALE_LEN       8
+
+/*
+ * Returns the index of timer in the tc->timer array. This can be used to
+ * locate the registers that belong to this timer.
+ */
+static int npcm7xx_timer_index(NPCM7xxTimerCtrlState *tc, NPCM7xxTimer *timer)
+{
+    int index = timer - tc->timer;
+
+    g_assert(index >= 0 && index < NPCM7XX_TIMERS_PER_CTRL);
+
+    return index;
+}
+
+/* Return the value by which to divide the reference clock rate. */
+static uint32_t npcm7xx_timer_prescaler(const NPCM7xxTimer *t)
+{
+    return extract32(t->tcsr, NPCM7XX_TCSR_PRESCALE_START,
+                     NPCM7XX_TCSR_PRESCALE_LEN) + 1;
+}
+
+/* Convert a timer cycle count to a time interval in nanoseconds. */
+static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *t, uint32_t count)
+{
+    int64_t ns = count;
+
+    ns *= NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ;
+    ns *= npcm7xx_timer_prescaler(t);
+
+    return ns;
+}
+
+/* Convert a time interval in nanoseconds to a timer cycle count. */
+static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
+{
+    int64_t count;
+
+    count = ns / (NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ);
+    count /= npcm7xx_timer_prescaler(t);
+
+    return count;
+}
+
+/*
+ * Raise the interrupt line if there's a pending interrupt and interrupts are
+ * enabled for this timer. If not, lower it.
+ */
+static void npcm7xx_timer_check_interrupt(NPCM7xxTimer *t)
+{
+    NPCM7xxTimerCtrlState *tc = t->ctrl;
+    int index = npcm7xx_timer_index(tc, t);
+
+    if ((t->tcsr & NPCM7XX_TCSR_IE) && (tc->tisr & BIT(index))) {
+        qemu_irq_raise(t->irq);
+        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 1);
+    } else {
+        qemu_irq_lower(t->irq);
+        trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, 0);
+    }
+}
+
+/* Start or resume the timer. */
+static void npcm7xx_timer_start(NPCM7xxTimer *t)
+{
+    int64_t now;
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    t->expires_ns = now + t->remaining_ns;
+    timer_mod(&t->qtimer, t->expires_ns);
+}
+
+/*
+ * Called when the counter reaches zero. Sets the interrupt flag, and either
+ * restarts or disables the timer.
+ */
+static void npcm7xx_timer_reached_zero(NPCM7xxTimer *t)
+{
+    NPCM7xxTimerCtrlState *tc = t->ctrl;
+    int index = npcm7xx_timer_index(tc, t);
+
+    tc->tisr |= BIT(index);
+
+    if (t->tcsr & NPCM7XX_TCSR_PERIODIC) {
+        t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
+        if (t->tcsr & NPCM7XX_TCSR_CEN) {
+            npcm7xx_timer_start(t);
+        }
+    } else {
+        t->tcsr &= ~(NPCM7XX_TCSR_CEN | NPCM7XX_TCSR_CACT);
+    }
+
+    npcm7xx_timer_check_interrupt(t);
+}
+
+/* Stop counting. Record the time remaining so we can continue later. */
+static void npcm7xx_timer_pause(NPCM7xxTimer *t)
+{
+    int64_t now;
+
+    timer_del(&t->qtimer);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    t->remaining_ns = t->expires_ns - now;
+    g_assert(t->remaining_ns > 0);
+}
+
+/*
+ * Restart the timer from its initial value. If the timer was enabled and stays
+ * enabled, adjust the QEMU timer according to the new count. If the timer is
+ * transitioning from disabled to enabled, the caller is expected to start the
+ * timer later.
+ */
+static void npcm7xx_timer_restart(NPCM7xxTimer *t, uint32_t old_tcsr)
+{
+    t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
+
+    if (old_tcsr & t->tcsr & NPCM7XX_TCSR_CEN) {
+        npcm7xx_timer_start(t);
+    }
+}
+
+/* Register read and write handlers */
+
+static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
+{
+    uint32_t old_tcsr = t->tcsr;
+
+    if (new_tcsr & NPCM7XX_TCSR_RSVD) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits in 0x%08x ignored\n",
+                      __func__, new_tcsr);
+        new_tcsr &= ~NPCM7XX_TCSR_RSVD;
+    }
+    if (new_tcsr & NPCM7XX_TCSR_CACT) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only bits in 0x%08x ignored\n",
+                      __func__, new_tcsr);
+        new_tcsr &= ~NPCM7XX_TCSR_CACT;
+    }
+
+    t->tcsr = (t->tcsr & NPCM7XX_TCSR_CACT) | new_tcsr;
+
+    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_IE) {
+        npcm7xx_timer_check_interrupt(t);
+    }
+    if (new_tcsr & NPCM7XX_TCSR_CRST) {
+        npcm7xx_timer_restart(t, old_tcsr);
+        t->tcsr &= ~NPCM7XX_TCSR_CRST;
+    }
+    if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_CEN) {
+        if (new_tcsr & NPCM7XX_TCSR_CEN) {
+            npcm7xx_timer_start(t);
+        } else {
+            npcm7xx_timer_pause(t);
+        }
+    }
+}
+
+static void npcm7xx_timer_write_ticr(NPCM7xxTimer *t, uint32_t new_ticr)
+{
+    t->ticr = new_ticr;
+
+    npcm7xx_timer_restart(t, t->tcsr);
+}
+
+static uint32_t npcm7xx_timer_read_tdr(NPCM7xxTimer *t)
+{
+    if (t->tcsr & NPCM7XX_TCSR_CEN) {
+        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+        return npcm7xx_timer_ns_to_count(t, t->expires_ns - now);
+    }
+
+    return npcm7xx_timer_ns_to_count(t, t->remaining_ns);
+}
+
+static hwaddr npcm7xx_tcsr_index(hwaddr reg)
+{
+    switch (reg) {
+    case NPCM7XX_TIMER_TCSR0:
+        return 0;
+    case NPCM7XX_TIMER_TCSR1:
+        return 1;
+    case NPCM7XX_TIMER_TCSR2:
+        return 2;
+    case NPCM7XX_TIMER_TCSR3:
+        return 3;
+    case NPCM7XX_TIMER_TCSR4:
+        return 4;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static hwaddr npcm7xx_ticr_index(hwaddr reg)
+{
+    switch (reg) {
+    case NPCM7XX_TIMER_TICR0:
+        return 0;
+    case NPCM7XX_TIMER_TICR1:
+        return 1;
+    case NPCM7XX_TIMER_TICR2:
+        return 2;
+    case NPCM7XX_TIMER_TICR3:
+        return 3;
+    case NPCM7XX_TIMER_TICR4:
+        return 4;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static hwaddr npcm7xx_tdr_index(hwaddr reg)
+{
+    switch (reg) {
+    case NPCM7XX_TIMER_TDR0:
+        return 0;
+    case NPCM7XX_TIMER_TDR1:
+        return 1;
+    case NPCM7XX_TIMER_TDR2:
+        return 2;
+    case NPCM7XX_TIMER_TDR3:
+        return 3;
+    case NPCM7XX_TIMER_TDR4:
+        return 4;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t npcm7xx_timer_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCM7xxTimerCtrlState *s = opaque;
+    uint64_t value = 0;
+    hwaddr reg;
+
+    reg = offset / sizeof(uint32_t);
+    switch (reg) {
+    case NPCM7XX_TIMER_TCSR0:
+    case NPCM7XX_TIMER_TCSR1:
+    case NPCM7XX_TIMER_TCSR2:
+    case NPCM7XX_TIMER_TCSR3:
+    case NPCM7XX_TIMER_TCSR4:
+        value = s->timer[npcm7xx_tcsr_index(reg)].tcsr;
+        break;
+
+    case NPCM7XX_TIMER_TICR0:
+    case NPCM7XX_TIMER_TICR1:
+    case NPCM7XX_TIMER_TICR2:
+    case NPCM7XX_TIMER_TICR3:
+    case NPCM7XX_TIMER_TICR4:
+        value = s->timer[npcm7xx_ticr_index(reg)].ticr;
+        break;
+
+    case NPCM7XX_TIMER_TDR0:
+    case NPCM7XX_TIMER_TDR1:
+    case NPCM7XX_TIMER_TDR2:
+    case NPCM7XX_TIMER_TDR3:
+    case NPCM7XX_TIMER_TDR4:
+        value = npcm7xx_timer_read_tdr(&s->timer[npcm7xx_tdr_index(reg)]);
+        break;
+
+    case NPCM7XX_TIMER_TISR:
+        value = s->tisr;
+        break;
+
+    case NPCM7XX_TIMER_WTCR:
+        value = s->wtcr;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid offset 0x%04" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+
+    trace_npcm7xx_timer_read(DEVICE(s)->canonical_path, offset, value);
+
+    return value;
+}
+
+static void npcm7xx_timer_write(void *opaque, hwaddr offset,
+                                uint64_t v, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxTimerCtrlState *s = opaque;
+    uint32_t value = v;
+
+    trace_npcm7xx_timer_write(DEVICE(s)->canonical_path, offset, value);
+
+    switch (reg) {
+    case NPCM7XX_TIMER_TCSR0:
+    case NPCM7XX_TIMER_TCSR1:
+    case NPCM7XX_TIMER_TCSR2:
+    case NPCM7XX_TIMER_TCSR3:
+    case NPCM7XX_TIMER_TCSR4:
+        npcm7xx_timer_write_tcsr(&s->timer[npcm7xx_tcsr_index(reg)], value);
+        return;
+
+    case NPCM7XX_TIMER_TICR0:
+    case NPCM7XX_TIMER_TICR1:
+    case NPCM7XX_TIMER_TICR2:
+    case NPCM7XX_TIMER_TICR3:
+    case NPCM7XX_TIMER_TICR4:
+        npcm7xx_timer_write_ticr(&s->timer[npcm7xx_ticr_index(reg)], value);
+        return;
+
+    case NPCM7XX_TIMER_TDR0:
+    case NPCM7XX_TIMER_TDR1:
+    case NPCM7XX_TIMER_TDR2:
+    case NPCM7XX_TIMER_TDR3:
+    case NPCM7XX_TIMER_TDR4:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
+                      __func__, offset);
+        return;
+
+    case NPCM7XX_TIMER_TISR:
+        s->tisr &= ~value;
+        return;
+
+    case NPCM7XX_TIMER_WTCR:
+        qemu_log_mask(LOG_UNIMP, "%s: WTCR write not implemented: 0x%08x\n",
+                      __func__, value);
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: invalid offset 0x%04" HWADDR_PRIx "\n",
+                  __func__, offset);
+}
+
+static const struct MemoryRegionOps npcm7xx_timer_ops = {
+    .read       = npcm7xx_timer_read,
+    .write      = npcm7xx_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+/* Called when the QEMU timer expires. */
+static void npcm7xx_timer_expired(void *opaque)
+{
+    NPCM7xxTimer *t = opaque;
+
+    if (t->tcsr & NPCM7XX_TCSR_CEN) {
+        npcm7xx_timer_reached_zero(t);
+    }
+}
+
+static void npcm7xx_timer_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxTimerCtrlState *s = NPCM7XX_TIMER(obj);
+    int i;
+
+    for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
+        NPCM7xxTimer *t = &s->timer[i];
+
+        timer_del(&t->qtimer);
+        t->expires_ns = 0;
+        t->remaining_ns = 0;
+        t->tcsr = 0x00000005;
+        t->ticr = 0x00000000;
+    }
+
+    s->tisr = 0x00000000;
+    s->wtcr = 0x00000400;
+}
+
+static void npcm7xx_timer_hold_reset(Object *obj)
+{
+    NPCM7xxTimerCtrlState *s = NPCM7XX_TIMER(obj);
+    int i;
+
+    for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
+        qemu_irq_lower(s->timer[i].irq);
+    }
+}
+
+static void npcm7xx_timer_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxTimerCtrlState *s = NPCM7XX_TIMER(dev);
+    SysBusDevice *sbd = &s->parent;
+    int i;
+
+    for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
+        NPCM7xxTimer *t = &s->timer[i];
+        t->ctrl = s;
+        timer_init_ns(&t->qtimer, QEMU_CLOCK_VIRTUAL, npcm7xx_timer_expired, t);
+        sysbus_init_irq(sbd, &t->irq);
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &npcm7xx_timer_ops, s,
+                          TYPE_NPCM7XX_TIMER, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_npcm7xx_timer = {
+    .name = "npcm7xx-timer",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER(qtimer, NPCM7xxTimer),
+        VMSTATE_INT64(expires_ns, NPCM7xxTimer),
+        VMSTATE_INT64(remaining_ns, NPCM7xxTimer),
+        VMSTATE_UINT32(tcsr, NPCM7xxTimer),
+        VMSTATE_UINT32(ticr, NPCM7xxTimer),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static const VMStateDescription vmstate_npcm7xx_timer_ctrl = {
+    .name = "npcm7xx-timer-ctrl",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(tisr, NPCM7xxTimerCtrlState),
+        VMSTATE_UINT32(wtcr, NPCM7xxTimerCtrlState),
+        VMSTATE_STRUCT_ARRAY(timer, NPCM7xxTimerCtrlState,
+                             NPCM7XX_TIMERS_PER_CTRL, 0, vmstate_npcm7xx_timer,
+                             NPCM7xxTimer),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm7xx_timer_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Timer Controller";
+    dc->realize = npcm7xx_timer_realize;
+    dc->vmsd = &vmstate_npcm7xx_timer_ctrl;
+    rc->phases.enter = npcm7xx_timer_enter_reset;
+    rc->phases.hold = npcm7xx_timer_hold_reset;
+}
+
+static const TypeInfo npcm7xx_timer_info = {
+    .name               = TYPE_NPCM7XX_TIMER,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCM7xxTimerCtrlState),
+    .class_init         = npcm7xx_timer_class_init,
+};
+
+static void npcm7xx_timer_register_type(void)
+{
+    type_register_static(&npcm7xx_timer_info);
+}
+type_init(npcm7xx_timer_register_type);
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 1303b13e0d..d245b73571 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
 common-obj-$(CONFIG_IMX) += imx_gpt.o
 common-obj-$(CONFIG_LM32) += lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_timer.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 
 common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 447b7c405b..ee66d8c84f 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -66,6 +66,11 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# npcm7xx_timer.c
+npcm7xx_timer_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+npcm7xx_timer_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+npcm7xx_timer_irq(const char *id, int timer, int state) "%s timer %d state %d"
+
 # nrf51_timer.c
 nrf51_timer_read(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-- 
2.28.0.rc0.105.gf9edc3c819-goog


