Received: from eggs.gnu.org ([2001:4830:134:3::10]:51355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwW-0005Zl-Gf
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyEwS-0004nB-4f
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:04 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cyEwR-0004n1-TB
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:52:00 -0400
Received: by mail-pg0-x241.google.com with SMTP id 34so1371706pgx.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 02:51:59 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Wed, 12 Apr 2017 17:51:09 +0800
Message-Id: <20170412095111.11728-4-xiaoguangrong@tencent.com>
In-Reply-To: <20170412095111.11728-1-xiaoguangrong@tencent.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] mc146818rtc: properly count the time for
 the next interrupt
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

If periodic_timer_update() is called due to RegA reconfiguration, i.e,
the period is updated, current time is not the start point for the next
periodic timer, instead, which should start from the last interrupt,
otherwise, the clock in VM will become slow

This patch takes the clocks from last interrupt to current clock into
account and compensates the clocks for the next interrupt, especially，
if a complete interrupt was lost in this window, the time can be caught
up by LOST_TICK_POLICY_SLEW

[ Xiao: redesign the algorithm based on Yunfang's original work. ]

Signed-off-by: Tai Yunfang <yunfangtai@tencent.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 649678c..3bf559d 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -161,8 +161,12 @@ static int period_code_to_clock(int period_code)
     return 1 << (period_code - 1);
 }
 
-/* handle periodic timer */
-static void periodic_timer_update(RTCState *s, int64_t current_time)
+/*
+ * handle periodic timer. @old_period indicates the periodic timer update
+ * is just due to period adjustment.
+ */
+static void
+periodic_timer_update(RTCState *s, int64_t current_time, int old_period)
 {
     int period_code, period;
     int64_t cur_clock, next_irq_clock, lost_clock = 0;
@@ -193,6 +197,56 @@ static void periodic_timer_update(RTCState *s, int64_t current_time)
         cur_clock =
             muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
 
+        /*
+        * if the periodic timer's update is due to period re-configuration,
+        * we should count the clock since last interrupt.
+        */
+        if (old_period) {
+            int64_t last_periodic_clock;
+
+            last_periodic_clock = muldiv64(s->next_periodic_time,
+                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+            /*
+             * if the next interrupt has not happened yet, we recall the last
+             * interrupt based on the original period.
+             */
+            if (last_periodic_clock > cur_clock) {
+                last_periodic_clock -= period_code_to_clock(old_period);
+
+                /* the last interrupt must have happened. */
+                assert(cur_clock >= last_periodic_clock);
+            }
+
+            /* calculate the clock since last interrupt. */
+            lost_clock += cur_clock - last_periodic_clock;
+
+#ifdef TARGET_I386
+            /*
+             * if more than period clocks were passed, i.e, the timer interrupt
+             * has been lost, we should catch up the time.
+             */
+            if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
+                (lost_clock / period)) {
+                int lost_interrupt = lost_clock / period;
+
+                s->irq_coalesced += lost_interrupt;
+                lost_clock -= lost_interrupt * period;
+                if (lost_interrupt) {
+                    DPRINTF_C("cmos: compensate %d interrupts, coalesced irqs "
+                              "increased to %d\n", lost_interrupt,
+                              s->irq_coalesced);
+                    rtc_coalesced_timer_update(s);
+                }
+            } else
+#endif
+            /*
+             * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
+             * is not used, we should make the time progress anyway.
+             */
+            lost_clock = MIN(lost_clock, period);
+            assert(lost_clock >= 0);
+        }
+
         next_irq_clock = cur_clock + period - lost_clock;
         s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
                                          RTC_CLOCK_RATE) + 1;
@@ -209,7 +263,7 @@ static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s = opaque;
 
-    periodic_timer_update(s, s->next_periodic_time);
+    periodic_timer_update(s, s->next_periodic_time, 0);
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
@@ -428,6 +482,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                               uint64_t data, unsigned size)
 {
     RTCState *s = opaque;
+    int cur_period;
     bool update_periodic_timer;
 
     if ((addr & 1) == 0) {
@@ -461,6 +516,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             }
             break;
         case RTC_REG_A:
+            cur_period = s->cmos_data[RTC_REG_A] & 0xf;
             update_periodic_timer = rtc_periodic_timer_updated_by_regA(s, data);
 
             if ((data & 0x60) == 0x60) {
@@ -487,7 +543,8 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      cur_period);
             }
 
             check_update_timer(s);
@@ -523,7 +580,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             s->cmos_data[RTC_REG_B] = data;
 
             if (update_periodic_timer) {
-                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
             }
 
             check_update_timer(s);
@@ -793,7 +850,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now = qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
         }
     }
 
@@ -858,7 +915,7 @@ static void rtc_notify_clock_reset(Notifier *notifier, void *data)
     int64_t now = *(int64_t *)data;
 
     rtc_set_date_from_host(ISA_DEVICE(s));
-    periodic_timer_update(s, now);
+    periodic_timer_update(s, now, 0);
     check_update_timer(s);
 #ifdef TARGET_I386
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
-- 
2.9.3
