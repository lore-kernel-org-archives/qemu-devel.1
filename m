Received: from eggs.gnu.org ([2001:4830:134:3::10]:53636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIph-00063N-1n
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpe-0003gI-0w
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:01:09 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpd-0003g1-TC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:01:05 -0500
Received: by mail-qk0-x244.google.com with SMTP id 8so4496481qkj.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:01:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 23:00:23 -0300
Message-Id: <20171214020025.4004-7-f4bug@amsat.org>
In-Reply-To: <20171214020025.4004-1-f4bug@amsat.org>
References: <20171214020025.4004-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] sdhci: add a check_capab_baseclock() qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

So far only the bcm2835 is tested (52 MHz for the raspi2 machine).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I didn't dig the dark web enough to get the other datashits

 tests/sdhci-test.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 01373a69df..966bd00499 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -7,9 +7,11 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "hw/registerfields.h"
 #include "libqtest.h"
 
 #define SDHC_CAPAB                      0x40
+FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -18,16 +20,17 @@ static const struct sdhci_t {
     struct {
         uintptr_t addr;
         uint8_t version;
+        uint8_t baseclock;
     } sdhci;
 } models[] = {
     { "arm",    "smdkc210",
-        {0x12510000, 2} },
+        {0x12510000, 2, 0} },
     { "arm",    "sabrelite",
-        {0x02190000, 3} },
+        {0x02190000, 3, 0} },
     { "arm",    "raspi2",           /* bcm2835 */
-        {0x3f300000, 3} },
+        {0x3f300000, 3, 52} },
     { "arm",    "xilinx-zynq-a9",   /* exynos4210 */
-        {0xe0100000, 3} },
+        {0xe0100000, 3, 0} },
 };
 
 static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
@@ -75,6 +78,18 @@ static void check_capab_readonly(uintptr_t addr)
     g_assert_cmpuint(capab1, ==, capab0);
 }
 
+static void check_capab_baseclock(uintptr_t addr, uint8_t expected_freq)
+{
+    uint64_t capab, capab_freq;
+
+    if (!expected_freq) {
+        return;
+    }
+    capab = sdhci_readq(addr, SDHC_CAPAB);
+    capab_freq = FIELD_EX64(capab, SDHC_CAPAB, BASECLKFREQ);
+    g_assert_cmpuint(capab_freq, ==, expected_freq);
+}
+
 static void test_machine(const void *data)
 {
     const struct sdhci_t *test = data;
@@ -83,6 +98,7 @@ static void test_machine(const void *data)
 
     check_specs_version(test->sdhci.addr, test->sdhci.version);
     check_capab_readonly(test->sdhci.addr);
+    check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
 
     qtest_quit(global_qtest);
 }
-- 
2.15.1
