Received: from eggs.gnu.org ([209.51.188.92]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNf-0003BY-K6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Ys-Pt
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNc-0000P1-Fn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id z5so19120114wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:43 +0000
Message-Id: <20190128181047.20781-23-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/26] tests/microbit-test: Add tests for nRF51
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
Message-id: 20190124141147.8416-1-stefanha@redhat.com
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
