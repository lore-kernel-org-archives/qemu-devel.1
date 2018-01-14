Received: from eggs.gnu.org ([2001:4830:134:3::10]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYIf-00031N-IX
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYIe-0003Dv-Oj
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:45:33 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYIe-0003DG-Fg
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:45:32 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so2485688qtm.12
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:45:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:45:24 -0300
Message-Id: <20180114024524.28821-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/i2c: QOM'ify i2c slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 59068f157e..c84dbfb884 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/i2c/i2c.h"
 
 typedef struct I2CNode I2CNode;
@@ -276,16 +277,15 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-static int i2c_slave_qdev_init(DeviceState *dev)
+static void i2c_slave_realize(DeviceState *dev, Error **errp)
 {
     I2CSlave *s = I2C_SLAVE(dev);
     I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
 
-    if (sc->init) {
-        return sc->init(s);
+    if (sc->init && sc->init(s)) {
+        error_setg(errp, "i2c slave initialization failed");
+        return;
     }
-
-    return 0;
 }
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
@@ -301,7 +301,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 static void i2c_slave_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->init = i2c_slave_qdev_init;
+    k->realize = i2c_slave_realize;
     set_bit(DEVICE_CATEGORY_MISC, k->categories);
     k->bus_type = TYPE_I2C_BUS;
     k->props = i2c_props;
-- 
2.15.1
