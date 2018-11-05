Received: from eggs.gnu.org ([2001:4830:134:3::10]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJcZn-000741-7F
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gJcOF-0003sq-6I
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:45:54 -0500
Received: from smtp31.i.mail.ru ([94.100.177.91]:47606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gJcOC-0000mu-5S
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:45:50 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Mon,  5 Nov 2018 13:45:24 +0300
Message-Id: <20181105104524.933-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>

Some functional tests for:
    Basic reception/transmittion
    Suspending
    INTEN* registers

Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
This patch was part of nRF51 UART patchset, but wasn't included in the latest
revision. Due to upcoming loader fixes, we need this test instead of
boot-serial-test, which doesn't support -device loader.

v3:
    * Fix directory leak [Stefan]

 tests/microbit-test.c | 109 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index ab319eb466..23d343cfdd 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -21,9 +21,87 @@
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/char/nrf51_uart.h"
+
+#include <sys/socket.h>
+#include <sys/un.h>
 
 #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
 
+static bool wait_for_event(uint32_t event_addr)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (readl(event_addr) == 1) {
+            writel(event_addr, 0x00);
+            return true;
+        }
+        g_usleep(10000);
+    }
+
+    return false;
+}
+
+static void rw_to_rxd(int sock_fd, const char *in, char *out)
+{
+    int i;
+
+    g_assert(write(sock_fd, in, strlen(in)) == strlen(in));
+    for (i = 0; i < strlen(in); i++) {
+        g_assert(wait_for_event(NRF51_UART_BASE + A_UART_RXDRDY));
+        out[i] = readl(NRF51_UART_BASE + A_UART_RXD);
+    }
+    out[i] = '\0';
+}
+
+static void w_to_txd(const char *in)
+{
+    int i;
+
+    for (i = 0; i < strlen(in); i++) {
+        writel(NRF51_UART_BASE + A_UART_TXD, in[i]);
+        g_assert(wait_for_event(NRF51_UART_BASE + A_UART_TXDRDY));
+    }
+}
+
+static void test_nrf51_uart(const void *data)
+{
+    int sock_fd = *((const int *) data);
+    char s[10];
+
+    g_assert(write(sock_fd, "c", 1) == 1);
+    g_assert(readl(NRF51_UART_BASE + A_UART_RXD) == 0);
+
+    writel(NRF51_UART_BASE + A_UART_ENABLE, 0x04);
+    writel(NRF51_UART_BASE + A_UART_STARTRX, 0x01);
+
+    g_assert(wait_for_event(NRF51_UART_BASE + A_UART_RXDRDY));
+    writel(NRF51_UART_BASE + A_UART_RXDRDY, 0x00);
+    g_assert(readl(NRF51_UART_BASE + A_UART_RXD) == 'c');
+
+    writel(NRF51_UART_BASE + A_UART_INTENSET, 0x04);
+    g_assert(readl(NRF51_UART_BASE + A_UART_INTEN) == 0x04);
+    writel(NRF51_UART_BASE + A_UART_INTENCLR, 0x04);
+    g_assert(readl(NRF51_UART_BASE + A_UART_INTEN) == 0x00);
+
+    rw_to_rxd(sock_fd, "hello", s);
+    g_assert(strcmp(s, "hello") == 0);
+
+    writel(NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    w_to_txd("d");
+    g_assert(read(sock_fd, s, 10) == 1);
+    g_assert(s[0] == 'd');
+
+    writel(NRF51_UART_BASE + A_UART_SUSPEND, 0x01);
+    writel(NRF51_UART_BASE + A_UART_TXD, 'h');
+    writel(NRF51_UART_BASE + A_UART_STARTTX, 0x01);
+    w_to_txd("world");
+    g_assert(read(sock_fd, s, 10) == 5);
+    g_assert(strcmp(s, "world") == 0);
+}
+
+
 static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_reg)
 {
     /* Fill memory */
@@ -223,17 +301,44 @@ static void test_nrf51_gpio(void)
 
 int main(int argc, char **argv)
 {
-    int ret;
+    int ret, sock_fd;
+    char serialtmpdir[] = "/tmp/qtest-microbit-serial-sXXXXXX";
+    char serialtmp[40];
+    struct sockaddr_un addr;
+
+    g_assert(mkdtemp(serialtmpdir));
+    sprintf(serialtmp, "%s/sock", serialtmpdir);
+
+    sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    g_assert(sock_fd != -1);
+
+    memset(&addr, 0, sizeof(struct sockaddr_un));
+
+    addr.sun_family = AF_UNIX;
+    strncpy(addr.sun_path, serialtmp, sizeof(addr.sun_path) - 1);
 
     g_test_init(&argc, &argv, NULL);
 
-    global_qtest = qtest_initf("-machine microbit");
+    global_qtest = qtest_initf("-machine microbit "
+                               "-chardev socket,id=s0,path=%s,server,nowait "
+                               "-no-shutdown -serial chardev:s0",
+                               serialtmp);
+
+    g_assert(connect(sock_fd, (const struct sockaddr *) &addr,
+                     sizeof(struct sockaddr_un)) != -1);
 
+    unlink(serialtmp);
+    rmdir(serialtmpdir);
+
+    qtest_add_data_func("/microbit/nrf51/uart", &sock_fd, test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
 
     ret = g_test_run();
 
     qtest_quit(global_qtest);
+
+    close(sock_fd);
+
     return ret;
 }
-- 
2.17.1
