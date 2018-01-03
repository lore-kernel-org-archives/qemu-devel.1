Received: from eggs.gnu.org ([2001:4830:134:3::10]:52391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqY1-00030G-Gk
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXt-0008Lv-Kr
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:05 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXt-0008L8-Eg
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:57 -0500
Received: by mail-qk0-x242.google.com with SMTP id p13so3255573qke.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:27 -0300
Message-Id: <20180103212436.15762-17-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 16/25] sdcard: add missing SPI legal
 commands
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

we don't implement them, but when firmware use them we get a UNIMP log.
 CMD: 58, 59
 ACMD: 6, 18, 25, 26, 38, 43 - 49

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d2a0baa0a7..a8198ecce9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1324,6 +1324,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
+    case 58:    /* CMD58:   READ_OCR (SPI) */
+        if (!sd->spi) {
+            goto bad_cmd;
+        }
+        return sd_r3;
+
+    case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
+        if (!sd->spi) {
+            goto bad_cmd;
+        }
+        goto unimplemented_cmd;
+
     default:
     bad_cmd:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
@@ -1340,14 +1352,16 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
-static sd_rsp_type_t sd_app_command(SDState *sd,
-                                    SDRequest req)
+static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
 {
     trace_sdcard_app_command(sd->proto_name, sd_acmd_abbreviation(req.cmd),
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
+        if (sd->spi) {
+            goto unimplemented_cmd;
+        }
         if (sd->state == sd_transfer_state) {
             sd->sd_status[0] &= 0x3f;
             sd->sd_status[0] |= (req.arg & 0x03) << 6;
@@ -1361,7 +1375,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
+        }
+        break;
 
+    case 18:
+        if (sd->spi) {
+            goto unimplemented_cmd;
         }
         break;
 
@@ -1382,6 +1401,19 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         }
         break;
 
+    case 25:
+    case 26:
+        if (sd->spi) {
+            goto unimplemented_cmd;
+        }
+        break;
+
+    case 38:
+        if (sd->spi) {
+            goto unimplemented_cmd;
+        }
+        break;
+
     case 41:	/* ACMD41: SD_APP_OP_COND */
         if (sd->spi) {
             /* SEND_OP_CMD */
@@ -1428,6 +1460,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         }
         break;
 
+    case 43 ... 49:
+        if (sd->spi) {
+            goto unimplemented_cmd;
+        }
+        break;
+
     case 51:	/* ACMD51: SEND_SCR */
         if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
@@ -1443,6 +1481,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     default:
         /* Fall back to standard commands.  */
         return sd_normal_command(sd, req);
+
+    unimplemented_cmd:
+        /* Commands that are recognised but not yet implemented in SPI mode.  */
+        qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
+                      req.cmd);
+        return sd_illegal;
     }
 
     qemu_log_mask(LOG_GUEST_ERROR, "SD: ACMD%i in a wrong state\n", req.cmd);
-- 
2.15.1
