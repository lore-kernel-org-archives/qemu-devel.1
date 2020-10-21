Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE81EC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0936724178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="povBYnuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0936724178
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLrC-00009c-Ul
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uKmQXwsKClE0B3166x57x6z77z4x.v759x5D-wxEx4676z6D.7Az@flex--hskinnemoen.bounces.google.com>)
 id 1kVLm3-0003JC-CX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:35:59 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:41692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uKmQXwsKClE0B3166x57x6z77z4x.v759x5D-wxEx4676z6D.7Az@flex--hskinnemoen.bounces.google.com>)
 id 1kVLlx-00037I-Pp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:35:59 -0400
Received: by mail-qt1-x84a.google.com with SMTP id h16so2604970qtr.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=ij7mMkzdVSWZeDaOFt/tKJq7yqvVgafOofU8KETEVP4=;
 b=povBYnuJs7gCBaOO02sWJI3GsNZNnlR0rxshZqY7KTcYpugzTG2qisJOPHGeWTI2kz
 PB6AV7TuZqRnUr82zl58ee48r0ad8ZKAg3w2HqeHfX5nsiNxcpbSB1OxlsKxy20FfhiT
 bkv6euvoj5+IOjDK6GMH2LrFWhOFL8cCh5NQaqxJnL+09iu6XV1p0lyjKuMEJwW6a/wv
 QuPfVoRuYIeoPm4yWVJwy7jv/VVdfzjWl4t8xe5MXSohTnUdxKUGoiPyx6eZIBWm+a4D
 JtfRkY18sIfEJ0++N5jNkecyc7TwY96xSiKcEgJvMGFwcp/fOwPWe3jWUkQ824m7C2Wa
 qdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ij7mMkzdVSWZeDaOFt/tKJq7yqvVgafOofU8KETEVP4=;
 b=LxhQPXUhA9vmB9AHEp5WPo8fDd2X6BGANRf6zhXw5Blz05mwZwXdZsFbUN3kTPwi68
 g0xnFHUGkMMn1rW2VkDBSBE1fA2R+dHFJnO2q123F1PjEnsmyVSJCctmMwVQpzZjnPog
 i6CUdOA9Xqz5n8AyASEtNXUmuv97wccq4WPYu6Z9hZzGQ32ChlqZGVZK7HGzAId/KQdV
 z1ufNaC73WMETBxXu9N1MnOELXrWfheRC45VGNyx9niYlVcFlU/xloSkLsF5KT7yS5GH
 GngEiJzhZGDZtF/AZiXs5R/nxZoxRqB1w9U2fetF0JtpneDurDYgxvmpPznCvPGbnV+Z
 vVZw==
X-Gm-Message-State: AOAM531W/p63xcaoUwt6As99nSJLQFAsAQ+twMY1ALsJkzCLVq+Su+OI
 YZgWNjYNhy5nU8uzpbGz4cQ2+yEOG0oiDoMm6g==
X-Google-Smtp-Source: ABdhPJxdTr9zldDijpf/BlUj2DUIYtqlb4FDIYyCM+XDbpq8oaXHDL5bb0sXm+cYVvO0bdk6sGKVeg6ZDCkWwcDv+g==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr4968524qvb.17.1603316152161; Wed, 21 Oct 2020 14:35:52 -0700 (PDT)
Date: Wed, 21 Oct 2020 14:35:41 -0700
In-Reply-To: <20201021213544.3399271-1-hskinnemoen@google.com>
Message-Id: <20201021213544.3399271-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201021213544.3399271-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 2/5] hw/timer: Adding watchdog for NPCM7XX Timer.
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3uKmQXwsKClE0B3166x57x6z77z4x.v759x5D-wxEx4676z6D.7Az@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

From: Hao Wu <wuhaotsh@google.com>

The watchdog is part of NPCM7XX's timer module. Its behavior is
controlled by the WTCR register in the timer.

When enabled, the watchdog issues an interrupt signal after a pre-set
amount of cycles, and issues a reset signal shortly after that.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 include/hw/misc/npcm7xx_clk.h             |   2 +
 include/hw/timer/npcm7xx_timer.h          |  48 +++-
 hw/arm/npcm7xx.c                          |  12 +
 hw/misc/npcm7xx_clk.c                     |  28 ++
 hw/timer/npcm7xx_timer.c                  | 266 ++++++++++++++----
 tests/qtest/npcm7xx_watchdog_timer-test.c | 313 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 tests/qtest/meson.build                   |   1 +
 8 files changed, 618 insertions(+), 53 deletions(-)
 create mode 100644 tests/qtest/npcm7xx_watchdog_timer-test.c

diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm7xx_clk.h
index cdcc9e8534..2338fbbdb5 100644
--- a/include/hw/misc/npcm7xx_clk.h
+++ b/include/hw/misc/npcm7xx_clk.h
@@ -31,6 +31,8 @@
  */
 #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
 
