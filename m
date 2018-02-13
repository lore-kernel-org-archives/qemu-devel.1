Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHW-0004GL-GH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHV-0007fx-Ia
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHV-0007eq-Ct
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id t74so15605280wme.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:22 +0100
Message-Id: <1518523252-49106-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/48] sdhci: add a check_capab_sdma() qtest
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
Message-Id: <20180208164818.7961-6-f4bug@amsat.org>
---
 tests/sdhci-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 36d13be..6fa3ddb 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -15,6 +15,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -109,6 +110,15 @@ static void check_capab_baseclock(QSDHCI *s, uint8_t expec_freq)
     g_assert_cmpuint(capab_freq, ==, expec_freq);
 }
 
+static void check_capab_sdma(QSDHCI *s, bool supported)
+{
+    uint64_t capab, capab_sdma;
+
+    capab = sdhci_readq(s, SDHC_CAPAB);
+    capab_sdma = FIELD_EX64(capab, SDHC_CAPAB, SDMA);
+    g_assert_cmpuint(capab_sdma, ==, supported);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -156,6 +166,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
+    check_capab_sdma(s, test->sdhci.capab.sdma);
     check_capab_baseclock(s, test->sdhci.baseclock);
 
     machine_stop(s);
-- 
1.8.3.1
