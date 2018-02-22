Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosif-0004sU-Q5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosie-0001k4-T8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosie-0001ix-Mc
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosid-00024C-O4
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:52 +0000
Message-Id: <20180222152307.7499-18-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/32] sdcard: Don't always set the high
 capacity bit
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

Don't set the high capacity bit by default as it will be set if required
in the sd_set_csd() function.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 and Peter Ogden <ogden@xilinx.com> from qemu/xilinx tag xilinx-v2015.4]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 706cb52668..cc347ff782 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -290,6 +290,10 @@ static void sd_ocr_powerup(void *opaque)
 
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
+
+    if (sd->size > 1 * G_BYTE) {
+        sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
+    }
 }
 
 static void sd_set_scr(SDState *sd)
@@ -394,7 +398,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[13] = 0x40;
         sd->csd[14] = 0x00;
         sd->csd[15] = 0x00;
-        sd->ocr |= 1 << 30;     /* High Capacity SD Memory Card */
     }
 }
 
-- 
2.16.1
