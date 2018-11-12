Received: from eggs.gnu.org ([2001:4830:134:3::10]:52888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyu-0006Yo-O9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyn-0002eM-P3
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:49 -0500
Received: from steffen-goertz.de ([88.198.119.201]:35594)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyl-0002cq-KC
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:45 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:20 -0500
Message-Id: <20181112214224.31560-11-contrib@steffen-goertz.de>
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 10/14] tests/microbit-test: Add Tests for
 nRF51 GPIO
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

The test suite for the nRF51 GPIO peripheral for now
only tests initial state. Additionally a set of
tests testing an implementation detail of the model
are included.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/microbit-test.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 40b8b4bc64..e606221b58 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -20,6 +20,7 @@
=20
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/gpio/nrf51_gpio.h"
=20
 #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
=20
@@ -116,6 +117,128 @@ static void test_nrf51_nvmc(void)
     }
 }
=20
+static void test_nrf51_gpio(void)
+{
+    size_t i;
+    uint32_t actual, expected;
+
+    struct {
+        hwaddr addr;
+        uint32_t expected;
+    } const reset_state[] =3D {
+        {NRF51_GPIO_REG_OUT, 0x00000000}, {NRF51_GPIO_REG_OUTSET, 0x0000=
0000},
+        {NRF51_GPIO_REG_OUTCLR, 0x00000000}, {NRF51_GPIO_REG_IN, 0x00000=
000},
+        {NRF51_GPIO_REG_DIR, 0x00000000}, {NRF51_GPIO_REG_DIRSET, 0x0000=
0000},
+        {NRF51_GPIO_REG_DIRCLR, 0x00000000}
+    };
+
+    /* Check reset state */
+    for (i =3D 0; i < ARRAY_SIZE(reset_state); i++) {
+        expected =3D reset_state[i].expected;
+        actual =3D readl(NRF51_GPIO_BASE + reset_state[i].addr);
+        g_assert_cmpuint(actual, =3D=3D, expected);
+    }
+
+    for (i =3D 0; i < NRF51_GPIO_PINS; i++) {
+        expected =3D 0x00000002;
+        actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START + i =
* 4);
+        g_assert_cmpuint(actual, =3D=3D, expected);
+    }
+
+    /* Check dir bit consistency between dir and cnf */
+    /* Check set via DIRSET */
+    expected =3D 0x80000001;
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRSET, expected);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, =3D=3D, expected);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+
+    /* Check clear via DIRCLR */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x80000001);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, =3D=3D, 0x00000000);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+
+    /* Check set via DIR */
+    expected =3D 0x80000001;
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, expected);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, =3D=3D, expected);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+
+    /* Reset DIR */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
+
+    /* Check Input propagates */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 0);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 1);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, -1);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-up working */
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 0);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-down working */
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 1);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, -1);
+
+    /* Check Output propagates */
+    irq_intercept_out("/machine/nrf51");
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0011);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    g_assert_true(get_irq(0));
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    g_assert_false(get_irq(0));
+
+    /* Check self-stimulation */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+
+    /*
+     * Check short-circuit - generates an guest_error which must be chec=
ked
+     * manually as long as qtest can not scan qemu_log messages
+     */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", =
0, 0);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -125,6 +248,7 @@ int main(int argc, char **argv)
     global_qtest =3D qtest_initf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
+    qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
=20
     ret =3D g_test_run();
=20
--=20
2.19.1
