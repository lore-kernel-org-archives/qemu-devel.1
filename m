Received: from eggs.gnu.org ([2001:4830:134:3::10]:36116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5cH-000635-PH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5cD-000588-Fy
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:41 -0400
Received: from mail-ve1eur01on0096.outbound.protection.outlook.com
	([104.47.1.96]:63928
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5cC-000559-QM
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:37 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:58 +0300
Message-Id: <1499342940-56739-12-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 11/13] virtio-console: chardev hotswap
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
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

In case of a backend change, the handler functions and the watch have
to be reset.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.7.4
