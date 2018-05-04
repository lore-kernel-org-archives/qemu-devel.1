Received: from eggs.gnu.org ([2001:4830:134:3::10]:55198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd83-0003Dp-U2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd83-0001oE-6c
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:16 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd83-0001o5-2w
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id p186so16986223qkd.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:14 -0300
Message-Id: <20180504155918.21287-17-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/20] sdcard: Add
 test_sd_response_frame136_crc7() qtest
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
 tests/sdcard-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index 2de0a5a0ee..efcfbfc033 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -66,12 +66,25 @@ static void test_sd_response_frame48_crc7(void)
     g_assert_cmphex(frame.crc, ==, 0x0c);
 }
 
+static void test_sd_response_frame136_crc7(void)
+{
+    SDFrame136 frame;
+
+    /* response to CMD2 ALL_SEND_CID */
+    memcpy(&frame.content,
+           "\x1d\x41\x44\x53\x44\x20\x20\x20\x10\xa0\x40\x0b\xc1\x00\x88",
+           sizeof(frame.content));
+    sd_update_frame136_checksum(&frame);
+    g_assert_cmphex(frame.crc, ==, 0xad);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("sd/req_crc7", test_sd_request_frame_crc7);
     qtest_add_func("sd/resp48_crc7", test_sd_response_frame48_crc7);
+    qtest_add_func("sd/resp136_crc7", test_sd_response_frame136_crc7);
 
     return g_test_run();
 }
-- 
2.17.0
