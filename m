Received: from eggs.gnu.org ([2001:4830:134:3::10]:45070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0H-0000i8-4z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0E-0007da-1w
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:41 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0D-0007dM-TV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:37 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so23493883qtj.13
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:41:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:52 -0300
Message-Id: <20180118204058.5768-9-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 08/14] sdhci: add a check_capab_v3() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index dd01a47839..51eaed6df8 100644
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
@@ -159,6 +161,20 @@ static void check_capab_sdma(uintptr_t addr, bool supported)
     g_assert_cmpuint(capab_sdma, ==, supported);
 }
 
+static void check_capab_v3(uintptr_t addr, uint8_t version)
+{
+    uint64_t capab, capab_v3;
+
+    if (version < 3) {
+        /* before v3 those fields are RESERVED */
+        capab = sdhci_readq(addr, SDHC_CAPAB);
+        capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, SDR);
+        g_assert_cmpuint(capab_v3, ==, 0);
+        capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, DRIVER);
+        g_assert_cmpuint(capab_v3, ==, 0);
+    }
+}
+
 static void machine_start(const struct sdhci_t *test)
 {
     if (test->pci.vendor_id) {
@@ -201,6 +217,7 @@ static void test_machine(const void *data)
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_v3(test->sdhci.addr, test->sdhci.version);
     check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
-- 
2.15.1
