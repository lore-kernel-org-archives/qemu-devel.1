Received: from eggs.gnu.org ([2001:4830:134:3::10]:58288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmb-0004eM-Ky
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmZ-0004yt-CO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:37 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmZ-0004yb-7K
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:35 -0500
Received: by mail-qk0-x242.google.com with SMTP id g2so1548440qkd.12
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:06 -0300
Message-Id: <20180215221325.7611-2-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/20] sdcard: Don't always set the high
 capacity bit
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

Don't set the high capacity bit by default as it will be set if required
in the sd_set_csd() function.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 and Peter Ogden <ogden@xilinx.com> from qemu/xilinx tag xilinx-v2015.4]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fbee87afef..9dfbd65ac8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -291,6 +291,10 @@ static void sd_ocr_powerup(void *opaque)
 
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
+
+    if (sd->size > 1 * G_BYTE) {
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
 }
 
 static void sd_set_scr(SDState *sd)
@@ -395,7 +399,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
         sd->csd[15] = 0x00;
-        sd->ocr |= 1 << 30;     /* High Capacity SD Memory Card */
     }
 }
 
-- 
2.16.1
