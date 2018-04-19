Received: from eggs.gnu.org ([2001:4830:134:3::10]:48920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.oppenlander@gmail.com>) id 1f9JKB-0005PK-TN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.oppenlander@gmail.com>) id 1f9JKB-0002Q4-5q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:50:47 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.oppenlander@gmail.com>)
	id 1f9JKB-0002Ol-1D
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:50:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id o64so7214665qkl.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 16:50:46 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date: Fri, 20 Apr 2018 09:50:45 +1000
Message-ID: <CAEg67GkRTw=cXei3o9hvpxG_L4zSrNzR0bFyAgny+sSEUb_kPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-uart.c: Accept more input
 after character read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The character frontend needs to be notified that the uart receive buffer
is empty and ready to handle another character.

Previously, the uart only worked correctly when receiving one character
at a time.

Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
---
 hw/char/cmsdk-apb-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 9c0929d8a2..ddfbb25c24 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -157,6 +157,7 @@ static uint64_t uart_read(void *opaque, hwaddr
offset, unsigned size)
         r = s->rxbuf;
         s->state &= ~R_STATE_RXFULL_MASK;
         cmsdk_apb_uart_update(s);
+        qemu_chr_fe_accept_input(&s->chr);
         break;
     case A_STATE:
         r = s->state;
-- 
2.17.0
