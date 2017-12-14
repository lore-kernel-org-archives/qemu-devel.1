Received: from eggs.gnu.org ([2001:4830:134:3::10]:43314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePVIM-0000jJ-RK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePVIG-00082d-Jb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:19:34 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1ePVIG-000812-Aa
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:19:28 -0500
Received: by mail-pg0-x242.google.com with SMTP id j4so3611338pgp.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 07:19:28 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 07:19:06 -0800
Message-Id: <20171214151906.3250-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/misc: Add code to emulate PFUZE3000 PMIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.orgn, yurovsky@gmail.com, Peter Maydell <peter.maydell@linaro.org>

Add trivial code to emulate PFUZE3000 PMIC.

Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.orgn
Cc: yurovsky@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Integrating this into a build system via "obj-y" might not be the best
way. Does this code need a dedicated CONFIG_ symbol?

Thanks,
Andrey Smirnov

 hw/misc/Makefile.objs       |   2 +
 hw/misc/pfuze3000.c         | 212 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pfuze3000.h |  48 ++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 hw/misc/pfuze3000.c
 create mode 100644 include/hw/misc/pfuze3000.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 4599288e55..72dcd953bb 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -64,3 +64,5 @@ obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-y += mmio_interface.o
+
+obj-y += pfuze3000.o
diff --git a/hw/misc/pfuze3000.c b/hw/misc/pfuze3000.c
new file mode 100644
index 0000000000..f414b7c0ba
--- /dev/null
+++ b/hw/misc/pfuze3000.c
@@ -0,0 +1,212 @@
+/*
+ *
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i2c/i2c.h"
+#include "hw/misc/pfuze3000.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+
+#define PFUZE_NUMREGS       128
+#define PFUZE100_VOL_OFFSET 0
+#define PFUZE100_STANDBY_OFFSET 1
+#define PFUZE100_MODE_OFFSET    3
+#define PFUZE100_CONF_OFFSET    4
+
+#define PFUZE100_DEVICEID   0x0
+#define PFUZE100_REVID      0x3
+#define PFUZE100_FABID      0x4
+
+#define PFUZE100_COINVOL    0x1a
+#define PFUZE100_SW1ABVOL   0x20
+#define PFUZE100_SW1ACONF   0x24
+#define PFUZE100_SW1CVOL    0x2e
+#define PFUZE100_SW1BCONF   0x32
+#define PFUZE100_SW2VOL     0x35
+#define PFUZE100_SW3AVOL    0x3c
+#define PFUZE100_SW3BVOL    0x43
+#define PFUZE100_SW4VOL     0x4a
+#define PFUZE100_SWBSTCON1  0x66
+#define PFUZE100_VREFDDRCON 0x6a
+#define PFUZE100_VSNVSVOL   0x6b
+#define PFUZE100_VGEN1VOL   0x6c
+#define PFUZE100_VGEN2VOL   0x6d
+#define PFUZE100_VGEN3VOL   0x6e
+#define PFUZE100_VGEN4VOL   0x6f
+#define PFUZE100_VGEN5VOL   0x70
+#define PFUZE100_VGEN6VOL   0x71
+
+#define PFUZE100_INVAL      0xff
+
+static int pfuze3000_recv(I2CSlave *i2c)
+{
+    PFuze3000State *s = PFUZE3000(i2c);
+
+    const uint8_t reg = s->reg;
+
+    s->reg = PFUZE100_INVAL;
+
+    switch (reg) {
+    case PFUZE100_DEVICEID:
+        return 0x30;
+    case PFUZE100_REVID:
+        return 0x10;
+    case PFUZE100_FABID:
+        return 0x00;
+    case PFUZE100_COINVOL:
+        return s->coinvol;
+    case PFUZE100_SW1ABVOL:
+        return s->sw1abvol;
+    case PFUZE100_SW1ACONF:
+        return s->sw1aconf;
+    case PFUZE100_SW1CVOL:
+        return s->sw1cvol;
+    case PFUZE100_SW1BCONF:
+        return s->sw1bconf;
+    case PFUZE100_SW2VOL:
+        return s->sw2vol;
+    case PFUZE100_SW3AVOL:
+        return s->sw3avol;
+    case PFUZE100_SW3BVOL:
+        return s->sw3bvol;
+    case PFUZE100_SW4VOL:
+        return s->sw4vol;
+    case PFUZE100_SWBSTCON1:
+        return s->swbstcon1;
+    case PFUZE100_VREFDDRCON:
+        return s->vrefddrcon;
+    case PFUZE100_VSNVSVOL:
+        return s->vsnvsvol;
+    case PFUZE100_VGEN1VOL:
+        return s->vgen1vol;
+    case PFUZE100_VGEN2VOL:
+        return s->vgen2vol;
+    case PFUZE100_VGEN3VOL:
+        return s->vgen3vol;
+    case PFUZE100_VGEN4VOL:
+        return s->vgen4vol;
+    case PFUZE100_VGEN5VOL:
+        return s->vgen5vol;
+    case PFUZE100_VGEN6VOL:
+        return s->vgen6vol;
+    }
+
+    return -EINVAL;
+}
+
+static int pfuze3000_send(I2CSlave *i2c, uint8_t data)
+{
+    PFuze3000State *s = PFUZE3000(i2c);
+
+    switch (s->reg) {
+    case PFUZE100_INVAL:
+        s->reg = data;
+        return 0;
+
+    case PFUZE100_COINVOL:
+        s->coinvol = data;
+        break;
+    case PFUZE100_SW1ABVOL:
+        s->sw1abvol = data;
+        break;
+    case PFUZE100_SW1ACONF:
+        s->sw1aconf = data;
+        break;
+    case PFUZE100_SW1CVOL:
+        s->sw1cvol = data;
+        break;
+    case PFUZE100_SW1BCONF:
+        s->sw1bconf = data;
+        break;
+    case PFUZE100_SW2VOL:
+        s->sw2vol = data;
+        break;
+    case PFUZE100_SW3AVOL:
+        s->sw3avol = data;
+        break;
+    case PFUZE100_SW3BVOL:
+        s->sw3bvol = data;
+        break;
+    case PFUZE100_SW4VOL:
+        s->sw4vol = data;
+        break;
+    case PFUZE100_SWBSTCON1:
+        s->swbstcon1 = data;
+        break;
+    case PFUZE100_VREFDDRCON:
+        s->vrefddrcon = data;
+        break;
+    case PFUZE100_VSNVSVOL:
+        s->vsnvsvol = data;
+        break;
+    case PFUZE100_VGEN1VOL:
+        s->vgen1vol = data;
+        break;
+    case PFUZE100_VGEN2VOL:
+        s->vgen2vol = data;
+        break;
+    case PFUZE100_VGEN3VOL:
+        s->vgen3vol = data;
+        break;
+    case PFUZE100_VGEN4VOL:
+        s->vgen4vol = data;
+        break;
+    case PFUZE100_VGEN5VOL:
+        s->vgen5vol = data;
+        break;
+    case PFUZE100_VGEN6VOL:
+        s->vgen6vol = data;
+        break;
+    }
+
+    s->reg = PFUZE100_INVAL;
+    return 0;
+}
+
+static void pfuze3000_reset(DeviceState *ds)
+{
+    PFuze3000State *s = PFUZE3000(ds);
+
+    s->reg = PFUZE100_INVAL;
+}
+
+static void pfuze3000_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    dc->reset = pfuze3000_reset;
+    k->recv   = pfuze3000_recv;
+    k->send   = pfuze3000_send;
+}
+
+static const TypeInfo pfuze3000_info = {
+    .name          = TYPE_PFUZE3000,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(PFuze3000State),
+    .class_init    = pfuze3000_class_init,
+};
+
+static void pfuze3000_register_types(void)
+{
+    type_register_static(&pfuze3000_info);
+}
+type_init(pfuze3000_register_types)
diff --git a/include/hw/misc/pfuze3000.h b/include/hw/misc/pfuze3000.h
new file mode 100644
index 0000000000..c0d467bbb9
--- /dev/null
+++ b/include/hw/misc/pfuze3000.h
@@ -0,0 +1,48 @@
+/*
+ * PFUZE3000 PMIC emulation
+ *
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#ifndef PFUZE3000_H
+#define PFUZE3000_H
+
+#include "hw/i2c/i2c.h"
+
+#define TYPE_PFUZE3000 "pfuze3000"
+#define PFUZE3000(obj) OBJECT_CHECK(PFuze3000State, (obj), TYPE_PFUZE3000)
+
+/**
+ * PFUZE3000State:
+ */
+typedef struct PFuze3000State {
+    /*< private >*/
+    I2CSlave i2c;
+
+    uint8_t reg;
+
+    uint8_t coinvol;
+    uint8_t sw1abvol;
+    uint8_t sw1aconf;
+    uint8_t sw1cvol;
+    uint8_t sw1bconf;
+    uint8_t sw2vol;
+    uint8_t sw3avol;
+    uint8_t sw3bvol;
+    uint8_t sw4vol;
+    uint8_t swbstcon1;
+    uint8_t vrefddrcon;
+    uint8_t vsnvsvol;
+    uint8_t vgen1vol;
+    uint8_t vgen2vol;
+    uint8_t vgen3vol;
+    uint8_t vgen4vol;
+    uint8_t vgen5vol;
+    uint8_t vgen6vol;
+} PFuze3000State;
+
+#endif
-- 
2.14.3
