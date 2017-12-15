Received: from eggs.gnu.org ([2001:4830:134:3::10]:54886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgWF-0007fC-OL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgWE-0002hC-U7
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:18:39 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:44 -0300
Message-Id: <20171215031547.31006-18-f4bug@amsat.org>
In-Reply-To: <20171215031547.31006-1-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 17/20] sdhci: add check_capab_readonly()
 qtest
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
 tests/sdhci-test.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 4ebe1e349b..01373a69df 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+#define SDHC_CAPAB                      0x40
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -36,6 +37,20 @@ static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
     return qtest_readl(qtest, base + reg_addr);
 }
 
+static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
+{
+    QTestState *qtest = global_qtest;
+
+    return qtest_readq(qtest, base + reg_addr);
+}
+
+static void sdhci_writeq(uintptr_t base, uint32_t reg_addr, uint64_t value)
+{
+    QTestState *qtest = global_qtest;
+
+    qtest_writeq(qtest, base + reg_addr, value);
+}
+
 static void check_specs_version(uintptr_t addr, uint8_t version)
 {
     uint32_t v;
@@ -46,6 +61,20 @@ static void check_specs_version(uintptr_t addr, uint8_t version)
     g_assert_cmpuint(v, ==, version);
 }
 
+static void check_capab_readonly(uintptr_t addr)
+{
+    const uint64_t vrand = 0x123456789abcdef;
+    uint64_t capab0, capab1;
+
+    capab0 = sdhci_readq(addr, SDHC_CAPAB);
+    g_assert_cmpuint(capab0, !=, vrand);
+
+    sdhci_writeq(addr, SDHC_CAPAB, vrand);
+    capab1 = sdhci_readq(addr, SDHC_CAPAB);
+    g_assert_cmpuint(capab1, !=, vrand);
+    g_assert_cmpuint(capab1, ==, capab0);
+}
+
 static void test_machine(const void *data)
 {
     const struct sdhci_t *test = data;
@@ -53,6 +82,7 @@ static void test_machine(const void *data)
     global_qtest = qtest_startf("-machine %s -d unimp", test->machine);
 
     check_specs_version(test->sdhci.addr, test->sdhci.version);
+    check_capab_readonly(test->sdhci.addr);
 
     qtest_quit(global_qtest);
 }
-- 
2.15.1
