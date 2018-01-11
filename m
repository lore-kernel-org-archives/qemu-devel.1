Received: from eggs.gnu.org ([2001:4830:134:3::10]:44858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYz-0002vN-0E
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYy-0005gV-5r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:57 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYy-0005g6-1O
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:56 -0500
Received: by mail-qk0-x243.google.com with SMTP id i141so5790431qke.0
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:30:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 16:30:17 -0300
Message-Id: <20180111193021.17466-10-f4bug@amsat.org>
In-Reply-To: <20180111193021.17466-1-f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 09/13] sdhci: move MASK_TRNMOD with other
 SDHC_TRN* defines in "sd-internal.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 1 +
 hw/sd/sdhci.c          | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 248fd027f9..e941bc2386 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -43,6 +43,7 @@
 #define SDHC_TRNS_ACMD12               0x0004
 #define SDHC_TRNS_READ                 0x0010
 #define SDHC_TRNS_MULTI                0x0020
+#define SDHC_TRNMOD_MASK               0x0037
 
 /* R/W Command Register 0x0 */
 #define SDHC_CMDREG                    0x0E
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ad60cd50d3..73c1efbef3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -98,7 +98,6 @@
     (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
     (SDHC_CAPAB_TOCLKFREQ))
 
-#define MASK_TRNMOD     0x0037
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
 static uint8_t sdhci_slotint(SDHCIState *s)
@@ -1025,7 +1024,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(s->capareg & SDHC_CAN_DO_DMA)) {
             value &= ~SDHC_TRNS_DMA;
         }
-        MASKED_WRITE(s->trnmod, mask, value & MASK_TRNMOD);
+        MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
 
         /* Writing to the upper byte of CMDREG triggers SD command generation */
-- 
2.15.1
