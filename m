Received: from eggs.gnu.org ([2001:4830:134:3::10]:55243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd8A-0003Ih-7B
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd85-0001pf-D9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:22 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd85-0001pZ-9O
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:17 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so27971016qtn.3
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:15 -0300
Message-Id: <20180504155918.21287-18-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/20] sdcard: Add SDFrameData struct and data
 frame checksum functions
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

The block transfers data frames are upto 512 bytes and use a 16-bit CRC.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h     | 29 +++++++++++++++++++++++++++++
 hw/sd/sdmmc-internal.c | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index c76be51b32..6bf9daf559 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -102,6 +102,17 @@ typedef struct SDFrame136 {
     uint8_t crc;
 } SDFrame136;
 
+/**
+ * SDFrameData: 512 bytes block transfers
+ *
+ * @content: block data
+ * @crc:     16-bit CRC checksum
+ */
+typedef struct SDFrameData {
+    uint8_t content[512];
+    uint16_t crc;
+} SDFrameData;
+
 typedef struct SDFrame48 SDRequest;
 
 typedef struct SDState SDState;
@@ -212,6 +223,14 @@ void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response);
  */
 void sd_update_frame136_checksum(SDFrame136 *frame);
 
+/**
+ * sd_update_framedata_checksum:
+ * @frame: the #SDFrameData to verify
+ *
+ * Update the 16-bit CRC checksum of a SD data frame (up to 512 bytes).
+ */
+void sd_update_framedata_checksum(SDFrameData *frame);
+
 /**
  * sd_verify_frame48_checksum:
  * @frame: the #SDFrame48 to verify
@@ -233,6 +252,16 @@ bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response);
  */
 bool sd_verify_frame136_checksum(SDFrame136 *frame);
 
+/**
+ * sd_verify_framedata_checksum:
+ * @frame: the #SDFrameData to verify
+ *
+ * Verify the 16-bit CRC checksum of a SD data frame.
+ *
+ * Returns: A boolean indicating whether the frame 16-bit CRC is correct.
+ */
+bool sd_verify_framedata_checksum(SDFrameData *frame);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 68350a2304..0e82e69d99 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -134,6 +134,11 @@ bool sd_verify_frame136_checksum(SDFrame136 *frame)
     return sd_calc_frame136_crc7(frame) == frame->crc;
 }
 
+bool sd_verify_framedata_checksum(SDFrameData *frame)
+{
+    return sd_crc16(frame->content, sizeof(frame->content)) == frame->crc;
+}
+
 void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response)
 {
     frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
@@ -144,6 +149,11 @@ void sd_update_frame136_checksum(SDFrame136 *frame)
     frame->crc = (sd_crc7(frame->content, sizeof(frame->content)) << 1) | 1;
 }
 
+void sd_update_framedata_checksum(SDFrameData *frame)
+{
+    frame->crc = sd_crc16(frame->content, sizeof(frame->content));
+}
+
 void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
                         bool is_response, bool gen_crc)
 {
-- 
2.17.0
