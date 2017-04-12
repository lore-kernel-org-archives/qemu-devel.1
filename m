Received: from eggs.gnu.org ([2001:4830:134:3::10]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwY-0005aQ-DX
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwU-0004nT-6g
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:06 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cyEwT-0004nN-VP
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:02 -0400
Received: by mail-pg0-x241.google.com with SMTP id g2so4225886pge.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 02:52:01 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 12 Apr 2017 17:51:10 +0800
Message-Id: <20170412095111.11728-5-xiaoguangrong@tencent.com>
In-Reply-To: <20170412095111.11728-1-xiaoguangrong@tencent.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 4/5] mc146818rtc: move x86 specific code out of
 periodic_timer_update
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

Move the x86 specific code in periodic_timer_update() to a common place,
the actual logic is not changed

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 112 +++++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 46 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 3bf559d..d7b7c56 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -144,6 +144,63 @@ static void rtc_coalesced_timer(void *opaque)
 
     rtc_coalesced_timer_update(s);
 }
+
+static int64_t
+arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
+{
+    if (period != s->period) {
+        int64_t scale_lost_clock;
+        int current_irq_coalesced = s->irq_coalesced;
+
+        s->irq_coalesced = (current_irq_coalesced * s->period) / period;
+
+        /*
+         * calculate the lost clock after it is scaled which should be
+         * compensated in the next interrupt.
+         */
+        scale_lost_clock = current_irq_coalesced * s->period -
+                            s->irq_coalesced * period;
+        DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, %ld clocks "
+                  "are compensated.\n", current_irq_coalesced,
+                  s->irq_coalesced, scale_lost_clock);
+        lost_clock += scale_lost_clock;
+        s->period = period;
+    }
+
+    /*
+     * if more than period clocks were passed, i.e, the timer interrupt
+     * has been lost, we should catch up the time.
+     */
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
+       (lost_clock / period)) {
+        int lost_interrupt = lost_clock / period;
+
+        s->irq_coalesced += lost_interrupt;
+        lost_clock -= lost_interrupt * period;
+        if (lost_interrupt) {
+            DPRINTF_C("cmos: compensate %d interrupts, coalesced irqs "
+                      "increased to %d\n", lost_interrupt, s->irq_coalesced);
+            rtc_coalesced_timer_update(s);
+        }
+    }
+
+    return lost_clock;
+}
+
+static void arch_periodic_timer_disable(RTCState *s)
+{
+    s->irq_coalesced = 0;
+}
+#else
+static int64_t
+arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
+{
+    return lost_clock;
+}
+
+static void arch_periodic_timer_disable(RTCState *s)
+{
+}
 #endif
 
 static int period_code_to_clock(int period_code)
@@ -175,24 +232,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, int old_period)
     if (period_code != 0
         && (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
         period = period_code_to_clock(period_code);
-#ifdef TARGET_I386
-        if (period != s->period) {
-            int current_irq_coalesced = s->irq_coalesced;
-
-            s->irq_coalesced = (current_irq_coalesced * s->period) / period;
 
-            /*
-             * calculate the lost clock after it is scaled which should be
-             * compensated in the next interrupt.
-             */
-            lost_clock += current_irq_coalesced * s->period -
-                            s->irq_coalesced * period;
-            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, %ld clocks "
-                      "are compensated.\n",
-                      current_irq_coalesced, s->irq_coalesced, lost_clock);
-        }
-        s->period = period;
-#endif
         /* compute 32 khz clock */
         cur_clock =
             muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
@@ -219,42 +259,22 @@ periodic_timer_update(RTCState *s, int64_t current_time, int old_period)
 
             /* calculate the clock since last interrupt. */
             lost_clock += cur_clock - last_periodic_clock;
-
-#ifdef TARGET_I386
-            /*
-             * if more than period clocks were passed, i.e, the timer interrupt
-             * has been lost, we should catch up the time.
-             */
-            if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
-                (lost_clock / period)) {
-                int lost_interrupt = lost_clock / period;
-
-                s->irq_coalesced += lost_interrupt;
-                lost_clock -= lost_interrupt * period;
-                if (lost_interrupt) {
-                    DPRINTF_C("cmos: compensate %d interrupts, coalesced irqs "
-                              "increased to %d\n", lost_interrupt,
-                              s->irq_coalesced);
-                    rtc_coalesced_timer_update(s);
-                }
-            } else
-#endif
-            /*
-             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
-             * is not used, we should make the time progress anyway.
-             */
-            lost_clock = MIN(lost_clock, period);
-            assert(lost_clock >= 0);
         }
 
+        lost_clock = arch_periodic_timer_update(s, period, lost_clock);
+
+        /*
+         * we should make the time progress anyway.
+         */
+        lost_clock = MIN(lost_clock, period);
+        assert(lost_clock >= 0);
+
         next_irq_clock = cur_clock + period - lost_clock;
         s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
                                          RTC_CLOCK_RATE) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
     } else {
-#ifdef TARGET_I386
-        s->irq_coalesced = 0;
-#endif
+        arch_periodic_timer_disable(s);
         timer_del(s->periodic_timer);
     }
 }
-- 
2.9.3
