Received: from eggs.gnu.org ([2001:4830:134:3::10]:52997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcp7-0006kB-QI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcp2-0003UT-Lt
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:00:17 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 08:50:08 +0100
Message-Id: <20180202075009.11653-2-kraxel@redhat.com>
In-Reply-To: <20180202075009.11653-1-kraxel@redhat.com>
References: <20180202075009.11653-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] hw/audio/wm8750: move WM8750 declarations
 from i2c/i2c.h to audio/wm8750.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, "open list:Musicpal" <qemu-arm@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

while here use TYPE_WM8750 and declare a data_req_cb() typedef.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170919123053.32675-1-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/wm8750.h  | 30 ++++++++++++++++++++++++++++++
 include/hw/i2c/i2c.h       |  9 ---------
 hw/arm/musicpal.c          |  3 ++-
 hw/arm/spitz.c             |  3 ++-
 hw/arm/z2.c                |  3 ++-
 hw/audio/marvell_88w8618.c |  1 +
 hw/audio/wm8750.c          |  6 ++----
 7 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/audio/wm8750.h

diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
new file mode 100644
index 0000000000..84e7a119bb
--- /dev/null
+++ b/include/hw/audio/wm8750.h
@@ -0,0 +1,30 @@
+/*
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HW_DAC_WM8750_H
+#define HW_DAC_WM8750_H
+
+#include "hw/hw.h"
+
+#define TYPE_WM8750 "wm8750"
+
+typedef void data_req_cb(void *opaque, int free_out, int free_in);
+
+void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *=
opaque);
+void wm8750_dac_dat(void *opaque, uint32_t sample);
+uint32_t wm8750_adc_dat(void *opaque);
+void *wm8750_dac_buffer(void *opaque, int samples);
+void wm8750_dac_commit(void *opaque);
+void wm8750_set_bclk_in(void *opaque, int new_hz);
+
+#endif
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2ce611d4c8..24e95d0155 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -70,15 +70,6 @@ int i2c_recv(I2CBus *bus);
=20
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
=20
-/* wm8750.c */
-void wm8750_data_req_set(DeviceState *dev,
-                void (*data_req)(void *, int, int), void *opaque);
-void wm8750_dac_dat(void *opaque, uint32_t sample);
-uint32_t wm8750_adc_dat(void *opaque);
-void *wm8750_dac_buffer(void *opaque, int samples);
-void wm8750_dac_commit(void *opaque);
-void wm8750_set_bclk_in(void *opaque, int new_hz);
-
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
=20
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b648770882..4172caf5db 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -25,6 +25,7 @@
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
+#include "hw/audio/wm8750.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "ui/pixel_ops.h"
@@ -1691,7 +1692,7 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15))=
;
     }
=20
-    wm8750_dev =3D i2c_create_slave(i2c, "wm8750", MP_WM_ADDR);
+    wm8750_dev =3D i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev =3D qdev_create(NULL, "mv88w8618_audio");
     s =3D SYS_BUS_DEVICE(dev);
     qdev_prop_set_ptr(dev, "wm8750", wm8750_dev);
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index ac1e15cbbc..e419e3c00e 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -24,6 +24,7 @@
 #include "hw/devices.h"
 #include "hw/arm/sharpsl.h"
 #include "ui/console.h"
+#include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
@@ -745,7 +746,7 @@ static void spitz_i2c_setup(PXA2xxState *cpu)
     DeviceState *wm;
=20
     /* Attach a WM8750 to the bus */
-    wm =3D i2c_create_slave(bus, "wm8750", 0);
+    wm =3D i2c_create_slave(bus, TYPE_WM8750, 0);
=20
     spitz_wm8750_addr(wm, 0, 0);
     qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 60561c7b7c..300e933c82 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -23,6 +23,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "ui/console.h"
+#include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
@@ -346,7 +347,7 @@ static void z2_init(MachineState *machine)
     z2_lcd =3D ssi_create_slave(mpu->ssp[1], "zipit-lcd");
     bus =3D pxa2xx_i2c_bus(mpu->i2c[0]);
     i2c_create_slave(bus, TYPE_AER915, 0x55);
-    wm =3D i2c_create_slave(bus, "wm8750", 0x1b);
+    wm =3D i2c_create_slave(bus, TYPE_WM8750, 0x1b);
     mpu->i2s->opaque =3D wm;
     mpu->i2s->codec_out =3D wm8750_dac_dat;
     mpu->i2s->codec_in =3D wm8750_adc_dat;
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 4f65f8c199..e546892d3c 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/audio/wm8750.h"
 #include "audio/audio.h"
=20
 #define MP_AUDIO_SIZE           0x00001000
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 6d8b728923..416a78e869 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -8,8 +8,8 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/audio/wm8750.h"
 #include "audio/audio.h"
=20
 #define IN_PORT_N	3
@@ -24,7 +24,6 @@ typedef struct {
     int dac_hz;
 } WMRate;
=20
-#define TYPE_WM8750 "wm8750"
 #define WM8750(obj) OBJECT_CHECK(WM8750State, (obj), TYPE_WM8750)
=20
 typedef struct WM8750State {
@@ -639,8 +638,7 @@ static void wm8750_fini(I2CSlave *i2c)
 }
 #endif
=20
-void wm8750_data_req_set(DeviceState *dev,
-                void (*data_req)(void *, int, int), void *opaque)
+void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *=
opaque)
 {
     WM8750State *s =3D WM8750(dev);
=20
--=20
2.9.3
