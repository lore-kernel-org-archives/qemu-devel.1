Received: from eggs.gnu.org ([2001:4830:134:3::10]:42117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHx-0004ZM-B6
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHw-0007rw-Eu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:21 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHw-0007re-8Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:20 -0500
Received: by mail-wr0-x242.google.com with SMTP id h9so18378075wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:46 +0100
Message-Id: <1518523252-49106-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/48] sdhci: add a check_capab_v3() qtest
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
Message-Id: <20180208164818.7961-30-f4bug@amsat.org>
---
 tests/sdhci-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 08bc5cd..4fdb1b4 100644
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
@@ -159,6 +161,20 @@ static void check_capab_sdma(QSDHCI *s, bool supported)
     g_assert_cmpuint(capab_sdma, ==, supported);
 }
 
+static void check_capab_v3(QSDHCI *s, uint8_t version)
+{
+    uint64_t capab, capab_v3;
+
+    if (version < 3) {
+        /* before v3 those fields are RESERVED */
+        capab = sdhci_readq(s, SDHC_CAPAB);
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
@@ -207,6 +223,7 @@ static void test_machine(const void *data)
     check_specs_version(s, test->sdhci.version);
     check_capab_capareg(s, test->sdhci.capab.reg);
     check_capab_readonly(s);
+    check_capab_v3(s, test->sdhci.version);
     check_capab_sdma(s, test->sdhci.capab.sdma);
     check_capab_baseclock(s, test->sdhci.baseclock);
 
-- 
1.8.3.1
