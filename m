Received: from eggs.gnu.org ([2001:4830:134:3::10]:49313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyE-0004GV-F1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyC-0000tZ-Ht
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:22 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyC-0000t1-8T
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id b84so1791794wmh.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:20:54 +0200
Message-Id: <1495192872-27667-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/20] mc146818rtc: precisely count the clock
 for periodic timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tai Yunfang <yunfangtai@tencent.com>, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Tai Yunfang <yunfangtai@tencent.com>

There are two issues in current code:
1) If the period is changed by re-configuring RegA, the coalesced
   irq will be scaled to reflect the new period, however, it
   calculates the new interrupt number like this:
    s->irq_coalesced = (s->irq_coalesced * s->period) / period;

   There are some clocks will be lost if they are not enough to
   be squeezed to a single new period that will cause the VM clock
   slower

   In order to fix the issue, we calculate the interrupt window
   based on the precise clock rather than period, then the clocks
   lost during period is scaled can be compensated properly

2) If periodic_timer_update() is called due to RegA reconfiguration,
   i.e, the period is updated, current time is not the start point
   for the next periodic timer, instead, which should start from the
   last interrupt, otherwise, the clock in VM will become slow

   This patch takes the clocks from last interrupt to current clock
   into account and compensates the clocks for the next interrupt,
   especially if a complete interrupt was lost in this window, the
   time can be caught up by LOST_TICK_POLICY_SLEW

Signed-off-by: Tai Yunfang <yunfangtai@tencent.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20170510083259.3900-3-xiaoguangrong@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 120 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 23 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 7d78391..aeb60cc 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -146,31 +146,100 @@ static void rtc_coalesced_timer(void *opaque)
 }
 #endif
 
-/* handle periodic timer */
-static void periodic_timer_update(RTCState *s, int64_t current_time)
+static uint32_t rtc_periodic_clock_ticks(RTCState *s)
 {
-    int period_code, period;
-    int64_t cur_clock, next_irq_clock;
+    int period_code;
+
+    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
+        return 0;
+     }
 
     period_code = s->cmos_data[RTC_REG_A] & 0x0f;
-    if (period_code != 0
-        && (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
-        if (period_code <= 2)
-            period_code += 7;
-        /* period in 32 Khz cycles */
-        period = 1 << (period_code - 1);
-#ifdef TARGET_I386
-        if (period != s->period) {
-            s->irq_coalesced = (s->irq_coalesced * s->period) / period;
-            DPRINTF_C("cmos: coalesced irqs scaled to %d\n", s->irq_coalesced);
-        }
-        s->period = period;
-#endif
+    if (!period_code) {
+        return 0;
+    }
+
+    if (period_code <= 2) {
+        period_code += 7;
+    }
+
+    /* period in 32 Khz cycles */
+    return 1 << (period_code - 1);
+}
+
+/*
+ * handle periodic timer. @old_period indicates the periodic timer update
+ * is just due to period adjustment.
+ */
+static void
+periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
+{
+    uint32_t period;
+    int64_t cur_clock, next_irq_clock, lost_clock = 0;
+
+    period = rtc_periodic_clock_ticks(s);
+
+    if (period) {
         /* compute 32 khz clock */
         cur_clock =
             muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
 
-        next_irq_clock = (cur_clock & ~(period - 1)) + period;
+        /*
+        * if the periodic timer's update is due to period re-configuration,
+        * we should count the clock since last interrupt.
+        */
+        if (old_period) {
+            int64_t last_periodic_clock, next_periodic_clock;
+
+            next_periodic_clock = muldiv64(s->next_periodic_time,
+                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+            last_periodic_clock = next_periodic_clock - old_period;
+            lost_clock = cur_clock - last_periodic_clock;
+            assert(lost_clock >= 0);
+        }
+
+#ifdef TARGET_I386
+        /*
+         * s->irq_coalesced can change for two reasons:
+         *
+         * a) if one or more periodic timer interrupts have been lost,
+         *    lost_clock will be more that a period.
+         *
+         * b) when the period may be reconfigured, we expect the OS to
+         *    treat delayed tick as the new period.  So, when switching
+         *    from a shorter to a longer period, scale down the missing,
+         *    because the OS will treat past delayed ticks as longer
+         *    (leftovers are put back into lost_clock).  When switching
+         *    to a shorter period, scale up the missing ticks since the
+         *    OS handler will treat past delayed ticks as shorter.
+         */
+        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+            uint32_t old_irq_coalesced = s->irq_coalesced;
+
+            s->period = period;
+            lost_clock += old_irq_coalesced * old_period;
+            s->irq_coalesced = lost_clock / s->period;
+            lost_clock %= s->period;
+            if (old_irq_coalesced != s->irq_coalesced ||
+                old_period != s->period) {
+                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
+                          "period scaled from %d to %d\n", old_irq_coalesced,
+                          s->irq_coalesced, old_period, s->period);
+                rtc_coalesced_timer_update(s);
+            }
+        } else
+#endif
+        {
+           /*
+             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
+             * is not used, we should make the time progress anyway.
+             */
+            lost_clock = MIN(lost_clock, period);
+        }
+
+        assert(lost_clock >= 0 && lost_clock <= period);
+
+        next_irq_clock = cur_clock + period - lost_clock;
         s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
                                          RTC_CLOCK_RATE) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
@@ -186,7 +255,7 @@ static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s = opaque;
 
-    periodic_timer_update(s, s->next_periodic_time);
+    periodic_timer_update(s, s->next_periodic_time, 0);
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
@@ -391,6 +460,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                               uint64_t data, unsigned size)
 {
     RTCState *s = opaque;
+    uint32_t old_period;
     bool update_periodic_timer;
 
     if ((addr & 1) == 0) {
@@ -425,6 +495,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             break;
         case RTC_REG_A:
             update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & 0x0f;
+            old_period = rtc_periodic_clock_ticks(s);
 
             if ((data & 0x60) == 0x60) {
                 if (rtc_running(s)) {
@@ -450,7 +521,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      old_period);
             }
 
             check_update_timer(s);
@@ -458,6 +530,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
         case RTC_REG_B:
             update_periodic_timer = (s->cmos_data[RTC_REG_B] ^ data)
                                        & REG_B_PIE;
+            old_period = rtc_periodic_clock_ticks(s);
 
             if (data & REG_B_SET) {
                 /* update cmos to when the rtc was stopping */
@@ -487,7 +560,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             s->cmos_data[RTC_REG_B] = data;
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      old_period);
             }
 
             check_update_timer(s);
@@ -757,7 +831,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now = qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
         }
     }
 
@@ -822,7 +896,7 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
     int64_t now = *(int64_t *)data;
 
     rtc_set_date_from_host(ISA_DEVICE(s));
-    periodic_timer_update(s, now);
+    periodic_timer_update(s, now, 0);
     check_update_timer(s);
 #ifdef TARGET_I386
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-- 
1.8.3.1
