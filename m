Received: from eggs.gnu.org ([2001:4830:134:3::10]:52567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY7-000369-6c
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXy-0008P1-2D
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:11 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXx-0008Oa-Ol
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:01 -0500
Received: by mail-qk0-x244.google.com with SMTP id d202so3245064qkc.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:28 -0300
Message-Id: <20180103212436.15762-18-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 17/25] sdcard: fix SPI response length
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

SPI response are often shorter than SD/MMC protocols.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a8198ecce9..024a9fa1df 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -466,29 +466,59 @@ static size_t sd_response_r1_make(SDState *sd, uint8_t *response)
     /* Clear the "clear on read" status bits */
     sd->card_status &= ~CARD_STATUS_C;
 
-    response[0] = (status >> 24) & 0xff;
-    response[1] = (status >> 16) & 0xff;
-    response[2] = (status >> 8) & 0xff;
-    response[3] = (status >> 0) & 0xff;
+    if (sd->spi) {
+        response[0] = 0xff; /* XXX */
+        return 1;
+    } else {
+        response[0] = (status >> 24) & 0xff;
+        response[1] = (status >> 16) & 0xff;
+        response[2] = (status >> 8) & 0xff;
+        response[3] = (status >> 0) & 0xff;
+        return 4;
+    }
+}
+
+static size_t sd_response_r1b_make(SDState *sd, uint8_t *response)
+{
+    /* This response token is identical to the R1 format with the
+     * optional addition of the busy signal. */
+    if (sd->spi) {
+        /* The busy signal token can be any number of bytes. A zero value
+         * indicates card is busy. A non-zero value indicates the card is
+         * ready for the next command. */
+        size_t sz = sd_response_r1_make(sd, response);
+
+        response[sz++] = 0x42;
 
-    return 4;
+        return sz;
+    }
+    return sd_response_r1_make(sd, response);
 }
 
 static size_t sd_response_r2s_make(SDState *sd, uint8_t *response)
 {
-    memcpy(response, sd->csd, sizeof(sd->csd));
-
-    return 16;
+    if (sd->spi) {
+        /* TODO */
+        return 2;
+    } else {
+        memcpy(response, sd->csd, sizeof(sd->csd));
+        return 16;
+    }
 }
 
 static size_t sd_response_r3_make(SDState *sd, uint8_t *response)
 {
-    response[0] = (sd->ocr >> 24) & 0xff;
-    response[1] = (sd->ocr >> 16) & 0xff;
-    response[2] = (sd->ocr >> 8) & 0xff;
-    response[3] = (sd->ocr >> 0) & 0xff;
+    int ofs = 0;
+
+    if (sd->spi) {
+        ofs += sd_response_r1_make(sd, response);
+    }
+    response[ofs++] = (sd->ocr >> 24) & 0xff;
+    response[ofs++] = (sd->ocr >> 16) & 0xff;
+    response[ofs++] = (sd->ocr >> 8) & 0xff;
+    response[ofs++] = (sd->ocr >> 0) & 0xff;
 
-    return 4;
+    return ofs;
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
@@ -1249,7 +1279,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
             sd->data_start = addr;
             sd->data_offset = 0;
-            return sd_r1b;
+            return sd->spi ? sd_r1 : sd_r1b;
         }
         break;
 
@@ -1306,9 +1336,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Application specific commands (Class 8) */
     case 55:	/* CMD55:  APP_CMD */
-        if (sd->rca != rca)
-            return sd_r0;
-
+        if (!sd->spi) {
+            if (sd->rca != rca) {
+                return sd_r0;
+            }
+        }
         sd->expecting_acmd = true;
         sd->card_status |= APP_CMD;
         return sd_r1;
@@ -1374,7 +1406,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
-            return sd_r1;
+            return sd->spi ? sd_r2_s : sd_r1;
         }
         break;
 
@@ -1569,10 +1601,13 @@ int sd_do_command(SDState *sd, SDRequest *req,
 send_response:
     switch (rtype) {
     case sd_r1:
-    case sd_r1b:
         rsplen = sd_response_r1_make(sd, response);
         break;
 
+    case sd_r1b:
+        rsplen = sd_response_r1b_make(sd, response);
+        break;
+
     case sd_r2_i:
         memcpy(response, sd->cid, sizeof(sd->cid));
         rsplen = 16;
-- 
2.15.1
