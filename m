Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPM-0008FD-AK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPH-0001d4-Pm
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:15 -0500
Message-Id: <20170911172022.4738-32-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 31/38] libqtest: Merge qtest_clock_*() with
 clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_clock_set()
 qtest_clock_step()
 qtest_clock_step_next()
with their short counterparts.  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h         | 50 ++++----------------------------
 tests/libqtest.c         |  6 ++--
 tests/e1000e-test.c      |  2 +-
 tests/fdc-test.c         |  4 +--
 tests/ide-test.c         |  2 +-
 tests/libqos/virtio.c    |  8 +++---
 tests/rtc-test.c         | 74 ++++++++++++++++++++++++------------------------
 tests/rtl8139-test.c     | 10 +++----
 tests/tco-test.c         | 22 +++++++-------
 tests/test-arm-mptimer.c | 25 +++++++++-------
 tests/wdt_ib700-test.c   | 12 ++++----
 11 files changed, 90 insertions(+), 125 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 5651b77d2f..26d5f37bc9 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -417,17 +417,17 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
 void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);

 /**
- * qtest_clock_step_next:
+ * clock_step_next:
  * @s: #QTestState instance to operate on.
  *
  * Advance the QEMU_CLOCK_VIRTUAL to the next deadline.
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_step_next(QTestState *s);
+int64_t clock_step_next(QTestState *s);

 /**
- * qtest_clock_step:
+ * clock_step:
  * @s: QTestState instance to operate on.
  * @step: Number of nanoseconds to advance the clock by.
  *
@@ -435,10 +435,10 @@ int64_t qtest_clock_step_next(QTestState *s);
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_step(QTestState *s, int64_t step);
+int64_t clock_step(QTestState *s, int64_t step);

 /**
- * qtest_clock_set:
+ * clock_set:
  * @s: QTestState instance to operate on.
  * @val: Nanoseconds value to advance the clock to.
  *
@@ -446,7 +446,7 @@ int64_t qtest_clock_step(QTestState *s, int64_t step);
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_set(QTestState *s, int64_t val);
+int64_t clock_set(QTestState *s, int64_t val);

 /**
  * qtest_big_endian:
@@ -868,44 +868,6 @@ static inline void qmemset(uint64_t addr, uint8_t patt, size_t size)
     qtest_memset(global_qtest, addr, patt, size);
 }

-/**
- * clock_step_next:
- *
- * Advance the QEMU_CLOCK_VIRTUAL to the next deadline.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_step_next(void)
-{
-    return qtest_clock_step_next(global_qtest);
-}
-
-/**
- * clock_step:
- * @step: Number of nanoseconds to advance the clock by.
- *
- * Advance the QEMU_CLOCK_VIRTUAL by @step nanoseconds.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_step(int64_t step)
-{
-    return qtest_clock_step(global_qtest, step);
-}
-
-/**
- * clock_set:
- * @val: Nanoseconds value to advance the clock to.
- *
- * Advance the QEMU_CLOCK_VIRTUAL to @val nanoseconds since the VM was launched.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_set(int64_t val)
-{
-    return qtest_clock_set(global_qtest, val);
-}
-
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
 void qmp_fd_send(int fd, const char *fmt, ...);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 44c89813ff..9f5f2cb933 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -666,19 +666,19 @@ static int64_t qtest_clock_rsp(QTestState *s)
     return clock;
 }

-int64_t qtest_clock_step_next(QTestState *s)
+int64_t clock_step_next(QTestState *s)
 {
     qtest_sendf(s, "clock_step\n");
     return qtest_clock_rsp(s);
 }

-int64_t qtest_clock_step(QTestState *s, int64_t step)
+int64_t clock_step(QTestState *s, int64_t step)
 {
     qtest_sendf(s, "clock_step %"PRIi64"\n", step);
     return qtest_clock_rsp(s);
 }

-int64_t qtest_clock_set(QTestState *s, int64_t val)
+int64_t clock_set(QTestState *s, int64_t val)
 {
     qtest_sendf(s, "clock_set %"PRIi64"\n", val);
     return qtest_clock_rsp(s);
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 323aabb454..f4ead74f96 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -229,7 +229,7 @@ static void e1000e_wait_isr(e1000e_device *d, uint16_t msg_id)
         if (qpci_msix_pending(d->pci_dev, msg_id)) {
             return;
         }
-        clock_step(10000);
+        clock_step(global_qtest, 10000);
     } while (g_get_monotonic_time() < end_time);

     g_error("Timeout expired");
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index ec83625db2..e79cd0f3b5 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -424,7 +424,7 @@ static void test_read_id(void)

     while (!get_irq(FLOPPY_IRQ)) {
         /* qemu involves a timer with READ ID... */