+#define NPCM7XX_WATCHDOG_RESET_GPIO_IN "npcm7xx-clk-watchdog-reset-gpio-in"
+
 typedef struct NPCM7xxCLKState {
     SysBusDevice parent;
 
diff --git a/include/hw/timer/npcm7xx_timer.h b/include/hw/timer/npcm7xx_timer.h
index 878a365a79..6993fd723a 100644
--- a/include/hw/timer/npcm7xx_timer.h
+++ b/include/hw/timer/npcm7xx_timer.h
@@ -29,14 +29,31 @@
  */
 #define NPCM7XX_TIMER_NR_REGS (0x54 / sizeof(uint32_t))
 
+/* The basic watchdog timer period is 2^14 clock cycles. */
+#define NPCM7XX_WATCHDOG_BASETIME_SHIFT 14
+
+#define NPCM7XX_WATCHDOG_RESET_GPIO_OUT "npcm7xx-clk-watchdog-reset-gpio-out"
+
 typedef struct NPCM7xxTimerCtrlState NPCM7xxTimerCtrlState;
 
 /**
- * struct NPCM7xxTimer - Individual timer state.
- * @irq: GIC interrupt line to fire on expiration (if enabled).
+ * struct NPCM7xxBaseTimer - Basic functionality that both regular timer and
+ * watchdog timer use.
  * @qtimer: QEMU timer that notifies us on expiration.
  * @expires_ns: Absolute virtual expiration time.
  * @remaining_ns: Remaining time until expiration if timer is paused.
+ */
+typedef struct NPCM7xxBaseTimer {
+    QEMUTimer   qtimer;
+    int64_t     expires_ns;
+    int64_t     remaining_ns;
+} NPCM7xxBaseTimer;
+
+/**
+ * struct NPCM7xxTimer - Individual timer state.
+ * @ctrl: The timer module that owns this timer.
+ * @irq: GIC interrupt line to fire on expiration (if enabled).
+ * @base_timer: The basic timer functionality for this timer.
  * @tcsr: The Timer Control and Status Register.
  * @ticr: The Timer Initial Count Register.
  */
@@ -44,21 +61,38 @@ typedef struct NPCM7xxTimer {
     NPCM7xxTimerCtrlState *ctrl;
 
     qemu_irq    irq;
-    QEMUTimer   qtimer;
-    int64_t     expires_ns;
-    int64_t     remaining_ns;
+    NPCM7xxBaseTimer base_timer;
 
     uint32_t    tcsr;
     uint32_t    ticr;
 } NPCM7xxTimer;
 
+/**
+ * struct NPCM7xxWatchdogTimer - The watchdog timer state.
+ * @ctrl: The timer module that owns this timer.
+ * @irq: GIC interrupt line to fire on expiration (if enabled).
+ * @reset_signal: The GPIO used to send a reset signal.
+ * @base_timer: The basic timer functionality for this timer.
+ * @wtcr: The Watchdog Timer Control Register.
+ */
+typedef struct NPCM7xxWatchdogTimer {
+    NPCM7xxTimerCtrlState *ctrl;
+
+    qemu_irq            irq;
+    qemu_irq            reset_signal;
+    NPCM7xxBaseTimer base_timer;
+
+    uint32_t            wtcr;
+} NPCM7xxWatchdogTimer;
+
 /**
  * struct NPCM7xxTimerCtrlState - Timer Module device state.
  * @parent: System bus device.
  * @iomem: Memory region through which registers are accessed.
+ * @index: The index of this timer module.
  * @tisr: The Timer Interrupt Status Register.
- * @wtcr: The Watchdog Timer Control Register.
  * @timer: The five individual timers managed by this module.
+ * @watchdog_timer: The watchdog timer managed by this module.
  */
 struct NPCM7xxTimerCtrlState {
     SysBusDevice parent;
@@ -66,9 +100,9 @@ struct NPCM7xxTimerCtrlState {
     MemoryRegion iomem;
 
     uint32_t    tisr;
-    uint32_t    wtcr;
 
     NPCM7xxTimer timer[NPCM7XX_TIMERS_PER_CTRL];
+    NPCM7xxWatchdogTimer watchdog_timer;
 };
 
 #define TYPE_NPCM7XX_TIMER "npcm7xx-timer"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 037f3a26f2..c341dcab8b 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -86,6 +86,9 @@ enum NPCM7xxInterrupt {
     NPCM7XX_TIMER12_IRQ,
     NPCM7XX_TIMER13_IRQ,
     NPCM7XX_TIMER14_IRQ,
+    NPCM7XX_WDG0_IRQ            = 47,   /* Timer Module 0 Watchdog */
+    NPCM7XX_WDG1_IRQ,                   /* Timer Module 1 Watchdog */
+    NPCM7XX_WDG2_IRQ,                   /* Timer Module 2 Watchdog */
 };
 
 /* Total number of GIC interrupts, including internal Cortex-A9 interrupts. */
@@ -353,6 +356,15 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
             qemu_irq irq = npcm7xx_irq(s, first_irq + j);
             sysbus_connect_irq(sbd, j, irq);
         }
