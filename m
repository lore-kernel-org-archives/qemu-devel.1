Received: from eggs.gnu.org ([2001:4830:134:3::10]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIAH-00009V-ED
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIAE-0005hF-P9
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:25 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIAE-0005g4-Ko
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:22 -0400
Received: by mail-qt0-x242.google.com with SMTP id g13-v6so44208071qth.8
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 23:01:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 03:01:04 -0300
Message-Id: <20180509060104.4458-5-f4bug@amsat.org>
In-Reply-To: <20180509060104.4458-1-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/4] sdcard: Add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d8dd88f872..a0e8a1b46a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -94,6 +94,10 @@ struct SDState {
 
     BlockBackend *blk;
     bool spi;
+    /**
+     * The UHS mode the card supports if any, else #UHS_NOT_SUPPORTED
+     */
+    uint8_t uhs_mode_supported;
 
     /* Runtime changeables */
 
@@ -300,6 +304,9 @@ static void sd_set_ocr(SDState *sd)
 {
     /* All voltages OK */
     sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
+
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8,
+                         sd->uhs_mode_supported != UHS_NOT_SUPPORTED);
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -2240,6 +2247,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    DEFINE_PROP_UINT8("uhs", SDState, uhs_mode_supported, UHS_NOT_SUPPORTED),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.17.0
