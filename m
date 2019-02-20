Received: from eggs.gnu.org ([209.51.188.92]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQP-0005cx-VS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGN4-0003r2-PH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:08:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:19 +0100
Message-Id: <20190220010232.18731-13-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/25] xen: Let buffer_append() return the
 size consumed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The buffer.size and buffer.consumed fields are only updated within the
buffer_append() body. We can simply let buffer_append() return the
difference (the buffer consumed).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/xen_console.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 083b2c8e2a..1a30014a11 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -48,7 +48,7 @@ struct XenConsole {
     int               backlog;
 };
=20
-static void buffer_append(struct XenConsole *con)
+static ssize_t buffer_append(struct XenConsole *con)
 {
     struct buffer *buffer =3D &con->buffer;
     XENCONS_RING_IDX cons, prod, size;
@@ -59,8 +59,9 @@ static void buffer_append(struct XenConsole *con)
     xen_mb();
=20
     size =3D prod - cons;
-    if ((size =3D=3D 0) || (size > sizeof(intf->out)))
-        return;
+    if ((size =3D=3D 0) || (size > sizeof(intf->out))) {
+        goto out;
+    }
=20
     if ((buffer->capacity - buffer->size) < size) {
         buffer->capacity +=3D (size + 1024);
@@ -89,6 +90,9 @@ static void buffer_append(struct XenConsole *con)
         if (buffer->consumed > buffer->max_capacity - over)
             buffer->consumed =3D buffer->max_capacity - over;
     }
+
+ out:
+    return buffer->size - buffer->consumed;
 }
=20
 static void buffer_advance(struct buffer *buffer, size_t len)
@@ -281,8 +285,7 @@ static void con_event(struct XenLegacyDevice *xendev)
     struct XenConsole *con =3D container_of(xendev, struct XenConsole, x=
endev);
     ssize_t size;
=20
-    buffer_append(con);
-    size =3D con->buffer.size - con->buffer.consumed;
+    size =3D buffer_append(con);
     if (size) {
         xencons_send(con, size);
     }
--=20
2.20.1
