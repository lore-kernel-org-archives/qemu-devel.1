Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8E-0003Ne-B8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8D-0001sE-Kw
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8D-0001s4-H6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:25 -0400
Received: by mail-qk0-x241.google.com with SMTP id s70so16972874qks.13
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:18 -0300
Message-Id: <20180504155918.21287-21-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/20] sdcard: Add
 test_sd_verify_cksum_frame48() qtest
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
 tests/sdcard-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index c51e8095b6..fa45188e48 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -47,6 +47,8 @@ static void test_sd_request_frame_crc7(void)
     /* CMD2 ALL_SEND_CID */
     sd_prepare_request48(&frame, 2, 0);
     g_assert_cmphex(frame.crc, ==, 0x4d >> 1);
+
+    g_assert_true(sd_verify_frame48_checksum(&frame, false));
 }
 
 static void test_sd_response_frame48_crc7(void)
@@ -64,6 +66,8 @@ static void test_sd_response_frame48_crc7(void)
     /* response to CMD3 SEND_RELATIVE_ADDR (Relative Card Address is 0xb368) */
     sd_prepare_response48(&frame, 3, 0xb3680500);
     g_assert_cmphex(frame.crc, ==, 0x0c);
+
+    g_assert_true(sd_verify_frame48_checksum(&frame, true));
 }
 
 static void test_sd_response_frame136_crc7(void)
@@ -87,6 +91,17 @@ static void test_sd_data_frame_crc16(void)
     g_assert_cmphex(frame.crc, ==, 0x7fa1);
 }
 
+static void test_sd_verify_cksum_frame48(void)
+{
+    SDFrame48 frame;
+
+    sd_prepare_request48(&frame, 42, 0x12345678);
+    g_assert_true(sd_verify_frame48_checksum(&frame, false));
+
+    sd_prepare_response48(&frame, 69, 0x98765432);
+    g_assert_true(sd_verify_frame48_checksum(&frame, true));
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -95,6 +110,7 @@ int main(int argc, char *argv[])
     qtest_add_func("sd/resp48_crc7", test_sd_response_frame48_crc7);
     qtest_add_func("sd/resp136_crc7", test_sd_response_frame136_crc7);
     qtest_add_func("sd/data_crc16", test_sd_data_frame_crc16);
+    qtest_add_func("sd/verify_cksum_frame48", test_sd_verify_cksum_frame48);
 
     return g_test_run();
 }
-- 
2.17.0
