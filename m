Received: from eggs.gnu.org ([209.51.188.92]:53827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbU-0007tg-4y
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbS-0006kp-B0
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAbO-0006dB-Hm
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:56 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 00:12:36 +0200
Message-Id: <20190404221238.12468-3-philmd@redhat.com>
In-Reply-To: <20190404221238.12468-1-philmd@redhat.com>
References: <20190404221238.12468-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 2/4] hw/isa/superio: Support more than
 one IDE bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The current code is limited to a single IDE bus (supporting
two IDE drives). Some Super I/O chipset provide two IDE buses
(four IDE drives).
Modify the model to support more that one IDE bus.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/isa-superio.c     | 43 ++++++++++++++++++++++------------------
 include/hw/isa/superio.h |  2 +-
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index c6845eaf578..b0761ea1f96 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -18,6 +18,7 @@
 #include "hw/isa/superio.h"
 #include "hw/input/i8042.h"
 #include "hw/char/serial.h"
+#include "hw/ide.h"
 #include "trace.h"
=20
 static void isa_superio_realize(DeviceState *dev, Error **errp)
@@ -30,7 +31,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
     Chardev *chr;
     DriveInfo *drive;
     char *name;
-    int i;
+    int i, j;
=20
     /* Parallel port */
     for (i =3D 0; i < k->parallel.count; i++) {
@@ -146,25 +147,29 @@ static void isa_superio_realize(DeviceState *dev, E=
rror **errp)
     s->kbc =3D isa_create_simple(bus, TYPE_I8042);
=20
     /* IDE */
-    if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(s, 0)))=
 {
-        isa =3D isa_create(bus, "isa-ide");
-        d =3D DEVICE(isa);
-        if (k->ide.get_iobase) {
-            qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(s, 0));
-        }
-        if (k->ide.get_iobase) {
-            qdev_prop_set_uint32(d, "iobase2", k->ide.get_iobase(s, 1));
-        }
-        if (k->ide.get_irq) {
-            qdev_prop_set_uint32(d, "irq", k->ide.get_irq(s, 0));
+    size_t bus_count =3D k->ide.count / MAX_IDE_DEVS;
+    s->ide =3D g_new(ISADevice *, bus_count);
+    for (i =3D 0, j =3D 0; i < bus_count; i++, j +=3D MAX_IDE_DEVS) {
+        if (!k->ide.is_enabled || k->ide.is_enabled(s, j)) {
+            isa =3D isa_create(bus, "isa-ide");
+            d =3D DEVICE(isa);
+            if (k->ide.get_iobase) {
+                qdev_prop_set_uint32(d, "iobase", k->ide.get_iobase(s, j=
));
+            }
+            if (k->ide.get_iobase) {
+                qdev_prop_set_uint32(d, "iobase2", k->ide.get_iobase(s, =
j + 1));
+            }
+            if (k->ide.get_irq) {
+                qdev_prop_set_uint32(d, "irq", k->ide.get_irq(s, j));
+            }
+            qdev_init_nofail(d);
+            s->ide[i] =3D isa;
+            trace_superio_create_ide(i,
+                                     k->ide.get_iobase ?
+                                     k->ide.get_iobase(s, j) : -1,
+                                     k->ide.get_irq ?
+                                     k->ide.get_irq(s, j) : -1);
         }
-        qdev_init_nofail(d);
-        s->ide =3D isa;
-        trace_superio_create_ide(0,
-                                 k->ide.get_iobase ?
-                                 k->ide.get_iobase(s, 0) : -1,
-                                 k->ide.get_irq ?
-                                 k->ide.get_irq(s, 0) : -1);
     }
 }
=20
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 345f0060817..980a9691696 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -33,7 +33,7 @@ typedef struct ISASuperIODevice {
     ISADevice *serial[SUPERIO_MAX_SERIAL_PORTS];
     ISADevice *floppy;
     ISADevice *kbc;
-    ISADevice *ide;
+    ISADevice **ide;
 } ISASuperIODevice;
=20
 typedef struct ISASuperIOFuncs {
--=20
2.20.1
