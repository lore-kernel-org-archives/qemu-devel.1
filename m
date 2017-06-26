Received: from eggs.gnu.org ([2001:4830:134:3::10]:55704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXAd-0002uI-1V
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXAZ-0003BS-R2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:26 -0400
Received: from mail-eopbgr50131.outbound.protection.outlook.com
	([40.107.5.131]:8588
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPXAZ-0003AV-C1
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:23 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:48 +0300
Message-Id: <1498495550-72357-12-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 11/13] virtio-console: chardev hotswap
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, Amit Shah <amit@kernel.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Amit Shah <amit@kernel.org>
---
 hw/char/virtio-console.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index afb4949..198b2a8 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -49,7 +49,7 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     VirtConsole *vcon = VIRTIO_CONSOLE(port);
     ssize_t ret;
 
-    if (!qemu_chr_fe_get_driver(&vcon->chr)) {
+    if (!qemu_chr_fe_backend_connected(&vcon->chr)) {
         /* If there's no backend, we can just say we consumed all data. */
         return len;
     }
@@ -163,12 +163,35 @@ static void chr_event(void *opaque, int event)
     }
 }
 
+static int chr_be_change(void *opaque)
+{
+    VirtConsole *vcon = opaque;
+    VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
+    VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+
+    if (k->is_console) {
+        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
+                                 NULL, chr_be_change, vcon, NULL, true);
+    } else {
+        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
+                                 chr_event, chr_be_change, vcon, NULL, false);
+    }
+
+    if (vcon->watch) {
+        g_source_remove(vcon->watch);
+        vcon->watch = qemu_chr_fe_add_watch(&vcon->chr,
+                                            G_IO_OUT | G_IO_HUP,
+                                            chr_write_unblocked, vcon);
+    }
+
+    return 0;
+}
+
 static void virtconsole_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
-    Chardev *chr = qemu_chr_fe_get_driver(&vcon->chr);
 
     if (port->id == 0 && !k->is_console) {
         error_setg(errp, "Port number 0 on virtio-serial devices reserved "
@@ -176,7 +199,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (chr) {
+    if (qemu_chr_fe_backend_connected(&vcon->chr)) {
         /*
          * For consoles we don't block guest data transfer just
          * because nothing is connected - we'll just let it go
@@ -188,11 +211,13 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, NULL, vcon, NULL, true);
+                                     NULL, chr_be_change,
+                                     vcon, NULL, true);
             virtio_serial_open(port);
         } else {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     chr_event, NULL, vcon, NULL, false);
+                                     chr_event, chr_be_change,
+                                     vcon, NULL, false);
         }
     }
 }
-- 
2.7.4
