Received: from eggs.gnu.org ([2001:4830:134:3::10]:60303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovi-00015L-5L
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovh-000529-4z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:22 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovh-00051v-0S
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:21 -0500
Received: by mail-qt0-x244.google.com with SMTP id l20so25032996qtj.11
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:07:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:06:29 -0300
Message-Id: <20180123030630.26613-14-f4bug@amsat.org>
In-Reply-To: <20180123030630.26613-1-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 13/14] sdhci: add a check_capab_v3() qtest
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
index 56eefdafd8..a8970da71a 100644
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
@@ -160,6 +162,20 @@ static void check_capab_sdma(uintptr_t addr, bool supported)
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
@@ -202,6 +218,7 @@ static void test_machine(const void *data)
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_v3(test->sdhci.addr, test->sdhci.version);
     check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
-- 
2.15.1
