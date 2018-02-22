Received: from eggs.gnu.org ([2001:4830:134:3::10]:38257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiU-0004gU-Ft
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiT-0001Zi-7g
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiT-0001Ye-0f
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:25 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiR-00020n-QU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:38 +0000
Message-Id: <20180222152307.7499-4-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/32] hw/char/stm32f2xx_usart: fix TXE/TC bit
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Braun <rbraun@sceen.net>

I/O currently being synchronous, there is no reason to ever clear the
SR_TXE bit. However the SR_TC bit may be cleared by software writing
to the SR register, so set it on each write.

In addition, fix the reset value of the USART status register.

Signed-off-by: Richard Braun <rbraun@sceen.net>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
[PMM: removed XXX tag from comment, since it isn't something
 we need to come back and fix in QEMU]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/stm32f2xx_usart.h |  7 ++++++-
 hw/char/stm32f2xx_usart.c         | 12 ++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index 9d03a7527c..84c4029777 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -37,7 +37,12 @@
 #define USART_CR3  0x14
 #define USART_GTPR 0x18
 
-#define USART_SR_RESET 0x00C00000
+/*
+ * NB: The reset value mentioned in "24.6.1 Status register" seems bogus.
+ * Looking at "Table 98 USART register map and reset values", it seems it
+ * should be 0xc0, and that's how real hardware behaves.
+ */
+#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
 
 #define USART_SR_TXE  (1 << 7)
 #define USART_SR_TC   (1 << 6)
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 07b462d4b6..032b5fda13 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -96,12 +96,10 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
     switch (addr) {
     case USART_SR:
         retvalue = s->usart_sr;
-        s->usart_sr &= ~USART_SR_TC;
         qemu_chr_fe_accept_input(&s->chr);
         return retvalue;
     case USART_DR:
         DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
-        s->usart_sr |= USART_SR_TXE;
         s->usart_sr &= ~USART_SR_RXNE;
         qemu_chr_fe_accept_input(&s->chr);
         qemu_set_irq(s->irq, 0);
@@ -137,7 +135,9 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
     switch (addr) {
     case USART_SR:
         if (value <= 0x3FF) {
-            s->usart_sr = value;
+            /* I/O being synchronous, TXE is always set. In addition, it may
+               only be set by hardware, so keep it set here. */
+            s->usart_sr = value | USART_SR_TXE;
         } else {
             s->usart_sr &= value;
         }
@@ -151,8 +151,12 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
             /* XXX this blocks entire thread. Rewrite to use
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
+            /* XXX I/O are currently synchronous, making it impossible for
+               software to observe transient states where TXE or TC aren't
+               set. Unlike TXE however, which is read-only, software may
+               clear TC by writing 0 to the SR register, so set it again
+               on each write. */
             s->usart_sr |= USART_SR_TC;
-            s->usart_sr &= ~USART_SR_TXE;
         }
         return;
     case USART_BRR:
-- 
2.16.1
