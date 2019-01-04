Received: from eggs.gnu.org ([208.118.235.92]:52429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTmj-00052r-Ot
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTmf-0005KY-Kt
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:01:27 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 18:58:40 +0100
Message-Id: <20190104175847.6290-10-philmd@redhat.com>
In-Reply-To: <20190104175847.6290-1-philmd@redhat.com>
References: <20190104175847.6290-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/16] hw/devices: Move TI touchscreen
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since uWireSlave is only used in this new header, there is no
need to expose it via "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                     |  2 ++
 hw/arm/nseries.c                |  2 +-
 hw/arm/palm.c                   |  2 +-
 hw/input/tsc2005.c              |  2 +-
 hw/input/tsc210x.c              |  4 ++--
 include/hw/arm/omap.h           |  6 +-----
 include/hw/devices.h            | 14 --------------
 include/hw/input/ti_uwire_tsc.h | 28 ++++++++++++++++++++++++++++
 include/qemu/typedefs.h         |  1 -
 9 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/input/ti_uwire_tsc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03872552ee..4722805d9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -642,6 +642,7 @@ S: Odd Fixes
 F: hw/arm/nseries.c
 F: hw/input/tsc2*.c
 F: include/hw/display/blizzard.h
+F: include/hw/input/ti_uwire_tsc.h
 F: include/hw/misc/cbus.h
=20
 Palm
@@ -651,6 +652,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/palm.c
 F: hw/input/tsc2*.c
+F: include/hw/input/ti_uwire_tsc.h
=20
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index ac876b5878..f1c94ca607 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -30,8 +30,8 @@
 #include "ui/console.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
-#include "hw/devices.h"
 #include "hw/display/blizzard.h"
+#include "hw/input/ti_uwire_tsc.h"
 #include "hw/misc/cbus.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 285f43709d..2327a25be3 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -26,7 +26,7 @@
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
+#include "hw/input/ti_uwire_tsc.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 2b9108a193..d3c79f7825 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -23,7 +23,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/devices.h"
+#include "hw/input/ti_uwire_tsc.h"
 #include "trace.h"
=20
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 1cad57f644..8e4c282989 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -24,8 +24,8 @@
 #include "audio/audio.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/arm/omap.h"	/* For I2SCodec and uWireSlave */
-#include "hw/devices.h"
+#include "hw/arm/omap.h"            /* For I2SCodec */
+#include "hw/input/ti_uwire_tsc.h"
=20
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e7fbd340f3..fc0fe4f7a2 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,6 +20,7 @@
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
+#include "hw/input/ti_uwire_tsc.h"
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
index d9c06de7ab..ba9034050b 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -11,18 +11,4 @@ void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
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
diff --git a/include/hw/input/ti_uwire_tsc.h b/include/hw/input/ti_uwire_=
tsc.h
new file mode 100644
index 0000000000..0f8f296bc3
--- /dev/null
+++ b/include/hw/input/ti_uwire_tsc.h
@@ -0,0 +1,28 @@
+#ifndef HW_INPUT_TI_UWIRE_TOUCHSCREEN_H
+#define HW_INPUT_TI_UWIRE_TOUCHSCREEN_H
+
+/* TI 4/8-wire resistive touch screen converters */
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
index d59df20c4d..5d2b2925fb 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -111,7 +111,6 @@ typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SMBusDevice SMBusDevice;
 typedef struct SSIBus SSIBus;
-typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
--=20
2.17.2
