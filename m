Received: from eggs.gnu.org ([2001:4830:134:3::10]:51776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4M-0001oj-1v
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4H-0004Gx-W8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4H-0004Gg-PJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so9397780wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:13 +0200
Message-Id: <1499955874-10954-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] serial: chardev hotswap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

This allows to change the port's backend runtime, e.g. change it from
file to a socket making it possible to establish a debug session with
WinDbg

> qemu-system [..] -chardev file,id=charchannel2,path=/tmp/charchannel2 \
  -device isa-serial,chardev=charchannel2,id=channel2

QEMU 2.9.50 monitor - type 'help' for more information
(qemu) chardev-change charchannel2 \
  socket,host=127.0.0.1,port=4242,server,nowait

For a backend change, a number of ioctls has to be replayed to sync
the current setup of a frontend to a backend tty. This is hopefully
enough so we don't have to track, store and replay the whole original
control byte sequence.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1499342940-56739-14-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 09157f9..9aec6c6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -891,6 +891,34 @@ static void serial_reset(void *opaque)
     s->msr &= ~UART_MSR_ANY_DELTA;
 }
 
+static int serial_be_change(void *opaque)
+{
+    SerialState *s = opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
+                             serial_event, serial_be_change, s, NULL, true);
+
+    serial_update_parameters(s);
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
+                      &s->last_break_enable);
+
+    s->poll_msl = (s->ier & UART_IER_MSI) ? 1 : 0;
+    serial_update_msl(s);
+
+    if (s->poll_msl >= 0 && !(s->mcr & UART_MCR_LOOP)) {
+        serial_update_tiocm(s);
+    }
+
+    if (s->watch_tag > 0) {
+        g_source_remove(s->watch_tag);
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             serial_watch_cb, s);
+    }
+
+    return 0;
+}
+
 void serial_realize_core(SerialState *s, Error **errp)
 {
     if (!qemu_chr_fe_backend_connected(&s->chr)) {
@@ -904,7 +932,7 @@ void serial_realize_core(SerialState *s, Error **errp)
     qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
-                             serial_event, NULL, s, NULL, true);
+                             serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
     serial_reset(s);
-- 
1.8.3.1
