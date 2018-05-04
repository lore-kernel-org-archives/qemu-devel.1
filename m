Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd83-0003DJ-AA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7x-0001iO-5Z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:15 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7x-0001i2-22
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:09 -0400
Received: by mail-qt0-x244.google.com with SMTP id m5-v6so27964114qti.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:12 -0300
Message-Id: <20180504155918.21287-15-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/20] sdcard: Add
 test_sd_response_frame48_crc7 qtest (command response CRC7)
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
 tests/sdcard-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index 1358ee28c6..2de0a5a0ee 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -19,6 +19,11 @@ static void sd_prepare_request48(SDFrame48 *frame, uint8_t cmd, uint32_t arg)
     sd_prepare_request(frame, cmd, arg, /* gen_crc */ true);
 }
 
+static void sd_prepare_response48(SDFrame48 *frame, uint8_t cmd, uint32_t arg)
+{
+    sd_prepare_frame48(frame, cmd, arg, /* is_resp */ true, /* gen_crc */ true);
+}
+
 static void test_sd_request_frame_crc7(void)
 {
     SDFrame48 frame;
@@ -44,11 +49,29 @@ static void test_sd_request_frame_crc7(void)
     g_assert_cmphex(frame.crc, ==, 0x4d >> 1);
 }
 
+static void test_sd_response_frame48_crc7(void)
+{
+    SDFrame48 frame;
+
+    /* response to CMD17 */
+    sd_prepare_response48(&frame, 17, 0x00000900);
+    g_assert_cmphex(frame.crc, ==, 0b0110011);
+
+    /* response to the APP_CMD */
+    sd_prepare_response48(&frame, 55, 0x00000120);
+    g_assert_cmphex(frame.crc, ==, 0x41);
+
+    /* response to CMD3 SEND_RELATIVE_ADDR (Relative Card Address is 0xb368) */
+    sd_prepare_response48(&frame, 3, 0xb3680500);
+    g_assert_cmphex(frame.crc, ==, 0x0c);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("sd/req_crc7", test_sd_request_frame_crc7);
+    qtest_add_func("sd/resp48_crc7", test_sd_response_frame48_crc7);
 
     return g_test_run();
 }
-- 
2.17.0
