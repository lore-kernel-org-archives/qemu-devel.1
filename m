Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHX-0004HG-7o
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHT-0007dU-Ei
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:55 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHT-0007dG-7v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:51 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so15619378wme.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:20 +0100
Message-Id: <1518523252-49106-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/48] sdhci: add check_capab_readonly() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180208164818.7961-4-f4bug@amsat.org>
---
 tests/sdhci-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 817d9c1..0dd3e8a 100644
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
 static void check_capab_capareg(QSDHCI *s, uint64_t expec_capab)
 {
     uint64_t capab;
@@ -73,6 +82,20 @@ static void check_capab_capareg(QSDHCI *s, uint64_t expec_capab)
     g_assert_cmphex(capab, ==, expec_capab);
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
@@ -119,6 +142,7 @@ static void test_machine(const void *data)
     s = machine_start(test);
 
     check_capab_capareg(s, test->sdhci.capab.reg);
+    check_capab_readonly(s);
 
     machine_stop(s);
 }
-- 
1.8.3.1
