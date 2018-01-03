Received: from eggs.gnu.org ([2001:4830:134:3::10]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXq-0002nG-Qv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXf-0008BL-Vr
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:54 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXf-0008B0-P6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:43 -0500
Received: by mail-qt0-x241.google.com with SMTP id u10so3818128qtg.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:24 -0300
Message-Id: <20180103212436.15762-14-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/25] sdcard: let function handling
 response codes returns the response size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

this will ease cases when the response is different regarding the protocol
use (SPI, MMC).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e6a6e0b2ad..7e9d7366fe 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -460,7 +460,7 @@ static int sd_req_crc_validate(SDRequest *req)
     return sd_crc7(buffer, 5) != req->crc;	/* TODO */
 }
 
-static void sd_response_r1_make(SDState *sd, uint8_t *response)
+static size_t sd_response_r1_make(SDState *sd, uint8_t *response)
 {
     uint32_t status = sd->card_status;
     /* Clear the "clear on read" status bits */
@@ -470,14 +470,25 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
     response[1] = (status >> 16) & 0xff;
     response[2] = (status >> 8) & 0xff;
     response[3] = (status >> 0) & 0xff;
+
+    return 4;
+}
+
+static size_t sd_response_r2s_make(SDState *sd, uint8_t *response)
+{
+    memcpy(response, sd->csd, sizeof(sd->csd));
+
+    return 16;
 }
 
-static void sd_response_r3_make(SDState *sd, uint8_t *response)
+static size_t sd_response_r3_make(SDState *sd, uint8_t *response)
 {
     response[0] = (sd->ocr >> 24) & 0xff;
     response[1] = (sd->ocr >> 16) & 0xff;
     response[2] = (sd->ocr >> 8) & 0xff;
     response[3] = (sd->ocr >> 0) & 0xff;
+
+    return 4;
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
@@ -1513,8 +1524,7 @@ send_response:
     switch (rtype) {
     case sd_r1:
     case sd_r1b:
-        sd_response_r1_make(sd, response);
-        rsplen = 4;
+        rsplen = sd_response_r1_make(sd, response);
         break;
 
     case sd_r2_i:
@@ -1523,13 +1533,11 @@ send_response:
         break;
 
     case sd_r2_s:
-        memcpy(response, sd->csd, sizeof(sd->csd));
-        rsplen = 16;
+        rsplen = sd_response_r2s_make(sd, response);
         break;
 
     case sd_r3:
-        sd_response_r3_make(sd, response);
-        rsplen = 4;
+        rsplen = sd_response_r3_make(sd, response);
         break;
 
     case sd_r6:
-- 
2.15.1
