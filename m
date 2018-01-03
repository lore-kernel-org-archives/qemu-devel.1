Received: from eggs.gnu.org ([2001:4830:134:3::10]:52849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYH-0003GX-5s
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYA-0000Cd-En
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:21 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYA-0000Bv-5q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:14 -0500
Received: by mail-qk0-x242.google.com with SMTP id b132so3256461qkc.13
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:31 -0300
Message-Id: <20180103212436.15762-21-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 20/25] sdcard: Don't always set the high
 capacity bit
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

Don't set the high capacity bit by default as it will be set if required
in the sd_set_csd() function.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 and Peter Ogden <ogden@xilinx.com> from qemu/xilinx tag xilinx-v2015.4]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a7cede8da6..16a8a7411d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -318,6 +318,7 @@ static uint16_t sd_crc16(void *message, size_t width)
     return shift_reg;
 }
 
+FIELD(OCR, CARD_CAPACITY,              30, 1); /* 0:SDSC, 1:SDHC/SDXC */
 FIELD(OCR, CARD_POWER_UP,              31, 1);
 
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -336,6 +337,10 @@ static void sd_ocr_powerup(void *opaque)
 
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
+
+    if (sd->capacity >= sd_capacity_sdhc) {
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
 }
 
 static void sd_reset_scr(SDState *sd)
@@ -440,7 +445,6 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
         sd->csd[15] = 0x00;
-        sd->ocr |= 1 << 30;     /* High Capacity SD Memory Card */
     }
 }
 
-- 
2.15.1
