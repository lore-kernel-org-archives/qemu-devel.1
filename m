Received: from eggs.gnu.org ([2001:4830:134:3::10]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUK7-0001wT-2M
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUK3-0004xO-UF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:59 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUK3-0004xB-P7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:55 -0500
Received: by mail-qt0-x242.google.com with SMTP id d14so2893099qtg.1
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:19:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  7 Feb 2018 15:19:19 -0300
Message-Id: <20180207181929.8701-7-f4bug@amsat.org>
In-Reply-To: <20180207181929.8701-1-f4bug@amsat.org>
References: <20180207181929.8701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 06/16] sdhci: add qtest to check the SD
 Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 4b901b6cf1..ee12c4be7b 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -51,6 +51,19 @@ typedef struct QSDHCI {
     } pci;
 } QSDHCI;
 
+static uint32_t sdhci_readl(QSDHCI *s, uintptr_t base, uint32_t reg)
+{
+    uint32_t val;
+
+    if (s->pci.dev) {
+        qpci_memread(s->pci.dev, s->pci.mem_bar, reg, &val, sizeof(val));
+    } else {
+        val = qtest_readl(global_qtest, base + reg);
+    }
+
+    return val;
+}
+
 static uint64_t sdhci_readq(QSDHCI *s, uintptr_t base, uint32_t reg)
 {
     uint64_t val;
@@ -73,6 +86,16 @@ static void sdhci_writeq(QSDHCI *s, uintptr_t base, uint32_t reg, uint64_t val)
     }
 }
 
+static void check_specs_version(QSDHCI *s, uintptr_t addr, uint8_t version)
+{
+    uint32_t v;
+
+    v = sdhci_readl(s, addr, SDHC_HCVER);
+    v &= 0xff;
+    v += 1;
+    g_assert_cmpuint(v, ==, version);
+}
+
 static void check_capab_capareg(QSDHCI *s, uintptr_t addr, uint64_t expec_capab)
 {
     uint64_t capab;
@@ -160,6 +183,7 @@ static void test_machine(const void *data)
 
     s = machine_start(test);
 
+    check_specs_version(s, test->sdhci.addr, test->sdhci.version);
     check_capab_capareg(s, test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(s, test->sdhci.addr);
     check_capab_sdma(s, test->sdhci.addr, test->sdhci.capab.sdma);
-- 
2.16.1
