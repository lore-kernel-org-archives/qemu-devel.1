Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHV-0004E1-9k
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHU-0007eL-HG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:53 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHU-0007do-BW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:52 -0500
Received: by mail-wm0-x243.google.com with SMTP id f71so15546027wmf.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:21 +0100
Message-Id: <1518523252-49106-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/48] sdhci: add a check_capab_baseclock() qtest
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
Message-Id: <20180208164818.7961-5-f4bug@amsat.org>
---
 tests/sdhci-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 0dd3e8a..36d13be 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 
 #define SDHC_CAPAB                      0x40
+FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -96,6 +97,18 @@ static void check_capab_readonly(QSDHCI *s)
     g_assert_cmpuint(capab1, ==, capab0);
 }
 
+static void check_capab_baseclock(QSDHCI *s, uint8_t expec_freq)
+{
+    uint64_t capab, capab_freq;
+
+    if (!expec_freq) {
+        return;
+    }
+    capab = sdhci_readq(s, SDHC_CAPAB);
+    capab_freq = FIELD_EX64(capab, SDHC_CAPAB, BASECLKFREQ);
+    g_assert_cmpuint(capab_freq, ==, expec_freq);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -143,6 +156,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
+    check_capab_baseclock(s, test->sdhci.baseclock);
 
     machine_stop(s);
 }
-- 
1.8.3.1
