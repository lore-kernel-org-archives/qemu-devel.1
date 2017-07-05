Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSktB-0004uP-L6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dSkt7-0007v7-OT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:45 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com
	([40.107.3.130]:12006
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dSkt7-0007ts-9d
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:41 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  5 Jul 2017 17:02:04 +0300
Message-Id: <1499263324-15184-14-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499263324-15184-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 13/13] serial: chardev hotswap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

for a backend change, a number of ioctls has to be replayed to sync
the current setup of a frontend to a backend tty. This is hopefully
enough so we don't have to track, store and replay the whole original
control byte sequence.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/char/serial.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index e47f0b6..9aec6c6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -891,9 +891,37 @@ static void serial_reset(void *opaque)
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
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         error_setg(errp, "Can't create serial device, empty char device");
         return;
     }
@@ -904,7 +932,7 @@ void serial_realize_core(SerialState *s, Error **errp)
     qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
-                             serial_event, NULL, s, NULL, true);
+                             serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
     serial_reset(s);
-- 
2.7.4
