Received: from eggs.gnu.org ([2001:4830:134:3::10]:55069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7n-0002rK-PO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7m-0001dZ-Fa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7m-0001dN-9l
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:58 -0400
Received: by mail-qk0-x243.google.com with SMTP id p186so16985379qkd.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:08 -0300
Message-Id: <20180504155918.21287-11-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/20] sdcard: Expose sd_prepare_request*()
 functions for QTest use
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

Take those functions out of hw/sd/sd.c (via "sdmmc-internal.h")
to be able to write QTests for them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdmmc-internal.h |  2 ++
 include/hw/sd/sd.h     | 18 ++++++++++++++++++
 hw/sd/sd.c             | 43 ------------------------------------------
 hw/sd/sdmmc-internal.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 43 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 62c0ff250d..d672112200 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -10,6 +10,8 @@
 #ifndef SD_INTERNAL_H
 #define SD_INTERNAL_H
 
+#include "hw/sd/sd.h"
+
 #define SDMMC_CMD_MAX 64
 
 /**
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 7d9c906897..b65107ffe1 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -168,6 +168,24 @@ void sd_prepare_request(SDRequest *req, uint8_t cmd, uint32_t arg,
 void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
                                  uint8_t crc);
 
+/**
+ * sd_update_frame48_checksum:
+ * @frame: the #SDFrame48 to verify
+ *
+ * Update the 7-bit CRC checksum of a SD 48-bit frame.
+ */
+void sd_update_frame48_checksum(SDFrame48 *frame);
+
+/**
+ * sd_verify_frame48_checksum:
+ * @frame: the #SDFrame48 to verify
+ *
+ * Verify the 7-bit CRC checksum of a SD 48-bit frame.
+ *
+ * Returns: A boolean indicating whether the frame 7-bit CRC is correct.
+ */
+bool sd_verify_frame48_checksum(SDFrame48 *frame);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 11b4606051..2d2c31d308 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -449,21 +449,6 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
-static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg)
-{
-    uint8_t buffer[5];
-    buffer[0] = 0x40 | cmd;
-    stl_be_p(&buffer[1], arg);
-    return sd_crc7(buffer, sizeof(buffer));
-}
-
-static bool sd_verify_frame48_checksum(SDFrame48 *frame)
-{
-    uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
-
-    return crc == frame->crc;
-}
-
 static bool sd_req_crc_validate(SDState *sd, SDRequest *req)
 {
     if (sd->validate_crc) {
@@ -472,34 +457,6 @@ static bool sd_req_crc_validate(SDState *sd, SDRequest *req)
     return true;
 }
 
-static void sd_update_frame48_checksum(SDFrame48 *frame)
-{
-    frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
-}
-
-static void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
-                               bool gen_crc)
-{
-    frame->cmd = cmd;
-    frame->arg = arg;
-    frame->crc = 0x00;
-    if (gen_crc) {
-        sd_update_frame48_checksum(frame);
-    }
-}
-
-void sd_prepare_request(SDFrame48 *req, uint8_t cmd, uint32_t arg, bool gen_crc)
-{
-    sd_prepare_frame48(req, cmd, arg, gen_crc);
-}
-
-void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
-                                 uint8_t crc)
-{
-    sd_prepare_frame48(req, cmd, arg, /* gen_crc */ false);
-    req->crc = crc;
-}
-
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
 {
     stl_be_p(response, sd->card_status);
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 69ad0a99e6..97f5f71569 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -108,3 +108,46 @@ uint16_t sd_crc16(const void *message, size_t width)
 
     return shift_reg;
 }
+
+static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg)
+{
+    uint8_t buffer[5];
+    buffer[0] = 0x40 | cmd;
+    stl_be_p(&buffer[1], arg);
+    return sd_crc7(buffer, sizeof(buffer));
+}
+
+bool sd_verify_frame48_checksum(SDFrame48 *frame)
+{
+    uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
+
+    return crc == frame->crc;
+}
+
+void sd_update_frame48_checksum(SDFrame48 *frame)
+{
+    frame->crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
+}
+
+static void sd_prepare_frame48(SDFrame48 *frame, uint8_t cmd, uint32_t arg,
+                               bool gen_crc)
+{
+    frame->cmd = cmd;
+    frame->arg = arg;
+    frame->crc = 0x00;
+    if (gen_crc) {
+        sd_update_frame48_checksum(frame);
+    }
+}
+
+void sd_prepare_request(SDFrame48 *req, uint8_t cmd, uint32_t arg, bool gen_crc)
+{
+    sd_prepare_frame48(req, cmd, arg, gen_crc);
+}
+
+void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
+                                 uint8_t crc)
+{
+    sd_prepare_frame48(req, cmd, arg, /* gen_crc */ false);
+    req->crc = crc;
+}
-- 
2.17.0