-        clock_step(1000000000LL / 50);
+        clock_step(global_qtest, 1000000000LL / 50);
     }

     msr = inb(FLOPPY_BASE + reg_msr);
@@ -467,7 +467,7 @@ static void test_read_id(void)

     while (!get_irq(FLOPPY_IRQ)) {
         /* qemu involves a timer with READ ID... */
-        clock_step(1000000000LL / 50);
+        clock_step(global_qtest, 1000000000LL / 50);
     }

     msr = inb(FLOPPY_BASE + reg_msr);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index e1650c0132..32c8c40294 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -749,7 +749,7 @@ static void nsleep(int64_t nsecs)
 {
     const struct timespec val = { .tv_nsec = nsecs };
     nanosleep(&val, NULL);
-    clock_set(nsecs);
+    clock_set(global_qtest, nsecs);
 }

 static uint8_t ide_wait_clear(uint8_t flag)
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 2212830742..92e47e78f2 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -97,7 +97,7 @@ void qvirtio_wait_queue_isr(QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        qtest_clock_step(d->bus->qts, 100);
+        clock_step(d->bus->qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
@@ -119,7 +119,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
     uint8_t val;

     while ((val = qtest_readb(d->bus->qts, addr)) == 0xff) {
-        qtest_clock_step(d->bus->qts, 100);
+        clock_step(d->bus->qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
@@ -143,7 +143,7 @@ void qvirtio_wait_used_elem(QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;

-        qtest_clock_step(d->bus->qts, 100);
+        clock_step(d->bus->qts, 100);

         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(vq, &got_desc_idx)) {
@@ -160,7 +160,7 @@ void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        qtest_clock_step(d->bus->qts, 100);
+        clock_step(d->bus->qts, 100);
         if (d->bus->get_config_isr_status(d)) {
             return;
         }
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index dd5430dd2d..9b98e2d494 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -291,7 +291,7 @@ static void alarm_time(void)
             break;
         }

-        clock_step(1000000000);
+        clock_step(global_qtest, 1000000000);
     }

     g_assert(get_irq(RTC_ISA_IRQ));
@@ -371,35 +371,35 @@ static void basic_12h_bcd(void)
 {
     /* set BCD 12 hour mode */
     set_time(0, 0x81, 0x59, 0x00);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x81, 0x59, 0x01);
-    clock_step(59000000000LL);
+    clock_step(global_qtest, 59000000000LL);
     assert_time(0x82, 0x00, 0x00);

     /* test BCD wraparound */
     set_time(0, 0x09, 0x59, 0x59);
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     assert_time(0x10, 0x00, 0x59);

     /* 12 AM -> 1 AM */
     set_time(0, 0x12, 0x59, 0x59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x01, 0x00, 0x00);

     /* 12 PM -> 1 PM */
     set_time(0, 0x92, 0x59, 0x59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x81, 0x00, 0x00);

     /* 11 AM -> 12 PM */
     set_time(0, 0x11, 0x59, 0x59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x92, 0x00, 0x00);
     /* TODO: test day wraparound */

     /* 11 PM -> 12 AM */
     set_time(0, 0x91, 0x59, 0x59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x12, 0x00, 0x00);
     /* TODO: test day wraparound */
 }
@@ -408,29 +408,29 @@ static void basic_12h_dec(void)
 {
     /* set decimal 12 hour mode */
     set_time(REG_B_DM, 0x81, 59, 0);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x81, 59, 1);
-    clock_step(59000000000LL);
+    clock_step(global_qtest, 59000000000LL);
     assert_time(0x82, 0, 0);

     /* 12 PM -> 1 PM */
     set_time(REG_B_DM, 0x8c, 59, 59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x81, 0, 0);

     /* 12 AM -> 1 AM */
     set_time(REG_B_DM, 0x0c, 59, 59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x01, 0, 0);

     /* 11 AM -> 12 PM */
     set_time(REG_B_DM, 0x0b, 59, 59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x8c, 0, 0);

     /* 11 PM -> 12 AM */
     set_time(REG_B_DM, 0x8b, 59, 59);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x0c, 0, 0);
     /* TODO: test day wraparound */
 }
