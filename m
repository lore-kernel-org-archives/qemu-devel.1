Received: from eggs.gnu.org ([209.51.188.92]:58833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECQ-0002vC-6B
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECO-0002bv-3b
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun, 20 Jan 2019 14:34:52 +0000
Message-Id: <20190120143452.21683-5-stefanha@redhat.com>
In-Reply-To: <20190120143452.21683-1-stefanha@redhat.com>
References: <20190120143452.21683-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] tests/microbit-test: Add tests for nRF51
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim@groklearning.com, jusual@mail.ru, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/microbit-test.c | 97 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 0c125535f6..d3edd38643 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -20,8 +20,104 @@
=20
 #include "hw/arm/nrf51.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/nvram/nrf51_nvm.h"
 #include "hw/timer/nrf51_timer.h"
=20
+#define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
+
+static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
+{
+    hwaddr i;
+
+    /* Erase Page */
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    writel(NRF51_NVMC_BASE + address_reg, base);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    /* Check memory */
+    for (i =3D 0; i < size / 4; i++) {
+        g_assert_cmpuint(readl(base + i * 4), =3D=3D, 0xFFFFFFFF);
+    }
+
+    /* Fill memory */
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i =3D 0; i < size / 4; i++) {
+        writel(base + i * 4, i);
+        g_assert_cmpuint(readl(base + i * 4), =3D=3D, i);
+    }
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+}
+
+static void test_nrf51_nvmc(void)
+{
+    uint32_t value;
+    hwaddr i;
+
+    /* Test always ready */
+    value =3D readl(NRF51_NVMC_BASE + NRF51_NVMC_READY);
+    g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
+
+    /* Test write-read config register */
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
+    g_assert_cmpuint(readl(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG), =3D=3D,=
 0x03);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+    g_assert_cmpuint(readl(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG), =3D=3D,=
 0x00);
+
+    /* Test PCR0 */
+    fill_and_erase(NRF51_FLASH_BASE, NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPC=
R0);
+    fill_and_erase(NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
+                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR0);
+
+    /* Test PCR1 */
+    fill_and_erase(NRF51_FLASH_BASE, NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPC=
R1);
+    fill_and_erase(NRF51_FLASH_BASE + NRF51_PAGE_SIZE,
+                   NRF51_PAGE_SIZE, NRF51_NVMC_ERASEPCR1);
+
+    /* Erase all */
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
+        writel(NRF51_FLASH_BASE + i * 4, i);
+        g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, i);
+    }
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
+        g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, 0xFFFF=
FFFF);
+    }
+
+    /* Erase UICR */
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, 0xFFFFF=
FFF);
+    }
+
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        writel(NRF51_UICR_BASE + i * 4, i);
+        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, i);
+    }
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
+    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
+
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, 0xFFFFF=
FFF);
+    }
+}
+
 static void test_nrf51_gpio(void)
 {
     size_t i;
@@ -246,6 +342,7 @@ int main(int argc, char **argv)
     global_qtest =3D qtest_initf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
     qtest_add_func("/microbit/nrf51/timer", test_nrf51_timer);
=20
     ret =3D g_test_run();
--=20
2.20.1
