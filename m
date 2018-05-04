Received: from eggs.gnu.org ([2001:4830:134:3::10]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8B-0003LK-KK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8A-0001re-Tt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8A-0001rY-Pi
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:22 -0400
Received: by mail-qt0-x242.google.com with SMTP id f1-v6so27975297qtj.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:17 -0300
Message-Id: <20180504155918.21287-20-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/20] sdcard: Add test_sd_data_frame_crc16()
 qtest
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
 tests/sdcard-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index efcfbfc033..c51e8095b6 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -78,6 +78,15 @@ static void test_sd_response_frame136_crc7(void)
     g_assert_cmphex(frame.crc, ==, 0xad);
 }
 
+static void test_sd_data_frame_crc16(void)
+{
+    SDFrameData frame;
+
+    memset(frame.content, 0xff, sizeof(frame.content));
+    sd_update_framedata_checksum(&frame);
+    g_assert_cmphex(frame.crc, ==, 0x7fa1);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -85,6 +94,7 @@ int main(int argc, char *argv[])
     qtest_add_func("sd/req_crc7", test_sd_request_frame_crc7);
     qtest_add_func("sd/resp48_crc7", test_sd_response_frame48_crc7);
     qtest_add_func("sd/resp136_crc7", test_sd_response_frame136_crc7);
+    qtest_add_func("sd/data_crc16", test_sd_data_frame_crc16);
 
     return g_test_run();
 }
-- 
2.17.0
