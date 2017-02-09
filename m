Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbN-0004ty-U7
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbJ-0003Fa-Mw
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:41 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:10539 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cbqbJ-0003FB-5K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:37 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  9 Feb 2017 18:25:34 +0300
Message-Id: <1486653934-14805-3-git-send-email-den@openvz.org>
In-Reply-To: <1486653934-14805-1-git-send-email-den@openvz.org>
References: <1486653934-14805-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] virtio-console: chardev hotswap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
---
 hw/char/virtio-console.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 798d9b6..4827219 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -163,6 +163,29 @@ static void chr_event(void *opaque, int event)
     }
 }
=20
+static int chr_be_change(void *opaque)
+{
+    VirtConsole *vcon =3D opaque;
+    VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(vcon);
+    VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(port);
+
+    if (k->is_console) {
+        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
+                                 NULL, vcon, NULL, true);
+    } else {
+        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
+                                 chr_event, vcon, NULL, false);
+    }
+    if (vcon->watch) {
+        g_source_remove(vcon->watch);
+        vcon->watch =3D qemu_chr_fe_add_watch(&vcon->chr,
+                                            G_IO_OUT | G_IO_HUP,
+                                            chr_write_unblocked, vcon);
+    }
+
+    return 0;
+}
+
 static void virtconsole_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(dev);
@@ -194,6 +217,7 @@ static void virtconsole_realize(DeviceState *dev, Err=
or **errp)
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                      chr_event, vcon, NULL, false);
         }
+        qemu_chr_fe_set_be_change_handler(&vcon->chr, chr_be_change);
     }
 }
=20
--=20
2.7.4
