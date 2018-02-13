Received: from eggs.gnu.org ([2001:4830:134:3::10]:41987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHl-0004RR-Oq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHk-0007mS-Js
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:09 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHk-0007mG-9Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:08 -0500
Received: by mail-wm0-x241.google.com with SMTP id j199so3415746wmj.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:35 +0100
Message-Id: <1518523252-49106-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/48] sdhci: rename the hostctl1 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As per the Spec v3.00

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-19-f4bug@amsat.org>
---
 hw/sd/sdhci.c         | 42 +++++++++++++++++++++---------------------
 include/hw/sd/sdhci.h |  2 +-
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 844c5d5..55b3f3a 100644
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
@@ -1586,7 +1586,7 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint32_t ret;
-    uint16_t hostctl;
+    uint16_t hostctl1;
 
     switch (offset) {
     default:
@@ -1598,17 +1598,17 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
          * manipulation code see comments in a similar part of
          * usdhc_write()
          */
-        hostctl = SDHC_DMA_TYPE(s->hostctl) << (8 - 3);
+        hostctl1 = SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
 
-        if (s->hostctl & SDHC_CTRL_8BITBUS) {
-            hostctl |= ESDHC_CTRL_8BITBUS;
+        if (s->hostctl1 & SDHC_CTRL_8BITBUS) {
+            hostctl1 |= ESDHC_CTRL_8BITBUS;
         }
 
-        if (s->hostctl & SDHC_CTRL_4BITBUS) {
-            hostctl |= ESDHC_CTRL_4BITBUS;
+        if (s->hostctl1 & SDHC_CTRL_4BITBUS) {
+            hostctl1 |= ESDHC_CTRL_4BITBUS;
         }
 
-        ret  = hostctl;
+        ret  = hostctl1;
         ret |= (uint32_t)s->blkgap << 16;
         ret |= (uint32_t)s->wakcon << 24;
 
@@ -1632,7 +1632,7 @@ static void
 usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
-    uint8_t hostctl;
+    uint8_t hostctl1;
     uint32_t value = (uint32_t)val;
 
     switch (offset) {
@@ -1695,25 +1695,25 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /*
          * First, save bits 7 6 and 0 since they are identical
          */
-        hostctl = value & (SDHC_CTRL_LED |
-                           SDHC_CTRL_CDTEST_INS |
-                           SDHC_CTRL_CDTEST_EN);
+        hostctl1 = value & (SDHC_CTRL_LED |
+                            SDHC_CTRL_CDTEST_INS |
+                            SDHC_CTRL_CDTEST_EN);
         /*
          * Second, split "Data Transfer Width" from bits 2 and 1 in to
          * bits 5 and 1
          */
         if (value & ESDHC_CTRL_8BITBUS) {
-            hostctl |= SDHC_CTRL_8BITBUS;
+            hostctl1 |= SDHC_CTRL_8BITBUS;
         }
 
         if (value & ESDHC_CTRL_4BITBUS) {
-            hostctl |= ESDHC_CTRL_4BITBUS;
+            hostctl1 |= ESDHC_CTRL_4BITBUS;
         }
 
         /*
          * Third, move DMA select from bits 9 and 8 to bits 4 and 3
          */
-        hostctl |= SDHC_DMA_TYPE(value >> (8 - 3));
+        hostctl1 |= SDHC_DMA_TYPE(value >> (8 - 3));
 
         /*
          * Now place the corrected value into low 16-bit of the value
@@ -1724,7 +1724,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * kernel
          */
         value &= ~UINT16_MAX;
-        value |= hostctl;
+        value |= hostctl1;
         value |= (uint16_t)s->pwrcon << 8;
 
         sdhci_write(opaque, offset, value, size);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 2a26b46..5459484 100644
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
-- 
1.8.3.1
