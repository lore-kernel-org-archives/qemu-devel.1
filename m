Received: from eggs.gnu.org ([2001:4830:134:3::10]:43144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4P-0004se-NU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4O-0005Wm-NJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:07 +0200
Message-Id: <20170713163219.9024-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/29] virtio-serial: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f5bc173844..17a1bb008a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -663,7 +663,7 @@ static void virtio_serial_save_device(VirtIODevice *v=
dev, QEMUFile *f)
=20
     /* The ports map */
     max_nr_ports =3D s->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         qemu_put_be32s(f, &s->ports_map[i]);
     }
=20
@@ -798,7 +798,7 @@ static int virtio_serial_load_device(VirtIODevice *vd=
ev, QEMUFile *f,
     qemu_get_be32s(f, &tmp);
=20
     max_nr_ports =3D s->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         qemu_get_be32s(f, &ports_map);
=20
         if (ports_map !=3D s->ports_map[i]) {
@@ -863,7 +863,7 @@ static uint32_t find_free_port_id(VirtIOSerial *vser)
     unsigned int i, max_nr_ports;
=20
     max_nr_ports =3D vser->serial.max_virtserial_ports;
-    for (i =3D 0; i < (max_nr_ports + 31) / 32; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
         uint32_t map, zeroes;
=20
         map =3D vser->ports_map[i];
@@ -1075,7 +1075,7 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
         vser->ovqs[i] =3D virtio_add_queue(vdev, 128, handle_output);
     }
=20
-    vser->ports_map =3D g_malloc0(((vser->serial.max_virtserial_ports + =
31) / 32)
+    vser->ports_map =3D g_malloc0((DIV_ROUND_UP(vser->serial.max_virtser=
ial_ports, 32))
         * sizeof(vser->ports_map[0]));
     /*
      * Reserve location 0 for a console port for backward compat
--=20
2.13.1.395.gf7b71de06