@@ -439,19 +439,19 @@ static void basic_24h_bcd(void)
 {
     /* set BCD 24 hour mode */
     set_time(REG_B_24H, 0x09, 0x59, 0x00);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(0x09, 0x59, 0x01);
-    clock_step(59000000000LL);
+    clock_step(global_qtest, 59000000000LL);
     assert_time(0x10, 0x00, 0x00);

     /* test BCD wraparound */
     set_time(REG_B_24H, 0x09, 0x59, 0x00);
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     assert_time(0x10, 0x00, 0x00);

     /* TODO: test day wraparound */
     set_time(REG_B_24H, 0x23, 0x59, 0x00);
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     assert_time(0x00, 0x00, 0x00);
 }

@@ -459,19 +459,19 @@ static void basic_24h_dec(void)
 {
     /* set decimal 24 hour mode */
     set_time(REG_B_24H | REG_B_DM, 9, 59, 0);
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_time(9, 59, 1);
-    clock_step(59000000000LL);
+    clock_step(global_qtest, 59000000000LL);
     assert_time(10, 0, 0);

     /* test BCD wraparound */
     set_time(REG_B_24H | REG_B_DM, 9, 59, 0);
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     assert_time(10, 0, 0);

     /* TODO: test day wraparound */
     set_time(REG_B_24H | REG_B_DM, 23, 59, 0);
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     assert_time(0, 0, 0);
 }

@@ -493,7 +493,7 @@ static void am_pm_alarm(void)
     cmos_write(RTC_REG_A, 0x26);

     /* Check that alarm triggers when AM/PM is set.  */
-    clock_step(60000000000LL);
+    clock_step(global_qtest, 60000000000LL);
     g_assert(cmos_read(RTC_HOURS) == 0x82);
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) != 0);

@@ -520,7 +520,7 @@ static void am_pm_alarm(void)
     cmos_write(RTC_REG_A, 0x26);

     /* Check that alarm triggers.  */
-    clock_step(3600 * 11 * 1000000000LL);
+    clock_step(global_qtest, 3600 * 11 * 1000000000LL);
     g_assert(cmos_read(RTC_HOURS) == 0x82);
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) != 0);

@@ -534,7 +534,7 @@ static void am_pm_alarm(void)
     cmos_write(RTC_REG_A, 0x26);

     /* Check that alarm does not trigger if hours differ only by AM/PM.  */
-    clock_step(3600 * 11 * 1000000000LL);
+    clock_step(global_qtest, 3600 * 11 * 1000000000LL);
     g_assert(cmos_read(RTC_HOURS) == 0x82);
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) == 0);
 }
@@ -558,7 +558,7 @@ static void fuzz_registers(void)
 static void register_b_set_flag(void)
 {
     if (cmos_read(RTC_REG_A) & REG_A_UIP) {
-        clock_step(UIP_HOLD_LENGTH + NANOSECONDS_PER_SECOND / 5);
+        clock_step(global_qtest, UIP_HOLD_LENGTH + NANOSECONDS_PER_SECOND / 5);
     }
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);

@@ -570,7 +570,7 @@ static void register_b_set_flag(void)
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

     /* Since SET flag is still enabled, time does not advance. */
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

     /* Disable SET flag in Register B */
