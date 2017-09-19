Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHgC-0004yA-At
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHg6-0005yw-4L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:31:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Sep 2017 09:30:53 -0300
Message-Id: <20170919123053.32675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/audio/wm8750: move WM8750 declarations from
 i2c/i2c.h to audio/wm8750.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

while here use TYPE_WM8750 and declare a data_req_cb() typedef.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index 0000000000..9ff976d4b8
--- /dev/null
+++ b/include/hw/audio/wm8750.h
@@ -0,0 +1,30 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
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
+void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *opaque);
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
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
 
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
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ab4ba31a24..b5e25d417c 100644
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
@@ -1699,7 +1700,7 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15));
     }
 
-    wm8750_dev = i2c_create_slave(i2c, "wm8750", MP_WM_ADDR);
+    wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev = qdev_create(NULL, "mv88w8618_audio");
     s = SYS_BUS_DEVICE(dev);
     qdev_prop_set_ptr(dev, "wm8750", wm8750_dev);
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 6406421d0c..2ae611d785 100644
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
 
     /* Attach a WM8750 to the bus */
-    wm = i2c_create_slave(bus, "wm8750", 0);
+    wm = i2c_create_slave(bus, TYPE_WM8750, 0);
 
     spitz_wm8750_addr(wm, 0, 0);
     qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 417bc1ac33..4541dc3054 100644
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
@@ -350,7 +351,7 @@ static void z2_init(MachineState *machine)
     z2_lcd = ssi_create_slave(mpu->ssp[1], "zipit-lcd");
     bus = pxa2xx_i2c_bus(mpu->i2c[0]);
     i2c_create_slave(bus, TYPE_AER915, 0x55);
-    wm = i2c_create_slave(bus, "wm8750", 0x1b);
+    wm = i2c_create_slave(bus, TYPE_WM8750, 0x1b);
     mpu->i2s->opaque = wm;
     mpu->i2s->codec_out = wm8750_dac_dat;
     mpu->i2s->codec_in = wm8750_adc_dat;
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
 
 #define MP_AUDIO_SIZE           0x00001000
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index d2bf2e1da1..7624bc1bf0 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -8,8 +8,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 
 #define IN_PORT_N	3
@@ -24,7 +24,6 @@ typedef struct {
     int dac_hz;
 } WMRate;
 
-#define TYPE_WM8750 "wm8750"
 #define WM8750(obj) OBJECT_CHECK(WM8750State, (obj), TYPE_WM8750)
 
 typedef struct WM8750State {
@@ -637,8 +636,7 @@ static void wm8750_fini(I2CSlave *i2c)
 }
 #endif
 
-void wm8750_data_req_set(DeviceState *dev,
-                void (*data_req)(void *, int, int), void *opaque)
+void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *opaque)
 {
     WM8750State *s = WM8750(dev);
 
-- 
2.14.1
