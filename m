Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuA-0001K9-Gw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRu9-00080B-BO
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:18 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRu9-0007zW-74
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:17 -0500
Received: by mail-qk0-x242.google.com with SMTP id n188so21058031qkn.11
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:09:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:57 -0300
Message-Id: <20180213040809.26021-19-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 18/30] sdhci: rename the hostctl1 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

As per the Spec v3.00

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/sd/sdhci.h |  2 +-
 hw/sd/sdhci.c         | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 2a26b46f05..54594845ce 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -59,7 +59,7 @@ typedef struct SDHCIState {
     uint16_t cmdreg;       /* Command Register */
     uint32_t rspreg[4];    /* Response Registers 0-3 */
     uint32_t prnsts;       /* Present State Register */
-    uint8_t  hostctl;      /* Host Control Register */
+    uint8_t  hostctl1;     /* Host Control Register */
     uint8_t  pwrcon;       /* Power control Register */
     uint8_t  blkgap;       /* Block Gap Control Register */
     uint8_t  wakcon;       /* WakeUp Control Register */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e7214d6f60..9a8cdd551c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -691,7 +691,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     uint32_t adma1 = 0;
     uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
-    switch (SDHC_DMA_TYPE(s->hostctl)) {
+    switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
         dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma2,
                         sizeof(adma2));
@@ -880,7 +880,7 @@ static void sdhci_data_transfer(void *opaque)
     SDHCIState *s = (SDHCIState *)opaque;
 
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (SDHC_DMA_TYPE(s->hostctl)) {
+        switch (SDHC_DMA_TYPE(s->hostctl1)) {
         case SDHC_CTRL_SDMA:
             if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
                 sdhci_sdma_transfer_single_block(s);
@@ -989,7 +989,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = s->prnsts;
         break;
     case SDHC_HOSTCTL:
-        ret = s->hostctl | (s->pwrcon << 8) | (s->blkgap << 16) |
+        ret = s->hostctl1 | (s->pwrcon << 8) | (s->blkgap << 16) |
               (s->wakcon << 24);
         break;
     case SDHC_CLKCON:
@@ -1107,7 +1107,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->sdmasysad, mask, value);
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
-                s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
+                s->blksize && SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
             if (s->trnmod & SDHC_TRNS_MULTI) {
                 sdhci_sdma_transfer_multi_blocks(s);
             } else {
@@ -1159,7 +1159,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(mask & 0xFF0000)) {
             sdhci_blkgap_write(s, value >> 16);
         }
-        MASKED_WRITE(s->hostctl, mask, value);
+        MASKED_WRITE(s->hostctl1, mask, value);
         MASKED_WRITE(s->pwrcon, mask >> 8, value >> 8);
         MASKED_WRITE(s->wakcon, mask >> 24, value >> 24);
         if (!(s->prnsts & SDHC_CARD_PRESENT) || ((s->pwrcon >> 1) & 0x7) < 5 ||
@@ -1380,7 +1380,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_UINT16(cmdreg, SDHCIState),
         VMSTATE_UINT32_ARRAY(rspreg, SDHCIState, 4),
         VMSTATE_UINT32(prnsts, SDHCIState),
-        VMSTATE_UINT8(hostctl, SDHCIState),
+        VMSTATE_UINT8(hostctl1, SDHCIState),
         VMSTATE_UINT8(pwrcon, SDHCIState),
         VMSTATE_UINT8(blkgap, SDHCIState),
         VMSTATE_UINT8(wakcon, SDHCIState),
@@ -1598,13 +1598,13 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
          * manipulation code see comments in a similar part of
          * usdhc_write()
          */
-        hostctl = SDHC_DMA_TYPE(s->hostctl) << (8 - 3);
+        hostctl = SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
 
-        if (s->hostctl & SDHC_CTRL_8BITBUS) {
+        if (s->hostctl1 & SDHC_CTRL_8BITBUS) {
             hostctl |= ESDHC_CTRL_8BITBUS;
         }
 
-        if (s->hostctl & SDHC_CTRL_4BITBUS) {
+        if (s->hostctl1 & SDHC_CTRL_4BITBUS) {
             hostctl |= ESDHC_CTRL_4BITBUS;
         }
 
-- 
2.16.1
