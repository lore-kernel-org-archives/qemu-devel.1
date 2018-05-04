Received: from eggs.gnu.org ([2001:4830:134:3::10]:54888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7U-0002VN-M8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7T-0001TL-MX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:40 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7T-0001TD-I7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:39 -0400
Received: by mail-qt0-x241.google.com with SMTP id h2-v6so27972701qtp.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:02 -0300
Message-Id: <20180504155918.21287-5-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/20] sdcard: Add
 sd_prepare_request[_with_crc]()
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

The sd_prepare_request*() functions fill all the request frame members.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h | 27 +++++++++++++++++++++++++++
 hw/sd/sd.c         | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index f0b41232f7..7d9c906897 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -141,6 +141,33 @@ typedef struct {
     void (*set_readonly)(DeviceState *dev, bool readonly);
 } SDBusClass;
 
+/**
+ * sd_prepare_request:
+ * @req: the #SDRequest to be filled
+ * @cmd: the SD command
+ * @arg: the SD command argument
+ * @gen_crc: generates the frame CRC7 if true, else fill with zeroes
+ *
+ * Initialize a SD request buffer.
+ *
+ * If @gen_crc the frame checksum will be calculated
+ * and filled in the request buffer.
+ */
+void sd_prepare_request(SDRequest *req, uint8_t cmd, uint32_t arg,
+                        bool gen_crc);
+
+/**
+ * sd_prepare_request_with_crc:
+ * @req: the #SDRequest to be filled
+ * @cmd: the SD command
+ * @arg: the SD command argument
+ * @crc: the calculated request CRC7
+ *
+ * Initialize a SD request buffer.
+ */
+void sd_prepare_request_with_crc(SDRequest *req, uint8_t cmd, uint32_t arg,
+                                 uint8_t crc);
+
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *bs, bool is_spi);
 int sd_do_command(SDState *sd, SDRequest *req,
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 861bba197d..be75e118c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -489,10 +489,45 @@ static uint8_t sd_calc_frame48_crc7(uint8_t cmd, uint32_t arg)
     return sd_crc7(buffer, sizeof(buffer));
 }
 
+static bool sd_verify_frame48_checksum(SDFrame48 *frame)
+{
+    uint8_t crc = sd_calc_frame48_crc7(frame->cmd, frame->arg);
+
+    return crc == frame->crc;
+}
+
 static int sd_req_crc_validate(SDRequest *req)
 {
     return 0;
-    return sd_calc_frame48_crc7(req->cmd, req->arg) != req->crc; /* TODO */
+    return !sd_verify_frame48_checksum(req); /* TODO */
+}
+
+static void sd_update_frame48_checksum(SDFrame48 *frame)
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
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
-- 
2.17.0
