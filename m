Received: from eggs.gnu.org ([2001:4830:134:3::10]:55211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd85-0003F5-K2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7z-0001mT-Uv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:17 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:39600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7z-0001m3-Q4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:11 -0400
Received: by mail-qk0-x243.google.com with SMTP id z75so16983317qkb.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:13 -0300
Message-Id: <20180504155918.21287-16-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/20] sdcard: Add SDFrame136 struct and
 136-bit SD response frames functions
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

The 'read CID/CSD register' request returns a 136-bit frame
containing those 128-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h     | 29 +++++++++++++++++++++++++++++
 hw/sd/sdmmc-internal.c | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 13de1b30c3..c76be51b32 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -91,6 +91,17 @@ typedef struct SDFrame48 {
     uint8_t crc;
 } SDFrame48;
 
+/**
+ * SDFrame136: 136 bits CID or CSD responses
+ *
+ * @content: CID or CSD register
+ * @crc:     7-bit CRC checksum
+ */
+typedef struct SDFrame136 {
+    uint8_t content[15];
+    uint8_t crc;
+} SDFrame136;
+
 typedef struct SDFrame48 SDRequest;
 
 typedef struct SDState SDState;
@@ -193,6 +204,14 @@ void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
  */
 void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response);
 
+/**
+ * sd_update_frame136_checksum:
+ * @frame: the #SDFrame136 to verify
+ *
+ * Update the 16-bit CRC checksum of a SD 136-bit frame.
+ */
+void sd_update_frame136_checksum(SDFrame136 *frame);
+
 /**
  * sd_verify_frame48_checksum:
  * @frame: the #SDFrame48 to verify
@@ -204,6 +223,16 @@ void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response);
  */
 bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response);
 
+/**
+ * sd_verify_frame136_checksum:
+ * @frame: the #SDFrame48 to verify
+ *
+ * Verify the 16-bit CRC checksum of a SD 136-bit frame.
+ *
+ * Returns: A boolean indicating whether the frame 16-bit CRC is correct.
+ */
+bool sd_verify_frame136_checksum(SDFrame136 *frame);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index c990cc9e8e..68350a2304 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -117,6 +117,11 @@ static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg, bool is_response)
     return sd_crc7(buffer, sizeof(buffer));
 }
 
+static uint8_t sd_calc_frame136_crc7(SDFrame136 *frame)
+{
+    return (sd_crc7(frame->content, sizeof(frame->content)) << 1) | 1;
+}
+
 bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response)
 {
     uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
@@ -124,11 +129,21 @@ bool sd_verify_frame48_checksum(SDFrame48 *frame, bool is_response)
     return crc == frame->crc;
 }
 
+bool sd_verify_frame136_checksum(SDFrame136 *frame)
+{
+    return sd_calc_frame136_crc7(frame) == frame->crc;
+}
+
 void sd_update_frame48_checksum(SDFrame48 *frame, bool is_response)
 {
     frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg, is_response);
 }
 
+void sd_update_frame136_checksum(SDFrame136 *frame)
+{
+    frame->crc = (sd_crc7(frame->content, sizeof(frame->content)) << 1) | 1;
+}
+
 void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
                         bool is_response, bool gen_crc)
 {
-- 
2.17.0
