Received: from eggs.gnu.org ([209.51.188.92]:54262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1h12LT-0000Wm-Ux
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1h12LS-0004kW-Lg
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:10:27 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:40658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1h12LS-0004hW-C4
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:10:26 -0500
Received: by mail-it1-x141.google.com with SMTP id l139so2474758ita.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 21:10:25 -0800 (PST)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Tue,  5 Mar 2019 00:10:07 -0500
Message-Id: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
Subject: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit buffer
 is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

This fixes that situation by explicitly lowering the IRQ when a
character is written to the buffer.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/char/escc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..bea55ad8da 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -509,6 +509,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         break;
     case SERIAL_DATA:
         trace_escc_mem_writeb_data(CHN_C(s), val);
+        qemu_irq_lower(s->irq);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
             if (qemu_chr_fe_backend_connected(&s->chr)) {
-- 
2.17.2 (Apple Git-113)
