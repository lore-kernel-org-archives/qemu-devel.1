Received: from eggs.gnu.org ([2001:4830:134:3::10]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiq-00055a-Ln
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosip-0001vz-L2
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosip-0001vB-DD
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:47 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosio-00026h-EZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:02 +0000
Message-Id: <20180222152307.7499-28-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/32] sdcard: use a more descriptive label
 'unimplemented_spi_cmd'
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

Suggested-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-12-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f13f33efca..34080f0e4c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1179,8 +1179,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
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
@@ -1205,8 +1206,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
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
@@ -1246,8 +1248,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
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
@@ -1357,8 +1360,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
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
@@ -1409,7 +1413,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
 
-    unimplemented_cmd:
+    unimplemented_spi_cmd:
         /* Commands that are recognised but not yet implemented in SPI mode.  */
         qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
                       req.cmd);
-- 
2.16.1
