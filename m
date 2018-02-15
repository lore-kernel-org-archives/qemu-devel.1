Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmp-0004vo-7q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmo-00059d-6t
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:39661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmo-00059O-1b
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:50 -0500
Received: by mail-qk0-x243.google.com with SMTP id z197so1569716qkb.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:11 -0300
Message-Id: <20180215221325.7611-7-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 06/20] sdcard: simplify using the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

the code is easier to review/refactor.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4267919ce0..b43baa2edd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -432,57 +432,39 @@ static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
     buffer[0] = 0x40 | req->cmd;
-    buffer[1] = (req->arg >> 24) & 0xff;
-    buffer[2] = (req->arg >> 16) & 0xff;
-    buffer[3] = (req->arg >> 8) & 0xff;
-    buffer[4] = (req->arg >> 0) & 0xff;
+    stl_be_p(&buffer[1], req->arg);
     return 0;
     return sd_crc7(buffer, 5) != req->crc;	/* TODO */
 }
 
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
 {
-    uint32_t status = sd->card_status;
+    stl_be_p(response, sd->card_status);
+
     /* Clear the "clear on read" status bits */
     sd->card_status &= ~CARD_STATUS_C;
-
-    response[0] = (status >> 24) & 0xff;
-    response[1] = (status >> 16) & 0xff;
-    response[2] = (status >> 8) & 0xff;
-    response[3] = (status >> 0) & 0xff;
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
 {
-    uint16_t arg;
     uint16_t status;
 
-    arg = sd->rca;
     status = ((sd->card_status >> 8) & 0xc000) |
              ((sd->card_status >> 6) & 0x2000) |
               (sd->card_status & 0x1fff);
     sd->card_status &= ~(CARD_STATUS_C & 0xc81fff);
-
-    response[0] = (arg >> 8) & 0xff;
-    response[1] = arg & 0xff;
-    response[2] = (status >> 8) & 0xff;
-    response[3] = status & 0xff;
+    stw_be_p(response + 0, sd->rca);
+    stw_be_p(response + 2, status);
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
@@ -728,7 +710,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
 
 static void sd_function_switch(SDState *sd, uint32_t arg)
 {
-    int i, mode, new_func, crc;
+    int i, mode, new_func;
     mode = !!(arg & 0x80000000);
 
     sd->data[0] = 0x00;		/* Maximum current consumption */
@@ -752,9 +734,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
         sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
     }
     memset(&sd->data[17], 0, 47);
-    crc = sd_crc16(sd->data, 64);
-    sd->data[65] = crc >> 8;
-    sd->data[66] = crc & 0xff;
+    stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
 }
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
-- 
2.16.1
