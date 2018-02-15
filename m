Received: from eggs.gnu.org ([2001:4830:134:3::10]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnT-0005wA-Gx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnR-0005aM-7S
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:31 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnR-0005a9-1i
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:29 -0500
Received: by mail-qt0-x244.google.com with SMTP id q18so1639825qtl.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:24 -0300
Message-Id: <20180215221325.7611-20-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 19/20] sdcard: add a 'uhs' property,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ada96f5574..b9429b06ca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -93,6 +93,7 @@ struct SDState {
     /* Configurable properties */
     BlockBackend *blk;
     bool spi;
+    uint8_t uhs_supported;
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
@@ -292,6 +293,8 @@ static void sd_set_ocr(SDState *sd)
 {
     /* All voltages OK */
     sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
+
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_supported);
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -2189,6 +2192,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.16.1
