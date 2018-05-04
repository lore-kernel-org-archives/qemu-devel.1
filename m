Received: from eggs.gnu.org ([2001:4830:134:3::10]:51594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ7-0005bY-L1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ6-0000Ua-Ri
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ6-0000Q4-Ky
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ5-00030U-IS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:19 +0100
Message-Id: <20180504171540.25813-4-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/24] hw/char/cmsdk-apb-uart.c: Accept more
 input after character read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Patrick Oppenlander <patrick.oppenlander@gmail.com>

The character frontend needs to be notified that the uart receive buffer
is empty and ready to handle another character.

Previously, the uart only worked correctly when receiving one character
at a time.

Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Message-id: CAEg67GkRTw=cXei3o9hvpxG_L4zSrNzR0bFyAgny+sSEUb_kPw@mail.gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/cmsdk-apb-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 9c0929d8a2..ddfbb25c24 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -157,6 +157,7 @@ static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
         r = s->rxbuf;
         s->state &= ~R_STATE_RXFULL_MASK;
         cmsdk_apb_uart_update(s);
+        qemu_chr_fe_accept_input(&s->chr);
         break;
     case A_STATE:
         r = s->state;
-- 
2.17.0