+
+        /* IRQ for watchdogs */
+        sysbus_connect_irq(sbd, NPCM7XX_TIMERS_PER_CTRL,
+                npcm7xx_irq(s, NPCM7XX_WDG0_IRQ + i));
+        /* GPIO that connects clk module with watchdog */
+        qdev_connect_gpio_out_named(DEVICE(&s->tim[i]),
+                NPCM7XX_WATCHDOG_RESET_GPIO_OUT, 0,
+                qdev_get_gpio_in_named(DEVICE(&s->clk),
+                        NPCM7XX_WATCHDOG_RESET_GPIO_IN, i));
     }
 
     /* UART0..3 (16550 compatible) */
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index 21ab4200d1..6732437fe2 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/misc/npcm7xx_clk.h"
+#include "hw/timer/npcm7xx_timer.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -24,6 +25,7 @@
 #include "qemu/timer.h"
 #include "qemu/units.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 #define PLLCON_LOKI     BIT(31)
 #define PLLCON_LOKS     BIT(30)
@@ -87,6 +89,12 @@ static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
     [NPCM7XX_CLK_AHBCKFI]       = 0x000000c8,
 };
 
+/* Register Field Definitions */
+#define NPCM7XX_CLK_WDRCR_CA9C  BIT(0) /* Cortex A9 Cores */
+
+/* The number of watchdogs that can trigger a reset. */
+#define NPCM7XX_NR_WATCHDOGS    (3)
+
 static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
@@ -187,6 +195,24 @@ static void npcm7xx_clk_write(void *opaque, hwaddr offset,
     s->regs[reg] = value;
 }
 
+/* Perform reset action triggered by a watchdog */
+static void npcm7xx_clk_perform_watchdog_reset(void *opaque, int n,
+        int level)
+{
+    NPCM7xxCLKState *clk = NPCM7XX_CLK(opaque);
+    uint32_t rcr;
+
+    g_assert(n >= 0 && n <= NPCM7XX_NR_WATCHDOGS);
+    rcr = clk->regs[NPCM7XX_CLK_WD0RCR + n];
+    if (rcr & NPCM7XX_CLK_WDRCR_CA9C) {
+        watchdog_perform_action();
+    } else {
+        qemu_log_mask(LOG_UNIMP,
+                "%s: only CPU reset is implemented. (requested 0x%" PRIx32")\n",
+                __func__, rcr);
+    }
+}
+
 static const struct MemoryRegionOps npcm7xx_clk_ops = {
     .read       = npcm7xx_clk_read,
     .write      = npcm7xx_clk_write,
@@ -226,6 +252,8 @@ static void npcm7xx_clk_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &npcm7xx_clk_ops, s,
                           TYPE_NPCM7XX_CLK, 4 * KiB);
     sysbus_init_mmio(&s->parent, &s->iomem);
