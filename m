Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIL-000351-CU
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIK-0007e9-LC
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:45 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIK-0007dt-G4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:44 -0500
Received: by mail-qt0-x244.google.com with SMTP id d8so17863774qtm.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:17 -0300
Message-Id: <20180123033034.29493-2-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/18] sdcard: Don't always set the high
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Don't set the high capacity bit by default as it will be set if required
in the sd_set_csd() function.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 and Peter Ogden <ogden@xilinx.com> from qemu/xilinx tag xilinx-v2015.4]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 437ce25f79..20764451f2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -289,6 +289,10 @@ static void sd_ocr_powerup(void *opaque)
 
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
+
+    if (sd->size > 1 * G_BYTE) {
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
 }
 
 static void sd_reset_scr(SDState *sd)
@@ -393,7 +397,6 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
         sd->csd[15] = 0x00;
-        sd->ocr |= 1 << 30;     /* High Capacity SD Memory Card */
     }
 }
 
-- 
2.15.1
