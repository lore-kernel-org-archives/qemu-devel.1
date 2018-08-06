Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKN-00025K-Go
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-0003Fm-FU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:27 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33156)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-0003Ev-6G
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:23 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:12 +0200
Message-Id: <20180806100114.21410-6-contrib@steffen-goertz.de>
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] tests/microbit-test: Add Tests for nRF51
 GPIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

The test suite for the nRF51 GPIO peripheral for now
only tests initial state. Additionally a set of
tests testing an implementation detail of the model
are included.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 tests/microbit-test.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index 9f83063cf3..cc36171734 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -33,6 +33,21 @@
 #define NVMC_ERASEPCR0      0x510
 #define NVMC_ERASEUICR      0x514
=20
+#define GPIO_BASE         0x50000000
+#define GPIO_OUT          0x504
+#define GPIO_OUTSET       0x508
+#define GPIO_OUTCLR       0x50C
+#define GPIO_IN           0x510
+#define GPIO_DIR          0x514
+#define GPIO_DIRSET       0x518
+#define GPIO_DIRCLR       0x51C
+#define GPIO_CNF_START    0x700
+#define GPIO_CNF_END      0x77F
+#define GPIO_PINS 32
+
+#define GPIO_PULLDOWN 1
+#define GPIO_PULLUP 3
+
=20
 static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
 {
@@ -109,6 +124,86 @@ static void test_nrf51_nvmc(void)
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
+            {GPIO_OUT, 0x00000000}, {GPIO_OUTSET, 0x00000000},
+            {GPIO_OUTCLR, 0x00000000}, {GPIO_IN, 0x00000000},
+            {GPIO_DIR, 0x00000000}, {GPIO_DIRSET, 0x00000000},
+            {GPIO_DIRCLR, 0x00000000}
+    };
+
+    /** Check reset state **/
+    for (i =3D 0; i < ARRAY_SIZE(reset_state); i++) {
+        expected =3D reset_state[i].expected;
+        actual =3D readl(GPIO_BASE + reset_state[i].addr);
+        g_assert_cmpuint(actual, =3D=3D, expected);
+    }
+
+    for (i =3D 0; i < GPIO_PINS; i++) {
+        expected =3D 0x00000002;
+        actual =3D readl(GPIO_BASE + GPIO_CNF_START + i * 4);
+        g_assert_cmpuint(actual, =3D=3D, expected);
+    }
+
+    /** Check dir bit consistency between dir and cnf **/
+    /* Check set via DIRSET */
+    expected =3D 0x80000001;
+    writel(GPIO_BASE + GPIO_DIRSET, expected);
+    actual =3D readl(GPIO_BASE + GPIO_DIR);
+    g_assert_cmpuint(actual, =3D=3D, expected);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+
+    /* Check clear via DIRCLR */
+    writel(GPIO_BASE + GPIO_DIRCLR, 0x80000001);
+    actual =3D readl(GPIO_BASE + GPIO_DIR);
+    g_assert_cmpuint(actual, =3D=3D, 0x00000000);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x00);
+
+    /* Check set via DIR */
+    expected =3D 0x80000001;
+    writel(GPIO_BASE + GPIO_DIR, expected);
+    actual =3D readl(GPIO_BASE + GPIO_DIR);
+    g_assert_cmpuint(actual, =3D=3D, expected);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    actual =3D readl(GPIO_BASE + GPIO_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, =3D=3D, 0x01);
+
+    /* Reset DIR */
+    writel(GPIO_BASE + GPIO_DIR, 0x00000000);
+
+    /* Check Input propagates */
+    g_assert_false(true);
+
+    /* Check pull-up working */
+    g_assert_false(true);
+
+    /* Check pull-down working */
+    g_assert_false(true);
+
+    /* Check Output propagates */
+    g_assert_false(true);
+
+    /* Check self-stimulation */
+    g_assert_false(true);
+
+    /* Check short-circuit */
+    g_assert_false(true);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -118,6 +213,7 @@ int main(int argc, char **argv)
     global_qtest =3D qtest_startf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
+    qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
=20
     ret =3D g_test_run();
=20
--=20
2.18.0
