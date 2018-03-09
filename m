Received: from eggs.gnu.org ([2001:4830:134:3::10]:59780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmz-000052-Li
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmy-0006Bd-P3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmy-0006A9-HT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:40 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmx-00079O-BB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:39 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:20 +0000
Message-Id: <20180309172622.4277-24-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/25] sdcard: Add the Tuning Command (CMD19)
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

>From the "Physical Layer Simplified Specification Version 3.01":

  A known data block ("Tuning block") can be used to tune sampling
  point for tuning required hosts. [...]
  This procedure gives the system optimal timing for each specific
  host and card combination and compensates for static delays in
  the timing budget including process, voltage and different PCB
  loads and skews. [...]
  Data block, carried by DAT[3:0], contains a pattern for tuning
  sampling position to receive data on the CMD and DAT[3:0] line.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180309153654.13518-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dc50d6bbf7..235e0518d6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1169,6 +1169,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
+    case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
+        if (sd->state == sd_transfer_state) {
+            sd->state = sd_sendingdata_state;
+            sd->data_offset = 0;
+            return sd_r1;
+        }
+        break;
+
     case 23:    /* CMD23: SET_BLOCK_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -1893,6 +1901,20 @@ void sd_write_data(SDState *sd, uint8_t value)
     }
 }
 
+#define SD_TUNING_BLOCK_SIZE    64
+
+static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
+    /* See: Physical Layer Simplified Specification Version 3.01, Table 4-2 */
+    0xff, 0x0f, 0xff, 0x00,         0x0f, 0xfc, 0xc3, 0xcc,
+    0xc3, 0x3c, 0xcc, 0xff,         0xfe, 0xff, 0xfe, 0xef,
+    0xff, 0xdf, 0xff, 0xdd,         0xff, 0xfb, 0xff, 0xfb,
+    0xbf, 0xff, 0x7f, 0xff,         0x77, 0xf7, 0xbd, 0xef,
+    0xff, 0xf0, 0xff, 0xf0,         0x0f, 0xfc, 0xcc, 0x3c,
+    0xcc, 0x33, 0xcc, 0xcf,         0xff, 0xef, 0xff, 0xee,
+    0xff, 0xfd, 0xff, 0xfd,         0xdf, 0xff, 0xbf, 0xff,
+    0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
+};
+
 uint8_t sd_read_data(SDState *sd)
 {
     /* TODO: Append CRCs */
@@ -1972,6 +1994,13 @@ uint8_t sd_read_data(SDState *sd)
         }
         break;
 
+    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
+        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
+            sd->state = sd_transfer_state;
+        }
+        ret = sd_tuning_block_pattern[sd->data_offset++];
+        break;
+
     case 22:	/* ACMD22: SEND_NUM_WR_BLOCKS */
         ret = sd->data[sd->data_offset ++];
 
-- 
2.16.2
