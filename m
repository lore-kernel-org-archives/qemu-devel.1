Received: from eggs.gnu.org ([2001:4830:134:3::10]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQR-0003MW-GW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQO-0005fb-Ow
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:03 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQO-0005fT-In
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:00 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so11048268wmh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:22 +0200
Message-Id: <1496320911-51305-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/33] mc146818rtc: drop unnecessary '#ifdef
 TARGET_I386'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

If the code purely depends on LOST_TICK_POLICY_SLEW, we can simply
drop '#ifdef TARGET_I386' as only x86 can enable this tick policy

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20170510083259.3900-5-xiaoguangrong@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 4870a72..f9d6181 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -112,7 +112,6 @@ static uint64_t get_guest_rtc_ns(RTCState *s)
         guest_clock - s->last_update + s->offset;
 }
 
-#ifdef TARGET_I386
 static void rtc_coalesced_timer_update(RTCState *s)
 {
     if (s->irq_coalesced == 0) {
@@ -126,6 +125,7 @@ static void rtc_coalesced_timer_update(RTCState *s)
     }
 }
 
+#ifdef TARGET_I386
 static void rtc_coalesced_timer(void *opaque)
 {
     RTCState *s = opaque;
@@ -198,7 +198,6 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
             assert(lost_clock >= 0);
         }
 
-#ifdef TARGET_I386
         /*
          * s->irq_coalesced can change for two reasons:
          *
@@ -227,9 +226,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
                           s->irq_coalesced, old_period, s->period);
                 rtc_coalesced_timer_update(s);
             }
-        } else
-#endif
-        {
+        } else {
            /*
              * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
              * is not used, we should make the time progress anyway.
@@ -244,9 +241,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
                                          RTC_CLOCK_RATE) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
     } else {
-#ifdef TARGET_I386
         s->irq_coalesced = 0;
-#endif
         timer_del(s->periodic_timer);
     }
 }
@@ -835,13 +830,11 @@ static int rtc_post_load(void *opaque, int version_id)
         }
     }
 
-#ifdef TARGET_I386
     if (version_id >= 2) {
         if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
             rtc_coalesced_timer_update(s);
         }
     }
-#endif
     return 0;
 }
 
@@ -898,11 +891,10 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
     rtc_set_date_from_host(ISA_DEVICE(s));
     periodic_timer_update(s, now, 0);
     check_update_timer(s);
-#ifdef TARGET_I386
+
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         rtc_coalesced_timer_update(s);
     }
-#endif
 }
 
 /* set CMOS shutdown status register (index 0xF) as S3_resume(0xFE)
@@ -923,12 +915,10 @@ static void rtc_reset(void *opaque)
 
     qemu_irq_lower(s->irq);
 
-#ifdef TARGET_I386
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         s->irq_coalesced = 0;
         s->irq_reinject_on_ack_count = 0;		
     }
-#endif
 }
 
 static const MemoryRegionOps cmos_ops = {
-- 
1.8.3.1
