Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD1F20708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="p/q03vaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD1F20708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfGk-0005Fl-HF
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3I59_XwsKCmIHSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEr-0003qC-CG
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:22 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:48324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3I59_XwsKCmIHSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEj-0002s3-Ov
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:19 -0400
Received: by mail-yb1-xb49.google.com with SMTP id 139so6976214ybe.15
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=+wARlxwocmYwbHNJ5PBrGzo3nS0ESEdkc+4L6/XBYBU=;
 b=p/q03vaIjfwKp0ScosLHWv+CtyMkddrKKZaveNkwcoNfMTf5fWyE8w7DVvo5R0PP97
 mjUXy1zQnxuMU7qTPTxk2KOaOIne0I1J03kUFZhPdh+yY3bzOCTIqsmS2SedcqOSkE48
 mVQq01ykG2Old+H5KAFHrmZw0sF35jwODqd9jsWT+FjEEagsY0sLmiX7y16/aX1B+NtK
 ffndAO6aBQvTPYGa+JISQriCIzyvl4X7uwZz+/8YKj3ZXD7FwsegTdoWJxQXkoMAlhPV
 WbhsS+bo/NM7ARtcT5gPJ0eEv/VeY5CWgwlpQrd/kYDNCjNUX5szjnyvMBSAKDCD38eF
 akSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=+wARlxwocmYwbHNJ5PBrGzo3nS0ESEdkc+4L6/XBYBU=;
 b=mX8m+uXvQhN1AoZsOnNftaa18kpqbgwC+HMWjxVwGDchtrUt+pN3AhpHK+S0L9KvvO
 Ru7X6SX6pWxIcWCaFPRxL0l3WoiSAI3NQVKI99UVr1WpLqa8a0Ja1u47BOIZOoG06KYr
 l/LpFuTlq3+Iq/jzucCoCSQqi86U+HUN8GuW2IV+w5HzCJ/ZBhqhgy2ph5k+6XhwoECH
 qlafn2A792ies0iA3ZNZEIgwT80KonOkXM06ixOv2jGj38uoApu7yVlJKir333viLzb5
 YrpXFLivySYphuqkpuVm3zwD2RJJNWyPVo43NQmZkTv7nyaJX2kXVhnLW6jFlOdeBg62
 XRLQ==
X-Gm-Message-State: AOAM530qWTat9606ti8NnKJdUofASkOiRyiKC+soyYWuGRbXbhb7ebiO
 2uIM9YWxdH/HxGwPIFGcBZPzUGIEN9ugSljoUe+FG+/nb+mTVnwRNe+6GQ7cC94rjuSu3elseVR
 9MS/uorB9+6WYLHUlTwQiVOYGxEifvAo2hZKzP7a8Z8IJgWs32wYrT891n+PZ0DsfYoiGGjujZw
 ==
X-Google-Smtp-Source: ABdhPJzkso5O8iQFFqzG5MTdm4PfWcwpurbe7V68uCIcoKQdqNCFvSNN4bIg15AhYgsSA9PeO9bt7B9kuOYJ3/CRzg==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a25:a85:: with SMTP id
 127mr16143000ybk.143.1602199331852; Thu, 08 Oct 2020 16:22:11 -0700 (PDT)
Date: Thu,  8 Oct 2020 16:21:49 -0700
In-Reply-To: <20201008232154.94221-1-hskinnemoen@google.com>
Message-Id: <20201008232154.94221-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 1/6] tests/qtest: Add npcm7xx timer test
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, f4bug@amsat.org, clg@kaod.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3I59_XwsKCmIHSKINNEMOENGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

This test exercises the various modes of the npcm7xx timer. In
particular, it triggers the bug found by the fuzzer, as reported here:

https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02992.html

It also found several other bugs, especially related to interrupt
handling.

