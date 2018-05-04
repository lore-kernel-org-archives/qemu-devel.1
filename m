Received: from eggs.gnu.org ([2001:4830:134:3::10]:55137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7x-00034O-PZ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7r-0001g9-S5
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:09 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7r-0001fW-Nx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:03 -0400
Received: by mail-qt0-x242.google.com with SMTP id m5-v6so27963671qti.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:10 -0300
Message-Id: <20180504155918.21287-13-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/20] sdcard: Let sd_frame48_crc7_calc() work
 on response frames
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

Currently sd_calc_frame48_crc7() only works for request frames, having
the bit 6 hardwire to 1.

Extend it to handle response frames, adding a 'is_response' boolean argument.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h     |  6 ++++--
 hw/sd/sd.c             |  2 +-
 hw/sd/sdmmc-internal.c | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b65107ffe1..b1f865fe20 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -171,20 +171,22 @@ void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
 /**
  * sd_update_frame48_checksum:
  * @frame: the #SDFrame48 to verify
+ * @is_response: whether the frame is a command request or response
  *
  * Update the 7-bit CRC checksum of a SD 48-bit frame.
  */
-void sd_update_frame48_checksum(SDFrame48 *frame);
+void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response);
 
 /**
  * sd_verify_frame48_checksum:
  * @frame: the #SDFrame48 to verify
+ * @is_response: whether the frame is a command request or response
  *
  * Verify the 7-bit CRC checksum of a SD 48-bit frame.
  *
  * Returns: A boolean indicating whether the frame 7-bit CRC is correct.
  */
-bool sd_verify_frame48_checksum(SDFrame48 *frame);
+bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response);
 
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2d2c31d308..5e0b5c2b87 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -452,7 +452,7 @@ static void sd_set_sdstatus(SDState *sd)
 static bool sd_req_crc_validate(SDState *sd, SDRequest *req)
 {
     if (sd->validate_crc) {
-        return sd_verify_frame48_checksum(req);
+        return sd_verify_frame48_checksum(req, false);
     }
     return true;
 }
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 97f5f71569..04da81e665 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -109,45 +109,45 @@ uint16_t sd_crc16(const void *message, size_t width)
     return shift_reg;
 }
 
-static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg)
+static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg, bool is_response)
 {
     uint8_t buffer[5];
-    buffer[0] = 0x40 | cmd;
+    buffer[0] = (!is_response << 6) | cmd;
     stl_be_p(&buffer[1], arg);
     return sd_crc7(buffer, sizeof(buffer));
 }
 
-bool sd_verify_frame48_checksum(SDFrame48 *frame)
+bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response)
 {
-    uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
+    uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
 
     return crc == frame->crc;
 }
 
-void sd_update_frame48_checksum(SDFrame48 *frame)
+void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response)
 {
-    frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
+    frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
 }
 
 static void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
-                               bool gen_crc)
+                               bool is_response, bool gen_crc)
 {
     frame->cmd = cmd;
     frame->arg = arg;
     frame->crc = 0x00;
     if (gen_crc) {
-        sd_update_frame48_checksum(frame);
+        sd_update_frame48_checksum(frame, is_response);
     }
 }
 
 void sd_prepare_request(SDFrame48 *req, uint8_t cmd, uint32_t arg, bool gen_crc)
 {
-    sd_prepare_frame48(req, cmd, arg, gen_crc);
+    sd_prepare_frame48(req, cmd, arg, /* is_response */ false, gen_crc);
 }
 
 void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
                                  uint8_t crc)
 {
-    sd_prepare_frame48(req, cmd, arg, /* gen_crc */ false);
+    sd_prepare_request(req, cmd, arg, /* gen_crc */ false);
     req->crc = crc;
 }
-- 
2.17.0
