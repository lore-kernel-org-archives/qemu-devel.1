Received: from eggs.gnu.org ([209.51.188.92]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmfjY-0003I0-OQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmfjX-0005a6-Kl
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Jan 2019 14:11:47 +0000
Message-Id: <20190124141147.8416-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/microbit-test: Add tests for nRF51 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: contrib@steffen-goertz.de, jim@groklearning.com, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, joel@jms.id.au, jusual@mail.ru, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This resolves the conflict with Julia's UART test series due to
global_qtest removal.

 tests/microbit-test.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 3bad947b6c..04e199ec33 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -21,6 +21,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/nvram/nrf51_nvm.h"
 #include "hw/timer/nrf51_timer.h"
 #include "hw/i2c/microbit_i2c.h"
=20
@@ -156,6 +157,112 @@ static void test_microbit_i2c(void)
     qtest_quit(qts);
 }
=20
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
+    for (i =3D 0; i < size / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, base + i * 4), =3D=3D, 0xFFFFF=
FFF);
+    }
+
+    /* Fill memory */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i =3D 0; i < size / 4; i++) {
+        qtest_writel(qts, base + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, base + i * 4), =3D=3D, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+}
+
+static void test_nrf51_nvmc(void)
+{
+    uint32_t value;
+    hwaddr i;
+    QTestState *qts =3D qtest_init("-M microbit");
+
+    /* Test always ready */
+    value =3D qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_READY);
+    g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
+
+    /* Test write-read config register */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFI=
G),
+                     =3D=3D, 0x03);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+    g_assert_cmpuint(qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFI=
G),
+                     =3D=3D, 0x00);
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
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
+        qtest_writel(qts, NRF51_FLASH_BASE + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, NRF51_FLASH_BASE + i * 4), =3D=
=3D, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_FLASH_BASE + i * 4),
+                         =3D=3D, 0xFFFFFFFF);
+    }
+
+    /* Erase UICR */
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4),
+                         =3D=3D, 0xFFFFFFFF);
+    }
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        qtest_writel(qts, NRF51_UICR_BASE + i * 4, i);
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4), =3D=3D=
, i);
+    }
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(qtest_readl(qts, NRF51_UICR_BASE + i * 4),
+                         =3D=3D, 0xFFFFFFFF);
+    }
+
+    qtest_quit(qts);
+}
+
 static void test_nrf51_gpio(void)
 {
     size_t i;
@@ -392,6 +499,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/microbit/nrf51/uart", test_nrf51_uart);
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
     qtest_add_func("/microbit/microbit/i2c", test_microbit_i2c);
=20
--=20
2.20.1
