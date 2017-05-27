Received: from eggs.gnu.org ([2001:4830:134:3::10]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dERr2-0004oV-Jt
	for qemu-devel@nongnu.org; Fri, 26 May 2017 22:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dERqx-0004lX-PQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 22:53:24 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dERqx-0004jf-GV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 22:53:19 -0400
Received: by mail-pf0-x242.google.com with SMTP id f27so6120617pfe.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 19:53:19 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Sat, 27 May 2017 10:53:01 +0800
Message-Id: <20170527025301.23499-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2] [PATCH] qtest: add rtc periodic timer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It tests the accuracy of rtc periodic timer which is recently
improved & fixed by:
      mc146818rtc: precisely count the clock for periodic timer
(commit id has not been decided yet)

Changelog in v2:
  integrate it with rtc-test by using clock_step_next() to inquire
  the time in QEMU instead of real time (thanks to Paolo's suggestion)

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c         | 15 +++----------
 include/hw/timer/mc146818rtc.h | 19 ++++++++++++++++
 tests/rtc-test.c               | 49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6d0a610..0aba66c 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -120,7 +120,7 @@ static void rtc_coalesced_timer_update(RTCState *s)
         /* divide each RTC interval to 2 - 8 smaller intervals */
         int c = MIN(s->irq_coalesced, 7) + 1; 
         int64_t next_clock = qemu_clock_get_ns(rtc_clock) +
-            muldiv64(s->period / c, NANOSECONDS_PER_SECOND, RTC_CLOCK_RATE);
+            periodic_clock_to_ns(s->period / c);
         timer_mod(s->coalesced_timer, next_clock);
     }
 }
@@ -178,16 +178,8 @@ static uint32_t rtc_periodic_clock_ticks(RTCState *s)
      }
 
     period_code = s->cmos_data[RTC_REG_A] & 0x0f;
-    if (!period_code) {
-        return 0;
-    }
-
-    if (period_code <= 2) {
-        period_code += 7;
-    }
 
-    /* period in 32 Khz cycles */
-    return 1 << (period_code - 1);
+    return periodic_period_to_clock(period_code);
 }
 
 /*
@@ -266,8 +258,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
         assert(lost_clock >= 0 && lost_clock <= period);
 
         next_irq_clock = cur_clock + period - lost_clock;
-        s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
-                                         RTC_CLOCK_RATE) + 1;
+        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
     } else {
         s->irq_coalesced = 0;
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rtc.h
index 7c8e64b..f23e734 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -10,4 +10,23 @@ ISADevice *rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq);
 void rtc_set_memory(ISADevice *dev, int addr, int val);
 int rtc_get_memory(ISADevice *dev, int addr);
 
+static inline uint32_t periodic_period_to_clock(int period_code)
+{
+    if (!period_code) {
+        return 0;
+   }
+
+    if (period_code <= 2) {
+        period_code += 7;
+    }
+    /* period in 32 Khz cycles */
+   return 1 << (period_code - 1);
+}
+
+#define RTC_CLOCK_RATE            32768
+
+static inline int64_t periodic_clock_to_ns(int64_t clocks)
+{
+    return muldiv64(clocks, NANOSECONDS_PER_SECOND, RTC_CLOCK_RATE);
+}
 #endif /* MC146818RTC_H */
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index a086efd..0500686 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
+#include "hw/timer/mc146818rtc.h"
 #include "hw/timer/mc146818rtc_regs.h"
 
 static uint8_t base = 0x70;
@@ -542,6 +543,52 @@ static void register_b_set_flag(void)
     g_assert_cmpint(cmos_read(RTC_CENTURY), ==, 0x20);
 }
 
+#define RTC_PERIOD_CODE1    13   /* 8 Hz */
+#define RTC_PERIOD_CODE2    15   /* 2 Hz */
+
+#define RTC_PERIOD_TEST_NR  50
+
+static uint64_t wait_periodic_interrupt(uint64_t real_time)
+{
+    while (!get_irq(RTC_ISA_IRQ)) {
+        real_time = clock_step_next();
+    }
+
+    g_assert((cmos_read(RTC_REG_C) & REG_C_PF) != 0);
+    return real_time;
+}
+
+static void periodic_timer(void)
+{
+    int i;
+    uint64_t period_clocks, period_time, start_time, real_time;
+
+    /* disable all interrupts. */
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) &
+                                   ~(REG_B_PIE | REG_B_AIE | REG_B_UIE));
+    cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
+    /* enable periodic interrupt after properly configure the period. */
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
+
+    start_time = real_time = clock_step_next();
+
+    for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
+        cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
+        real_time = wait_periodic_interrupt(real_time);
+        cmos_write(RTC_REG_A, RTC_PERIOD_CODE2);
+        real_time = wait_periodic_interrupt(real_time);
+    }
+
+    period_clocks = periodic_period_to_clock(RTC_PERIOD_CODE1) +
+                       periodic_period_to_clock(RTC_PERIOD_CODE2);
+    period_clocks *= RTC_PERIOD_TEST_NR;
+    period_time = periodic_clock_to_ns(period_clocks);
+
+    real_time -= start_time;
+    g_assert_cmpint(ABS((int64_t)(real_time - period_time)), <=,
+                    NANOSECONDS_PER_SECOND * 0.5);
+}
+
 int main(int argc, char **argv)
 {
     QTestState *s = NULL;
@@ -564,6 +611,8 @@ int main(int argc, char **argv)
     qtest_add_func("/rtc/set-year/1980", set_year_1980);
     qtest_add_func("/rtc/misc/register_b_set_flag", register_b_set_flag);
     qtest_add_func("/rtc/misc/fuzz-registers", fuzz_registers);
+    qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
+
     ret = g_test_run();
 
     if (s) {
-- 
2.9.4
