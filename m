Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA12C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AACB2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtU2+jem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AACB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Awl-0008I7-SH
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArN-0002l1-Iu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArM-0005uN-58
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArL-0005tZ-UC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id l11so9174222wrx.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m+TKKTWvRC4vo5fFotjFs4jfzAaPam+tpeNKcBhEHyY=;
 b=LtU2+jemSfwD3cFVVwWrgxblNdAATqWm5NFyBMUO6CWtPZvCewtBisJiMdHSqzzjxd
 UEJ3i0QHH/mEmLlCjO1W4QbnEqyc2TWnWCCk2CtJKTgLXykZmG8vRJzSJbYTMe44UE4A
 UYI3R87slDe5vJSYkR6YMLu15Z9SH4wFhzv5SW8MtDP3bvoc5gi+6JH00Pm7ZHSda10b
 sMrZKgTKjP3BEzm+mgiFUgHZKCD/fYv5aF6qqccxO0iHYvFEVjHURZjkJFsmg3Kui8sS
 Z5fUZMwTGC0tE2d9d/BLdXI0itzL0SxecOj05oGsC48vpjxGDd2O4GQ5JFd9UQD48fm5
 rNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m+TKKTWvRC4vo5fFotjFs4jfzAaPam+tpeNKcBhEHyY=;
 b=PbM8eYg3Uz2yIWQ5kC9h+WFGwz+EtRUgnVOzc7Dxn9C7I24c6gelXZJJq7WB8dRdRh
 tQrP5nBXRbhUkdSo5UmLjCNBpD2KYzxO2tSDouawXJQ8kj9CXMSQ6g5wj5taXmeWUgUL
 c5F8DOB5U4A+ZRNt8760ZiAQzIrnvyUmOluHOwU6cn3XwcgWVef/x54shm+Uimu06Mw6
 JxvbptKhUMbP6O/Pnj+9M4IdYHRWERlaGpLvifHb0ABcodOV0UpbdL0b2JXwAgml7RR1
 51DKvit7hkcnva1QR5ra+Cf54Gy/fjQ4FjWBVWkEpaXKqRNgcRiB/TKQSkm2wZjK4Ymm
 RXKA==
X-Gm-Message-State: APjAAAWj84vPMT2sivmoBmB5xkI2I8YoPoLAR0bHyaMglc+UdFUb8rpL
 rCiphZWSG15tR1ATTZjXuSHkoazTv4u5Og==
X-Google-Smtp-Source: APXvYqxhjK5DkqNH5wtFReeiGX3+PCjtlmg7w0+jK7tirA/FbpzrLooG1gzfrcPwZ7Lv6UMt8tBf5Q==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr7732013wrw.104.1567525002604; 
 Tue, 03 Sep 2019 08:36:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:17 +0100
Message-Id: <20190903153633.6651-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 05/21] aspeed/timer: Provide back-pressure
 information for short periods
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

From: Andrew Jeffery <andrew@aj.id.au>

First up: This is not the way the hardware behaves.

However, it helps resolve real-world problems with short periods being
used under Linux. Commit 4451d3f59f2a ("clocksource/drivers/fttmr010:
Fix set_next_event handler") in Linux fixed the timer driver to
correctly schedule the next event for the Aspeed controller, and in
combination with 5daa8212c08e ("ARM: dts: aspeed: Describe random number
device") Linux will now set a timer with a period as low as 1us.

Configuring a qemu timer with such a short period results in spending
time handling the interrupt in the model rather than executing guest
code, leading to noticeable "sticky" behaviour in the guest.

The behaviour of Linux is correct with respect to the hardware, so we
need to improve our handling under emulation. The approach chosen is to
provide back-pressure information by calculating an acceptable minimum
number of ticks to be set on the model. Under Linux an additional read
is added in the timer configuration path to detect back-pressure, which
will never occur on hardware. However if back-pressure is observed, the
driver alerts the clock event subsystem, which then performs its own
next event dilation via a config option - d1748302f70b ("clockevents:
Make minimum delay adjustments configurable")

A minimum period of 5us was experimentally determined on a Lenovo
T480s, which I've increased to 20us for "safety".

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190704055150.4899-1-clg@kaod.org
[clg: - changed the computation of min_ticks to be done each time the
        timer value is reloaded. It removes the ordering issue of the
        timer and scu reset handlers but is slightly slower ]
      - introduced TIMER_MIN_NS
      - introduced calculate_min_ticks() ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/aspeed_timer.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index ed81d5c44c7..59c2bbeee60 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -44,6 +44,13 @@ enum timer_ctrl_op {
     op_pulse_enable
 };
 
+/*
+ * Minimum value of the reload register to filter out short period
+ * timers which have a noticeable impact in emulation. 5us should be
+ * enough, use 20us for "safety".
+ */
+#define TIMER_MIN_NS (20 * SCALE_US)
+
 /**
  * Avoid mutual references between AspeedTimerCtrlState and AspeedTimer
  * structs, as it's a waste of memory. The ptimer BH callback needs to know
@@ -98,6 +105,14 @@ static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t now_ns)
     return t->reload - MIN(t->reload, ticks);
 }
 
+static uint32_t calculate_min_ticks(AspeedTimer *t, uint32_t value)
+{
+    uint32_t rate = calculate_rate(t);
+    uint32_t min_ticks = muldiv64(TIMER_MIN_NS, rate, NANOSECONDS_PER_SECOND);
+
+    return  value < min_ticks ? min_ticks : value;
+}
+
 static inline uint64_t calculate_time(struct AspeedTimer *t, uint32_t ticks)
 {
     uint64_t delta_ns;
@@ -261,7 +276,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
     switch (reg) {
     case TIMER_REG_RELOAD:
         old_reload = t->reload;
-        t->reload = value;
+        t->reload = calculate_min_ticks(t, value);
 
         /* If the reload value was not previously set, or zero, and
          * the current value is valid, try to start the timer if it is
-- 
2.20.1


