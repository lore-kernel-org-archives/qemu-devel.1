Received: from eggs.gnu.org ([2001:4830:134:3::10]:50360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4w-0006Mn-6I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4v-0008DU-4p
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:06 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4u-0008Cw-V3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:05 -0500
Received: by mail-wr0-x243.google.com with SMTP id a27so1744311wra.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:50 +0100
Message-Id: <20180309153654.13518-5-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/8] sdcard: Add the Tuning Command (CMD19)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

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
