Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1elhaq-0006bK-QP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1elhap-0003OU-Nz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:24 -0500
Received: from shattrath.sceen.net ([2001:41d0:c:ada::1]:53105
	helo=mail.sceen.net) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1elhap-0003Gh-HB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:23 -0500
From: Richard Braun <rbraun@sceen.net>
Date: Tue, 13 Feb 2018 21:54:19 +0100
Message-Id: <1518555259-26463-1-git-send-email-rbraun@sceen.net>
In-Reply-To: <20180209093643.GC27456@shattrath>
References: <20180209093643.GC27456@shattrath>
Subject: [Qemu-devel] [PATCH v2] hw/char/stm32f2xx_usart: fix TXE/TC bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>

I/O currently being synchronous, there is no reason to ever clear the
SR_TXE bit. However the SR_TC bit may be cleared by software writing
to the SR register, so set it on each write.

In addition, fix the reset value of the USART status register.

Signed-off-by: Richard Braun <rbraun@sceen.net>
---
 hw/char/stm32f2xx_usart.c         | 12 ++++++++----
 include/hw/char/stm32f2xx_usart.h |  7 ++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

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
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index 9d03a7527c..7ea7448813 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -37,7 +37,12 @@
 #define USART_CR3  0x14
 #define USART_GTPR 0x18
 
-#define USART_SR_RESET 0x00C00000
+/*
+ * XXX The reset value mentioned in "24.6.1 Status register" seems bogus.
+ * Looking at "Table 98 USART register map and reset values", it seems it
+ * should be 0xc0, and that's how real hardware behaves.
+ */
+#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
 
 #define USART_SR_TXE  (1 << 7)
 #define USART_SR_TC   (1 << 6)
-- 
2.11.0
