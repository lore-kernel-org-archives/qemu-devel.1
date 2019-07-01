Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81EC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5822021473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKNZZew5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5822021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7aR-00072Q-LM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Bs-0006Nu-O8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Bq-0004UC-Bj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:23 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4Bl-0004BH-9x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:21 -0400
Received: by mail-wr1-f44.google.com with SMTP id c27so7714626wrb.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wbaK2lk4yZHP52j/5+PW5BzsdFPHnkuejkFeyT9B6iY=;
 b=fKNZZew5Oh02CcxlKp2lEV04XxxkatzL6oCiuE3zqI6/RoSINksSra+/JteNGuKeE2
 Fv5edWUc/wL7d6Asf1HM/ldpFU2nGJB9r37hnOPyw1nB8aipJJb5zAqkzGK1LdCdFoEI
 tlTdH7dAQLRI3Ouz47bjXeTZ2j03anFT/OVT8gURDvaT24WJimi57OuqakybGLElo34i
 +kMBNXcC5bPsBwLiVBe6nps42etI2oY9mwF2kaTXj/KegjoUSNPqOJNu/Y5JpYYg3lLC
 E6SYxx0Q3BwOjdyxznW2c9IZSLqMwzDUWifR1IUZ+58+MeuItkjd3j6SMXoFmlEUG7B1
 JfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wbaK2lk4yZHP52j/5+PW5BzsdFPHnkuejkFeyT9B6iY=;
 b=fQoC7Ccwc1rt1nGLuhd1Ix14bzQxffcDNe2ClqwGkWTV0+bU/2WXJ6jk/n9mTCc1Kj
 oXrJCCkXgbhqTt33G475qy21EQCc0fTO5VmmS6UHeH7H7o7cmKBXxYw8m6H5jsg7JcDt
 +GdcKvRYD9YiHLQyebVeEuLhgsHLES0W1vN1mIQP9TrFXNuy5xj3CUp9tX++Ft402p9C
 No5qVUgHnqrZXgH9utFMDUE5Om9WJhiPnRipFBC2MVIeg7TqN9I5q7a8INHfpe/Aru+U
 NvA7OjbuysEYFDnXhPi1njUvFrl7XZQPJOrI8etvZDP62OEkvHpVlxYNZaEojTAZmJTr
 xaSg==
X-Gm-Message-State: APjAAAXqDmO5b/JSOAmbCXbvrVCXhbbqwBI7S7QYumI0cq/gdrCA8iir
 CZX6w9bxh6LUrwk/tgDmaKvI23xr2VbWlg==
X-Google-Smtp-Source: APXvYqyntrThvsXnDgmb3Jvc2F4qwOVxFWJlUiUGcjNnuo+nYw6R91DADJ8zyoqesNcI/ywnEdy9hQ==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr11726003wrv.207.1561999201868; 
 Mon, 01 Jul 2019 09:40:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:12 +0100
Message-Id: <20190701163943.22313-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: [Qemu-devel] [PULL 15/46] aspeed/timer: Fix behaviour running Linux
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

From: Joel Stanley <joel@jms.id.au>

The Linux kernel driver was updated in commit 4451d3f59f2a
("clocksource/drivers/fttmr010: Fix set_next_event handler) to fix an
issue observed on hardware:

 > RELOAD register is loaded into COUNT register when the aspeed timer
 > is enabled, which means the next event may be delayed because timer
 > interrupt won't be generated until <0xFFFFFFFF - current_count +
 > cycles>.

When running under Qemu, the system appeared "laggy". The guest is now
scheduling timer events too regularly, starving the host of CPU time.

This patch modifies the timer model to attempt to schedule the timer
expiry as the guest requests, but if we have missed the deadline we
re interrupt and try again, which allows the guest to catch up.

Provides expected behaviour with old and new guest code.

Fixes: c04bd47db6b9 ("hw/timer: Add ASPEED timer device model")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190618165311.27066-8-clg@kaod.org
[clg: - merged a fix from Andrew Jeffery <andrew@aj.id.au>
        "Fire interrupt on failure to meet deadline"
        https://lists.ozlabs.org/pipermail/openbmc/2019-January/014641.html
      - adapted commit log
      - checkpatch fixes ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/aspeed_timer.c | 57 ++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 2c3a4d0fe77..537f072cf87 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -109,37 +109,40 @@ static inline uint64_t calculate_time(struct AspeedTimer *t, uint32_t ticks)
 
 static uint64_t calculate_next(struct AspeedTimer *t)
 {
-    uint64_t next = 0;
-    uint32_t rate = calculate_rate(t);
+    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t next;
 
-    while (!next) {
-        /* We don't know the relationship between the values in the match
-         * registers, so sort using MAX/MIN/zero. We sort in that order as the
-         * timer counts down to zero. */
-        uint64_t seq[] = {
-            calculate_time(t, MAX(t->match[0], t->match[1])),
-            calculate_time(t, MIN(t->match[0], t->match[1])),
-            calculate_time(t, 0),
-        };
-        uint64_t reload_ns;
-        uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    /*
+     * We don't know the relationship between the values in the match
+     * registers, so sort using MAX/MIN/zero. We sort in that order as
+     * the timer counts down to zero.
+     */
 
-        if (now < seq[0]) {
-            next = seq[0];
-        } else if (now < seq[1]) {
-            next = seq[1];
-        } else if (now < seq[2]) {
-            next = seq[2];
-        } else if (t->reload) {
-            reload_ns = muldiv64(t->reload, NANOSECONDS_PER_SECOND, rate);
-            t->start = now - ((now - t->start) % reload_ns);
-        } else {
-            /* no reload value, return 0 */
-            break;
-        }
+    next = calculate_time(t, MAX(t->match[0], t->match[1]));
+    if (now < next) {
+        return next;
     }
 
-    return next;
+    next = calculate_time(t, MIN(t->match[0], t->match[1]));
+    if (now < next) {
+        return next;
+    }
+
+    next = calculate_time(t, 0);
+    if (now < next) {
+        return next;
+    }
+
+    /* We've missed all deadlines, fire interrupt and try again */
+    timer_del(&t->timer);
+
+    if (timer_overflow_interrupt(t)) {
+        t->level = !t->level;
+        qemu_set_irq(t->irq, t->level);
+    }
+
+    t->start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
 }
 
 static void aspeed_timer_mod(AspeedTimer *t)
-- 
2.20.1