+    qdev_init_gpio_in_named(DEVICE(s), npcm7xx_clk_perform_watchdog_reset,
+            NPCM7XX_WATCHDOG_RESET_GPIO_IN, NPCM7XX_NR_WATCHDOGS);
 }
 
 static const VMStateDescription vmstate_npcm7xx_clk = {
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 2df9e3e496..d24445bd6e 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "migration/vmstate.h"
@@ -60,6 +61,50 @@ enum NPCM7xxTimerRegisters {
 #define NPCM7XX_TCSR_PRESCALE_START     0
 #define NPCM7XX_TCSR_PRESCALE_LEN       8
 
+#define NPCM7XX_WTCR_WTCLK(rv)          extract32(rv, 10, 2)
+#define NPCM7XX_WTCR_FREEZE_EN          BIT(9)
+#define NPCM7XX_WTCR_WTE                BIT(7)
+#define NPCM7XX_WTCR_WTIE               BIT(6)
+#define NPCM7XX_WTCR_WTIS(rv)           extract32(rv, 4, 2)
+#define NPCM7XX_WTCR_WTIF               BIT(3)
+#define NPCM7XX_WTCR_WTRF               BIT(2)
+#define NPCM7XX_WTCR_WTRE               BIT(1)
+#define NPCM7XX_WTCR_WTR                BIT(0)
+
+/*
+ * The number of clock cycles between interrupt and reset in watchdog, used
+ * by the software to handle the interrupt before system is reset.
+ */
+#define NPCM7XX_WATCHDOG_INTERRUPT_TO_RESET_CYCLES 1024
+
+/* Start or resume the timer. */
+static void npcm7xx_timer_start(NPCM7xxBaseTimer *t)
+{
+    int64_t now;
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    t->expires_ns = now + t->remaining_ns;
+    timer_mod(&t->qtimer, t->expires_ns);
+}
+
+/* Stop counting. Record the time remaining so we can continue later. */
+static void npcm7xx_timer_pause(NPCM7xxBaseTimer *t)
+{
+    int64_t now;
+
+    timer_del(&t->qtimer);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    t->remaining_ns = t->expires_ns - now;
+}
+
+/* Delete the timer and reset it to default state. */
+static void npcm7xx_timer_clear(NPCM7xxBaseTimer *t)
+{
+    timer_del(&t->qtimer);
+    t->expires_ns = 0;
+    t->remaining_ns = 0;
+}
+
 /*
  * Returns the index of timer in the tc->timer array. This can be used to
  * locate the registers that belong to this timer.
@@ -102,6 +147,52 @@ static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
     return count;
 }
 
+static uint32_t npcm7xx_watchdog_timer_prescaler(const NPCM7xxWatchdogTimer *t)
+{
+    switch (NPCM7XX_WTCR_WTCLK(t->wtcr)) {
+    case 0:
+        return 1;
+    case 1:
+        return 256;
+    case 2:
+        return 2048;
+    case 3:
+        return 65536;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void npcm7xx_watchdog_timer_reset_cycles(NPCM7xxWatchdogTimer *t,
+        int64_t cycles)
+{
+    uint32_t prescaler = npcm7xx_watchdog_timer_prescaler(t);
+    int64_t ns = (NANOSECONDS_PER_SECOND / NPCM7XX_TIMER_REF_HZ) * cycles;
+
+    /*
+     * The reset function always clears the current timer. The caller of the
+     * this needs to decide whether to start the watchdog timer based on
+     * specific flag in WTCR.
+     */
+    npcm7xx_timer_clear(&t->base_timer);
+
+    ns *= prescaler;
+    t->base_timer.remaining_ns = ns;
+}
+
+static void npcm7xx_watchdog_timer_reset(NPCM7xxWatchdogTimer *t)
+{
+    int64_t cycles = 1;
+    uint32_t s = NPCM7XX_WTCR_WTIS(t->wtcr);
+
+    g_assert(s <= 3);
+
+    cycles <<= NPCM7XX_WATCHDOG_BASETIME_SHIFT;
+    cycles <<= 2 * s;
+
+    npcm7xx_watchdog_timer_reset_cycles(t, cycles);
+}
+
 /*
  * Raise the interrupt line if there's a pending interrupt and interrupts are
  * enabled for this timer. If not, lower it.
@@ -116,16 +207,6 @@ static void npcm7xx_timer_check_interrupt(NPCM7xxTimer *t)
     trace_npcm7xx_timer_irq(DEVICE(tc)->canonical_path, index, pending);
 }
 
-/* Start or resume the timer. */
-static void npcm7xx_timer_start(NPCM7xxTimer *t)
-{
-    int64_t now;
-
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    t->expires_ns = now + t->remaining_ns;
-    timer_mod(&t->qtimer, t->expires_ns);
-}
-
 /*
  * Called when the counter reaches zero. Sets the interrupt flag, and either
  * restarts or disables the timer.
@@ -138,9 +219,9 @@ static void npcm7xx_timer_reached_zero(NPCM7xxTimer *t)
     tc->tisr |= BIT(index);
 
     if (t->tcsr & NPCM7XX_TCSR_PERIODIC) {
-        t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
+        t->base_timer.remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
         if (t->tcsr & NPCM7XX_TCSR_CEN) {
-            npcm7xx_timer_start(t);
+            npcm7xx_timer_start(&t->base_timer);
         }
     } else {
         t->tcsr &= ~(NPCM7XX_TCSR_CEN | NPCM7XX_TCSR_CACT);
@@ -149,15 +230,6 @@ static void npcm7xx_timer_reached_zero(NPCM7xxTimer *t)
     npcm7xx_timer_check_interrupt(t);
 }
 
-/* Stop counting. Record the time remaining so we can continue later. */
-static void npcm7xx_timer_pause(NPCM7xxTimer *t)
-{
-    int64_t now;
-
-    timer_del(&t->qtimer);
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    t->remaining_ns = t->expires_ns - now;
-}
 
 /*
  * Restart the timer from its initial value. If the timer was enabled and stays
@@ -167,10 +239,10 @@ static void npcm7xx_timer_pause(NPCM7xxTimer *t)
  */
 static void npcm7xx_timer_restart(NPCM7xxTimer *t, uint32_t old_tcsr)
 {
-    t->remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
+    t->base_timer.remaining_ns = npcm7xx_timer_count_to_ns(t, t->ticr);
 
     if (old_tcsr & t->tcsr & NPCM7XX_TCSR_CEN) {
-        npcm7xx_timer_start(t);
+        npcm7xx_timer_start(&t->base_timer);
     }
 }
 
@@ -181,10 +253,10 @@ static uint32_t npcm7xx_timer_read_tdr(NPCM7xxTimer *t)
     if (t->tcsr & NPCM7XX_TCSR_CEN) {
         int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-        return npcm7xx_timer_ns_to_count(t, t->expires_ns - now);
+        return npcm7xx_timer_ns_to_count(t, t->base_timer.expires_ns - now);
     }
 
-    return npcm7xx_timer_ns_to_count(t, t->remaining_ns);
+    return npcm7xx_timer_ns_to_count(t, t->base_timer.remaining_ns);
 }
 
 static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
@@ -216,9 +288,9 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
 
     if (npcm7xx_tcsr_prescaler(old_tcsr) != npcm7xx_tcsr_prescaler(new_tcsr)) {
         /* Recalculate time remaining based on the current TDR value. */
-        t->remaining_ns = npcm7xx_timer_count_to_ns(t, tdr);
+        t->base_timer.remaining_ns = npcm7xx_timer_count_to_ns(t, tdr);
         if (old_tcsr & t->tcsr & NPCM7XX_TCSR_CEN) {
-            npcm7xx_timer_start(t);
+            npcm7xx_timer_start(&t->base_timer);
         }
     }
 
