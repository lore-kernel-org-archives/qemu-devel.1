Received: from eggs.gnu.org ([2001:4830:134:3::10]:34292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnt0-0003te-Us
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnt0-0007zf-2S
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:35 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsz-0007zN-UD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:33 -0500
Received: by mail-qk0-x244.google.com with SMTP id q14so2663028qke.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:35:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:16 -0300
Message-Id: <20180103183418.23730-24-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 23/25] sdhci: add a check_capab_sdma() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 2aa3fa0d3b..91b1b29d75 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -12,6 +12,7 @@
 
 #define SDHC_CAPAB                      0x40
 FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
+FIELD(SDHC_CAPAB, SDMA,                     22, 1);
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -113,6 +114,15 @@ static void check_capab_baseclock(uintptr_t addr, uint8_t expected_freq)
     g_assert_cmpuint(capab_freq, ==, expected_freq);
 }
 
+static void check_capab_sdma(uintptr_t addr, bool supported)
+{
+    uint64_t capab, capab_sdma;
+
+    capab = sdhci_readq(addr, SDHC_CAPAB);
+    capab_sdma = FIELD_EX64(capab, SDHC_CAPAB, SDMA);
+    g_assert_cmpuint(capab_sdma, ==, supported);
+}
+
 static void test_machine(const void *data)
 {
     const struct sdhci_t *test = data;
@@ -122,6 +132,7 @@ static void test_machine(const void *data)
     check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
     check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
     qtest_quit(global_qtest);
-- 
2.15.1
