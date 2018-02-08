Received: from eggs.gnu.org ([2001:4830:134:3::10]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpOZ-0000P7-3L
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpOW-0004WO-FR
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:59 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpOW-0004WA-Az
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:56 -0500
Received: by mail-qk0-x244.google.com with SMTP id d125so6412370qkg.13
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:49:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 13:48:17 -0300
Message-Id: <20180208164818.7961-30-f4bug@amsat.org>
In-Reply-To: <20180208164818.7961-1-f4bug@amsat.org>
References: <20180208164818.7961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 29/30] sdhci: add a check_capab_v3() qtest
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
 tests/sdhci-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 70aa0a850e..74a644ceba 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -16,6 +16,8 @@
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
 FIELD(SDHC_CAPAB, SDMA,                     22, 1);
+FIELD(SDHC_CAPAB, SDR,                      32, 3); /* since v3 */
+FIELD(SDHC_CAPAB, DRIVER,                   36, 3); /* since v3 */
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -156,6 +158,20 @@ static void check_capab_sdma(QSDHCI *s, uintptr_t addr, bool supported)
     g_assert_cmpuint(capab_sdma, ==, supported);
 }
 
+static void check_capab_v3(QSDHCI *s, uintptr_t addr, uint8_t version)
+{
+    uint64_t capab, capab_v3;
+
+    if (version < 3) {
+        /* before v3 those fields are RESERVED */
+        capab = sdhci_readq(s, addr, SDHC_CAPAB);
+        capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, SDR);
+        g_assert_cmpuint(capab_v3, ==, 0);
+        capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, DRIVER);
+        g_assert_cmpuint(capab_v3, ==, 0);
+    }
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -203,6 +219,7 @@ static void test_machine(const void *data)
     check_specs_version(s, test->sdhci.addr, test->sdhci.version);
     check_capab_capareg(s, test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(s, test->sdhci.addr);
+    check_capab_v3(s, test->sdhci.addr, test->sdhci.version);
     check_capab_sdma(s, test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(s, test->sdhci.addr, test->sdhci.baseclock);
 
-- 
2.16.1
