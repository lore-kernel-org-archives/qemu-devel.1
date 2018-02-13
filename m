Received: from eggs.gnu.org ([2001:4830:134:3::10]:41831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHX-0004Ha-IN
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHW-0007gt-NQ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:55 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHW-0007gE-Gw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:54 -0500
Received: by mail-wm0-x241.google.com with SMTP id j199so3414441wmj.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:23 +0100
Message-Id: <1518523252-49106-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/48] sdhci: add qtest to check the SD Spec
 version
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
Message-Id: <20180208164818.7961-7-f4bug@amsat.org>
---
 tests/sdhci-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 6fa3ddb..3e9a5bf 100644
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
@@ -76,6 +89,16 @@ static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
     }
 }
 
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
 static void check_capab_capareg(QSDHCI *s, uint64_t expec_capab)
 {
     uint64_t capab;
@@ -164,6 +187,7 @@ static void test_machine(const void *data)
 
     s = machine_start(test);
 
+    check_specs_version(s, test->sdhci.version);
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
     check_capab_sdma(s, test->sdhci.capab.sdma);
-- 
1.8.3.1
