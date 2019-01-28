Received: from eggs.gnu.org ([209.51.188.92]:41094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNU-00031M-Dd
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNQ-0000Q3-6c
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNJ-0000Bb-93
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id q18so19139580wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:36 +0000
Message-Id: <20190128181047.20781-16-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/26] tests/microbit-test: Check nRF51 UART
 functionality
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

Some functional tests for:
    Basic reception/transmittion
    Suspending
    INTEN* registers

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190123120759.7162-4-jusual@mail.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/microbit-test.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index afeb6b082a6..3bad947b6cd 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -19,10 +19,98 @@
 #include "libqtest.h"
 
 #include "hw/arm/nrf51.h"
+#include "hw/char/nrf51_uart.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/i2c/microbit_i2c.h"
 
+static bool uart_wait_for_event(QTestState *qts, uint32_t event_addr)
+{
+    time_t now, start = time(NULL);
+
+    while (true) {
+        if (qtest_readl(qts, event_addr) == 1) {
+            qtest_writel(qts, event_addr, 0x00);
+            return true;
+        }
+
+        /* Wait at most 10 minutes */
+        now = time(NULL);
+        if (now - start > 600) {
+            break;
+        }
+        g_usleep(10000);
+    }
+
+    return false;
+}
+
+static void uart_rw_to_rxd(QTestState *qts, int sock_fd, const char *in,
+                           char *out)
+{
+    int i, in_len = strlen(in);
+
+    g_assert_true(write(sock_fd, in, in_len) == in_len);
+    for (i = 0; i < in_len; i++) {
+        g_assert_true(uart_wait_for_event(qts, NRF51_UART_BASE +
+                                               A_UART_RXDRDY));
+        out[i] = qtest_readl(qts, NRF51_UART_BASE + A_UART_RXD);
+    }
+    out[i] = '\0';
+}
+
+static void uart_w_to_txd(QTestState *qts, const char *in)
+{
+    int i, in_len = strlen(in);
+
+    for (i = 0; i < in_len; i++) {
+        qtest_writel(qts, NRF51_UART_BASE + A_UART_TXD, in[i]);
+        g_assert_true(uart_wait_for_event(qts, NRF51_UART_BASE +
+                                               A_UART_TXDRDY));
+    }
+}
+
+static void test_nrf51_uart(void)
+{
+    int sock_fd;
+    char s[10];
+    QTestState *qts = qtest_init_with_serial("-M microbit", &sock_fd);
+
+    g_assert_true(write(sock_fd, "c", 1) == 1);
+    g_assert_cmphex(qtest_readl(qts, NRF51_UART_BASE + A_UART_RXD), ==, 0x00);
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_ENABLE, 0x04);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTRX, 0x01);
+
+    g_assert_true(uart_wait_for_event(qts, NRF51_UART_BASE + A_UART_RXDRDY));
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_RXDRDY, 0x00);
+    g_assert_cmphex(qtest_readl(qts, NRF51_UART_BASE + A_UART_RXD), ==, 'c');
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_INTENSET, 0x04);
+    g_assert_cmphex(qtest_readl(qts, NRF51_UART_BASE + A_UART_INTEN), ==, 0x04);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_INTENCLR, 0x04);
+    g_assert_cmphex(qtest_readl(qts, NRF51_UART_BASE + A_UART_INTEN), ==, 0x00);
+
+    uart_rw_to_rxd(qts, sock_fd, "hello", s);
+    g_assert_true(memcmp(s, "hello", 5) == 0);
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    uart_w_to_txd(qts, "d");
+    g_assert_true(read(sock_fd, s, 10) == 1);
+    g_assert_cmphex(s[0], ==, 'd');
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_SUSPEND, 0x01);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_TXD, 'h');
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    uart_w_to_txd(qts, "world");
+    g_assert_true(read(sock_fd, s, 10) == 5);
+    g_assert_true(memcmp(s, "world", 5) == 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
 /* Read a byte from I2C device at @addr from register @reg */
 static uint32_t i2c_read_byte(QTestState *qts, uint32_t addr, uint32_t reg)
 {
@@ -302,6 +390,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
-- 
2.20.1
