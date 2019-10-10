Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBCC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F9A206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F9A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXjj-0004mR-VZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1iIXaV-0002lf-OG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1iIXaT-00013C-VG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1iIXaT-000136-CL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0ED31300BEAD;
 Thu, 10 Oct 2019 12:30:32 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8443D5C22F;
 Thu, 10 Oct 2019 12:30:31 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id 6F45E105174;
 Thu, 10 Oct 2019 09:30:08 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x9ACU8GJ019248;
 Thu, 10 Oct 2019 09:30:08 -0300
Date: Thu, 10 Oct 2019 09:30:08 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191010123008.GA19158@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 10 Oct 2019 12:30:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest.

In that case, old_period is 0, which ends up zeroing irq_coalesced
(counter of reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

Fix by not updating s->irq_coalesced when old_period is 0.

V2: reorganize code (Paolo Bonzini)

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb378751b..0e7cf97042 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -203,24 +203,28 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
 
     period = rtc_periodic_clock_ticks(s);
 
-    if (period) {
-        /* compute 32 khz clock */
-        cur_clock =
-            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+    if (!period) {
+        s->irq_coalesced = 0;
+        timer_del(s->periodic_timer);
+        return;
+    }
 
-        /*
-        * if the periodic timer's update is due to period re-configuration,
-        * we should count the clock since last interrupt.
-        */
-        if (old_period) {
-            int64_t last_periodic_clock, next_periodic_clock;
-
-            next_periodic_clock = muldiv64(s->next_periodic_time,
-                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
-            last_periodic_clock = next_periodic_clock - old_period;
-            lost_clock = cur_clock - last_periodic_clock;
-            assert(lost_clock >= 0);
-        }
+    /* compute 32 khz clock */
+    cur_clock =
+        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+
+    /*
+     * if the periodic timer's update is due to period re-configuration,
+     * we should count the clock since last interrupt.
+     */
+    if (old_period) {
+        int64_t last_periodic_clock, next_periodic_clock;
+
+        next_periodic_clock = muldiv64(s->next_periodic_time,
+                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+        last_periodic_clock = next_periodic_clock - old_period;
+        lost_clock = cur_clock - last_periodic_clock;
+        assert(lost_clock >= 0);
 
         /*
          * s->irq_coalesced can change for two reasons:
@@ -251,22 +255,19 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
                 rtc_coalesced_timer_update(s);
             }
         } else {
-           /*
+            /*
              * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
              * is not used, we should make the time progress anyway.
              */
             lost_clock = MIN(lost_clock, period);
         }
+    }
 
-        assert(lost_clock >= 0 && lost_clock <= period);
+    assert(lost_clock >= 0 && lost_clock <= period);
 
-        next_irq_clock = cur_clock + period - lost_clock;
-        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
-        timer_mod(s->periodic_timer, s->next_periodic_time);
-    } else {
-        s->irq_coalesced = 0;
-        timer_del(s->periodic_timer);
-    }
+    next_irq_clock = cur_clock + period - lost_clock;
+    s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
+    timer_mod(s->periodic_timer, s->next_periodic_time);
 }
 
 static void rtc_periodic_timer(void *opaque)


