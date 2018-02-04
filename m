Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1eiR6N-0002yl-V8
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1eiR6K-0003kh-1j
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:41:28 -0500
Received: from shattrath.sceen.net ([151.80.19.218]:52867 helo=mail.sceen.net)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1eiR6J-0003k5-Qq
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 15:41:23 -0500
From: Richard Braun <rbraun@sceen.net>
Date: Sun,  4 Feb 2018 21:41:21 +0100
Message-Id: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
Subject: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: improve TXE/TC bit
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

Consider that data is always immediately sent. As a result, keep
the SR_TXE and SR_TC bits always set. In addition, fix the reset value
of the USART status register.

Signed-off-by: Richard Braun <rbraun@sceen.net>
---
 hw/char/stm32f2xx_usart.c         | 4 ----
 include/hw/char/stm32f2xx_usart.h | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 07b462d4b6..a914f98a2a 100644
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
@@ -151,8 +149,6 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
             /* XXX this blocks entire thread. Rewrite to use
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
-            s->usart_sr |= USART_SR_TC;
-            s->usart_sr &= ~USART_SR_TXE;
         }
         return;
     case USART_BRR:
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2xx_usart.h
index 9d03a7527c..bbba3965a1 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -37,7 +37,12 @@
 #define USART_CR3  0x14
 #define USART_GTPR 0x18
 
-#define USART_SR_RESET 0x00C00000
+/*
+ * XXX The reset value mentioned in 24.6.1 Status register seems bogus.
+ * Looking at Table 98 USART register map and reset values, it seems it
+ * should be 0xc0, and that's how real hardware behaves.
+ */
+#define USART_SR_RESET (USART_SR_TXE | USART_SR_TC)
 
 #define USART_SR_TXE  (1 << 7)
 #define USART_SR_TC   (1 << 6)
-- 
2.11.0
