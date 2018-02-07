Received: from eggs.gnu.org ([2001:4830:134:3::10]:33813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJy-0001pM-2c
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJu-0004tP-Ts
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:50 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJu-0004tF-PG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:46 -0500
Received: by mail-qt0-x241.google.com with SMTP id r13so2876329qtm.8
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:19:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  7 Feb 2018 15:19:16 -0300
Message-Id: <20180207181929.8701-4-f4bug@amsat.org>
In-Reply-To: <20180207181929.8701-1-f4bug@amsat.org>
References: <20180207181929.8701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 03/16] sdhci: add check_capab_readonly()
 qtest
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
index 1105e07093..e961f2b997 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -62,6 +62,15 @@ static uint64_t sdhci_readq(QSDHCI *s, uintptr_t base, uint32_t reg)
     return val;
 }
 
+static void sdhci_writeq(QSDHCI *s, uintptr_t base, uint32_t reg, uint64_t val)
+{
+    if (s->pci.dev) {
+        qpci_memwrite(s->pci.dev, s->pci.mem_bar, reg, &val, sizeof(val));
+    } else {
+        qtest_writeq(global_qtest, base + reg, val);
+    }
+}
+
 static void check_capab_capareg(QSDHCI *s, uintptr_t addr, uint64_t expec_capab)
 {
     uint64_t capab;
@@ -70,6 +79,20 @@ static void check_capab_capareg(QSDHCI *s, uintptr_t addr, uint64_t expec_capab)
     g_assert_cmphex(capab, ==, expec_capab);
 }
 
+static void check_capab_readonly(QSDHCI *s, uintptr_t addr)
+{
+    const uint64_t vrand = 0x123456789abcdef;
+    uint64_t capab0, capab1;
+
+    capab0 = sdhci_readq(s, addr, SDHC_CAPAB);
+    g_assert_cmpuint(capab0, !=, vrand);
+
+    sdhci_writeq(s, addr, SDHC_CAPAB, vrand);
+    capab1 = sdhci_readq(s, addr, SDHC_CAPAB);
+    g_assert_cmpuint(capab1, !=, vrand);
+    g_assert_cmpuint(capab1, ==, capab0);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -115,6 +138,7 @@ static void test_machine(const void *data)
     s = machine_start(test);
 
     check_capab_capareg(s, test->sdhci.addr, test->sdhci.capab.reg);
+    check_capab_readonly(s, test->sdhci.addr);
 
     machine_stop(s);
 }
-- 
2.16.1
