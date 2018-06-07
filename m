Received: from eggs.gnu.org ([2001:4830:134:3::10]:45955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJJ-0001y6-CW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJI-0004Nl-EC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:06:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 15:06:36 -0300
Message-Id: <20180607180641.874-3-f4bug@amsat.org>
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/7] sdcard: Allow commands valid in SPI mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

>From the "Physical Layer Simplified Specification Version 1.10"
  Chapter 7.3 "SPI Mode Transaction Packets"
    Table 57: "Commands and arguments"

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/sd/sd.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e1218d1fb6..80e70dd93e 100644
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