The test exercises all the timers in all the timer modules, which
expands to 180 test cases in total.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/qtest/npcm7xx_timer-test.c | 562 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 2 files changed, 563 insertions(+)
 create mode 100644 tests/qtest/npcm7xx_timer-test.c

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
new file mode 100644
index 0000000000..f08b0cd62a
--- /dev/null
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -0,0 +1,562 @@
+/*
+ * QTest testcase for the Nuvoton NPCM7xx Timer
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
+#include "libqtest-single.h"
+
+#define TIM_REF_HZ      (25000000)
+
+/* Bits in TCSRx */
+#define CEN             BIT(30)
+#define IE              BIT(29)
+#define MODE_ONESHOT    (0 << 27)
+#define MODE_PERIODIC   (1 << 27)
+#define CRST            BIT(26)
+#define CACT            BIT(25)
+#define PRESCALE(x)     (x)
+
+/* Registers shared between all timers in a module. */
+#define TISR    0x18
+#define WTCR    0x1c
+# define WTCLK(x)       ((x) << 10)
+
+/* Power-on default; used to re-initialize timers before each test. */
+#define TCSR_DEFAULT    PRESCALE(5)
+
+/* Register offsets for a timer within a timer block. */
+typedef struct Timer {
+    unsigned int tcsr_offset;
+    unsigned int ticr_offset;
+    unsigned int tdr_offset;
+} Timer;
+
+/* A timer block containing 5 timers. */
+typedef struct TimerBlock {
+    int irq_base;
+    uint64_t base_addr;
+} TimerBlock;
+
+/* Testdata for testing a particular timer within a timer block. */
+typedef struct TestData {
+    const TimerBlock *tim;
+    const Timer *timer;
+} TestData;
+
+const TimerBlock timer_block[] = {
+    {
+        .irq_base   = 32,
+        .base_addr  = 0xf0008000,
+    },
+    {
+        .irq_base   = 37,
+        .base_addr  = 0xf0009000,
+    },
+    {
+        .irq_base   = 42,
+        .base_addr  = 0xf000a000,
+    },
+};
+
+const Timer timer[] = {
+    {
+        .tcsr_offset    = 0x00,
+        .ticr_offset    = 0x08,
+        .tdr_offset     = 0x10,
+    }, {
+        .tcsr_offset    = 0x04,
+        .ticr_offset    = 0x0c,
+        .tdr_offset     = 0x14,
+    }, {
+        .tcsr_offset    = 0x20,
+        .ticr_offset    = 0x28,
+        .tdr_offset     = 0x30,
+    }, {
+        .tcsr_offset    = 0x24,
+        .ticr_offset    = 0x2c,
+        .tdr_offset     = 0x34,
+    }, {
+        .tcsr_offset    = 0x40,
+        .ticr_offset    = 0x48,
+        .tdr_offset     = 0x50,
+    },
+};
+
+/* Returns the index of the timer block. */
+static int tim_index(const TimerBlock *tim)
+{
+    ptrdiff_t diff = tim - timer_block;
+
+    g_assert(diff >= 0 && diff < ARRAY_SIZE(timer_block));
+
+    return diff;
+}
+
+/* Returns the index of a timer within a timer block. */
+static int timer_index(const Timer *t)
+{
+    ptrdiff_t diff = t - timer;
+
+    g_assert(diff >= 0 && diff < ARRAY_SIZE(timer));
+
+    return diff;
+}
+
+/* Returns the irq line for a given timer. */
+static int tim_timer_irq(const TestData *td)
+{
+    return td->tim->irq_base + timer_index(td->timer);
+}
+
+/* Register read/write accessors. */
+
+static void tim_write(const TestData *td,
+                      unsigned int offset, uint32_t value)
+{
+    writel(td->tim->base_addr + offset, value);
+}
+
+static uint32_t tim_read(const TestData *td, unsigned int offset)
+{
+    return readl(td->tim->base_addr + offset);
+}
+
+static void tim_write_tcsr(const TestData *td, uint32_t value)
+{
+    tim_write(td, td->timer->tcsr_offset, value);
+}
+
+static uint32_t tim_read_tcsr(const TestData *td)
+{
+    return tim_read(td, td->timer->tcsr_offset);
+}
+
+static void tim_write_ticr(const TestData *td, uint32_t value)
+{
+    tim_write(td, td->timer->ticr_offset, value);
+}
+
+static uint32_t tim_read_ticr(const TestData *td)
+{
+    return tim_read(td, td->timer->ticr_offset);
+}
+
+static uint32_t tim_read_tdr(const TestData *td)
+{
+    return tim_read(td, td->timer->tdr_offset);
+}
+
+/* Returns the number of nanoseconds to count the given number of cycles. */
+static int64_t tim_calculate_step(uint32_t count, uint32_t prescale)
+{
+    return (1000000000LL / TIM_REF_HZ) * count * (prescale + 1);
+}
+
+/* Returns a bitmask corresponding to the timer under test. */
+static uint32_t tim_timer_bit(const TestData *td)
+{
+    return BIT(timer_index(td->timer));
+}
+
+/* Resets all timers to power-on defaults. */
+static void tim_reset(const TestData *td)
+{
+    int i, j;
+
+    /* Reset all the timers, in case a previous test left a timer running. */
+    for (i = 0; i < ARRAY_SIZE(timer_block); i++) {
+        for (j = 0; j < ARRAY_SIZE(timer); j++) {
+            writel(timer_block[i].base_addr + timer[j].tcsr_offset,
+                   CRST | TCSR_DEFAULT);
+        }
+        writel(timer_block[i].base_addr + TISR, -1);
+    }
+}
+
+/* Verifies the reset state of a timer. */
+static void test_reset(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+
+    tim_reset(td);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, TCSR_DEFAULT);
+    g_assert_cmphex(tim_read_ticr(td), ==, 0);
+    g_assert_cmphex(tim_read_tdr(td), ==, 0);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+    g_assert_cmphex(tim_read(td, WTCR), ==, WTCLK(1));
+}
+
+/* Verifies that CRST wins if both CEN and CRST are set. */
+static void test_reset_overrides_enable(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+
+    tim_reset(td);
+
+    /* CRST should force CEN to 0 */
+    tim_write_tcsr(td, CEN | CRST | TCSR_DEFAULT);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, TCSR_DEFAULT);
+    g_assert_cmphex(tim_read_tdr(td), ==, 0);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+}
+
+/* Verifies the behavior when CEN is set and then cleared. */
+static void test_oneshot_enable_then_disable(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+
+    tim_reset(td);
+
+    /* Enable the timer with zero initial count, then disable it again. */
+    tim_write_tcsr(td, CEN | TCSR_DEFAULT);
+    tim_write_tcsr(td, TCSR_DEFAULT);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, TCSR_DEFAULT);
+    g_assert_cmphex(tim_read_tdr(td), ==, 0);
+    /* Timer interrupt flag should be set, but interrupts are not enabled. */
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/* Verifies that a one-shot timer fires when expected with prescaler 5. */
+static void test_oneshot_ps5(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 256;
+    unsigned int ps = 5;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | PRESCALE(ps));
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+
+    clock_step(tim_calculate_step(count, ps) - 1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), <, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+
+    clock_step(1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+    /* Clear the interrupt flag. */
+    tim_write(td, TISR, tim_timer_bit(td));
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+    /* Verify that this isn't a periodic timer. */
+    clock_step(2 * tim_calculate_step(count, ps));
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/* Verifies that a one-shot timer fires when expected with prescaler 0. */
+static void test_oneshot_ps0(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 1;
+    unsigned int ps = 0;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | PRESCALE(ps));
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+
+    clock_step(tim_calculate_step(count, ps) - 1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), <, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+
+    clock_step(1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/* Verifies that a one-shot timer fires when expected with highest prescaler. */
+static void test_oneshot_ps255(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = (1U << 24) - 1;
+    unsigned int ps = 255;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | PRESCALE(ps));
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+
+    clock_step(tim_calculate_step(count, ps) - 1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, CEN | CACT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), <, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+
+    clock_step(1);
+
+    g_assert_cmphex(tim_read_tcsr(td), ==, PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/* Verifies that a oneshot timer fires an interrupt when expected. */
+static void test_oneshot_interrupt(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 256;
+    unsigned int ps = 7;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, IE | CEN | MODE_ONESHOT | PRESCALE(ps));
+
+    clock_step_next();
+
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/*
+ * Verifies that the timer can be paused and later resumed, and it still fires
+ * at the right moment.
+ */
+static void test_pause_resume(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 256;
+    unsigned int ps = 1;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, IE | CEN | MODE_ONESHOT | PRESCALE(ps));
+
+    /* Pause the timer halfway to expiration. */
+    clock_step(tim_calculate_step(count / 2, ps));
+    tim_write_tcsr(td, IE | MODE_ONESHOT | PRESCALE(ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 2);
+
+    /* Counter should not advance during the following step. */
+    clock_step(2 * tim_calculate_step(count, ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 2);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+    /* Resume the timer and run _almost_ to expiration. */
+    tim_write_tcsr(td, IE | CEN | MODE_ONESHOT | PRESCALE(ps));
+    clock_step(tim_calculate_step(count / 2, ps) - 1);
+    g_assert_cmpuint(tim_read_tdr(td), <, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+    g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+    /* Now, run the rest of the way and verify that the interrupt fires. */
+    clock_step(1);
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+    g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+}
+
+/* Verifies that the prescaler can be changed while the timer is runnin. */
+static void test_prescaler_change(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 256;
+    unsigned int ps = 5;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+
+    /* Run a quarter of the way, and change the prescaler. */
+    clock_step(tim_calculate_step(count / 4, ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, 3 * count / 4);
+    ps = 2;
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+    /* The counter must not change. */
+    g_assert_cmpuint(tim_read_tdr(td), ==, 3 * count / 4);
+
+    /* Run another quarter of the way, and change the prescaler again. */
+    clock_step(tim_calculate_step(count / 4, ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 2);
+    ps = 8;
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+    /* The counter must not change. */
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 2);
+
+    /* Run another quarter of the way, and change the prescaler again. */
+    clock_step(tim_calculate_step(count / 4, ps));
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 4);
+    ps = 0;
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+    /* The counter must not change. */
+    g_assert_cmpuint(tim_read_tdr(td), ==, count / 4);
+
+    /* Run almost to expiration, and verify the timer didn't fire yet. */
+    clock_step(tim_calculate_step(count / 4, ps) - 1);
+    g_assert_cmpuint(tim_read_tdr(td), <, count);
+    g_assert_cmphex(tim_read(td, TISR), ==, 0);
+
+    /* Now, run the rest of the way and verify that the timer fires. */
+    clock_step(1);
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+}
+
+/* Verifies that a periodic timer automatically restarts after expiration. */
+static void test_periodic_no_interrupt(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 2;
+    unsigned int ps = 3;
+    int i;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | MODE_PERIODIC | PRESCALE(ps));
+
+    for (i = 0; i < 4; i++) {
+        clock_step_next();
+
+        g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+        g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+        tim_write(td, TISR, tim_timer_bit(td));
+
+        g_assert_cmphex(tim_read(td, TISR), ==, 0);
+        g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+    }
+}
+
+/* Verifies that a periodict timer fires an interrupt every time it expires. */
+static void test_periodic_interrupt(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 65535;
+    unsigned int ps = 2;
+    int i;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
+
+    for (i = 0; i < 4; i++) {
+        clock_step_next();
+
+        g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+        g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+
+        tim_write(td, TISR, tim_timer_bit(td));
+
+        g_assert_cmphex(tim_read(td, TISR), ==, 0);
+        g_assert_false(qtest_get_irq(global_qtest, tim_timer_irq(td)));
+    }
+}
+
+/*
+ * Verifies that the timer behaves correctly when disabled right before and
+ * exactly when it's supposed to expire.
+ */
+static void test_disable_on_expiration(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    unsigned int count = 8;
+    unsigned int ps = 255;
+
+    tim_reset(td);
+
+    tim_write_ticr(td, count);
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+
+    clock_step(tim_calculate_step(count, ps) - 1);
+
+    tim_write_tcsr(td, MODE_ONESHOT | PRESCALE(ps));
+    tim_write_tcsr(td, CEN | MODE_ONESHOT | PRESCALE(ps));
+    clock_step(1);
+    tim_write_tcsr(td, MODE_ONESHOT | PRESCALE(ps));
+    g_assert_cmphex(tim_read(td, TISR), ==, tim_timer_bit(td));
+}
+
+/*
+ * Constructs a name that includes the timer block, timer and testcase name,
+ * and adds the test to the test suite.
+ */
+static void tim_add_test(const char *name, const TestData *td, GTestDataFunc fn)
+{
+    g_autofree char *full_name;
+
+    full_name = g_strdup_printf("npcm7xx_timer/tim[%d]/timer[%d]/%s",
+                                tim_index(td->tim), timer_index(td->timer),
+                                name);
+    qtest_add_data_func(full_name, td, fn);
+}
+
+/* Convenience macro for adding a test with a predictable function name. */
+#define add_test(name, td) tim_add_test(#name, td, test_##name)
+
+int main(int argc, char **argv)
+{
+    TestData testdata[ARRAY_SIZE(timer_block) * ARRAY_SIZE(timer)];
+    int ret;
+    int i, j;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    for (i = 0; i < ARRAY_SIZE(timer_block); i++) {
+        for (j = 0; j < ARRAY_SIZE(timer); j++) {
+            TestData *td = &testdata[i * ARRAY_SIZE(timer) + j];
+            td->tim = &timer_block[i];
+            td->timer = &timer[j];
+
+            add_test(reset, td);
+            add_test(reset_overrides_enable, td);
+            add_test(oneshot_enable_then_disable, td);
+            add_test(oneshot_ps5, td);
+            add_test(oneshot_ps0, td);
+            add_test(oneshot_ps255, td);
+            add_test(oneshot_interrupt, td);
+            add_test(pause_resume, td);
+            add_test(prescaler_change, td);
+            add_test(periodic_no_interrupt, td);
+            add_test(periodic_interrupt, td);
+            add_test(disable_on_expiration, td);
+        }
+    }
+
+    qtest_start("-machine npcm750-evb");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/a9mpcore/gic");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0f32ca0895..941d7cb8c5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -137,6 +137,7 @@ qtests_arm = \
   ['arm-cpu-features',
    'microbit-test',
    'm25p80-test',
+   'npcm7xx_timer-test',
    'test-arm-mptimer',
    'boot-serial-test',
    'hexloader-test']
-- 
2.28.0.1011.ga647a8990f-goog


