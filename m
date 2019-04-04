Received: from eggs.gnu.org ([209.51.188.92]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBwa3-0006Mj-9x
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBwa2-0001XM-Ev
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:14:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  4 Apr 2019 09:14:21 +0200
Message-Id: <20190404071421.4891-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should not be
 user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org

The i8042 PS/2 controller is part of the chipset on the motherboard.
It is instantiated by the machine init code, and it does not make sense
to allow the user to plug an additional i8042 in any of the free ISA slot=
s.
Thus let's mark the device with user_creatable =3D false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/pckbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 47a606f5e3..af393818fc 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -568,6 +568,8 @@ static void i8042_class_initfn(ObjectClass *klass, vo=
id *data)
     dc->realize =3D i8042_realizefn;
     dc->vmsd =3D &vmstate_kbd_isa;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    /* i8042 is a device on the motherboard, and not pluggable by the us=
er */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo i8042_info =3D {
--=20
2.21.0
