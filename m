Received: from eggs.gnu.org ([2001:4830:134:3::10]:50680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlw-0003DB-Dq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlv-0004Pl-DN
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlv-0004OV-4o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlu-0003mt-2q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:13 +0100
Message-Id: <20180608124517.29475-28-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/31] sdcard: Allow commands valid in SPI mode
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

>From the "Physical Layer Simplified Specification Version 1.10"
  Chapter 7.3 "SPI Mode Transaction Packets"
    Table 57: "Commands and arguments"

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20180607180641.874-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e1218d1fb6b..80e70dd93e2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -960,8 +960,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
 
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->mode) {
         case sd_data_transfer_mode:
             sd_function_switch(sd, req.arg);
@@ -1190,9 +1188,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd->spi) {
-            goto unimplemented_spi_cmd;
-        }
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1217,9 +1212,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 25:	/* CMD25:  WRITE_MULTIPLE_BLOCK */
-        if (sd->spi) {
-            goto unimplemented_spi_cmd;
-        }
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1259,9 +1251,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 27:	/* CMD27:  PROGRAM_CSD */
-        if (sd->spi) {
-            goto unimplemented_spi_cmd;
-        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_receivingdata_state;
@@ -1371,9 +1360,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:	/* CMD42:  LOCK_UNLOCK */
-        if (sd->spi) {
-            goto unimplemented_spi_cmd;
-        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_receivingdata_state;
-- 
2.17.1
