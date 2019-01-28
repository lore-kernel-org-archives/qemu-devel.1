Received: from eggs.gnu.org ([209.51.188.92]:41118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNb-00037o-PF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNU-0000SZ-BC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNQ-0000A3-6u
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so19088281wrt.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:35 +0000
Message-Id: <20190128181047.20781-15-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/26] tests/microbit-test: Make test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

Using of global_qtest is not required here. Let's replace functions like
readl() with the corresponding qtest_* counterparts.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190123120759.7162-3-jusual@mail.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/microbit-test.c | 247 ++++++++++++++++++++++--------------------
 1 file changed, 129 insertions(+), 118 deletions(-)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index dcdc0cd41a5..afeb6b082a6 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -24,22 +24,22 @@
 #include "hw/i2c/microbit_i2c.h"
 
 /* Read a byte from I2C device at @addr from register @reg */
-static uint32_t i2c_read_byte(uint32_t addr, uint32_t reg)
+static uint32_t i2c_read_byte(QTestState *qts, uint32_t addr, uint32_t reg)
 {
     uint32_t val;
 
-    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ADDRESS, addr);
-    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTTX, 1);
-    writel(NRF51_TWI_BASE + NRF51_TWI_REG_TXD, reg);
-    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_TXDSENT);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_ADDRESS, addr);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_TASK_STARTTX, 1);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_TXD, reg);
+    val = qtest_readl(qts, NRF51_TWI_BASE + NRF51_TWI_EVENT_TXDSENT);
     g_assert_cmpuint(val, ==, 1);
-    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
 
-    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTRX, 1);
-    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_RXDREADY);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_TASK_STARTRX, 1);
+    val = qtest_readl(qts, NRF51_TWI_BASE + NRF51_TWI_EVENT_RXDREADY);
     g_assert_cmpuint(val, ==, 1);
-    val = readl(NRF51_TWI_BASE + NRF51_TWI_REG_RXD);
-    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
+    val = qtest_readl(qts, NRF51_TWI_BASE + NRF51_TWI_REG_RXD);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
 
     return val;
 }
@@ -47,22 +47,25 @@ static uint32_t i2c_read_byte(uint32_t addr, uint32_t reg)
 static void test_microbit_i2c(void)
 {
     uint32_t val;
+    QTestState *qts = qtest_init("-M microbit");
 
     /* We don't program pins/irqs but at least enable the device */
-    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 5);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 5);
 
     /* MMA8653 magnetometer detection */
-    val = i2c_read_byte(0x3A, 0x0D);
+    val = i2c_read_byte(qts, 0x3A, 0x0D);
     g_assert_cmpuint(val, ==, 0x5A);
 
-    val = i2c_read_byte(0x3A, 0x0D);
+    val = i2c_read_byte(qts, 0x3A, 0x0D);
     g_assert_cmpuint(val, ==, 0x5A);
 
     /* LSM303 accelerometer detection */
-    val = i2c_read_byte(0x3C, 0x4F);
+    val = i2c_read_byte(qts, 0x3C, 0x4F);
     g_assert_cmpuint(val, ==, 0x40);
 
-    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
+    qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
+
+    qtest_quit(qts);
 }
 
 static void test_nrf51_gpio(void)
@@ -80,220 +83,228 @@ static void test_nrf51_gpio(void)
         {NRF51_GPIO_REG_DIRCLR, 0x00000000}
     };
 
+    QTestState *qts = qtest_init("-M microbit");
+
     /* Check reset state */
     for (i = 0; i < ARRAY_SIZE(reset_state); i++) {
         expected = reset_state[i].expected;
-        actual = readl(NRF51_GPIO_BASE + reset_state[i].addr);
+        actual = qtest_readl(qts, NRF51_GPIO_BASE + reset_state[i].addr);
         g_assert_cmpuint(actual, ==, expected);
     }
 
     for (i = 0; i < NRF51_GPIO_PINS; i++) {
         expected = 0x00000002;
-        actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START + i * 4);
+        actual = qtest_readl(qts, NRF51_GPIO_BASE +
+                                  NRF51_GPIO_REG_CNF_START + i * 4);
         g_assert_cmpuint(actual, ==, expected);
     }
 
     /* Check dir bit consistency between dir and cnf */
     /* Check set via DIRSET */
     expected = 0x80000001;
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRSET, expected);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRSET, expected);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
     g_assert_cmpuint(actual, ==, expected);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
+             & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
 
     /* Check clear via DIRCLR */
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x80000001);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x80000001);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
     g_assert_cmpuint(actual, ==, 0x00000000);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
+             & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
 
     /* Check set via DIR */
     expected = 0x80000001;
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, expected);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, expected);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
     g_assert_cmpuint(actual, ==, expected);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
+             & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
 
     /* Reset DIR */
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
 
     /* Check Input propagates */
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
 
     /* Check pull-up working */
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
 
     /* Check pull-down working */
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
 
     /* Check Output propagates */
-    irq_intercept_out("/machine/nrf51");
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0011);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
-    g_assert_true(get_irq(0));
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
-    g_assert_false(get_irq(0));
+    qtest_irq_intercept_out(qts, "/machine/nrf51");
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0011);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    g_assert_false(qtest_get_irq(qts, 0));
 
     /* Check self-stimulation */
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x01);
 
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
-    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
     g_assert_cmpuint(actual, ==, 0x00);
 
     /*
      * Check short-circuit - generates an guest_error which must be checked
      * manually as long as qtest can not scan qemu_log messages
      */
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
-    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
-    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+
+    qtest_quit(qts);
 }
 
-static void timer_task(hwaddr task)
+static void timer_task(QTestState *qts, hwaddr task)
 {
-    writel(NRF51_TIMER_BASE + task, NRF51_TRIGGER_TASK);
+    qtest_writel(qts, NRF51_TIMER_BASE + task, NRF51_TRIGGER_TASK);
 }
 
