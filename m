Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXG-0002H8-MQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXF-0007rt-HK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:18 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXF-0007ri-98
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:17 -0500
Received: by mail-qk0-x243.google.com with SMTP id x7so3255544qkb.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:18 -0300
Message-Id: <20180103212436.15762-8-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/25] sdcard: rename sd_set_$REG()
 functions called once as sd_reset_$REG()
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

All are only called once at reset.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b0e54f69d8..7d43ab072b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -293,7 +293,7 @@ static uint16_t sd_crc16(void *message, size_t width)
     return shift_reg;
 }
 
-static void sd_set_ocr(SDState *sd)
+static void sd_reset_ocr(SDState *sd)
 {
     /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
     sd->ocr = 0x00ffff00;
@@ -308,7 +308,7 @@ static void sd_ocr_powerup(void *opaque)
     sd->ocr |= OCR_POWER_UP;
 }
 
-static void sd_set_scr(SDState *sd)
+static void sd_reset_scr(SDState *sd)
 {
     sd->scr[0] = 0x00;		/* SCR Structure */
     sd->scr[1] = 0x2f;		/* SD Security Support */
@@ -327,7 +327,7 @@ static void sd_set_scr(SDState *sd)
 #define MDT_YR	2006
 #define MDT_MON	2
 
-static void sd_set_cid(SDState *sd)
+static void sd_reset_cid(SDState *sd)
 {
     sd->cid[0] = MID;		/* Fake card manufacturer ID (MID) */
     sd->cid[1] = OID[0];	/* OEM/Application ID (OID) */
@@ -359,7 +359,7 @@ static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
 };
 
-static void sd_set_csd(SDState *sd, uint64_t size)
+static void sd_reset_csd(SDState *sd, uint64_t size)
 {
     uint32_t csize = (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
@@ -414,6 +414,11 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     }
 }
 
+static void sd_reset_rca(SDState *sd)
+{
+    sd->rca = 0;
+}
+
 static void sd_set_rca(SDState *sd)
 {
     sd->rca += 0x4567;
@@ -428,12 +433,12 @@ static void sd_set_rca(SDState *sd)
 #define CARD_STATUS_B	0x00c01e00
 #define CARD_STATUS_C	0xfd39a028
 
-static void sd_set_cardstatus(SDState *sd)
+static void sd_reset_cardstatus(SDState *sd)
 {
     sd->card_status = 0x00000100;
 }
 
-static void sd_set_sdstatus(SDState *sd)
+static void sd_reset_sdstatus(SDState *sd)
 {
     memset(sd->sd_status, 0, 64);
 }
@@ -517,13 +522,13 @@ static void sd_reset(DeviceState *dev)
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->state = sd_idle_state;
-    sd->rca = 0x0000;
-    sd_set_ocr(sd);
-    sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
-    sd_set_cardstatus(sd);
-    sd_set_sdstatus(sd);
+    sd_reset_rca(sd);
+    sd_reset_ocr(sd);
+    sd_reset_scr(sd);
+    sd_reset_cid(sd);
+    sd_reset_csd(sd, size);
+    sd_reset_cardstatus(sd);
+    sd_reset_sdstatus(sd);
 
     g_free(sd->wp_groups);
     sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
-- 
2.15.1
