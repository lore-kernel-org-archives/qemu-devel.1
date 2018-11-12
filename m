Received: from eggs.gnu.org ([2001:4830:134:3::10]:53009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz6-0006kp-Qm
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz3-0002lO-Hk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:04 -0500
Received: from steffen-goertz.de ([88.198.119.201]:35646)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz3-0002fF-6A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:01 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:23 -0500
Message-Id: <20181112214224.31560-14-contrib@steffen-goertz.de>
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 13/14] tests/microbit-test: Add Tests for
 nRF51 Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Paolo Bonzini <pbonzini@redhat.com>

Basic tests for nRF51 Timer Peripheral.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 tests/microbit-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index e606221b58..f8731e7c00 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -21,6 +21,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
=20
 #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
=20
@@ -239,6 +240,105 @@ static void test_nrf51_gpio(void)
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
+    int64_t prev_deadline, curr_deadline;
+    uint32_t steps_to_overflow =3D 405;
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
+    timer_set_bitmode(NRF51_TIMER_WIDTH_16);
+    /* 16 MHz Timer */
+    timer_set_prescaler(0);
+    /* Swept over in first step */
+    timer_set_cc(0, 2);
+    /* Barely miss on first step */
+    timer_set_cc(1, 162);
+    /* Spot on on third step */
+    timer_set_cc(2, 483);
+
+    timer_assert_events(0, 0, 0, 0);
+
+    timer_task(NRF51_TIMER_TASK_START);
+    prev_deadline =3D clock_step_next();
+    timer_assert_events(1, 0, 0, 0);
+
+    /* Swept over on first overflow */
+    timer_set_cc(3, 114);
+
+    curr_deadline =3D clock_step_next();
+    g_assert_cmpint(curr_deadline - prev_deadline, =3D=3D, 10000);
+    prev_deadline =3D curr_deadline;
+    timer_assert_events(1, 1, 0, 0);
+
+    curr_deadline =3D clock_step_next();
+    g_assert_cmpint(curr_deadline - prev_deadline, =3D=3D, 10000);
+    prev_deadline =3D curr_deadline;
+    timer_assert_events(1, 1, 1, 0);
+
+    /* Wrap time until internal counter overflows */
+    while (steps_to_overflow--) {
+        timer_assert_events(1, 1, 1, 0);
+        clock_step_next();
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
@@ -249,6 +349,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
=20
     ret =3D g_test_run();
=20
--=20
2.19.1
