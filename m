Received: from eggs.gnu.org ([2001:4830:134:3::10]:34241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsx-0003px-PN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnst-0007w0-Rr
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:31 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnst-0007vs-NK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:27 -0500
Received: by mail-qk0-x242.google.com with SMTP id l19so2667248qke.5
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:35:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:14 -0300
Message-Id: <20180103183418.23730-22-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 21/25] sdhci: add check_capab_readonly()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index f7487808af..0443a23e45 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -60,6 +60,13 @@ static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
     return qtest_readq(qtest, base + reg_addr);
 }
 
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
@@ -78,6 +85,20 @@ static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
     g_assert_cmphex(capab, ==, expected_capab);
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
@@ -86,6 +107,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_specs_version(test->sdhci.addr, test->sdhci.version);
+    check_capab_readonly(test->sdhci.addr);
 
     qtest_quit(global_qtest);
 }
-- 
2.15.1
