Received: from eggs.gnu.org ([2001:4830:134:3::10]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNR-0007gz-5u
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNQ-0003di-FH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:49 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNQ-0003dY-AH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:48 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so6982934qti.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:48:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 13:47:53 -0300
Message-Id: <20180208164818.7961-6-f4bug@amsat.org>
In-Reply-To: <20180208164818.7961-1-f4bug@amsat.org>
References: <20180208164818.7961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 05/30] sdhci: add a check_capab_sdma() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 45caf66455..4b901b6cf1 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -15,6 +15,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -106,6 +107,15 @@ static void check_capab_baseclock(QSDHCI *s, uintptr_t addr, uint8_t expec_freq)
     g_assert_cmpuint(capab_freq, ==, expec_freq);
 }
 
+static void check_capab_sdma(QSDHCI *s, uintptr_t addr, bool supported)
+{
+    uint64_t capab, capab_sdma;
+
+    capab = sdhci_readq(s, addr, SDHC_CAPAB);
+    capab_sdma = FIELD_EX64(capab, SDHC_CAPAB, SDMA);
+    g_assert_cmpuint(capab_sdma, ==, supported);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -152,6 +162,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(s, test->sdhci.addr);
+    check_capab_sdma(s, test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(s, test->sdhci.addr, test->sdhci.baseclock);
 
     machine_stop(s);
-- 
2.16.1