@@ -579,7 +579,7 @@ static void register_b_set_flag(void)
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

     /* Since SET flag is disabled, the clock now advances.  */
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
 }

@@ -595,18 +595,18 @@ static void divider_reset(void)
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

     /* Since divider reset flag is still enabled, these are equality checks. */
-    clock_step(1000000000LL);
+    clock_step(global_qtest, 1000000000LL);
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

     /* The first update ends 500 ms after divider reset */
     cmos_write(RTC_REG_A, 0x26);
-    clock_step(500000000LL - UIP_HOLD_LENGTH - 1);
+    clock_step(global_qtest, 500000000LL - UIP_HOLD_LENGTH - 1);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
     assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);

-    clock_step(1);
+    clock_step(global_qtest, 1);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, !=, 0);
-    clock_step(UIP_HOLD_LENGTH);
+    clock_step(global_qtest, UIP_HOLD_LENGTH);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);

     assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
@@ -618,7 +618,7 @@ static void uip_stuck(void)

     /* The first update ends 500 ms after divider reset */
     (void)cmos_read(RTC_REG_C);
-    clock_step(500000000LL);
+    clock_step(global_qtest, 500000000LL);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
     assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);

@@ -628,12 +628,12 @@ static void uip_stuck(void)
     cmos_write(RTC_SECONDS_ALARM, 0xC0);

     /* Because the alarm will fire soon, reading register A will latch UIP.  */
-    clock_step(1000000000LL - UIP_HOLD_LENGTH / 2);
+    clock_step(global_qtest, 1000000000LL - UIP_HOLD_LENGTH / 2);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, !=, 0);

     /* Move the alarm far away.  This must not cause UIP to remain stuck!  */
     cmos_write(RTC_HOURS_ALARM, 0x03);
-    clock_step(UIP_HOLD_LENGTH);
+    clock_step(global_qtest, UIP_HOLD_LENGTH);
     g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
 }

@@ -645,7 +645,7 @@ static void uip_stuck(void)
 static uint64_t wait_periodic_interrupt(uint64_t real_time)
 {
     while (!get_irq(RTC_ISA_IRQ)) {
-        real_time = clock_step_next();
+        real_time = clock_step_next(global_qtest);
     }

     g_assert((cmos_read(RTC_REG_C) & REG_C_PF) != 0);
@@ -664,7 +664,7 @@ static void periodic_timer(void)
     /* enable periodic interrupt after properly configure the period. */
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);