@@ -232,11 +304,11 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
     if ((old_tcsr ^ new_tcsr) & NPCM7XX_TCSR_CEN) {
         if (new_tcsr & NPCM7XX_TCSR_CEN) {
             t->tcsr |= NPCM7XX_TCSR_CACT;
-            npcm7xx_timer_start(t);
+            npcm7xx_timer_start(&t->base_timer);
         } else {
             t->tcsr &= ~NPCM7XX_TCSR_CACT;
-            npcm7xx_timer_pause(t);
-            if (t->remaining_ns <= 0) {
+            npcm7xx_timer_pause(&t->base_timer);
+            if (t->base_timer.remaining_ns <= 0) {
                 npcm7xx_timer_reached_zero(t);
             }
         }
@@ -259,9 +331,47 @@ static void npcm7xx_timer_write_tisr(NPCM7xxTimerCtrlState *s, uint32_t value)
         if (value & (1U << i)) {
             npcm7xx_timer_check_interrupt(&s->timer[i]);
         }
+
     }
 }
 
+static void npcm7xx_timer_write_wtcr(NPCM7xxWatchdogTimer *t, uint32_t new_wtcr)
+{
+    uint32_t old_wtcr = t->wtcr;
+
+    /*
+     * WTIF and WTRF are cleared by writing 1. Writing 0 makes these bits
+     * unchanged.
+     */
+    if (new_wtcr & NPCM7XX_WTCR_WTIF) {
+        new_wtcr &= ~NPCM7XX_WTCR_WTIF;
+    } else if (old_wtcr & NPCM7XX_WTCR_WTIF) {
+        new_wtcr |= NPCM7XX_WTCR_WTIF;
+    }
+    if (new_wtcr & NPCM7XX_WTCR_WTRF) {
+        new_wtcr &= ~NPCM7XX_WTCR_WTRF;
+    } else if (old_wtcr & NPCM7XX_WTCR_WTRF) {
+        new_wtcr |= NPCM7XX_WTCR_WTRF;
+    }
+
+    t->wtcr = new_wtcr;
+
+    if (new_wtcr & NPCM7XX_WTCR_WTR) {
+        t->wtcr &= ~NPCM7XX_WTCR_WTR;
+        npcm7xx_watchdog_timer_reset(t);
+        if (new_wtcr & NPCM7XX_WTCR_WTE) {
+            npcm7xx_timer_start(&t->base_timer);
+        }
+    } else if ((old_wtcr ^ new_wtcr) & NPCM7XX_WTCR_WTE) {
+        if (new_wtcr & NPCM7XX_WTCR_WTE) {
+            npcm7xx_timer_start(&t->base_timer);
+        } else {
+            npcm7xx_timer_pause(&t->base_timer);
+        }
+    }
+
+}
+
 static hwaddr npcm7xx_tcsr_index(hwaddr reg)
 {
     switch (reg) {
@@ -353,7 +463,7 @@ static uint64_t npcm7xx_timer_read(void *opaque, hwaddr offset, unsigned size)
         break;
 
     case NPCM7XX_TIMER_WTCR:
-        value = s->wtcr;
+        value = s->watchdog_timer.wtcr;
         break;
 
     default:
@@ -409,8 +519,7 @@ static void npcm7xx_timer_write(void *opaque, hwaddr offset,
         return;
 
     case NPCM7XX_TIMER_WTCR:
-        qemu_log_mask(LOG_UNIMP, "%s: WTCR write not implemented: 0x%08x\n",
-                      __func__, value);
+        npcm7xx_timer_write_wtcr(&s->watchdog_timer, value);
         return;
     }
 
@@ -448,15 +557,42 @@ static void npcm7xx_timer_enter_reset(Object *obj, ResetType type)
     for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
         NPCM7xxTimer *t = &s->timer[i];
 
-        timer_del(&t->qtimer);
-        t->expires_ns = 0;
-        t->remaining_ns = 0;
+        npcm7xx_timer_clear(&t->base_timer);
         t->tcsr = 0x00000005;
         t->ticr = 0x00000000;
     }
 
     s->tisr = 0x00000000;
-    s->wtcr = 0x00000400;
+    /*
+     * Set WTCLK to 1(default) and reset all flags except WTRF.
+     * WTRF is not reset during a core domain reset.
+     */
+    s->watchdog_timer.wtcr = 0x00000400 | (s->watchdog_timer.wtcr &
+            NPCM7XX_WTCR_WTRF);
+}
+
+static void npcm7xx_watchdog_timer_expired(void *opaque)
+{
+    NPCM7xxWatchdogTimer *t = opaque;
+
+    if (t->wtcr & NPCM7XX_WTCR_WTE) {
+        if (t->wtcr & NPCM7XX_WTCR_WTIF) {
+            if (t->wtcr & NPCM7XX_WTCR_WTRE) {
+                t->wtcr |= NPCM7XX_WTCR_WTRF;
+                /* send reset signal to CLK module*/
+                qemu_irq_raise(t->reset_signal);
+            }
+        } else {
+            t->wtcr |= NPCM7XX_WTCR_WTIF;
+            if (t->wtcr & NPCM7XX_WTCR_WTIE) {
+                /* send interrupt */
+                qemu_irq_raise(t->irq);
+            }
+            npcm7xx_watchdog_timer_reset_cycles(t,
+                    NPCM7XX_WATCHDOG_INTERRUPT_TO_RESET_CYCLES);
+            npcm7xx_timer_start(&t->base_timer);
+        }
+    }
 }
 
 static void npcm7xx_timer_hold_reset(Object *obj)