-static void timer_clear_event(hwaddr event)
+static void timer_clear_event(QTestState *qts, hwaddr event)
 {
-    writel(NRF51_TIMER_BASE + event, NRF51_EVENT_CLEAR);
+    qtest_writel(qts, NRF51_TIMER_BASE + event, NRF51_EVENT_CLEAR);
 }
 
-static void timer_set_bitmode(uint8_t mode)
+static void timer_set_bitmode(QTestState *qts, uint8_t mode)
 {
-    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_BITMODE, mode);
+    qtest_writel(qts, NRF51_TIMER_BASE + NRF51_TIMER_REG_BITMODE, mode);
 }
 
-static void timer_set_prescaler(uint8_t prescaler)
+static void timer_set_prescaler(QTestState *qts, uint8_t prescaler)
 {
-    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_PRESCALER, prescaler);
+    qtest_writel(qts, NRF51_TIMER_BASE + NRF51_TIMER_REG_PRESCALER, prescaler);
 }
 
-static void timer_set_cc(size_t idx, uint32_t value)
+static void timer_set_cc(QTestState *qts, size_t idx, uint32_t value)
 {
-    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_CC0 + idx * 4, value);
+    qtest_writel(qts, NRF51_TIMER_BASE + NRF51_TIMER_REG_CC0 + idx * 4, value);
 }
 
-static void timer_assert_events(uint32_t ev0, uint32_t ev1, uint32_t ev2,
-                                uint32_t ev3)
+static void timer_assert_events(QTestState *qts, uint32_t ev0, uint32_t ev1,
+                                uint32_t ev2, uint32_t ev3)
 {
-    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_0) == ev0);
-    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_1) == ev1);
-    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_2) == ev2);
-    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_3) == ev3);
+    g_assert(qtest_readl(qts, NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_0)
+             == ev0);
+    g_assert(qtest_readl(qts, NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_1)
+             == ev1);
+    g_assert(qtest_readl(qts, NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_2)
+             == ev2);
+    g_assert(qtest_readl(qts, NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_3)
+             == ev3);
 }
 
 static void test_nrf51_timer(void)
 {
     uint32_t steps_to_overflow = 408;
+    QTestState *qts = qtest_init("-M microbit");
 
     /* Compare Match */
-    timer_task(NRF51_TIMER_TASK_STOP);
-    timer_task(NRF51_TIMER_TASK_CLEAR);
+    timer_task(qts, NRF51_TIMER_TASK_STOP);
+    timer_task(qts, NRF51_TIMER_TASK_CLEAR);
 
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_0);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_1);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_2);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_3);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_0);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_1);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_2);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_3);
 
-    timer_set_bitmode(NRF51_TIMER_WIDTH_16); /* 16 MHz Timer */
-    timer_set_prescaler(0);
+    timer_set_bitmode(qts, NRF51_TIMER_WIDTH_16); /* 16 MHz Timer */
+    timer_set_prescaler(qts, 0);
     /* Swept over in first step */
-    timer_set_cc(0, 2);
+    timer_set_cc(qts, 0, 2);
     /* Barely miss on first step */
-    timer_set_cc(1, 162);
+    timer_set_cc(qts, 1, 162);
     /* Spot on on third step */
-    timer_set_cc(2, 480);
+    timer_set_cc(qts, 2, 480);
 
-    timer_assert_events(0, 0, 0, 0);
+    timer_assert_events(qts, 0, 0, 0, 0);
 
-    timer_task(NRF51_TIMER_TASK_START);
-    clock_step(10000);
-    timer_assert_events(1, 0, 0, 0);
+    timer_task(qts, NRF51_TIMER_TASK_START);
+    qtest_clock_step(qts, 10000);
+    timer_assert_events(qts, 1, 0, 0, 0);
 
     /* Swept over on first overflow */
-    timer_set_cc(3, 114);
+    timer_set_cc(qts, 3, 114);
 
-    clock_step(10000);
-    timer_assert_events(1, 1, 0, 0);
+    qtest_clock_step(qts, 10000);
+    timer_assert_events(qts, 1, 1, 0, 0);
 
-    clock_step(10000);
-    timer_assert_events(1, 1, 1, 0);
+    qtest_clock_step(qts, 10000);
+    timer_assert_events(qts, 1, 1, 1, 0);
 
     /* Wrap time until internal counter overflows */
     while (steps_to_overflow--) {
-        timer_assert_events(1, 1, 1, 0);
-        clock_step(10000);
+        timer_assert_events(qts, 1, 1, 1, 0);
+        qtest_clock_step(qts, 10000);
     }
 
-    timer_assert_events(1, 1, 1, 1);
+    timer_assert_events(qts, 1, 1, 1, 1);
 
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_0);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_1);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_2);
-    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_3);
-    timer_assert_events(0, 0, 0, 0);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_0);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_1);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_2);
+    timer_clear_event(qts, NRF51_TIMER_EVENT_COMPARE_3);
+    timer_assert_events(qts, 0, 0, 0, 0);
 
-    timer_task(NRF51_TIMER_TASK_STOP);
+    timer_task(qts, NRF51_TIMER_TASK_STOP);
 
     /* Test Proposal: Stop/Shutdown */
     /* Test Proposal: Shortcut Compare -> Clear */
     /* Test Proposal: Shortcut Compare -> Stop */
     /* Test Proposal: Counter Mode */
+
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
 {
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
 
-    global_qtest = qtest_initf("-machine microbit");
-
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
 
-    ret = g_test_run();
-
-    qtest_quit(global_qtest);
-    return ret;
+    return g_test_run();
 }
-- 
2.20.1
