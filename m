Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn8-0005Ny-3G
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn3-0005IY-45
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:10 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn2-0005IL-Vb
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:05 -0500
Received: by mail-qk0-x243.google.com with SMTP id g2so1550096qkd.12
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:16 -0300
Message-Id: <20180215221325.7611-12-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 11/20] sdcard: use a more descriptive label
 'unimplemented_spi_cmd'
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

Suggested-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0457f5214b..4f82638735 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1183,8 +1183,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1209,8 +1210,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 25:	/* CMD25:  WRITE_MULTIPLE_BLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1250,8 +1252,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 27:	/* CMD27:  PROGRAM_CSD */
-        if (sd->spi)
-            goto unimplemented_cmd;
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_receivingdata_state;
@@ -1361,8 +1364,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:	/* CMD42:  LOCK_UNLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_receivingdata_state;
@@ -1413,7 +1417,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
 
-    unimplemented_cmd:
+    unimplemented_spi_cmd:
         /* Commands that are recognised but not yet implemented in SPI mode.  */
         qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
                       req.cmd);
-- 
2.16.1
