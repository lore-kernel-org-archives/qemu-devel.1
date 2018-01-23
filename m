Received: from eggs.gnu.org ([2001:4830:134:3::10]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ5-0003lG-JP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ4-0008I6-Ko
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:31 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ4-0008Ho-Gx
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:30 -0500
Received: by mail-qt0-x244.google.com with SMTP id a27so13312153qtd.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:32 -0300
Message-Id: <20180123033034.29493-17-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/18] sdcard: add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 27176ba33e..b3b6859bc4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,6 +93,7 @@ struct SDState {
     /* Configurable properties */
     BlockBackend *blk;
     bool spi;
+    uint8_t uhs_supported;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -289,6 +290,8 @@ static void sd_reset_ocr(SDState *sd)
 {
     /* All voltages OK */
     sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
+
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_supported);
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -2107,6 +2110,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.15.1
