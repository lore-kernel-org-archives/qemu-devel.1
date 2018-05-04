Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7l-0002oq-V6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7j-0001cf-CE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:58 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7j-0001cX-7O
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:55 -0400
Received: by mail-qt0-x241.google.com with SMTP id f1-v6so27973161qtj.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:07 -0300
Message-Id: <20180504155918.21287-10-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/20] sdcard: Expose sd_crc*() functions for
 QTest use
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
 hw/sd/sdmmc-internal.h | 22 ++++++++++++++++++++++
 hw/sd/sd.c             | 37 -------------------------------------
 hw/sd/sdmmc-internal.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 9aa04766fc..62c0ff250d 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -36,4 +36,26 @@ const char *sd_cmd_name(uint8_t cmd);
  */
 const char *sd_acmd_name(uint8_t cmd);
 
+/**
+ * sd_crc7:
+ * @data: pointer to the data buffer
+ * @data_len: data length
+ *
+ * Calculate the 7-bit CRC of a SD frame.
+ *
+ * Returns: The frame CRC.
+ */
+uint8_t sd_crc7(const void *data, size_t data_len);
+
+/**
+ * sd_crc16:
+ * @data: pointer to the data buffer
+ * @data_len: data length
+ *
+ * Calculate the 16-bit CRC of a SD data frame.
+ *
+ * Returns: The frame CRC.
+ */
+uint16_t sd_crc16(const void *data, size_t data_len);
+
 #endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a28ef8de5e..11b4606051 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,43 +237,6 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
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
-static uint16_t sd_crc16(const void *message, size_t width)
-{
-    int i, bit;
-    uint16_t shift_reg = 0x0000;
-    const uint16_t *msg = (const uint16_t *)message;
-    width <<= 1;
-
-    for (i = 0; i < width; i++, msg++) {
-        for (bit = 15; bit >= 0; bit--) {
-            shift_reg <<= 1;
-            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1)) {
-                shift_reg ^= 0x1011;
-            }
-        }
-    }
-
-    return shift_reg;
-}
-
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 2053def3f1..69ad0a99e6 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -70,3 +70,41 @@ const char *sd_acmd_name(uint8_t cmd)
 
     return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
 }
+
+/* 7 bit CRC with polynomial x^7 + x^3 + 1 */
+uint8_t sd_crc7(const void *message, size_t width)
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
+uint16_t sd_crc16(const void *message, size_t width)
+{
+    int i, bit;
+    uint16_t shift_reg = 0x0000;
+    const uint16_t *msg = (const uint16_t *)message;
+    width <<= 1;
+
+    for (i = 0; i < width; i++, msg++) {
+        for (bit = 15; bit >= 0; bit--) {
+            shift_reg <<= 1;
+            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1)) {
+                shift_reg ^= 0x1011;
+            }
+        }
+    }
+
+    return shift_reg;
+}
-- 
2.17.0