@@ -467,6 +603,7 @@ static void npcm7xx_timer_hold_reset(Object *obj)
     for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
         qemu_irq_lower(s->timer[i].irq);
     }
+    qemu_irq_lower(s->watchdog_timer.irq);
 }
 
 static void npcm7xx_timer_realize(DeviceState *dev, Error **errp)
@@ -474,43 +611,80 @@ static void npcm7xx_timer_realize(DeviceState *dev, Error **errp)
     NPCM7xxTimerCtrlState *s = NPCM7XX_TIMER(dev);
     SysBusDevice *sbd = &s->parent;
     int i;
+    NPCM7xxWatchdogTimer *w;
 
     for (i = 0; i < NPCM7XX_TIMERS_PER_CTRL; i++) {
         NPCM7xxTimer *t = &s->timer[i];
         t->ctrl = s;
-        timer_init_ns(&t->qtimer, QEMU_CLOCK_VIRTUAL, npcm7xx_timer_expired, t);
+        timer_init_ns(&t->base_timer.qtimer, QEMU_CLOCK_VIRTUAL,
+                npcm7xx_timer_expired, t);
         sysbus_init_irq(sbd, &t->irq);
     }
 
+    w = &s->watchdog_timer;
+    w->ctrl = s;
+    timer_init_ns(&w->base_timer.qtimer, QEMU_CLOCK_VIRTUAL,
+            npcm7xx_watchdog_timer_expired, w);
+    sysbus_init_irq(sbd, &w->irq);
+
     memory_region_init_io(&s->iomem, OBJECT(s), &npcm7xx_timer_ops, s,
                           TYPE_NPCM7XX_TIMER, 4 * KiB);
     sysbus_init_mmio(sbd, &s->iomem);
+    qdev_init_gpio_out_named(dev, &w->reset_signal,
+            NPCM7XX_WATCHDOG_RESET_GPIO_OUT, 1);
 }
 
-static const VMStateDescription vmstate_npcm7xx_timer = {
-    .name = "npcm7xx-timer",
+static const VMStateDescription vmstate_npcm7xx_base_timer = {
+    .name = "npcm7xx-base-timer",
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_TIMER(qtimer, NPCM7xxTimer),
-        VMSTATE_INT64(expires_ns, NPCM7xxTimer),
-        VMSTATE_INT64(remaining_ns, NPCM7xxTimer),
+        VMSTATE_TIMER(qtimer, NPCM7xxBaseTimer),
+        VMSTATE_INT64(expires_ns, NPCM7xxBaseTimer),
+        VMSTATE_INT64(remaining_ns, NPCM7xxBaseTimer),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static const VMStateDescription vmstate_npcm7xx_timer = {
+    .name = "npcm7xx-timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(base_timer, NPCM7xxTimer,
+                             0, vmstate_npcm7xx_base_timer,
+                             NPCM7xxBaseTimer),
         VMSTATE_UINT32(tcsr, NPCM7xxTimer),
         VMSTATE_UINT32(ticr, NPCM7xxTimer),
         VMSTATE_END_OF_LIST(),
     },
 };
 
