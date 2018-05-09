Received: from eggs.gnu.org ([2001:4830:134:3::10]:58546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4l-0004cu-SF
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4k-00033k-TL
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:35 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4k-00032c-Nl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:34 -0400
Received: by mail-qk0-x242.google.com with SMTP id d74so26465926qkg.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:53 -0300
Message-Id: <20180509034658.26455-10-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/14] sdcard: Add
 sd_frame136_verify_checksum()
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
 include/hw/sd/sd.h     | 10 ++++++++++
 hw/sd/sdmmc-internal.c |  6 ++++++
 tests/sdcard-test.c    | 12 ++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 752d8edd6c..83399cd42d 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -160,6 +160,16 @@ uint8_t sd_frame136_calc_checksum(const void *content);
  */
 bool sd_frame48_verify_checksum(const void *content);
 
+/**
+ * sd_frame136_verify_checksum:
+ * @content: pointer to the frame content
+ *
+ * Verify the 7-bit CRC checksum of a 136-bit SD frame.
+ *
+ * Returns: A boolean indicating whether the frame 7-bit CRC is correct.
+ */
+bool sd_frame136_verify_checksum(const void *content);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index a9d19ce3eb..f709211401 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -111,3 +111,9 @@ bool sd_frame48_verify_checksum(const void *content)
     return sd_frame48_calc_checksum(content)
            == ((const uint8_t *)content)[F48_CONTENT_LENGTH];
 }
+
+bool sd_frame136_verify_checksum(const void *content)
+{
+    return sd_frame136_calc_checksum(content)
+           == ((const uint8_t *)content)[F136_CONTENT_LENGTH];
+}
diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
index c59af28382..81789d1f88 100644
--- a/tests/sdcard-test.c
+++ b/tests/sdcard-test.c
@@ -23,6 +23,17 @@ static void test_sd_response_frame136_crc7(void)
            sizeof(buf));
     buf[15] = sd_frame136_calc_checksum(buf);
     g_assert_cmphex(buf[15], ==, 0xad);
+
+    g_assert_true(sd_frame136_verify_checksum(buf));
+}
+
+static void test_sd_verify_cksum_frame136(void)
+{
+    uint8_t buf[16];
+
+    memset(buf, 69, sizeof(buf));
+    buf[15] = sd_frame136_calc_checksum(buf);
+    g_assert_true(sd_frame136_verify_checksum(buf));
 }
 
 int main(int argc, char *argv[])
@@ -30,6 +41,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("sd/prepare_resp136_crc7", test_sd_response_frame136_crc7);
+    qtest_add_func("sd/verify_cksum_frame136", test_sd_verify_cksum_frame136);
 
     return g_test_run();
 }
-- 
2.17.0
