Received: from eggs.gnu.org ([2001:4830:134:3::10]:37811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAP-00074B-9s
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAN-0008WR-Qq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:21 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAN-0008Tv-KM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:19 -0400
Received: by mail-wr0-x231.google.com with SMTP id c13-v6so6679841wrq.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:15 +0200
Message-Id: <1530216310-52873-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/60] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>

From: Sergio Lopez <slp@redhat.com>

Only retry on serial_xmit if qemu_chr_fe_write returns 0, as this is the
only recoverable error.

Retrying with any other scenario, in addition to being a waste of CPU
cycles, can compromise the Guest stability if by the vCPU issuing the
write and the main loop thread are, by chance or explicit pinning,
running on the same pCPU.

Previous discussion:

https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06998.html

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <1528185295-14199-1-git-send-email-slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 605b0d0..6de6c29 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -260,7 +260,7 @@ static void serial_xmit(SerialState *s)
         if (s->mcr & UART_MCR_LOOP) {
             /* in loopback mode, say that we just received a char */
             serial_receive1(s, &s->tsr, 1);
-        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) != 1 &&
+        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) == 0 &&
                    s->tsr_retry < MAX_XMIT_RETRY) {
             assert(s->watch_tag == 0);
             s->watch_tag =
-- 
1.8.3.1
