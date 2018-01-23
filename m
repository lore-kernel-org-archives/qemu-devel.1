Received: from eggs.gnu.org ([2001:4830:134:3::10]:48711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1A-0005Pq-Jx
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo19-0003PT-KY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:56 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo19-0003PC-Fv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:55 -0500
Received: by mail-qt0-x243.google.com with SMTP id a27so12959663qtd.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 18:08:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 23:08:10 -0300
Message-Id: <20180123020820.1288-7-f4bug@amsat.org>
In-Reply-To: <20180123020820.1288-1-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 06/16] sdhci: add qtest to check the SD Spec
 version
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
index f4c43b8120..094e0570e1 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -49,6 +49,21 @@ static struct {
     QPCIBar mem_bar;
 } g = { };
 
+static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
+{
+    if (g.dev) {
+        uint32_t value;
+
+        qpci_memread(g.dev, g.mem_bar, reg_addr, &value, sizeof(value));
+
+        return value;
+    } else {
+        QTestState *qtest = global_qtest;
+
+        return qtest_readl(qtest, base + reg_addr);
+    }
+}
+
 static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
 {
     if (g.dev) {
@@ -75,6 +90,16 @@ static void sdhci_writeq(uintptr_t base, uint32_t reg_addr, uint64_t value)
     }
 }
 
+static void check_specs_version(uintptr_t addr, uint8_t version)
+{
+    uint32_t v;
+
+    v = sdhci_readl(addr, SDHC_HCVER);
+    v &= 0xff;
+    v += 1;
+    g_assert_cmpuint(v, ==, version);
+}
+
 static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
 {
     uint64_t capab;
@@ -157,6 +182,7 @@ static void test_machine(const void *data)
 
     machine_start(test);
 
+    check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(test->sdhci.addr);
     check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
-- 
2.15.1
