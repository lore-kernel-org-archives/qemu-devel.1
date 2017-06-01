Received: from eggs.gnu.org ([2001:4830:134:3::10]:33931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGTZU-0006vC-GU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGTZS-0004Mv-RP
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGTZS-0004Mb-Hz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:38 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 19:07:32 +0200
Message-Id: <20170601170733.13080-2-pbonzini@redhat.com>
In-Reply-To: <20170601170733.13080-1-pbonzini@redhat.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/34] qtest: add rtc periodic timer test
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

It tests the accuracy of rtc periodic timer which is recently
improved & fixed by commit 7ffcb539a3 ("mc146818rtc: precisely count
the clock for periodic timer", 2017-05-19).

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20170527025301.23499-1-xiaoguangrong@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c              | 15 +++---------
 include/hw/timer/mc146818rtc_regs.h | 20 +++++++++++++++
 tests/rtc-test.c                    | 49 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 542cd09bc1..1b8d3d7d4c 100644
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
@@ -260,8 +252,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
         assert(lost_clock >= 0 && lost_clock <= period);
 
         next_irq_clock = cur_clock + period - lost_clock;
-        s->next_periodic_time = muldiv64(next_irq_clock, NANOSECONDS_PER_SECOND,
-                                         RTC_CLOCK_RATE) + 1;
+        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
         timer_mod(s->periodic_timer, s->next_periodic_time);
     } else {
         s->irq_coalesced = 0;
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146818rtc_regs.h
index 6ede6c832e..c62f17bf2d 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -65,4 +65,24 @@
 #define REG_C_AF   0x20
 #define REG_C_MASK 0x70
 
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
+
 #endif
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index a086efd120..e78f701afb 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "libqtest.h"
+#include "qemu/timer.h"
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
2.13.0
