Received: from eggs.gnu.org ([209.51.188.92]:52198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAMQ-0004Vk-KW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAMO-0000wd-97
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:42 -0500
Received: from smtp45.i.mail.ru ([94.100.177.105]:46554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gkAMF-0000ic-Px
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:34 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 17 Jan 2019 19:16:40 +0300
Message-Id: <20190117161640.5496-4-jusual@mail.ru>
In-Reply-To: <20190117161640.5496-1-jusual@mail.ru>
References: <20190117161640.5496-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v4 3/3] tests/microbit-test: Check nRF51 UART
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Some functional tests for:
    Basic reception/transmittion
    Suspending
    INTEN* registers

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 tests/microbit-test.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index afeb6b082a..3da6d9529f 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -19,10 +19,93 @@
 #include "libqtest.h"
 
 #include "hw/arm/nrf51.h"
+#include "hw/char/nrf51_uart.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/i2c/microbit_i2c.h"
 
+#include <sys/socket.h>
+#include <sys/un.h>
+
+static bool uart_wait_for_event(QTestState *qts, uint32_t event_addr)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (qtest_readl(qts, event_addr) == 1) {
+            qtest_writel(qts, event_addr, 0x00);
+            return true;
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
+    g_assert(write(sock_fd, in, in_len) == in_len);
+    for (i = 0; i < in_len; i++) {
+        g_assert(uart_wait_for_event(qts, NRF51_UART_BASE + A_UART_RXDRDY));
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
+        g_assert(uart_wait_for_event(qts, NRF51_UART_BASE + A_UART_TXDRDY));
+    }
+}
+
+static void test_nrf51_uart(void)
+{
+    int sock_fd;
+    char s[10];
+    QTestState *qts = qtest_init_with_serial("-M microbit", &sock_fd);
+
+    g_assert(write(sock_fd, "c", 1) == 1);
+    g_assert(qtest_readl(qts, NRF51_UART_BASE + A_UART_RXD) == 0);
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_ENABLE, 0x04);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTRX, 0x01);
+
+    g_assert(uart_wait_for_event(qts, NRF51_UART_BASE + A_UART_RXDRDY));
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_RXDRDY, 0x00);
+    g_assert(qtest_readl(qts, NRF51_UART_BASE + A_UART_RXD) == 'c');
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_INTENSET, 0x04);
+    g_assert(qtest_readl(qts, NRF51_UART_BASE + A_UART_INTEN) == 0x04);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_INTENCLR, 0x04);
+    g_assert(qtest_readl(qts, NRF51_UART_BASE + A_UART_INTEN) == 0x00);
+
+    uart_rw_to_rxd(qts, sock_fd, "hello", s);
+    g_assert(memcmp(s, "hello", 5) == 0);
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    uart_w_to_txd(qts, "d");
+    g_assert(read(sock_fd, s, 10) == 1);
+    g_assert(s[0] == 'd');
+
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_SUSPEND, 0x01);
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_TXD, 'h');
+    qtest_writel(qts, NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    uart_w_to_txd(qts, "world");
+    g_assert(read(sock_fd, s, 10) == 5);
+    g_assert(memcmp(s, "world", 5) == 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
 /* Read a byte from I2C device at @addr from register @reg */
 static uint32_t i2c_read_byte(QTestState *qts, uint32_t addr, uint32_t reg)
 {
@@ -302,6 +385,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
-- 
2.17.1
