Received: from eggs.gnu.org ([2001:4830:134:3::10]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn8-0005Nx-2D
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn6-0005Kb-4I
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:10 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn5-0005K9-VM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:08 -0500
Received: by mail-qk0-x242.google.com with SMTP id o7so1602335qkc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:17 -0300
Message-Id: <20180215221325.7611-13-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 12/20] sdcard: handles more commands in SPI
 mode
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4f82638735..0ecb446fdb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1390,9 +1390,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
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
@@ -1412,6 +1414,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
+        goto unimplemented_spi_cmd;
+
     default:
     bad_cmd:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
@@ -1436,6 +1450,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->sd_status[0] &= 0x3f;
@@ -1569,6 +1586,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     default:
         /* Fall back to standard commands.  */
         return sd_normal_command(sd, req);
+
+    unimplemented_spi_cmd:
+        /* Commands that are recognised but not yet implemented in SPI mode.  */
+        qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
+                      req.cmd);
+        return sd_illegal;
     }
 
     qemu_log_mask(LOG_GUEST_ERROR, "SD: ACMD%i in a wrong state\n", req.cmd);
-- 
2.16.1
