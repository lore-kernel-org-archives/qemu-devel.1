Received: from eggs.gnu.org ([2001:4830:134:3::10]:33824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJy-0001pz-NJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJx-0004uj-TL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:50 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJx-0004uV-OF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:49 -0500
Received: by mail-qt0-x244.google.com with SMTP id u6so2450043qtg.13
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:19:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  7 Feb 2018 15:19:17 -0300
Message-Id: <20180207181929.8701-5-f4bug@amsat.org>
In-Reply-To: <20180207181929.8701-1-f4bug@amsat.org>
References: <20180207181929.8701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 04/16] sdhci: add a check_capab_baseclock()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index e961f2b997..45caf66455 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 
 #define SDHC_CAPAB                      0x40
+FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -93,6 +94,18 @@ static void check_capab_readonly(QSDHCI *s, uintptr_t addr)
     g_assert_cmpuint(capab1, ==, capab0);
 }
 
+static void check_capab_baseclock(QSDHCI *s, uintptr_t addr, uint8_t expec_freq)
+{
+    uint64_t capab, capab_freq;
+
+    if (!expec_freq) {
+        return;
+    }
+    capab = sdhci_readq(s, addr, SDHC_CAPAB);
+    capab_freq = FIELD_EX64(capab, SDHC_CAPAB, BASECLKFREQ);
+    g_assert_cmpuint(capab_freq, ==, expec_freq);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -139,6 +152,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.addr, test->sdhci.capab.reg);
     check_capab_readonly(s, test->sdhci.addr);
+    check_capab_baseclock(s, test->sdhci.addr, test->sdhci.baseclock);
 
     machine_stop(s);
 }
-- 
2.16.1
