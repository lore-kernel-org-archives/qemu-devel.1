Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtX-0000jC-5S
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtW-0007UA-9g
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:39 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtW-0007TG-5n
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:38 -0500
Received: by mail-qt0-x242.google.com with SMTP id d14so2248704qtg.1
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:08:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:45 -0300
Message-Id: <20180213040809.26021-7-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 06/30] sdhci: add qtest to check the SD
 Spec version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 7c50c0482b..24feea744a 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -54,6 +54,19 @@ typedef struct QSDHCI {
     };
 } QSDHCI;
 
+static uint32_t sdhci_readl(QSDHCI *s, uint32_t reg)
+{
+    uint32_t val;
+
+    if (s->pci.dev) {
+        qpci_memread(s->pci.dev, s->mem_bar, reg, &val, sizeof(val));
+    } else {
+        val = qtest_readl(global_qtest, s->addr + reg);
+    }
+
+    return val;
+}
+
 static uint64_t sdhci_readq(QSDHCI *s, uint32_t reg)
 {
     uint64_t val;
@@ -78,6 +91,16 @@ static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
 
 /* tests */
 
+static void check_specs_version(QSDHCI *s, uint8_t version)
+{
+    uint32_t v;
+
+    v = sdhci_readl(s, SDHC_HCVER);
+    v &= 0xff;
+    v += 1;
+    g_assert_cmpuint(v, ==, version);
+}
+
 static void check_capab_capareg(QSDHCI *s, uint64_t expected_capab)
 {
     uint64_t capab;
@@ -166,6 +189,7 @@ static void test_machine(const void *data)
 
     s = machine_start(test);
 
+    check_specs_version(s, test->sdhci.version);
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
     check_capab_sdma(s, test->sdhci.capab.sdma);
-- 
2.16.1
