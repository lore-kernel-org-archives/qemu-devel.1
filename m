Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4n-0001i9-Hy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4j-00050a-67
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:56 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4j-00050G-1U
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:54:53 -0500
Received: by mail-qk0-x242.google.com with SMTP id d144so3446569qkg.13
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:54:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 11:54:05 -0300
Message-Id: <20180209145430.26007-6-f4bug@amsat.org>
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 05/30] sdhci: add a check_capab_sdma() qtest
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
 tests/sdhci-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index d6eb3c3a48..7c50c0482b 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -15,6 +15,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -111,6 +112,15 @@ static void check_capab_baseclock(QSDHCI *s, uint8_t expected_freq)
     g_assert_cmpuint(capab_freq, ==, expected_freq);
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
@@ -158,6 +168,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
+    check_capab_sdma(s, test->sdhci.capab.sdma);
     check_capab_baseclock(s, test->sdhci.baseclock);
 
     machine_stop(s);
-- 
2.16.1
