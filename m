Received: from eggs.gnu.org ([2001:4830:134:3::10]:38983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dED1U-00030Z-5k
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dED1R-0006pi-0L
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:03:12 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dED1Q-0006nM-NL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:03:08 -0400
Received: by mail-wm0-x232.google.com with SMTP id d127so17722078wmf.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:03:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170525031936.8449-1-xiaoguangrong@tencent.com>
	<210485b2-c6f5-2f57-f196-dc1b25bbe243@redhat.com>
	<09486d4e-7b21-06bb-ee6a-9b847e94cdd0@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40f3734e-d8c0-811c-5e1a-9a5c53f8323a@redhat.com>
Date: Fri, 26 May 2017 13:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <09486d4e-7b21-06bb-ee6a-9b847e94cdd0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qtest: add rtc periodic timer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 26/05/2017 05:21, Xiao Guangrong wrote:
> On 05/26/2017 12:03 AM, Paolo Bonzini wrote:
>> On 25/05/2017 05:19, guangrong.xiao@gmail.com wrote:
>> I'm not sure I understand.  Why would clock_step(1000) not be a good
>> replacement for nsleep(1000)?
> 
> We can not. As we use the real time to compare with the time that is
> passed in the VM, however, clock_step() is not a real time based clock
> source which immediately injects a time step to the VM regardless how
> much real time elapsed.

The trick lies in not using the real time for comparison, but the number
of time steps that were injected (or directly nanoseconds), like this:

--- a/tests/rtc-periodic-test.c
+++ b/tests/rtc-periodic-test.c
@@ -21,29 +21,29 @@
 
 #include "rtc-test.h"
 
-#define RTC_PERIOD_CODE1    13
-#define RTC_PERIOD_CODE2    15
+#define RTC_PERIOD_CODE1    13	/* 8 Hz */
+#define RTC_PERIOD_CODE2    15	/* 2 Hz */
 
 #define RTC_PERIOD_TEST_NR  50
 
-static void nsleep(int64_t nsecs)
-{
-    const struct timespec val = { .tv_nsec = nsecs };
-    nanosleep(&val, NULL);
-}
-
-static void wait_periodic_interrupt(void)
+static uint64_t wait_periodic_interrupt(void)
 {
-    while (1) {
-        if (get_irq(RTC_ISA_IRQ)) {
-            break;
-        }
-
-        /* 1 us.*/
-        nsleep(1000);
+    uint64_t real_time = 0;
+    while (!get_irq(RTC_ISA_IRQ)) {
+        /*
+	 * about 2 ms.  It's more than enough given the period
+	 * that we set above.
+	 */
+	clock_step(NANOSECONDS_PER_SECOND / 512);
+	real_time += NANOSECONDS_PER_SECOND / 512;
     }
 
     g_assert((cmos_read(RTC_REG_C) & REG_C_PF) != 0);
+    return real_time;
 }
 
 static void periodic_timer(void)
@@ -58,17 +58,15 @@
     /* enable periodic interrupt after properly configure the period. */
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
 
-    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    real_time = 0;
 
     for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
         cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
-        wait_periodic_interrupt();
+        real_time += wait_periodic_interrupt();
         cmos_write(RTC_REG_A, RTC_PERIOD_CODE2);
-        wait_periodic_interrupt();
+        real_time += wait_periodic_interrupt();
     }
 
-    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - real_time;
-
     period_clocks = periodic_period_to_clock(RTC_PERIOD_CODE1) +
                        periodic_period_to_clock(RTC_PERIOD_CODE2);
     period_clocks *= RTC_PERIOD_TEST_NR;
@@ -85,7 +83,7 @@
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_start("-rtc clock=host");
+    s = qtest_start("-rtc clock=vm");
     qtest_irq_intercept_in(s, "ioapic");
 
     qtest_add_func("/rtc/periodic/interrupt", periodic_timer);


Even better, the vm_clock time can be returned directly from
clock_step(), and you can even speed up the test by using
clock_step_next():

--- a/tests/rtc-periodic-test.c
+++ b/tests/rtc-periodic-test.c
@@ -21,29 +21,19 @@
 
 #include "rtc-test.h"
 
-#define RTC_PERIOD_CODE1    13
-#define RTC_PERIOD_CODE2    15
+#define RTC_PERIOD_CODE1    13	/* 8 Hz */
+#define RTC_PERIOD_CODE2    15	/* 2 Hz */
 
 #define RTC_PERIOD_TEST_NR  50
 
-static void nsleep(int64_t nsecs)
+static uint64_t wait_periodic_interrupt(uint64_t real_time)
 {
-    const struct timespec val = { .tv_nsec = nsecs };
-    nanosleep(&val, NULL);
-}
-
-static void wait_periodic_interrupt(void)
-{
-    while (1) {
-        if (get_irq(RTC_ISA_IRQ)) {
-            break;
-        }
-
-        /* 1 us.*/
-        nsleep(1000);
+    while (!get_irq(RTC_ISA_IRQ)) {
+	real_time = clock_step_next();
     }
 
     g_assert((cmos_read(RTC_REG_C) & REG_C_PF) != 0);
+    return real_time;
 }
 
 static void periodic_timer(void)
@@ -51,6 +41,8 @@
     int i;
     int64_t period_clocks, period_time, real_time;
 
+    real_time = clock_step(0);
+
     /* disable all interrupts. */
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) &
                                    ~(REG_B_PIE | REG_B_AIE | REG_B_UIE));
@@ -58,17 +50,13 @@
     /* enable periodic interrupt after properly configure the period. */
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
 
-    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-
     for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
         cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
-        wait_periodic_interrupt();
+        real_time = wait_periodic_interrupt(real_time);
         cmos_write(RTC_REG_A, RTC_PERIOD_CODE2);
-        wait_periodic_interrupt();
+        real_time = wait_periodic_interrupt(real_time);
     }
 
-    real_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - real_time;
-
     period_clocks = periodic_period_to_clock(RTC_PERIOD_CODE1) +
                        periodic_period_to_clock(RTC_PERIOD_CODE2);
     period_clocks *= RTC_PERIOD_TEST_NR;
@@ -85,7 +73,7 @@
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_start("-rtc clock=host");
+    s = qtest_start("-rtc clock=vm");
     qtest_irq_intercept_in(s, "ioapic");
 
     qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
@@ -98,57 +86,3 @@
 
     return ret;
 }


Can you send v2 that integrates this in rtc-test.c?

Thanks,

Paolo
