Received: from eggs.gnu.org ([2001:4830:134:3::10]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dDjJh-0005vZ-2K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dDjJd-0003Od-Ro
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:20:01 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dDjJd-0003MJ-Iy
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:19:57 -0400
Received: by mail-pf0-x244.google.com with SMTP id n23so36161253pfb.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 20:19:57 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 25 May 2017 11:19:36 +0800
Message-Id: <20170525031936.8449-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH] qtest: add rtc periodic timer test
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

Note: as qemu needs a precise timer to drive its rtc timer callbacks,
that means clock=vm is not suitable for us as it's driven by icount
for qtest, so that we use clock=host instead, it is why we put the
periodic timer test separately without mixing with rtc-test

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/timer/mc146818rtc.c         |  15 ++-----
 include/hw/timer/mc146818rtc.h |  19 ++++++++
 tests/Makefile.include         |   2 +
 tests/rtc-periodic-test.c      | 100 +++++++++++++++++++++++++++++++++++++++++
 tests/rtc-test.c               |  14 +-----
 tests/rtc-test.h               |  17 +++++++
 6 files changed, 142 insertions(+), 25 deletions(-)
 create mode 100644 tests/rtc-periodic-test.c
 create mode 100644 tests/rtc-test.h

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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 31931c0..6958d91 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -218,6 +218,7 @@ check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
 check-qtest-i386-y += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-y += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
+check-qtest-i386-y += tests/rtc-periodic-test$(EXESUF)
 check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
 check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
@@ -677,6 +678,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
+tests/rtc-periodic-test$(EXESUF): tests/rtc-periodic-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
 tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
diff --git a/tests/rtc-periodic-test.c b/tests/rtc-periodic-test.c
new file mode 100644
index 0000000..8f3e4b5
--- /dev/null
+++ b/tests/rtc-periodic-test.c
@@ -0,0 +1,100 @@
+/*
+ * QTest testcase for the periodic timer of MC146818 real-time clock
+ *
+ * Copyright Tencent Corp. 2017
+ *
+ * Authors:
+ *  Xiao Guangrong <xiaoguangrong@tencent.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+
+#include "libqtest.h"
+
+#include "hw/timer/mc146818rtc.h"
+#include "hw/timer/mc146818rtc_regs.h"
+
+#include "rtc-test.h"
+
+#define RTC_PERIOD_CODE1    13
+#define RTC_PERIOD_CODE2    15
+
+#define RTC_PERIOD_TEST_NR  50
+
+static void nsleep(int64_t nsecs)
+{
+    const struct timespec val = { .tv_nsec = nsecs };
+    nanosleep(&val, NULL);
+}
+
+static void wait_periodic_interrupt(void)
+{
+    while (1) {
+        if (get_irq(RTC_ISA_IRQ)) {
+            break;
+        }
+
+        /* 1 us.*/
+        nsleep(1000);
+    }
+
+    g_assert((cmos_read(RTC_REG_C) & REG_C_PF) != 0);
+}
+
+static void periodic_timer(void)
+{
+    int i;
+    int64_t period_clocks, period_time, real_time;
+
+    /* disable all interrupts. */
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) &
+                                   ~(REG_B_PIE | REG_B_AIE | REG_B_UIE));
+    cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
+    /* enable periodic interrupt after properly configure the period. */
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
+
+    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+
+    for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
+        cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
+        wait_periodic_interrupt();
+        cmos_write(RTC_REG_A, RTC_PERIOD_CODE2);
+        wait_periodic_interrupt();
+    }
+
+    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - real_time;
+
+    period_clocks = periodic_period_to_clock(RTC_PERIOD_CODE1) +
+                       periodic_period_to_clock(RTC_PERIOD_CODE2);
+    period_clocks *= RTC_PERIOD_TEST_NR;
+    period_time = periodic_clock_to_ns(period_clocks);
+
+    g_assert_cmpint(ABS(real_time - period_time), <=,
+                    NANOSECONDS_PER_SECOND * 0.5);
+}
+
+int main(int argc, char **argv)
+{
+    QTestState *s = NULL;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    s = qtest_start("-rtc clock=host");
+    qtest_irq_intercept_in(s, "ioapic");
+
+    qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
+
+    ret = g_test_run();
+
+    if (s) {
+        qtest_quit(s);
+    }
+
+    return ret;
+}
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index a086efd..9ec9ba4 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -16,25 +16,13 @@
 #include "libqtest.h"
 #include "hw/timer/mc146818rtc_regs.h"
 
-static uint8_t base = 0x70;
+#include "rtc-test.h"
 
 static int bcd2dec(int value)
 {
     return (((value >> 4) & 0x0F) * 10) + (value & 0x0F);
 }
 
-static uint8_t cmos_read(uint8_t reg)
-{
-    outb(base + 0, reg);
-    return inb(base + 1);
-}
-
-static void cmos_write(uint8_t reg, uint8_t val)
-{
-    outb(base + 0, reg);
-    outb(base + 1, val);
-}
-
 static int tm_cmp(struct tm *lhs, struct tm *rhs)
 {
     time_t a, b;
diff --git a/tests/rtc-test.h b/tests/rtc-test.h
new file mode 100644
index 0000000..5a63d68
--- /dev/null
+++ b/tests/rtc-test.h
@@ -0,0 +1,17 @@
+#ifndef TEST_RTC_H__
+#define TEST_RTC_H__
+
+#define RTC_BASE_REG    0x70
+
+static uint8_t cmos_read(uint8_t reg)
+{
+    outb(RTC_BASE_REG + 0, reg);
+    return inb(RTC_BASE_REG + 1);
+}
+
+static void cmos_write(uint8_t reg, uint8_t val)
+{
+    outb(RTC_BASE_REG + 0, reg);
+    outb(RTC_BASE_REG + 1, val);
+}
+#endif
-- 
2.9.4
