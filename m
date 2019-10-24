Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990432070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps38OElF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990432070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45151 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeiY-0001Qq-Io
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdig-0006t8-St
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdib-0007a3-Hs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdib-0007ZZ-3O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so1561263wmm.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iGmswL4U/5XW7ql7Ew8zQ48E5AkJVaBYfQW9kZ657mI=;
 b=ps38OElF2RwitS8r3osFXr8symM/iIehe0wXdlIb3ctYk1BNZrHA0bR0eMFzp5+hPP
 RxPs0TNWiIQFoIaf7dRLZpfTD6CFmtJgxhcaj3lsGsLrrU4XcPgsg/Hs39YPoUpRfH8R
 c741xxkW87CXl5sVmhSUtXUIqVwzVp+WzsIbMqeqZowSv8+/NMg82kz7l36hUnea5mGL
 iJU9K0ahgTI0hgpivTpwqVjAGZKNk0PuGFMTbLwk8gw8NquQJRCQ7OJ9Rc6z9GhE7RGk
 rUA8gqt/4vS0NdPqJxXIZuNe1tKCFLEj1QUbs37eFnuICqT0VLE8LyuWskrxt7FjWtls
 Hh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iGmswL4U/5XW7ql7Ew8zQ48E5AkJVaBYfQW9kZ657mI=;
 b=DzRkVQ5rADWzRuSv974YPbYlZrWu2y6INKqf+nJsyHlpW+HS6tDh3e5nsL4qxUV4lE
 Dni8PSs1n880wxhpGLdA6PrPUrDYJIyPlts3bHSaj2OpTMGbhdFNSAhep9APuk6gzJX8
 zOrKoghR5mhq5UM4XB9wHpCAQJjXEi0zpXtMd4sVeLAgZ+66Y6Np8Qrq7HpBqM4597C7
 sIXkbuzJ3E5Z596e201PR/xWLOxENojZUNxp4O8mNFWPu1WF86LD2nIHPmPLpZad4H4D
 WyYKV7ZmzZ1E2ShKdpbrUSDLZMW9YTZgH51h1diJafahqJ1AAgohukMGEybgsIEe7VA1
 AsJA==
X-Gm-Message-State: APjAAAVFjyGFOqQJ7IT8rCuPKtzCStcaQqjheiXbDgEChkyUEkt0iHuC
 s/PPQqAMwKX7tQlpnfU9k/qYN8US
X-Google-Smtp-Source: APXvYqxV6x/LUk/FGWOTOI4l7+8LG8EaHqdcHV1pkWRoOOYvdchHy1F001MLq6RepbdnpeI92C0Ptg==
X-Received: by 2002:a1c:e404:: with SMTP id b4mr5555773wmh.90.1571925839703;
 Thu, 24 Oct 2019 07:03:59 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.03.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:03:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/39] mc146818rtc: fix timer interrupt reinjection
Date: Thu, 24 Oct 2019 16:03:18 +0200
Message-Id: <1571925835-31930-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marcelo Tosatti <mtosatti@redhat.com>

commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest.

In that case, old_period is 0, which ends up zeroing irq_coalesced
(counter of reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

Fix by not updating s->irq_coalesced when old_period is 0.

V2: reorganize code (Paolo Bonzini)

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Message-Id: <20191010123008.GA19158@amt.cnet>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 53 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb3787..0e7cf97 100644
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
-- 
1.8.3.1



