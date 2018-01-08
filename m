Received: from eggs.gnu.org ([2001:4830:134:3::10]:42953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZcW-0003JC-6O
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZcV-0000UM-FU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:43:01 -0300
Message-Id: <20180108154303.6522-30-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 29/31] sdhci: add a check_capab_sdma() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 2aa3fa0d3b..91b1b29d75 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -12,6 +12,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -113,6 +114,15 @@ static void check_capab_baseclock(uintptr_t addr, uint8_t expected_freq)
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
@@ -122,6 +132,7 @@ static void test_machine(const void *data)
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
     qtest_quit(global_qtest);
-- 
2.15.1
