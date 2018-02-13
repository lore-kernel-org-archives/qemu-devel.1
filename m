Received: from eggs.gnu.org ([2001:4830:134:3::10]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtR-0000em-7g
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtQ-0007LV-Dx
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:33 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtQ-0007L1-8m
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:32 -0500
Received: by mail-qt0-x244.google.com with SMTP id k13so2227030qtg.5
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:08:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:43 -0300
Message-Id: <20180213040809.26021-5-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 04/30] sdhci: add a check_capab_baseclock()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 51af5eac67..d6eb3c3a48 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 
 #define SDHC_CAPAB                      0x40
+FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
 #define SDHC_HCVER                      0xFE
 
 static const struct sdhci_t {
@@ -98,6 +99,18 @@ static void check_capab_readonly(QSDHCI *s)
     g_assert_cmpuint(capab1, ==, capab0);
 }
 
+static void check_capab_baseclock(QSDHCI *s, uint8_t expected_freq)
+{
+    uint64_t capab, capab_freq;
+
+    if (!expected_freq) {
+        return;
+    }
+    capab = sdhci_readq(s, SDHC_CAPAB);
+    capab_freq = FIELD_EX64(capab, SDHC_CAPAB, BASECLKFREQ);
+    g_assert_cmpuint(capab_freq, ==, expected_freq);
+}
+
 static QSDHCI *machine_start(const struct sdhci_t *test)
 {
     QSDHCI *s = g_new0(QSDHCI, 1);
@@ -145,6 +158,7 @@ static void test_machine(const void *data)
 
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
+    check_capab_baseclock(s, test->sdhci.baseclock);
 
     machine_stop(s);
 }
-- 
2.16.1