-static const VMStateDescription vmstate_npcm7xx_timer_ctrl = {
-    .name = "npcm7xx-timer-ctrl",
+static const VMStateDescription vmstate_npcm7xx_watchdog_timer = {
+    .name = "npcm7xx-watchdog-timer",
     .version_id = 0,
     .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(base_timer, NPCM7xxWatchdogTimer,
+                             0, vmstate_npcm7xx_base_timer,
+                             NPCM7xxBaseTimer),
+        VMSTATE_UINT32(wtcr, NPCM7xxWatchdogTimer),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static const VMStateDescription vmstate_npcm7xx_timer_ctrl = {
+    .name = "npcm7xx-timer-ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(tisr, NPCM7xxTimerCtrlState),
-        VMSTATE_UINT32(wtcr, NPCM7xxTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timer, NPCM7xxTimerCtrlState,
                              NPCM7XX_TIMERS_PER_CTRL, 0, vmstate_npcm7xx_timer,
                              NPCM7xxTimer),
+        VMSTATE_STRUCT(watchdog_timer, NPCM7xxTimerCtrlState,
+                             0, vmstate_npcm7xx_watchdog_timer,
+                             NPCM7xxWatchdogTimer),
         VMSTATE_END_OF_LIST(),
     },
 };
diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm7xx_watchdog_timer-test.c
new file mode 100644
index 0000000000..bfe0020ffc
--- /dev/null
+++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
@@ -0,0 +1,313 @@
+/*
+ * QTests for Nuvoton NPCM7xx Timer Watchdog Modules.
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
+#include "qemu/timer.h"
+
+#include "libqtest-single.h"
+#include "qapi/qmp/qdict.h"
+
+#define WTCR_OFFSET     0x1c
+#define REF_HZ          (25000000)
+
+/* WTCR bit fields */
+#define WTCLK(rv)       ((rv) << 10)
+#define WTE             BIT(7)
+#define WTIE            BIT(6)
+#define WTIS(rv)        ((rv) << 4)
+#define WTIF            BIT(3)
+#define WTRF            BIT(2)
+#define WTRE            BIT(1)
+#define WTR             BIT(0)
+
+typedef struct Watchdog {
+    int irq;
+    uint64_t base_addr;
+} Watchdog;
+
+static const Watchdog watchdog_list[] = {
+    {
+        .irq        = 47,
+        .base_addr  = 0xf0008000
+    },
+    {
+        .irq        = 48,
+        .base_addr  = 0xf0009000
+    },
+    {
+        .irq        = 49,
+        .base_addr  = 0xf000a000
+    }
+};
+
+
+static int watchdog_index(const Watchdog *wd)
+{
+    ptrdiff_t diff = wd - watchdog_list;
+
+    g_assert(diff >= 0 && diff < ARRAY_SIZE(watchdog_list));
+
+    return diff;
+}
+
+static uint32_t watchdog_read_wtcr(const Watchdog *wd)
+{
+    return readl(wd->base_addr + WTCR_OFFSET);
+}
+
+static void watchdog_write_wtcr(const Watchdog *wd, uint32_t value)
+{
+    writel(wd->base_addr + WTCR_OFFSET, value);
+}
+
+static uint32_t watchdog_prescaler(const Watchdog *wd)
+{
+    switch (extract32(watchdog_read_wtcr(wd), 10, 2)) {
+    case 0:
+        return 1;
+    case 1:
+        return 256;
+    case 2:
+        return 2048;
+    case 3:
+        return 65536;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static QDict *get_watchdog_action(QTestState *qts)
+{
+    QDict *ev = qtest_qmp_eventwait_ref(qts, "WATCHDOG");
+    QDict *data;
+
+    data = qdict_get_qdict(ev, "data");
+    qobject_ref(data);
+    qobject_unref(ev);
+    return data;
+}
+
+#define RESET_CYCLES 1024
+static uint32_t watchdog_interrupt_cycles(const Watchdog *wd)
+{
+    uint32_t wtis = extract32(watchdog_read_wtcr(wd), 4, 2);
+    return 1 << (14 + 2 * wtis);
+}
+
+static int64_t watchdog_calculate_steps(uint32_t count, uint32_t prescale)
+{
+    return (NANOSECONDS_PER_SECOND / REF_HZ) * count * prescale;
+}
+
+static int64_t watchdog_interrupt_steps(const Watchdog *wd)
+{
+    return watchdog_calculate_steps(watchdog_interrupt_cycles(wd),
+            watchdog_prescaler(wd));
+}
+
+/* Check wtcr can be reset to default value */
+static void test_init(gconstpointer watchdog)
+{
+    const Watchdog *wd = watchdog;
+    QTestState *qts = qtest_start("-machine quanta-gsj");
+
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+
+    watchdog_write_wtcr(wd, WTCLK(1) | WTRF | WTIF | WTR);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(1));
+
+    qtest_end();
+}
+
+/* Check a watchdog can generate interrupt and reset actions */
+static void test_reset_action(gconstpointer watchdog)
+{
+    const Watchdog *wd = watchdog;
+    QTestState *qts = qtest_start("-machine quanta-gsj");
+    QDict *ad;
+
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTRF | WTRE | WTIF | WTIE | WTR);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTE | WTRE | WTIE);
+
+    /* Check a watchdog can generate an interrupt */
+    clock_step(watchdog_interrupt_steps(wd));
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==,
+            WTCLK(0) | WTE | WTIF | WTIE | WTRE);
+    g_assert_true(qtest_get_irq(qts, wd->irq));
+
+    /* Check a watchdog can generate a reset signal */
+    clock_step(watchdog_calculate_steps(RESET_CYCLES, watchdog_prescaler(wd)));
+    ad = get_watchdog_action(qts);
+    /* The signal is a reset signal */
+    g_assert_false(strcmp(qdict_get_str(ad, "action"), "reset"));
+    qobject_unref(ad);
+    qtest_qmp_eventwait(qts, "RESET");
+    /*
+     * Make sure WTCR is reset to default except for WTRF bit which shouldn't
+     * be reset.
+     */
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(1) | WTRF);
+    qtest_end();
+}
+
+/* Check a watchdog works with all possible WTCLK prescalers and WTIS cycles */
+static void test_prescaler(gconstpointer watchdog)
+{
+    const Watchdog *wd = watchdog;
+
+    for (int wtclk = 0; wtclk < 4; ++wtclk) {
+        for (int wtis = 0; wtis < 4; ++wtis) {
+            QTestState *qts = qtest_start("-machine quanta-gsj");
+
+            qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+            watchdog_write_wtcr(wd,
+                    WTCLK(wtclk) | WTE | WTIF | WTIS(wtis) | WTIE | WTR);
+            /*
+             * The interrupt doesn't fire until watchdog_interrupt_steps()
+             * cycles passed
+             */
+            clock_step(watchdog_interrupt_steps(wd) - 1);
+            g_assert_false(watchdog_read_wtcr(wd) & WTIF);
+            g_assert_false(qtest_get_irq(qts, wd->irq));
+            clock_step(1);
+            g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+            g_assert_true(qtest_get_irq(qts, wd->irq));
+
+            qtest_end();
+        }
+    }
+}
+
+/*
+ * Check a watchdog doesn't fire if corresponding flags (WTIE and WTRE) are not
+ * set.
+ */
+static void test_enabling_flags(gconstpointer watchdog)
+{
+    const Watchdog *wd = watchdog;
+    QTestState *qts;
+
+    /* Neither WTIE or WTRE is set, no interrupt or reset should happen */
+    qts = qtest_start("-machine quanta-gsj");
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIF | WTRF | WTR);
+    clock_step(watchdog_interrupt_steps(wd));
+    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+    g_assert_false(qtest_get_irq(qts, wd->irq));
+    clock_step(watchdog_calculate_steps(RESET_CYCLES, watchdog_prescaler(wd)));
+    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+    g_assert_false(watchdog_read_wtcr(wd) & WTRF);
+    qtest_end();
+
+    /* Only WTIE is set, interrupt is triggered but reset should not happen */
+    qts = qtest_start("-machine quanta-gsj");
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIF | WTIE | WTRF | WTR);
+    clock_step(watchdog_interrupt_steps(wd));
+    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+    g_assert_true(qtest_get_irq(qts, wd->irq));
+    clock_step(watchdog_calculate_steps(RESET_CYCLES, watchdog_prescaler(wd)));
+    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+    g_assert_false(watchdog_read_wtcr(wd) & WTRF);
+    qtest_end();
+
+    /* Only WTRE is set, interrupt is triggered but reset should not happen */
+    qts = qtest_start("-machine quanta-gsj");
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIF | WTRE | WTRF | WTR);
+    clock_step(watchdog_interrupt_steps(wd));
+    g_assert_true(watchdog_read_wtcr(wd) & WTIF);
+    g_assert_false(qtest_get_irq(qts, wd->irq));
+    clock_step(watchdog_calculate_steps(RESET_CYCLES, watchdog_prescaler(wd)));
+    g_assert_false(strcmp(qdict_get_str(get_watchdog_action(qts), "action"),
+                "reset"));
+    qtest_qmp_eventwait(qts, "RESET");
+    qtest_end();
+
+    /*
+     * The case when both flags are set is already tested in
+     * test_reset_action().
+     */
+}
+
+/* Check a watchdog can pause and resume by setting WTE bits */
+static void test_pause(gconstpointer watchdog)
+{
+    const Watchdog *wd = watchdog;
+    QTestState *qts;
+    int64_t remaining_steps, steps;
+
+    qts = qtest_start("-machine quanta-gsj");
+    qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIF | WTIE | WTRF | WTR);
+    remaining_steps = watchdog_interrupt_steps(wd);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTE | WTIE);
+
+    /* Run for half of the execution period. */
+    steps = remaining_steps / 2;
+    remaining_steps -= steps;
+    clock_step(steps);
+
+    /* Pause the watchdog */
+    watchdog_write_wtcr(wd, WTCLK(0) | WTIE);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTIE);
+
+    /* Run for a long period of time, the watchdog shouldn't fire */
+    clock_step(steps << 4);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTIE);
+    g_assert_false(qtest_get_irq(qts, wd->irq));
+
+    /* Resume the watchdog */
+    watchdog_write_wtcr(wd, WTCLK(0) | WTE | WTIE);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTE | WTIE);
+
+    /* Run for the reset of the execution period, the watchdog should fire */
+    clock_step(remaining_steps);
+    g_assert_cmphex(watchdog_read_wtcr(wd), ==, WTCLK(0) | WTE | WTIF | WTIE);
+    g_assert_true(qtest_get_irq(qts, wd->irq));
+
+    qtest_end();
+}
+
+static void watchdog_add_test(const char *name, const Watchdog* wd,
+        GTestDataFunc fn)
+{
+    g_autofree char *full_name = g_strdup_printf(
+            "npcm7xx_watchdog_timer[%d]/%s", watchdog_index(wd), name);
+    qtest_add_data_func(full_name, wd, fn);
+}
+#define add_test(name, td) watchdog_add_test(#name, td, test_##name)
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    for (int i = 0; i < ARRAY_SIZE(watchdog_list); ++i) {
+        const Watchdog *wd = &watchdog_list[i];
+
+        add_test(init, wd);
+        add_test(reset_action, wd);
+        add_test(prescaler, wd);
+        add_test(enabling_flags, wd);
+        add_test(pause, wd);
+    }
+
+    return g_test_run();
+}
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a197bd358..0fa74b9bf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -755,6 +755,7 @@ L: qemu-arm@nongnu.org
 S: Supported
 F: hw/*/npcm7xx*
 F: include/hw/*/npcm7xx*
+F: tests/qtest/npcm7xx*
 F: pc-bios/npcm7xx_bootrom.bin
 F: roms/vbootrom
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 28d4068718..f7b0e3ca9d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -139,6 +139,7 @@ qtests_arm = \
    'microbit-test',
    'm25p80-test',
    'npcm7xx_timer-test',
+   'npcm7xx_watchdog_timer-test',
    'test-arm-mptimer',
    'boot-serial-test',
    'hexloader-test']
-- 
2.29.0.rc1.297.gfa9743e501-goog


