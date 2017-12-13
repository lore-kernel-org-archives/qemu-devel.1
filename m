Received: from eggs.gnu.org ([2001:4830:134:3::10]:60311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLb-0005DE-Ar
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLa-0007Et-5g
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:55 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLa-0007EX-10
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:54 -0500
Received: by mail-qk0-x242.google.com with SMTP id i130so4145715qke.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:21:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:02 -0300
Message-Id: <20171213232025.24503-4-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/26] sdcard: use ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

To keep the code way easier to review!

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 51 ++++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8e12b07ee4..9b3745a019 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -352,10 +352,7 @@ static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
     buffer[0] = 0x40 | req->cmd;
-    buffer[1] = (req->arg >> 24) & 0xff;
-    buffer[2] = (req->arg >> 16) & 0xff;
-    buffer[3] = (req->arg >> 8) & 0xff;
-    buffer[4] = (req->arg >> 0) & 0xff;
+    stl_be_p(buffer + 1, req->arg);
     return 0;
     return sd_crc7(buffer, 5) != req->crc;	/* TODO */
 }
@@ -365,19 +362,12 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
     uint32_t status = sd->card_status;
     /* Clear the "clear on read" status bits */
     sd->card_status &= ~CARD_STATUS_C;
-
-    response[0] = (status >> 24) & 0xff;
-    response[1] = (status >> 16) & 0xff;
-    response[2] = (status >> 8) & 0xff;
-    response[3] = (status >> 0) & 0xff;
+    stl_be_p(response, status);
 }
 
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
-    response[0] = (sd->ocr >> 24) & 0xff;
-    response[1] = (sd->ocr >> 16) & 0xff;
-    response[2] = (sd->ocr >> 8) & 0xff;
-    response[3] = (sd->ocr >> 0) & 0xff;
+    stl_be_p(response, sd->ocr);
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
@@ -390,19 +380,14 @@ static void sd_response_r6_make(SDState *sd, uint8_t *response)
              ((sd->card_status >> 6) & 0x2000) |
               (sd->card_status & 0x1fff);
     sd->card_status &= ~(CARD_STATUS_C & 0xc81fff);
+    stw_be_p(response + 0, arg);
+    stw_be_p(response + 2, status);
 
-    response[0] = (arg >> 8) & 0xff;
-    response[1] = arg & 0xff;
-    response[2] = (status >> 8) & 0xff;
-    response[3] = status & 0xff;
 }
 
 static void sd_response_r7_make(SDState *sd, uint8_t *response)
 {
-    response[0] = (sd->vhs >> 24) & 0xff;
-    response[1] = (sd->vhs >> 16) & 0xff;
-    response[2] = (sd->vhs >>  8) & 0xff;
-    response[3] = (sd->vhs >>  0) & 0xff;
+    stl_be_p(response, sd->vhs);
 }
 
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
@@ -644,20 +629,13 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     int i, mode, new_func, crc;
     mode = !!(arg & 0x80000000);
 
-    sd->data[0] = 0x00;		/* Maximum current consumption */
-    sd->data[1] = 0x01;
-    sd->data[2] = 0x80;		/* Supported group 6 functions */
-    sd->data[3] = 0x01;
-    sd->data[4] = 0x80;		/* Supported group 5 functions */
-    sd->data[5] = 0x01;
-    sd->data[6] = 0x80;		/* Supported group 4 functions */
-    sd->data[7] = 0x01;
-    sd->data[8] = 0x80;		/* Supported group 3 functions */
-    sd->data[9] = 0x01;
-    sd->data[10] = 0x80;	/* Supported group 2 functions */
-    sd->data[11] = 0x43;
-    sd->data[12] = 0x80;	/* Supported group 1 functions */
-    sd->data[13] = 0x03;
+    stw_be_p(sd->data +  0, 1);         /* Maximum current consumption */
+    stw_be_p(sd->data +  2, 0x8001);    /* Supported group 6 functions */
+    stw_be_p(sd->data +  4, 0x8001);    /* Supported group 5 functions */
+    stw_be_p(sd->data +  6, 0x8001);    /* Supported group 4 functions */
+    stw_be_p(sd->data +  8, 0x8001);    /* Supported group 3 functions */
+    stw_be_p(sd->data + 10, 0x8043);    /* Supported group 2 functions */
+    stw_be_p(sd->data + 12, 0x8003);    /* Supported group 1 functions */
     for (i = 0; i < 6; i ++) {
         new_func = (arg >> (i * 4)) & 0x0f;
         if (mode && new_func != 0x0f)
@@ -666,8 +644,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
     }
     memset(&sd->data[17], 0, 47);
     crc = sd_crc16(sd->data, 64);
-    sd->data[65] = crc >> 8;
-    sd->data[66] = crc & 0xff;
+    stw_be_p(sd->data + 65, crc);
 }
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
-- 
2.15.1
