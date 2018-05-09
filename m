Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4y-0004nl-Uv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4v-0003Lo-RX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4v-0003LA-Mk
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:45 -0400
Received: by mail-qt0-x243.google.com with SMTP id m9-v6so23222198qtb.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:56 -0300
Message-Id: <20180509034658.26455-13-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/14] sdcard: Add tests to validate the
 7-bit CRC checksum of 48-bit SD frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdcard-test.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index 81789d1f88..2288a05cdf 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -14,6 +14,66 @@
 #include "libqtest.h"
 #include "hw/sd/sd.h"
 
+static void sd_prepare_request48(uint8_t *buf, size_t bufsize,
+                                 uint8_t cmd, uint32_t arg)
+{
+    sd_frame48_init(buf, bufsize, cmd, arg, /* is_resp */ false);
+    buf[5] = sd_frame48_calc_checksum(buf);
+}
+
+static void sd_prepare_response48(uint8_t *buf, size_t bufsize,
+                                  uint8_t cmd, uint32_t arg)
+{
+    sd_frame48_init(buf, bufsize, cmd, arg, /* is_resp */ true);
+    buf[5] = sd_frame48_calc_checksum(buf);
+}
+
+static void test_sd_request_frame_crc7(void)
+{
+    uint8_t req[6];
+
+    /* CMD0 */
+    sd_prepare_request48(req, sizeof(req), 0, 0);
+    g_assert_cmphex(req[5], ==, 0b1001010);
+
+    /* CMD17 */
+    sd_prepare_request48(req, sizeof(req), 17, 0);
+    g_assert_cmphex(req[5], ==, 0b0101010);
+
+    /* APP_CMD */
+    sd_prepare_request48(req, sizeof(req), 55, 0);
+    g_assert_cmphex(req[5], ==, 0x32);
+
+    /* ACMD41 SEND_OP_COND */
+    sd_prepare_request48(req, sizeof(req), 41, 0x00100000);
+    g_assert_cmphex(req[5], ==, 0x5f >> 1);
+
+    /* CMD2 ALL_SEND_CID */
+    sd_prepare_request48(req, sizeof(req), 2, 0);
+    g_assert_cmphex(req[5], ==, 0x4d >> 1);
+
+    g_assert_true(sd_frame48_verify_checksum(req));
+}
+
+static void test_sd_response_frame48_crc7(void)
+{
+    uint8_t resp[6];
+
+    /* response to CMD17 */
+    sd_prepare_response48(resp, sizeof(resp), 17, 0x00000900);
+    g_assert_cmphex(resp[5], ==, 0b0110011);
+
+    /* response to the APP_CMD */
+    sd_prepare_response48(resp, sizeof(resp), 55, 0x00000120);
+    g_assert_cmphex(resp[5], ==, 0x41);
+
+    /* response to CMD3 SEND_RELATIVE_ADDR (Relative Card Address is 0xb368) */
+    sd_prepare_response48(resp, sizeof(resp), 3, 0xb3680500);
+    g_assert_cmphex(resp[5], ==, 0x0c);
+
+    g_assert_true(sd_frame48_verify_checksum(resp));
+}
+
 static void test_sd_response_frame136_crc7(void)
 {
     uint8_t buf[16];
@@ -27,6 +87,17 @@ static void test_sd_response_frame136_crc7(void)
     g_assert_true(sd_frame136_verify_checksum(buf));
 }
 
+static void test_sd_verify_cksum_frame48(void)
+{
+    uint8_t buf[6];
+
+    sd_prepare_request48(buf, sizeof(buf), 42, 0x12345678);
+    g_assert_true(sd_frame48_verify_checksum(buf));
+
+    sd_prepare_response48(buf, sizeof(buf), 69, 0x98765432);
+    g_assert_true(sd_frame48_verify_checksum(buf));
+}
+
 static void test_sd_verify_cksum_frame136(void)
 {
     uint8_t buf[16];
@@ -40,7 +111,10 @@ int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
 
+    qtest_add_func("sd/prepare_req_crc7", test_sd_request_frame_crc7);
+    qtest_add_func("sd/prepare_resp48_crc7", test_sd_response_frame48_crc7);
     qtest_add_func("sd/prepare_resp136_crc7", test_sd_response_frame136_crc7);
+    qtest_add_func("sd/verify_cksum_frame48", test_sd_verify_cksum_frame48);
     qtest_add_func("sd/verify_cksum_frame136", test_sd_verify_cksum_frame136);
 
     return g_test_run();
-- 
2.17.0
