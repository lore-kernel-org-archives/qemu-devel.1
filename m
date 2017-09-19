Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHzL-0004gc-LH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHzH-0003XD-6D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:50:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Sep 2017 09:50:41 -0300
Message-Id: <20170919125041.2153-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/input/lm832x: move LM8323 declarations to
 input/keypad.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 20170919123053.32675-1-f4bug@amsat.org

$ ./scripts/get_maintainer.pl -f hw/input/lm832x.c
get_maintainer.pl: No maintainers found, printing recent contributors.

 include/hw/i2c/i2c.h      |  3 ---
 include/hw/input/keypad.h | 23 +++++++++++++++++++++++
 hw/arm/nseries.c          |  3 ++-
 hw/input/lm832x.c         |  3 +--
 4 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/input/keypad.h

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 24e95d0155..8fdf3e47d6 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -70,9 +70,6 @@ int i2c_recv(I2CBus *bus);
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
 
-/* lm832x.c */
-void lm832x_key_event(DeviceState *dev, int key, int state);
-
 extern const VMStateDescription vmstate_i2c_slave;
 
 #define VMSTATE_I2C_SLAVE(_field, _state) {                          \
diff --git a/include/hw/input/keypad.h b/include/hw/input/keypad.h
new file mode 100644
index 0000000000..efacef6458
--- /dev/null
+++ b/include/hw/input/keypad.h
@@ -0,0 +1,23 @@
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
+#ifndef HW_KEYPAD_H
+#define HW_KEYPAD_H
+
+#include "hw/hw.h"
+
+#define TYPE_LM8323 "lm8323"
+
+void lm832x_key_event(DeviceState *dev, int key, int state);
+
+#endif
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a32ac82702..594b7e878c 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -30,6 +30,7 @@
 #include "ui/console.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
+#include "hw/input/keypad.h"
 #include "hw/devices.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
@@ -412,7 +413,7 @@ static void n810_kbd_setup(struct n800_s *s)
     /* Attach the LM8322 keyboard to the I2C bus,
      * should happen in n8x0_i2c_setup and s->kbd be initialised here.  */
     s->kbd = i2c_create_slave(omap_i2c_bus(s->mpu->i2c[0]),
-                           "lm8323", N810_LM8323_ADDR);
+                              TYPE_LM8323, N810_LM8323_ADDR);
     qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
 }
 
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 2340523da0..868ddfe5ea 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -19,12 +19,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/input/keypad.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
 
-#define TYPE_LM8323 "lm8323"
 #define LM8323(obj) OBJECT_CHECK(LM823KbdState, (obj), TYPE_LM8323)
 
 typedef struct {
-- 
2.14.1
