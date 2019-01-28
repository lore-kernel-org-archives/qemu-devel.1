Received: from eggs.gnu.org ([209.51.188.92]:40929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN9-0002fH-Ft
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN8-0008O0-6M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:56061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN7-0008FY-Rf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id y139so14912860wmc.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:26 +0000
Message-Id: <20190128181047.20781-6-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/26] tests/microbit-test: add TWI stub device
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

This test verifies that we read back the expected I2C WHO_AM_I register
values for the accelerometer/magnetometer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190110094020.18354-3-stefanha@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/microbit-test.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 0c125535f64..dcdc0cd41a5 100644
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
+    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_TXDSENT);
+    g_assert_cmpuint(val, ==, 1);
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STOP, 1);
+
+    writel(NRF51_TWI_BASE + NRF51_TWI_TASK_STARTRX, 1);
+    val = readl(NRF51_TWI_BASE + NRF51_TWI_EVENT_RXDREADY);
+    g_assert_cmpuint(val, ==, 1);
+    val = readl(NRF51_TWI_BASE + NRF51_TWI_REG_RXD);
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
+    val = i2c_read_byte(0x3A, 0x0D);
+    g_assert_cmpuint(val, ==, 0x5A);
+
+    val = i2c_read_byte(0x3A, 0x0D);
+    g_assert_cmpuint(val, ==, 0x5A);
+
+    /* LSM303 accelerometer detection */
+    val = i2c_read_byte(0x3C, 0x4F);
+    g_assert_cmpuint(val, ==, 0x40);
+
+    writel(NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
+}
 
 static void test_nrf51_gpio(void)
 {
@@ -247,6 +290,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
+    qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
 
     ret = g_test_run();
 
-- 
2.20.1
