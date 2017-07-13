Received: from eggs.gnu.org ([2001:4830:134:3::10]:51749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4H-0001lx-UT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4D-0004Ct-SV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4D-0004BZ-Kj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id n18so1462190wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:11 +0200
Message-Id: <1499955874-10954-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/41] virtio-console: chardev hotswap support
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

In case of a backend change, the handler functions and the watch have
to be reset.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1499342940-56739-12-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/virtio-console.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4d3967c..198b2a8 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -163,6 +163,30 @@ static void chr_event(void *opaque, int event)
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
@@ -187,11 +211,13 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
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
1.8.3.1
