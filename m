Received: from eggs.gnu.org ([209.51.188.92]:44771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4v-0005c6-O4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4p-0007Th-Sk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4p-0007Sr-J4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:04 +0100
Message-Id: <1547460140-1473-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 09/25] tests/pnv-xscom: Make test independent of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

Pass around the QTestState, so that we can finally get rid of the
out-of-favor global_qtest variable in this file, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pnv-xscom-test.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 70f4c84..974f8da 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -63,14 +63,15 @@ static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
     return addr;
 }
 
-static uint64_t pnv_xscom_read(const PnvChip *chip, uint32_t pcba)
+static uint64_t pnv_xscom_read(QTestState *qts, const PnvChip *chip,
+                               uint32_t pcba)
 {
-    return readq(pnv_xscom_addr(chip, pcba));
+    return qtest_readq(qts, pnv_xscom_addr(chip, pcba));
 }
 
-static void test_xscom_cfam_id(const PnvChip *chip)
+static void test_xscom_cfam_id(QTestState *qts, const PnvChip *chip)
 {
-    uint64_t f000f = pnv_xscom_read(chip, 0xf000f);
+    uint64_t f000f = pnv_xscom_read(qts, chip, 0xf000f);
 
     g_assert_cmphex(f000f, ==, chip->cfam_id);
 }
@@ -78,11 +79,11 @@ static void test_xscom_cfam_id(const PnvChip *chip)
 static void test_cfam_id(const void *data)
 {
     const PnvChip *chip = data;
+    QTestState *qts;
 
-    global_qtest = qtest_initf("-M powernv,accel=tcg -cpu %s",
-                               chip->cpu_model);
-    test_xscom_cfam_id(chip);
-    qtest_quit(global_qtest);
+    qts = qtest_initf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    test_xscom_cfam_id(qts, chip);
+    qtest_quit(qts);
 }
 
 
@@ -94,7 +95,7 @@ static void test_cfam_id(const void *data)
 
 #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
 
-static void test_xscom_core(const PnvChip *chip)
+static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 {
     uint32_t first_core_dts0 = PNV_XSCOM_EX_DTS_RESULT0;
     uint64_t dts0;
@@ -105,7 +106,7 @@ static void test_xscom_core(const PnvChip *chip)
         first_core_dts0 |= PNV_XSCOM_P9_EC_BASE(chip->first_core);
     }
 
-    dts0 = pnv_xscom_read(chip, first_core_dts0);
+    dts0 = pnv_xscom_read(qts, chip, first_core_dts0);
 
     g_assert_cmphex(dts0, ==, 0x26f024f023f0000ull);
 }
@@ -113,11 +114,11 @@ static void test_xscom_core(const PnvChip *chip)
 static void test_core(const void *data)
 {
     const PnvChip *chip = data;
+    QTestState *qts;
 
-    global_qtest = qtest_initf("-M powernv,accel=tcg -cpu %s",
-                               chip->cpu_model);
-    test_xscom_core(chip);
-    qtest_quit(global_qtest);
+    qts = qtest_initf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    test_xscom_core(qts, chip);
+    qtest_quit(qts);
 }
 
 static void add_test(const char *name, void (*test)(const void *data))
-- 
1.8.3.1
