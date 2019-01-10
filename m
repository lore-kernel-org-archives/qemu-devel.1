Received: from eggs.gnu.org ([209.51.188.92]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpK-0000IW-BB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpJ-0007aY-9w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Jan 2019 09:40:20 +0000
Message-Id: <20190110094020.18354-3-stefanha@redhat.com>
In-Reply-To: <20190110094020.18354-1-stefanha@redhat.com>
References: <20190110094020.18354-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] tests/microbit-test: add TWI stub
 device test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, Thomas Huth <thuth@redhat.com>, contrib@steffen-goertz.de, Stefan Hajnoczi <stefanha@redhat.com>

This test verifies that we read back the expected I2C WHO_AM_I register
values for the accelerometer/magnetometer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/microbit-test.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 0c125535f6..dcdc0cd41a 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -21,6 +21,49 @@
 #include "hw/arm/nrf51.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/timer/nrf51_timer.h"
+#include "hw/i2c/microbit_i2c.h"
+
+/* Read a byte from I2C device at @addr from register @reg */
+static uint32_t i2c_read_byte(uint32_t addr, uint32_t reg)
+{
+    uint32_t val;
+
+    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ADDRESS, addr);
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTTX, 1);
+    writel(NRF51_TWI_BASE + NRF51_TWI_REG_TXD, reg);
+    val =3D readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_TXDSENT);
+    g_assert_cmpuint(val, =3D=3D, 1);
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
+
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTRX, 1);
+    val =3D readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_RXDREADY);
+    g_assert_cmpuint(val, =3D=3D, 1);
+    val =3D readl(NRF51_TWI_BASE + NRF51_TWI_REG_RXD);
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
+
+    return val;
+}
+
+static void test_microbit_i2c(void)
+{
+    uint32_t val;
+
+    /* We don't program pins/irqs but at least enable the device */
+    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 5);
+
+    /* MMA8653 magnetometer detection */
+    val =3D i2c_read_byte(0x3A, 0x0D);
+    g_assert_cmpuint(val, =3D=3D, 0x5A);
+
+    val =3D i2c_read_byte(0x3A, 0x0D);
+    g_assert_cmpuint(val, =3D=3D, 0x5A);
+
+    /* LSM303 accelerometer detection */
+    val =3D i2c_read_byte(0x3C, 0x4F);
+    g_assert_cmpuint(val, =3D=3D, 0x40);
+
+    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
+}
=20
 static void test_nrf51_gpio(void)
 {
@@ -247,6 +290,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
+    qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
=20
     ret =3D g_test_run();
=20
--=20
2.20.1
