Received: from eggs.gnu.org ([209.51.188.92]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMJ-0008LD-RD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0003mz-16
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMC-0003lp-PH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id t200so6823395wmt.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:53 +0000
Message-Id: <20190201160653.13829-48-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 47/47] tests/microbit-test: Add tests for nRF51
 NVMC
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

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190201023357.22596-4-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/microbit-test.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 3bad947b6cd..04e199ec33f 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -21,6 +21,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/nvram/nrf51_nvm.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/i2c/microbit_i2c.h"
 
@@ -156,6 +157,112 @@ static void test_microbit_i2c(void)
     qtest_quit(qts);
 }
 
+#define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
+
+static void fill_and_erase(QTestState *qts, hwaddr base, hwaddr size,
+                           uint32_t address_reg)
+{
+    hwaddr i;
+
+    /* Erase Page */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + address_reg, base);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    /* Check memory */
+    for (i = 0; i < size / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, base + i * 4), ==, 0xFFFFFFFF);
+    }
+
+    /* Fill memory */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i = 0; i < size / 4; i++) {
+        qtest_writel(qts, base + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, base + i * 4), ==, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+}
+
+static void test_nrf51_nvmc(void)
+{
+    uint32_t value;
+    hwaddr i;
+    QTestState *qts = qtest_init("-M microbit");
+
+    /* Test always ready */
+    value = qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_READY);
+    g_assert_cmpuint(value & 0x01, ==, 0x01);
+
+    /* Test write-read config register */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG),
+                     ==, 0x03);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG),
+                     ==, 0x00);
+
+    /* Test PCR0 */
+    fill_and_erase(qts, NRF51_FLASH_BASE, NRF51_PAGE_SIZE,
+                   NRF51_NVMC_ERASEPCR0);
+    fill_and_erase(qts, NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
+                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR0);
+
+    /* Test PCR1 */
+    fill_and_erase(qts, NRF51_FLASH_BASE, NRF51_PAGE_SIZE,
+                   NRF51_NVMC_ERASEPCR1);
+    fill_and_erase(qts, NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
+                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR1);
+
+    /* Erase all */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i = 0; i < FLASH_SIZE / 4; i++) {
+        qtest_writel(qts, NRF51_FLASH_BASE + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, NRF51_FLASH_BASE + i * 4), ==, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i = 0; i < FLASH_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_FLASH_BASE + i * 4),
+                         ==, 0xFFFFFFFF);
+    }
+
+    /* Erase UICR */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i = 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4),
+                         ==, 0xFFFFFFFF);
+    }
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i = 0; i < NRF51_UICR_SIZE / 4; i++) {
+        qtest_writel(qts, NRF51_UICR_BASE + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4), ==, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i = 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4),
+                         ==, 0xFFFFFFFF);
+    }
+
+    qtest_quit(qts);
+}
+
 static void test_nrf51_gpio(void)
 {
     size_t i;
@@ -392,6 +499,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
 
-- 
2.20.1
