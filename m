Received: from eggs.gnu.org ([2001:4830:134:3::10]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gIcvx-0007df-1d
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gIcvn-0004gC-IA
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:08:30 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33356)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gIcvj-0004RR-EY
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:08:21 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Fri,  2 Nov 2018 13:07:27 -0400
Message-Id: <20181102170730.12432-11-contrib@steffen-goertz.de>
In-Reply-To: <20181102170730.12432-1-contrib@steffen-goertz.de>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/13] tests/microbit-test: Add Tests for
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

The test suite for the nRF51 GPIO peripheral for now
only tests initial state. Additionally a set of
tests testing an implementation detail of the model
are included.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/microbit-test.c | 137 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 6 deletions(-)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 743f831466..acdb9d1c02 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -20,14 +20,17 @@
=20
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/gpio/nrf51_gpio.h"
=20
 #define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
=20
 static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
 {
+    uint64_t i;
+
     /* Fill memory */
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
-    for (hwaddr i =3D 0; i < size; i++) {
+    for (i =3D 0; i < size; i++) {
         writeb(base + i, i);
         g_assert_cmpuint(readb(base + i), =3D=3D, i & 0xFF);
     }
@@ -39,7 +42,7 @@ static void fill_and_erase(hwaddr base, hwaddr size, ui=
nt32_t address_reg)
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
=20
     /* Check memory */
-    for (hwaddr i =3D 0; i < size; i++) {
+    for (i =3D 0; i < size; i++) {
         g_assert_cmpuint(readb(base + i), =3D=3D, 0xFF);
     }
 }
@@ -47,6 +50,7 @@ static void fill_and_erase(hwaddr base, hwaddr size, ui=
nt32_t address_reg)
 static void test_nrf51_nvmc(void)
 {
     uint32_t value;
+    uint64_t i;
     /* Test always ready */
     value =3D readl(NRF51_NVMC_BASE + NRF51_NVMC_READY);
     g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
@@ -69,7 +73,7 @@ static void test_nrf51_nvmc(void)
=20
     /* Erase all */
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
-    for (hwaddr i =3D 0; i < FLASH_SIZE / 4; i++) {
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
         writel(NRF51_FLASH_BASE + i * 4, i);
         g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, i);
     }
@@ -79,13 +83,13 @@ static void test_nrf51_nvmc(void)
     writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEALL, 0x01);
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
=20
-    for (hwaddr i =3D 0; i < FLASH_SIZE / 4; i++) {
+    for (i =3D 0; i < FLASH_SIZE / 4; i++) {
         g_assert_cmpuint(readl(NRF51_FLASH_BASE + i * 4), =3D=3D, 0xFFFF=
FFFF);
     }
=20
     /* Erase UICR */
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x01);
-    for (hwaddr i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
         writel(NRF51_UICR_BASE + i * 4, i);
         g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, i);
     }
@@ -95,11 +99,131 @@ static void test_nrf51_nvmc(void)
     writel(NRF51_NVMC_BASE + NRF51_NVMC_ERASEUICR, 0x01);
     writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);
=20
-    for (hwaddr i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
+    for (i =3D 0; i < NRF51_UICR_SIZE / 4; i++) {
         g_assert_cmpuint(readl(NRF51_UICR_BASE + i * 4), =3D=3D, 0xFFFFF=
FFF);
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
+    } reset_state[] =3D {
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
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, -1);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-up working */
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-down working */
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
+    actual =3D readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, -1);
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
+    /* Check short-circuit - generates an guest_error which must be chec=
ked
+       manually as long as qtest can not scan qemu_log messages */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    set_irq_in("/machine/nrf51", "unnamed-gpio-in", 0, 0);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -109,6 +233,7 @@ int main(int argc, char **argv)
     global_qtest =3D qtest_initf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
+    qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
=20
     ret =3D g_test_run();
=20
--=20
2.19.1
