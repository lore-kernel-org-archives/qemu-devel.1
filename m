Received: from eggs.gnu.org ([2001:4830:134:3::10]:48628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo10-0005FI-Cl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo0x-00035W-8L
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:46 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo0x-000358-3c
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:43 -0500
Received: by mail-qt0-x243.google.com with SMTP id z11so26112260qtm.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 18:08:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 23:08:07 -0300
Message-Id: <20180123020820.1288-4-f4bug@amsat.org>
In-Reply-To: <20180123020820.1288-1-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 03/16] sdhci: add check_capab_readonly()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 517e2ed5a2..4833dd4204 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -62,6 +62,17 @@ static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
     }
 }
 
+static void sdhci_writeq(uintptr_t base, uint32_t reg_addr, uint64_t value)
+{
+    if (g.dev) {
+        qpci_memwrite(g.dev, g.mem_bar, reg_addr, &value, sizeof(value));
+    } else {
+        QTestState *qtest = global_qtest;
+
+        qtest_writeq(qtest, base + reg_addr, value);
+    }
+}
+
 static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
 {
     uint64_t capab;
@@ -70,6 +81,20 @@ static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
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
 static void machine_start(const struct sdhci_t *test)
 {
     if (test->pci.vendor_id) {
@@ -110,6 +135,7 @@ static void test_machine(const void *data)
     machine_start(test);
 
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
+    check_capab_readonly(test->sdhci.addr);
 
     machine_stop();
 }
-- 
2.15.1
