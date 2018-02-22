Received: from eggs.gnu.org ([2001:4830:134:3::10]:38634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosir-00056Y-IN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiq-0001x0-J9
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiq-0001vB-B0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosip-00026v-6L
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:03 +0000
Message-Id: <20180222152307.7499-29-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/32] sdcard: handles more commands in SPI mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-13-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 34080f0e4c..ff7ace3491 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1386,9 +1386,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
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
@@ -1408,6 +1410,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
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
@@ -1431,6 +1445,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
+        if (sd->spi) {
+            goto unimplemented_spi_cmd;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->sd_status[0] &= 0x3f;
@@ -1565,6 +1582,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
