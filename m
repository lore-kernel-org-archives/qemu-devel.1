Received: from eggs.gnu.org ([209.51.188.92]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gooXp-0005GM-Gb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gooXn-0000at-Q1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gooXn-0000Wg-Da
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:00:39 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 30 Jan 2019 13:00:05 +0100
Message-Id: <20190130120005.23123-5-philmd@redhat.com>
In-Reply-To: <20190130120005.23123-1-philmd@redhat.com>
References: <20190130120005.23123-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/4] hw/display/milkymist-tmu2: Move inlined
 code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Move the complexity of milkymist_tmu2_create() into the
source file. Doing so we avoid to include the X11/OpenGL
headers in all LM32 devices, and we also avoid the duplicate
declaration of glx_fbconfig_attr[] (it is already declared
in hw/display/milkymist-tmu2.c).
Since TYPE_MILKYMIST_TMU2 is now accessible, use it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                         |  1 +
 hw/display/milkymist-tmu2.c         | 49 ++++++++++++++++++++++
 hw/lm32/milkymist-hw.h              | 63 -----------------------------
 hw/lm32/milkymist.c                 |  1 +
 include/hw/display/milkymist_tmu2.h | 41 +++++++++++++++++++
 5 files changed, 92 insertions(+), 63 deletions(-)
 create mode 100644 include/hw/display/milkymist_tmu2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b334b53979..737a33b102 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -185,6 +185,7 @@ F: disas/lm32.c
 F: hw/lm32/
 F: hw/*/lm32_*
 F: hw/*/milkymist-*
+F: include/hw/display/milkymist_tmu2.h
 F: include/hw/char/lm32_juart.h
 F: include/hw/lm32/
 F: tests/tcg/lm32/
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 3ce44fdfce..b33fc234e9 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "hw/display/milkymist_tmu2.h"
=20
 #include <X11/Xlib.h>
 #include <epoxy/gl.h>
@@ -499,3 +500,51 @@ static void milkymist_tmu2_register_types(void)
 }
=20
 type_init(milkymist_tmu2_register_types)
+
+DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq irq)
+{
+    DeviceState *dev;
+    Display *d;
+    GLXFBConfig *configs;
+    int nelements;
+    int ver_major, ver_minor;
+
+    /* check that GLX will work */
+    d =3D XOpenDisplay(NULL);
+    if (d =3D=3D NULL) {
+        return NULL;
+    }
+
+    if (!glXQueryVersion(d, &ver_major, &ver_minor)) {
+        /*
+         * Yeah, sometimes getting the GLX version can fail.
+         * Isn't X beautiful?
+         */
+        XCloseDisplay(d);
+        return NULL;
+    }
+
+    if ((ver_major < 1) || ((ver_major =3D=3D 1) && (ver_minor < 3))) {
+        printf("Your GLX version is %d.%d,"
+          "but TMU emulation needs at least 1.3. TMU disabled.\n",
+          ver_major, ver_minor);
+        XCloseDisplay(d);
+        return NULL;
+    }
+
+    configs =3D glXChooseFBConfig(d, 0, glx_fbconfig_attr, &nelements);
+    if (configs =3D=3D NULL) {
+        XCloseDisplay(d);
+        return NULL;
+    }
+
+    XFree(configs);
+    XCloseDisplay(d);
+
+    dev =3D qdev_create(NULL, TYPE_MILKYMIST_TMU2);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+
+    return dev;
+}
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 32c344ef9f..976cf9254d 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -88,69 +88,6 @@ static inline DeviceState *milkymist_pfpu_create(hwadd=
r base,
     return dev;
 }
=20
-#if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
-#include <X11/Xlib.h>
-#include <epoxy/gl.h>
-#include <epoxy/glx.h>
-static const int glx_fbconfig_attr[] =3D {
-    GLX_GREEN_SIZE, 5,
-    GLX_GREEN_SIZE, 6,
-    GLX_BLUE_SIZE, 5,
-    None
-};
-#endif
-
-static inline DeviceState *milkymist_tmu2_create(hwaddr base,
-        qemu_irq irq)
-{
-#if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
-    DeviceState *dev;
-    Display *d;
-    GLXFBConfig *configs;
-    int nelements;
-    int ver_major, ver_minor;
-
-    /* check that GLX will work */
-    d =3D XOpenDisplay(NULL);
-    if (d =3D=3D NULL) {
-        return NULL;
-    }
-
-    if (!glXQueryVersion(d, &ver_major, &ver_minor)) {
-        /* Yeah, sometimes getting the GLX version can fail.
-         * Isn't X beautiful? */
-        XCloseDisplay(d);
-        return NULL;
-    }
-
-    if ((ver_major < 1) || ((ver_major =3D=3D 1) && (ver_minor < 3))) {
-        printf("Your GLX version is %d.%d,"
-          "but TMU emulation needs at least 1.3. TMU disabled.\n",
-          ver_major, ver_minor);
-        XCloseDisplay(d);
-        return NULL;
-    }
-
-    configs =3D glXChooseFBConfig(d, 0, glx_fbconfig_attr, &nelements);
-    if (configs =3D=3D NULL) {
-        XCloseDisplay(d);
-        return NULL;
-    }
-
-    XFree(configs);
-    XCloseDisplay(d);
-
-    dev =3D qdev_create(NULL, "milkymist-tmu2");
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
-
-    return dev;
-#else
-    return NULL;
-#endif
-}
-
 static inline DeviceState *milkymist_ac97_create(hwaddr base,
         qemu_irq crrequest_irq, qemu_irq crreply_irq, qemu_irq dmar_irq,
         qemu_irq dmaw_irq)
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 63c6894c95..26a2398354 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -32,6 +32,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "milkymist-hw.h"
+#include "hw/display/milkymist_tmu2.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
=20
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/mil=
kymist_tmu2.h
new file mode 100644
index 0000000000..148a119a1d
--- /dev/null
+++ b/include/hw/display/milkymist_tmu2.h
@@ -0,0 +1,41 @@
+/*
+ *  QEMU model of the Milkymist texture mapping unit.
+ *
+ *  Copyright (c) 2010 Michael Walle <michael@walle.cc>
+ *  Copyright (c) 2010 Sebastien Bourdeauducq
+ *                       <sebastien.bourdeauducq@lekernel.net>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ *
+ * Specification available at:
+ *   http://milkymist.walle.cc/socdoc/tmu2.pdf
+ *
+ */
+
+#ifndef HW_DISPLAY_MILKYMIST_TMU2_H
+#define HW_DISPLAY_MILKYMIST_TMU2_H
+
+#include "hw/qdev.h"
+
+#if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
+DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq irq);
+#else
+static inline DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq i=
rq)
+{
+    return NULL;
+}
+#endif
+
+#endif /* HW_DISPLAY_MILKYMIST_TMU2_H */
--=20
2.20.1
