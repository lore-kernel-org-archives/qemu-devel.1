Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoR-0003yJ-19
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoN-0007Ze-Rp
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:19 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoN-0007ZR-My
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:15 -0500
Received: by mail-qk0-x241.google.com with SMTP id o126so41111384qke.12
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:51:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:21 -0300
Message-Id: <20171229174933.1781-31-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 30/42] sdhci: check Spec v2 capabilities
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

with check_capab_capareg()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 492b332588..200d7bcee2 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+#define SDHC_CAPAB                      0x40
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -40,6 +41,13 @@ static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
     return qtest_readl(qtest, base + reg_addr);
 }
 
+static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
+{
+    QTestState *qtest = global_qtest;
+
+    return qtest_readq(qtest, base + reg_addr);
+}
+
 static void check_specs_version(uintptr_t addr, uint8_t version)
 {
     uint32_t v;
@@ -50,12 +58,21 @@ static void check_specs_version(uintptr_t addr, uint8_t version)
     g_assert_cmpuint(v, ==, version);
 }
 
+static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
+{
+    uint64_t capab;
+
+    capab = sdhci_readq(addr, SDHC_CAPAB);
+    g_assert_cmphex(capab, ==, expected_capab);
+}
+
 static void test_machine(const void *data)
 {
     const struct sdhci_t *test = data;
 
     global_qtest = qtest_startf("-machine %s -d unimp", test->machine);
 
+    check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_specs_version(test->sdhci.addr, test->sdhci.version);
 
     qtest_quit(global_qtest);
-- 
2.15.1
