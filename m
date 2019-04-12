Received: from eggs.gnu.org ([209.51.188.92]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzS4-0001CC-GJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzS2-0007US-HI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:54:56 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:12 +0200
Message-Id: <20190412165416.7977-9-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/12] hw/devices: Move TI touchscreen
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Since uWireSlave is only used in this new header, there is no
need to expose it via "qemu/typedefs.h".

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3:
 Drop "TI 4/8-wire resistive touch screen converters" comment (Markus)
---
 MAINTAINERS                |  2 ++
 hw/arm/nseries.c           |  2 +-
 hw/arm/palm.c              |  2 +-
 hw/input/tsc2005.c         |  2 +-
 hw/input/tsc210x.c         |  4 ++--
 include/hw/arm/omap.h      |  6 +-----
 include/hw/devices.h       | 15 ---------------
 include/hw/input/tsc2xxx.h | 36 ++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h    |  1 -
 9 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/input/tsc2xxx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e7c3d282a0a..b31260189ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -669,6 +669,7 @@ F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
 F: include/hw/display/blizzard.h
+F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
=20
 Palm
@@ -678,6 +679,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/palm.c
 F: hw/input/tsc210x.c
+F: include/hw/input/tsc2xxx.h
=20
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 6889f13d699..303f7a31e1c 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -30,8 +30,8 @@
 #include "ui/console.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
-#include "hw/devices.h"
 #include "hw/display/blizzard.h"
+#include "hw/input/tsc2xxx.h"
 #include "hw/misc/cbus.h"
 #include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 285f43709dd..139d27d1cc0 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -26,7 +26,7 @@
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
+#include "hw/input/tsc2xxx.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 2b9108a1932..f82771e7a7c 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -23,7 +23,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/devices.h"
+#include "hw/input/tsc2xxx.h"
 #include "trace.h"
=20
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 41731619bb6..f94cb4683bf 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -24,8 +24,8 @@
 #include "audio/audio.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/arm/omap.h"	/* For I2SCodec and uWireSlave */
-#include "hw/devices.h"
+#include "hw/arm/omap.h"            /* For I2SCodec */
+#include "hw/input/tsc2xxx.h"
=20
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e7fbd340f37..9de867daa46 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,6 +20,7 @@
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
+#include "hw/input/tsc2xxx.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
=20
@@ -679,11 +680,6 @@ qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
 void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handl=
er);
 void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
=20
-struct uWireSlave {
-    uint16_t (*receive)(void *opaque);
-    void (*send)(void *opaque, uint16_t data);
-    void *opaque;
-};
 struct omap_uwire_s;
 void omap_uwire_attach(struct omap_uwire_s *s,
                 uWireSlave *slave, int chipselect);
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 7a630da47f7..ba9034050b4 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -4,7 +4,6 @@
 /* Devices that have nowhere better to go.  */
=20
 #include "hw/hw.h"
-#include "ui/console.h"
=20
 /* smc91c111.c */
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
@@ -12,18 +11,4 @@ void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
 /* lan9118.c */
 void lan9118_init(NICInfo *, uint32_t, qemu_irq);
=20
-/* tsc210x.c */
-uWireSlave *tsc2102_init(qemu_irq pint);
-uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
-I2SCodec *tsc210x_codec(uWireSlave *chip);
-uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
-void tsc210x_set_transform(uWireSlave *chip,
-                MouseTransformInfo *info);
-void tsc210x_key_event(uWireSlave *chip, int key, int down);
-
-/* tsc2005.c */
-void *tsc2005_init(qemu_irq pintdav);
-uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
-void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
-
 #endif
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
new file mode 100644
index 00000000000..dbfe5c55c1f
--- /dev/null
+++ b/include/hw/input/tsc2xxx.h
@@ -0,0 +1,36 @@
+/*
+ * TI touchscreen controller
+ *
+ * Copyright (c) 2006 Andrzej Zaborowski
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_INPUT_TSC2XXX_H
+#define HW_INPUT_TSC2XXX_H
+
+#include "hw/irq.h"
+#include "ui/console.h"
+
+typedef struct uWireSlave {
+    uint16_t (*receive)(void *opaque);
+    void (*send)(void *opaque, uint16_t data);
+    void *opaque;
+} uWireSlave;
+
+/* tsc210x.c */
+uWireSlave *tsc2102_init(qemu_irq pint);
+uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
+I2SCodec *tsc210x_codec(uWireSlave *chip);
+uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
+void tsc210x_set_transform(uWireSlave *chip, MouseTransformInfo *info);
+void tsc210x_key_event(uWireSlave *chip, int key, int down);
+
+/* tsc2005.c */
+void *tsc2005_init(qemu_irq pintdav);
+uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
+void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
+
+#endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e4a0a656d1c..fcdaae58c44 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -99,7 +99,6 @@ typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
-typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
--=20
2.20.1
