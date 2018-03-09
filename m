Received: from eggs.gnu.org ([2001:4830:134:3::10]:50386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4y-0006PC-E1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4x-0008Eu-OJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4x-0008EZ-I0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id a20so3955770wmd.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:52 +0100
Message-Id: <20180309153654.13518-7-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] sdcard: Add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b907d62aef..611094447c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,6 +93,7 @@ struct SDState {
     /* Configurable properties */
     BlockBackend *blk;
     bool spi;
+    uint8_t uhs_mode;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -292,6 +293,9 @@ static void sd_set_ocr(SDState *sd)
 {
     /* All voltages OK */
     sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
+
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8,
+                         sd->uhs_mode != UHS_NOT_SUPPORTED);
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -2198,6 +2202,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_UINT8("uhs", SDState, uhs_mode, UHS_NOT_SUPPORTED),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.16.2
