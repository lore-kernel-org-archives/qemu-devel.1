Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsd-0003XO-Qf
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsb-0007d7-Lo
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:11 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsb-0007ce-Gu
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:09 -0500
Received: by mail-qk0-x241.google.com with SMTP id x7so2661206qkb.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:35:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:08 -0300
Message-Id: <20180103183418.23730-16-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/25] sdhci: rename the hostctl1 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

As per the Spec v3.00

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  2 +-
 hw/sd/sdhci.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 46e1e42fa1..c2da48c17c 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -65,7 +65,7 @@ typedef struct SDHCIState {
     /* Buffer Data Port Register - virtual access point to R and W buffers */
     uint32_t prnsts;       /* Present State Register */
     /* 0x28 */
-    uint8_t  hostctl;      /* Host Control Register */
+    uint8_t  hostctl1;     /* Host Control Register */
     uint8_t  pwrcon;       /* Power control Register */
     uint8_t  blkgap;       /* Block Gap Control Register */
     uint8_t  wakcon;       /* WakeUp Control Register */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 58c07bae80..2bd3c5a4b9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -600,7 +600,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     uint32_t adma1 = 0;
     uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
-    switch (SDHC_DMA_TYPE(s->hostctl)) {
+    switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
         dma_memory_read(&s->dma_as, entry_addr, (uint8_t *)&adma2,
                         sizeof(adma2));
@@ -789,7 +789,7 @@ static void sdhci_data_transfer(void *opaque)
     SDHCIState *s = (SDHCIState *)opaque;
 
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (SDHC_DMA_TYPE(s->hostctl)) {
+        switch (SDHC_DMA_TYPE(s->hostctl1)) {
         case SDHC_CTRL_SDMA:
             if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
                 sdhci_sdma_transfer_single_block(s);
@@ -898,7 +898,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = s->prnsts;
         break;
     case SDHC_HOSTCTL:
-        ret = s->hostctl | (s->pwrcon << 8) | (s->blkgap << 16) |
+        ret = s->hostctl1 | (s->pwrcon << 8) | (s->blkgap << 16) |
               (s->wakcon << 24);
         break;
     case SDHC_CLKCON:
@@ -1016,7 +1016,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->sdmasysad, mask, value);
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
-                s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
+                s->blksize && SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
             if (s->trnmod & SDHC_TRNS_MULTI) {
                 sdhci_sdma_transfer_multi_blocks(s);
             } else {
@@ -1068,14 +1068,14 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(mask & 0xFF0000)) {
             sdhci_blkgap_write(s, value >> 16);
         }
-        MASKED_WRITE(s->hostctl, mask, value);
+        MASKED_WRITE(s->hostctl1, mask, value);
         MASKED_WRITE(s->pwrcon, mask >> 8, value >> 8);
         MASKED_WRITE(s->wakcon, mask >> 24, value >> 24);
         if (!(s->prnsts & SDHC_CARD_PRESENT) || ((s->pwrcon >> 1) & 0x7) < 5 ||
                 !(s->capareg & (1 << (31 - ((s->pwrcon >> 1) & 0x7))))) {
             s->pwrcon &= ~SDHC_POWER_ON;
         }
-        qemu_set_irq(s->access_led, s->hostctl & 1);
+        qemu_set_irq(s->access_led, s->hostctl1 & 1);
         break;
     case SDHC_CLKCON:
         if (!(mask & 0xFF000000)) {
@@ -1285,7 +1285,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_UINT16(cmdreg, SDHCIState),
         VMSTATE_UINT32_ARRAY(rspreg, SDHCIState, 4),
         VMSTATE_UINT32(prnsts, SDHCIState),
-        VMSTATE_UINT8(hostctl, SDHCIState),
+        VMSTATE_UINT8(hostctl1, SDHCIState),
         VMSTATE_UINT8(pwrcon, SDHCIState),
         VMSTATE_UINT8(blkgap, SDHCIState),
         VMSTATE_UINT8(wakcon, SDHCIState),
-- 
2.15.1
