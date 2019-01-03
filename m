Received: from eggs.gnu.org ([208.118.235.92]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez41-0003uX-TD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez40-0006oM-1l
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:13:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 09:11:18 +0000
Message-Id: <20190103091119.9367-11-stefanha@redhat.com>
In-Reply-To: <20190103091119.9367-1-stefanha@redhat.com>
References: <20190103091119.9367-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/11] tests/microbit-test: Add Tests for nRF51
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Basic tests for nRF51 Timer Peripheral.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/microbit-test.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 535714797a..16dffb1396 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -20,6 +20,7 @@
=20
 #include "hw/arm/nrf51.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
=20
 static void test_nrf51_gpio(void)
 {
@@ -143,6 +144,99 @@ static void test_nrf51_gpio(void)
     qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 0);
 }
=20
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
+static void timer_assert_events(uint32_t ev0, uint32_t ev1, uint32_t ev2=
,
+                                uint32_t ev3)
+{
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_0) =3D=3D=
 ev0);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_1) =3D=3D=
 ev1);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_2) =3D=3D=
 ev2);
+    g_assert(readl(NRF51_TIMER_BASE + NRF51_TIMER_EVENT_COMPARE_3) =3D=3D=
 ev3);
+}
+
+static void test_nrf51_timer(void)
+{
+    uint32_t steps_to_overflow =3D 408;
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
     global_qtest =3D qtest_initf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
=20
     ret =3D g_test_run();
=20
--=20
2.19.2
