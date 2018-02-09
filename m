Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4e-0001b3-Pm
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4d-0004yi-Ve
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:48 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4d-0004yO-Qk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:47 -0500
Received: by mail-qk0-x243.google.com with SMTP id c82so10272245qka.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:54:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 11:54:03 -0300
Message-Id: <20180209145430.26007-4-f4bug@amsat.org>
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 03/30] sdhci: add check_capab_readonly()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 82f3785a72..51af5eac67 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -65,6 +65,15 @@ static uint64_t sdhci_readq(QSDHCI *s, uint32_t reg)
     return val;
 }
 
+static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
+{
+    if (s->pci.dev) {
+        qpci_memwrite(s->pci.dev, s->mem_bar, reg, &val, sizeof(val));
+    } else {
+        qtest_writeq(global_qtest, s->addr + reg, val);
+    }
+}
+
 /* tests */
 
 static void check_capab_capareg(QSDHCI *s, uint64_t expected_capab)
@@ -75,6 +84,20 @@ static void check_capab_capareg(QSDHCI *s, uint64_t expected_capab)
     g_assert_cmphex(capab, ==, expected_capab);
 }
 
+static void check_capab_readonly(QSDHCI *s)
+{
+    const uint64_t vrand = 0x123456789abcdef;
+    uint64_t capab0, capab1;
+
+    capab0 = sdhci_readq(s, SDHC_CAPAB);
+    g_assert_cmpuint(capab0, !=, vrand);
+
+    sdhci_writeq(s, SDHC_CAPAB, vrand);
+    capab1 = sdhci_readq(s, SDHC_CAPAB);
+    g_assert_cmpuint(capab1, !=, vrand);
+    g_assert_cmpuint(capab1, ==, capab0);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -121,6 +144,7 @@ static void test_machine(const void *data)
     s = machine_start(test);
 
     check_capab_capareg(s, test->sdhci.capab.reg);
+    check_capab_readonly(s);
 
     machine_stop(s);
 }
-- 
2.16.1
