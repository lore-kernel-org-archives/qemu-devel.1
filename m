Received: from eggs.gnu.org ([209.51.188.92]:43859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVdH-0000mR-9m
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVdG-0001dY-6O
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:55 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:50515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHVdF-0001cp-R9
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:40:54 -0400
Received: by mail-it1-x143.google.com with SMTP id q14so1222796itk.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 08:40:53 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Fri, 19 Apr 2019 11:40:41 -0400
Message-Id: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] hw/char/escc: Lower irq when transmit
 buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>

The SCC/ESCC will briefly stop asserting an interrupt when the
transmit FIFO is filled.

This code doesn't model the transmit FIFO/shift register so the
pending transmit interrupt is never deasserted which means that an
edge-triggered interrupt controller will never see the low-to-high
transition it needs to raise another interrupt. The practical
consequence of this is that guest firmware with an interrupt service
routine for the ESCC that does not send all of the data it has
immediately will stop sending data if the following sequence of
events occurs:
1. Disable processor interrupts
2. Write a character to the ESCC
3. Add additional characters to a buffer which is drained by the ISR
4. Enable processor interrupts

In this case, the first character will be sent, the interrupt will
fire and the ISR will output the second character. Since the pending
transmit interrupt remains asserted, no additional interrupts will
ever fire.

This behavior was triggered by firmware for an embedded system with a
Z85C30 which necessitated this patch.

This patch fixes that situation by explicitly lowering the IRQ when a
character is written to the buffer and no other interrupts are currently
pending.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

I added a sentence about the Z85C30 necessitating this to the commit message.

 hw/char/escc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..c5b05a63f1 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         break;
     case SERIAL_DATA:
         trace_escc_mem_writeb_data(CHN_C(s), val);
+        /*
+         * Lower the irq when data is written to the Tx buffer and no other
+         * interrupts are currently pending. The irq will be raised again once
+         * the Tx buffer becomes empty below.
+         */
+        s->txint = 0;
+        escc_update_irq(s);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
             if (qemu_chr_fe_backend_connected(&s->chr)) {
-- 
2.20.1 (Apple Git-117)
