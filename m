Received: from eggs.gnu.org ([209.51.188.92]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpR-0005jb-9Z
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpP-0003Gk-6v
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:41 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpN-0002UB-81
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:37 -0500
Received: by mail-wr1-x433.google.com with SMTP id t6so1026448wrr.12
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.32.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:32:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:13 +0000
Message-Id: <20190107163117.16269-34-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/37] tests/microbit-test: Add Tests for nRF51
 Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

Basic tests for nRF51 Timer Peripheral.

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-11-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/microbit-test.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index f0a180cbc6f..0c125535f64 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -20,6 +20,7 @@
 
 #include "hw/arm/nrf51.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
 
 static void test_nrf51_gpio(void)
 {
@@ -143,6 +144,99 @@ static void test_nrf51_gpio(void)
     qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
 }
 
+static void timer_task(hwaddr task)
+{
+    writel(NRF51_TIMER_BASE + task, NRF51_TRIGGER_TASK);
+}
+
+static void timer_clear_event(hwaddr event)
+{
+    writel(NRF51_TIMER_BASE + event, NRF51_EVENT_CLEAR);
+}
+
+static void timer_set_bitmode(uint8_t mode)
+{
+    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_BITMODE, mode);
+}
+
+static void timer_set_prescaler(uint8_t prescaler)
+{
+    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_PRESCALER, prescaler);
+}
+
+static void timer_set_cc(size_t idx, uint32_t value)
+{
+    writel(NRF51_TIMER_BASE + NRF51_TIMER_REG_CC0 + idx * 4, value);
+}
+
+static void timer_assert_events(uint32_t ev0, uint32_t ev1, uint32_t ev2,
+                                uint32_t ev3)
+{
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_0) == ev0);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_1) == ev1);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_2) == ev2);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_3) == ev3);
+}
+
+static void test_nrf51_timer(void)
+{
+    uint32_t steps_to_overflow = 408;
+
+    /* Compare Match */
+    timer_task(NRF51_TIMER_TASK_STOP);
+    timer_task(NRF51_TIMER_TASK_CLEAR);
+
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_0);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_1);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_2);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_3);
+
+    timer_set_bitmode(NRF51_TIMER_WIDTH_16); /* 16 MHz Timer */
+    timer_set_prescaler(0);
+    /* Swept over in first step */
+    timer_set_cc(0, 2);
+    /* Barely miss on first step */
+    timer_set_cc(1, 162);
+    /* Spot on on third step */
+    timer_set_cc(2, 480);
+
+    timer_assert_events(0, 0, 0, 0);
+
+    timer_task(NRF51_TIMER_TASK_START);
+    clock_step(10000);
+    timer_assert_events(1, 0, 0, 0);
+
+    /* Swept over on first overflow */
+    timer_set_cc(3, 114);
+
+    clock_step(10000);
+    timer_assert_events(1, 1, 0, 0);
+
+    clock_step(10000);
+    timer_assert_events(1, 1, 1, 0);
+
+    /* Wrap time until internal counter overflows */
+    while (steps_to_overflow--) {
+        timer_assert_events(1, 1, 1, 0);
+        clock_step(10000);
+    }
+
+    timer_assert_events(1, 1, 1, 1);
+
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_0);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_1);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_2);
+    timer_clear_event(NRF51_TIMER_EVENT_COMPARE_3);
+    timer_assert_events(0, 0, 0, 0);
+
+    timer_task(NRF51_TIMER_TASK_STOP);
+
+    /* Test Proposal: Stop/Shutdown */
+    /* Test Proposal: Shortcut Compare -> Clear */
+    /* Test Proposal: Shortcut Compare -> Stop */
+    /* Test Proposal: Counter Mode */
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -152,6 +246,7 @@ int main(int argc, char **argv)
     global_qtest = qtest_initf("-machine microbit");
 
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
 
     ret = g_test_run();
 
-- 
2.19.2
