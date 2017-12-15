Received: from eggs.gnu.org ([2001:4830:134:3::10]:54989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgWP-0007mT-41
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgWO-0002oB-4V
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:18:49 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:46 -0300
Message-Id: <20171215031547.31006-20-f4bug@amsat.org>
In-Reply-To: <20171215031547.31006-1-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/20] sdhci: add a check_capab_sdma() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 966bd00499..b7646bccc6 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -12,6 +12,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -21,16 +22,19 @@ static const struct sdhci_t {
         uintptr_t addr;
         uint8_t version;
         uint8_t baseclock;
+        struct {
+            bool sdma;
+        } capab;
     } sdhci;
 } models[] = {
     { "arm",    "smdkc210",
-        {0x12510000, 2, 0} },
+        {0x12510000, 2, 0, {1} } },
     { "arm",    "sabrelite",
-        {0x02190000, 3, 0} },
+        {0x02190000, 3, 0, {1} } },
     { "arm",    "raspi2",           /* bcm2835 */
-        {0x3f300000, 3, 52} },
+        {0x3f300000, 3, 52, {0} } },
     { "arm",    "xilinx-zynq-a9",   /* exynos4210 */
-        {0xe0100000, 3, 0} },
+        {0xe0100000, 3, 0, {1} } },
 };
 
 static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
@@ -90,6 +94,15 @@ static void check_capab_baseclock(uintptr_t addr, uint8_t expected_freq)
     g_assert_cmpuint(capab_freq, ==, expected_freq);
 }
 
+static void check_capab_sdma(uintptr_t addr, bool supported)
+{
+    uint64_t capab, capab_sdma;
+
+    capab = sdhci_readq(addr, SDHC_CAPAB);
+    capab_sdma = FIELD_EX64(capab, SDHC_CAPAB, SDMA);
+    g_assert_cmpuint(capab_sdma, ==, supported);
+}
+
 static void test_machine(const void *data)
 {
     const struct sdhci_t *test = data;
@@ -98,6 +111,7 @@ static void test_machine(const void *data)
 
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
     qtest_quit(global_qtest);
-- 
2.15.1
