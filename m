Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4i-0004aX-S6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4h-0002yc-UN
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:32 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4h-0002xp-PM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:31 -0400
Received: by mail-qk0-x244.google.com with SMTP id h19so26472026qkj.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:52 -0300
Message-Id: <20180509034658.26455-9-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/14] sdcard: Extract
 sd_frame48_verify_checksum() out for qtesting
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
 hw/sd/sd.c             |  2 +-
 hw/sd/sdmmc-internal.c |  6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index c854ed6a14..752d8edd6c 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -150,6 +150,16 @@ uint8_t sd_frame48_calc_checksum(const void *content);
  */
 uint8_t sd_frame136_calc_checksum(const void *content);
 
+/**
+ * sd_frame48_verify_checksum:
+ * @content: pointer to the frame content
+ *
+ * Verify the 7-bit CRC checksum of a 48-bit SD frame.
+ *
+ * Returns: A boolean indicating whether the frame 7-bit CRC is correct.
+ */
+bool sd_frame48_verify_checksum(const void *content);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6fc8daa5b8..125707a65c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -473,7 +473,7 @@ static bool sd_req_crc_is_valid(SDRequest *req)
     buffer[0] = 0x40 | req->cmd;
     stl_be_p(&buffer[1], req->arg);
     return true;
-    return sd_frame48_calc_checksum(buffer) == req->crc; /* TODO */
+    return sd_frame48_verify_checksum(buffer); /* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index a94d65b756..a9d19ce3eb 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -105,3 +105,9 @@ uint8_t sd_frame136_calc_checksum(const void *content)
 {
     return (sd_crc7(content, F136_CONTENT_LENGTH) << 1) | 1;
 }
+
+bool sd_frame48_verify_checksum(const void *content)
+{
+    return sd_frame48_calc_checksum(content)
+           == ((const uint8_t *)content)[F48_CONTENT_LENGTH];
+}
-- 
2.17.0
