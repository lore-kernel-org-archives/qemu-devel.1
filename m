Received: from eggs.gnu.org ([2001:4830:134:3::10]:58481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4Z-0004SU-NB
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4Y-0002fr-LE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4Y-0002eo-Fl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:22 -0400
Received: by mail-qt0-x242.google.com with SMTP id j42-v6so43940189qtj.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:49 -0300
Message-Id: <20180509034658.26455-6-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/14] sdcard: Move sd_crc7() and
 calc_checksum() out for qtesting
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

Move the calc_checksum() functions out so we will able to write
qtests for them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h     | 20 ++++++++++++++++++++
 hw/sd/sd.c             | 33 ---------------------------------
 hw/sd/sdmmc-internal.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 9bdb3c9285..c854ed6a14 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -130,6 +130,26 @@ typedef struct {
     void (*set_readonly)(DeviceState *dev, bool readonly);
 } SDBusClass;
 
+/**
+ * sd_frame48_calc_checksum:
+ * @content: pointer to the frame content
+ *
+ * Calculate the 7-bit CRC of a 48-bit SD frame.
+ *
+ * Returns: The frame CRC.
+ */
+uint8_t sd_frame48_calc_checksum(const void *content);
+
+/**
+ * sd_frame136_calc_checksum:
+ * @content: pointer to the frame content
+ *
+ * Calculate the 7-bit CRC of a 136-bit SD frame.
+ *
+ * Returns: The frame CRC.
+ */
+uint8_t sd_frame136_calc_checksum(const void *content);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 06607115a7..d8dad94fc4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -236,24 +236,6 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
 };
 
-static uint8_t sd_crc7(const void *message, size_t width)
-{
-    int i, bit;
-    uint8_t shift_reg = 0x00;
-    const uint8_t *msg = (const uint8_t *)message;
-
-    for (i = 0; i < width; i++, msg++) {
-        for (bit = 7; bit >= 0; bit--) {
-            shift_reg <<= 1;
-            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1)) {
-                shift_reg ^= 0x89;
-            }
-        }
-    }
-
-    return shift_reg;
-}
-
 static uint16_t sd_crc16(const void *message, size_t width)
 {
     int i, bit;
@@ -273,21 +255,6 @@ static uint16_t sd_crc16(const void *message, size_t width)
     return shift_reg;
 }
 
-enum {
-    F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
-    F136_CONTENT_LENGTH = 15,
-};
-
-static uint8_t sd_frame48_calc_checksum(const void *content)
-{
-    return sd_crc7(content, F48_CONTENT_LENGTH);
-}
-
-static uint8_t sd_frame136_calc_checksum(const void *content)
-{
-    return (sd_crc7(content, F136_CONTENT_LENGTH) << 1) | 1;
-}
-
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 2053def3f1..a94d65b756 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/sd/sd.h"
 #include "sdmmc-internal.h"
 
 const char *sd_cmd_name(uint8_t cmd)
@@ -70,3 +71,37 @@ const char *sd_acmd_name(uint8_t cmd)
 
     return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
 }
+
+/* 7 bit CRC with polynomial x^7 + x^3 + 1 */
+static uint8_t sd_crc7(const void *message, size_t width)
+{
+    int i, bit;
+    uint8_t shift_reg = 0x00;
+    const uint8_t *msg = (const uint8_t *)message;
+
+    for (i = 0; i < width; i++, msg++) {
+        for (bit = 7; bit >= 0; bit--) {
+            shift_reg <<= 1;
+            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1)) {
+                shift_reg ^= 0x89;
+            }
+        }
+    }
+
+    return shift_reg;
+}
+
+enum {
+    F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
+    F136_CONTENT_LENGTH = 15,
+};
+
+uint8_t sd_frame48_calc_checksum(const void *content)
+{
+    return sd_crc7(content, F48_CONTENT_LENGTH);
+}
+
+uint8_t sd_frame136_calc_checksum(const void *content)
+{
+    return (sd_crc7(content, F136_CONTENT_LENGTH) << 1) | 1;
+}
-- 
2.17.0
