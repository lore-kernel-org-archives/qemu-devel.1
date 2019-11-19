Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AFAC43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEEC22363
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icVKQlmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEEC22363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6CG-00035E-KG
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63v-00021Y-AD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63u-00069S-21
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63t-000695-RW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id z26so3791999wmi.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=iIEhLJHGJyb/n0As6qSQK05whIAhohU7R9F3hYodbw0=;
 b=icVKQlmv2Y9HtY5+AT45kiySywerRLDixl1CG9V3SKDYtf//xFuaKxflsEk4qXmX+U
 LcLbedTX8RUpExn9RXIca0gX547aITz+oRR0qTNfTvXjsUZYmuPDxxcnAW5brk0bbKpd
 c1Gxx1jsE6hKJbXxfb4HiMKT4V42A2ierrt/++bB/oof2NEFFHfH6ylE49NU+2tobkJq
 A+U+TZ710YtAffh4wZ7hxNG5YwiTBs8vfwIMRZBKeXtV/ef5okLf4M+b4j7BHFvekCE+
 s8JoI0eZ/KhacGBL+1/yfc7W7y9QXhlr/6T5JwhM3bRQNbfxKw9JvB0RVhW3+Jsyx8Mc
 odOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=iIEhLJHGJyb/n0As6qSQK05whIAhohU7R9F3hYodbw0=;
 b=HhgRVlzeAbhogxSJ5goaO2SjBRLXOa+zI1ETni7C0Sq3d3tZKrEb8guim6I2OQCbxU
 NAlud0cRNZTosFnciLw+/UcRDXl3kprjuSKHzBvQcPBCxZdMpGIcd3+evDfiUKa/LrDa
 TnqwWFhdE4siZH6Guq41DTWwPI+L8bGy0tseLJUcbYQo4mDq9UwONAYdsCvF6KCitWZM
 CywBdQlKFSLcV9OWeleB3WC64hZt3epQoU5+VtHj4NCHjMC+cKjPi8mDU0SZK6SRVYqj
 foXrOQOzVBBqESdDSXsDIlGmo259sQ/mfQ3L2gkaBPfdukRMQhg/nln9KVQDA2U1hQBE
 KhtA==
X-Gm-Message-State: APjAAAUkMbC/R+D8nFb/HsTe2MwR/1JQluT0zHzvmtGhuhLTO8BZFfyC
 DZUl2pW3ZZA/3o9mKZE3Ip0gWSnt
X-Google-Smtp-Source: APXvYqyqbarSik4UhQAnuYZwBlFyhLRn2+lXi0y+Mv6M6A4RD3Eaa6/1231M+eGZ/AIFDmSG8j7hnw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr7040588wme.76.1574179744541;
 Tue, 19 Nov 2019 08:09:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.09.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:09:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] Revert "mc146818rtc: fix timer interrupt reinjection"
Date: Tue, 19 Nov 2019 17:08:47 +0100
Message-Id: <1574179728-35535-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

This reverts commit b429de730174b388ea5760e3debb0d542ea3c261, except
that the reversal of the outer "if (period)" is left in.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 67 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ee6bf82..9869dc5 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -174,7 +174,6 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
     int64_t cur_clock, next_irq_clock, lost_clock = 0;
 
     period = rtc_periodic_clock_ticks(s);
-
     if (!period) {
         s->irq_coalesced = 0;
         timer_del(s->periodic_timer);
@@ -197,42 +196,42 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
         last_periodic_clock = next_periodic_clock - old_period;
         lost_clock = cur_clock - last_periodic_clock;
         assert(lost_clock >= 0);
+    }
 
+    /*
+     * s->irq_coalesced can change for two reasons:
+     *
+     * a) if one or more periodic timer interrupts have been lost,
+     *    lost_clock will be more that a period.
+     *
+     * b) when the period may be reconfigured, we expect the OS to
+     *    treat delayed tick as the new period.  So, when switching
+     *    from a shorter to a longer period, scale down the missing,
+     *    because the OS will treat past delayed ticks as longer
+     *    (leftovers are put back into lost_clock).  When switching
+     *    to a shorter period, scale up the missing ticks since the
+     *    OS handler will treat past delayed ticks as shorter.
+     */
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+        uint32_t old_irq_coalesced = s->irq_coalesced;
+
+        s->period = period;
+        lost_clock += old_irq_coalesced * old_period;
+        s->irq_coalesced = lost_clock / s->period;
+        lost_clock %= s->period;
+        if (old_irq_coalesced != s->irq_coalesced ||
+            old_period != s->period) {
+            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
+                      "period scaled from %d to %d\n", old_irq_coalesced,
+                      s->irq_coalesced, old_period, s->period);
+            rtc_coalesced_timer_update(s);
+        }
+    } else {
         /*
-         * s->irq_coalesced can change for two reasons:
-         *
-         * a) if one or more periodic timer interrupts have been lost,
-         *    lost_clock will be more that a period.
-         *
-         * b) when the period may be reconfigured, we expect the OS to
-         *    treat delayed tick as the new period.  So, when switching
-         *    from a shorter to a longer period, scale down the missing,
-         *    because the OS will treat past delayed ticks as longer
-         *    (leftovers are put back into lost_clock).  When switching
-         *    to a shorter period, scale up the missing ticks since the
-         *    OS handler will treat past delayed ticks as shorter.
+         * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
+         * is not used, we should make the time progress anyway.
          */
-        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-            uint32_t old_irq_coalesced = s->irq_coalesced;
-
-            s->period = period;
-            lost_clock += old_irq_coalesced * old_period;
-            s->irq_coalesced = lost_clock / s->period;
-            lost_clock %= s->period;
-            if (old_irq_coalesced != s->irq_coalesced ||
-                old_period != s->period) {
-                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
-                          "period scaled from %d to %d\n", old_irq_coalesced,
-                          s->irq_coalesced, old_period, s->period);
-                rtc_coalesced_timer_update(s);
-            }
-        } else {
-            /*
-             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
-             * is not used, we should make the time progress anyway.
-             */
-            lost_clock = MIN(lost_clock, period);
-        }
+        lost_clock = MIN(lost_clock, period);
     }
 
     assert(lost_clock >= 0 && lost_clock <= period);
-- 
1.8.3.1



