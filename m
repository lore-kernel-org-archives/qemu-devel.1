Received: from eggs.gnu.org ([2001:4830:134:3::10]:42887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3n-0000fs-6X
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d8N3l-0003j8-Qv
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:27 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d8N3l-0003iZ-Ja
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:33:25 -0400
Received: by mail-pg0-x242.google.com with SMTP id i63so3236201pgd.2
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:33:25 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 10 May 2017 16:32:56 +0800
Message-Id: <20170510083259.3900-3-xiaoguangrong@tencent.com>
In-Reply-To: <20170510083259.3900-1-xiaoguangrong@tencent.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/5] mc146818rtc: precisely count the clock
 for periodic timer
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
   especially，if a complete interrupt was lost in this window, the
   time can be caught up by LOST_TICK_POLICY_SLEW

Signed-off-by: Tai Yunfang <yunfangtai@tencent.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 126 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 23 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 5cccb2a..dac6744 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -146,31 +146,106 @@ static void rtc_coalesced_timer(void *opaque)
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
+         * recalculate the coalesced irqs for two reasons:
+         *    a) the lost_clock is more that a period, i,e. the timer
+         *       interrupt has been lost, we should catch up the time.
+         *
+         *    b) the period may be reconfigured, under this case, when
+         *       switching from a shorter to a longer period, scale down
+         *       the missing ticks since we expect the OS handler to
+         *       treat the delayed ticks as longer. Any leftovers are
+         *       put back into lost_clock.
+         *       When switching to a shorter period, scale up the missing
+         *       ticks since we expect the OS handler to treat the delayed
+         *       ticks as shorter.
+         */
+        if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+            uint32_t old_irq_coalesced = s->irq_coalesced;
+
+            /*
+             * as the old QEMUs only used s->period for the case that
+             * LOST_TICK_POLICY_SLEW is used, in order to keep the
+             * compatible migration, we obey the rule as old QEMUs.
+             */
+            s->period = period;
+
+            lost_clock += old_irq_coalesced * old_period;
+            s->irq_coalesced = lost_clock / s->period;
+            lost_clock %= s->period;
+            if (old_irq_coalesced != s->irq_coalesced ||
+               old_period != s->period) {
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
@@ -186,7 +261,7 @@ static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s = opaque;
 
-    periodic_timer_update(s, s->next_periodic_time);
+    periodic_timer_update(s, s->next_periodic_time, 0);
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
@@ -391,6 +466,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                               uint64_t data, unsigned size)
 {
     RTCState *s = opaque;
+    uint32_t old_period;
     bool update_periodic_timer;
 
     if ((addr & 1) == 0) {
@@ -425,6 +501,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             break;
         case RTC_REG_A:
             update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & 0x0f;
+            old_period = rtc_periodic_clock_ticks(s);
 
             if ((data & 0x60) == 0x60) {
                 if (rtc_running(s)) {
@@ -450,7 +527,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      old_period);
             }
 
             check_update_timer(s);
@@ -458,6 +536,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
         case RTC_REG_B:
             update_periodic_timer = (s->cmos_data[RTC_REG_B] ^ data)
                                        & REG_B_PIE;
+            old_period = rtc_periodic_clock_ticks(s);
 
             if (data & REG_B_SET) {
                 /* update cmos to when the rtc was stopping */
@@ -487,7 +566,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             s->cmos_data[RTC_REG_B] = data;
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      old_period);
             }
 
             check_update_timer(s);
@@ -757,7 +837,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now = qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
         }
     }
 
@@ -822,7 +902,7 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
     int64_t now = *(int64_t *)data;
 
     rtc_set_date_from_host(ISA_DEVICE(s));
-    periodic_timer_update(s, now);
+    periodic_timer_update(s, now, 0);
     check_update_timer(s);
 #ifdef TARGET_I386
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-- 
2.9.3