-    start_time = real_time = clock_step_next();
+    start_time = real_time = clock_step_next(global_qtest);

     for (i = 0; i < RTC_PERIOD_TEST_NR; i++) {
         cmos_write(RTC_REG_A, RTC_PERIOD_CODE1);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 1741f0ec47..d123245108 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -84,7 +84,7 @@ static void test_timer(void)
         fatal("time too big %u\n", curr);
     }
     for (cnt = 0; ; ) {
-        clock_step(1 * NANOSECONDS_PER_SECOND);
+        clock_step(global_qtest, 1 * NANOSECONDS_PER_SECOND);
         prev = curr;
         curr = in_Timer();

@@ -106,7 +106,7 @@ static void test_timer(void)
     /* Test 3. Setting TimerInt to 1 and Timer to 0 get interrupt */
     out_TimerInt(1);
     out_Timer(0);
-    clock_step(40);
+    clock_step(global_qtest, 40);
     if ((in_IntrStatus() & 0x4000) == 0) {
         fatal("we should have an interrupt here!\n");
     }
@@ -123,7 +123,7 @@ static void test_timer(void)
     out_IntrStatus(0x4000);
     curr = in_Timer();
     out_TimerInt(curr + 0.5 * CLK);
-    clock_step(1 * NANOSECONDS_PER_SECOND);
+    clock_step(global_qtest, 1 * NANOSECONDS_PER_SECOND);
     out_Timer(0);
     if ((in_IntrStatus() & 0x4000) == 0) {
         fatal("we should have an interrupt here!\n");
@@ -135,7 +135,7 @@ static void test_timer(void)
     out_IntrStatus(0x4000);
     curr = in_Timer();
     out_TimerInt(curr + 0.5 * CLK);
-    clock_step(1 * NANOSECONDS_PER_SECOND);
+    clock_step(global_qtest, 1 * NANOSECONDS_PER_SECOND);
     out_TimerInt(0);
     if ((in_IntrStatus() & 0x4000) == 0) {
         fatal("we should have an interrupt here!\n");
@@ -146,7 +146,7 @@ static void test_timer(void)
     next = curr + 5.0 * CLK;
     out_TimerInt(next);
     for (cnt = 0; ; ) {
-        clock_step(1 * NANOSECONDS_PER_SECOND);
+        clock_step(global_qtest, 1 * NANOSECONDS_PER_SECOND);
         prev = curr;
         curr = in_Timer();
         diff = (curr-prev) & 0xffffffffu;
diff --git a/tests/tco-test.c b/tests/tco-test.c
index b84a50927a..27e982d8ac 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -173,7 +173,7 @@ static void test_tco_timeout(void)
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC);

     /* test first timeout */
     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
@@ -188,7 +188,7 @@ static void test_tco_timeout(void)
     g_assert(ret == 0);

     /* test second timeout */
-    clock_step(ticks * TCO_TICK_NSEC);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC);
     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret = val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret == 1);
@@ -217,14 +217,14 @@ static void test_tco_max_timeout(void)
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(((ticks & TCO_TMR_MASK) - 1) * TCO_TICK_NSEC);
+    clock_step(global_qtest, ((ticks & TCO_TMR_MASK) - 1) * TCO_TICK_NSEC);

     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO_RLD);
     g_assert_cmpint(val & TCO_RLD_MASK, ==, 1);
     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret = val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret == 0);
-    clock_step(TCO_TICK_NSEC);
+    clock_step(global_qtest, TCO_TICK_NSEC);
     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret = val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret == 1);
@@ -260,7 +260,7 @@ static void test_tco_second_timeout_pause(void)
     set_tco_timeout(&td, TCO_SECS_TO_TICKS(16));
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC * 2);
     ad = get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "pause"));
     QDECREF(ad);
@@ -285,7 +285,7 @@ static void test_tco_second_timeout_reset(void)
     set_tco_timeout(&td, TCO_SECS_TO_TICKS(16));
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC * 2);
     ad = get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "reset"));
     QDECREF(ad);
@@ -310,7 +310,7 @@ static void test_tco_second_timeout_shutdown(void)
     set_tco_timeout(&td, ticks);
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC * 2);
     ad = get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "shutdown"));
     QDECREF(ad);
@@ -335,7 +335,7 @@ static void test_tco_second_timeout_none(void)
     set_tco_timeout(&td, ticks);
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC * 2);
     ad = get_watchdog_action();
     g_assert(!strcmp(qdict_get_str(ad, "action"), "none"));
     QDECREF(ad);
@@ -364,7 +364,7 @@ static void test_tco_ticks_counter(void)
     do {
         rld = qpci_io_readw(d.dev, d.tco_io_bar, TCO_RLD) & TCO_RLD_MASK;
         g_assert_cmpint(rld, ==, ticks);
-        clock_step(TCO_TICK_NSEC);
+        clock_step(global_qtest, TCO_TICK_NSEC);
         ticks--;
     } while (!(qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS) & TCO_TIMEOUT));

@@ -407,7 +407,7 @@ static void test_tco1_status_bits(void)
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC);

     qpci_io_writeb(d.dev, d.tco_io_bar, TCO_DAT_IN, 0);
     qpci_io_writeb(d.dev, d.tco_io_bar, TCO_DAT_OUT, 0);
@@ -436,7 +436,7 @@ static void test_tco2_status_bits(void)
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    clock_step(global_qtest, ticks * TCO_TICK_NSEC * 2);

     val = qpci_io_readw(d.dev, d.tco_io_bar, TCO2_STS);
     ret = val & (TCO_SECOND_TO_STS | TCO_BOOT_STS) ? 1 : 0;
diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index 9631c55fe3..0e6484a4a8 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -14,7 +14,8 @@
 #define TIMER_BLOCK_SCALE(s)    ((((s) & 0xff) + 1) * 10)

 #define TIMER_BLOCK_STEP(scaler, steps_nb) \
-    clock_step(TIMER_BLOCK_SCALE(scaler) * (int64_t)(steps_nb) + 1)
+    clock_step(global_qtest, \
+               TIMER_BLOCK_SCALE(scaler) * (int64_t)(steps_nb) + 1)

 #define TIMER_BASE_PHYS 0x1e000600

@@ -185,12 +186,14 @@ static void test_timer_periodic(gconstpointer arg)
     timer_start(PERIODIC, scaler);

     while (repeat--) {
-        clock_step(TIMER_BLOCK_SCALE(scaler) * (101 + repeat) + 1);
+        clock_step(global_qtest,
+                   TIMER_BLOCK_SCALE(scaler) * (101 + repeat) + 1);

         g_assert_cmpuint(timer_counter(), ==, 100 - repeat);
         g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 1);

-        clock_step(TIMER_BLOCK_SCALE(scaler) * (101 - repeat) - 1);
+        clock_step(global_qtest,
+                   TIMER_BLOCK_SCALE(scaler) * (101 - repeat) - 1);
     }
 }

@@ -686,10 +689,10 @@ static void test_periodic_counter(gconstpointer arg)
     timer_load(test_load);
     timer_start(PERIODIC, scaler);

-    clock_step(1);
+    clock_step(global_qtest, 1);

     for (test_val = 0; test_val <= test_load; test_val++) {
-        clock_step(TIMER_BLOCK_SCALE(scaler) * test_load);
+        clock_step(global_qtest, TIMER_BLOCK_SCALE(scaler) * test_load);
         g_assert_cmpint(timer_counter(), ==, test_val);
     }
 }
@@ -783,7 +786,7 @@ again:
     timer_reset();
     timer_start(mode, 255);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_counter(), ==, 0);

@@ -795,7 +798,7 @@ again:
     timer_load(2);
     timer_start(mode, 255);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);

@@ -811,13 +814,13 @@ again:
     timer_load(UINT32_MAX);
     timer_start(mode, 255);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);

     timer_set_counter(0);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);

@@ -829,13 +832,13 @@ again:
     timer_load(UINT32_MAX);
     timer_start(mode, 255);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);

     timer_load(0);

-    clock_step(100);
+    clock_step(global_qtest, 100);

     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);

diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index a169265e16..05690e5159 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -22,29 +22,29 @@ static QDict *ib700_program_and_wait(QTestState *s)
 {
     QDict *event, *data;

-    qtest_clock_step(s, NANOSECONDS_PER_SECOND * 40);
+    clock_step(s, NANOSECONDS_PER_SECOND * 40);
     qmp_check_no_event(s);

     /* 2 second limit */
     qtest_outb(s, 0x443, 14);

     /* Ping */
-    qtest_clock_step(s, NANOSECONDS_PER_SECOND);
+    clock_step(s, NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
     qtest_outb(s, 0x443, 14);

     /* Disable */
-    qtest_clock_step(s, NANOSECONDS_PER_SECOND);
+    clock_step(s, NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
     qtest_outb(s, 0x441, 1);
-    qtest_clock_step(s, 3 * NANOSECONDS_PER_SECOND);
+    clock_step(s, 3 * NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);

     /* Enable and let it fire */
     qtest_outb(s, 0x443, 13);
-    qtest_clock_step(s, 3 * NANOSECONDS_PER_SECOND);
+    clock_step(s, 3 * NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
-    qtest_clock_step(s, 2 * NANOSECONDS_PER_SECOND);
+    clock_step(s, 2 * NANOSECONDS_PER_SECOND);
     event = qtest_qmp_eventwait_ref(s, "WATCHDOG");
     data = qdict_get_qdict(event, "data");
     QINCREF(data);
-- 
2.13.5
