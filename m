Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3r-0000j2-Dh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3q-0003mD-H9
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:31 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d8N3q-0003lg-By
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id w69so3029142pfk.1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:33:30 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 10 May 2017 16:32:58 +0800
Message-Id: <20170510083259.3900-5-xiaoguangrong@tencent.com>
In-Reply-To: <20170510083259.3900-1-xiaoguangrong@tencent.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 4/5] mc146818rtc: drop unnecessary '#ifdef
 TARGET_I386'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

If the code purely depends on LOST_TICK_POLICY_SLEW, we can simply
drop '#ifdef TARGET_I386' as only x86 can enable this tick policy

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 9810bd5..104a26d 100644
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
          * recalculate the coalesced irqs for two reasons:
          *    a) the lost_clock is more that a period, i,e. the timer
@@ -233,9 +232,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
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
@@ -250,9 +247,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
                                          RTC_CLOCK_RATE) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
     } else {
-#ifdef TARGET_I386
         s->irq_coalesced = 0;
-#endif
         timer_del(s->periodic_timer);
     }
 }
@@ -841,13 +836,11 @@ static int rtc_post_load(void *opaque, int version_id)
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
 
@@ -904,11 +897,10 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
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
@@ -929,12 +921,10 @@ static void rtc_reset(void *opaque)
 
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
2.9.3
