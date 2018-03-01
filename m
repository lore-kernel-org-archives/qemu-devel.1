Received: from eggs.gnu.org ([2001:4830:134:3::10]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-0003hk-Ue
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-000863-Ba
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJs-00084x-3Q
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJl-0000Yi-AL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:28 +0000
Message-Id: <20180301112403.12487-8-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/42] hw/sii9022: Add support for Silicon Image
 SII9022
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for emulating the Silicon Image SII9022 DVI/HDMI
bridge. It's not very clever right now, it just acknowledges
the switch into DDC I2C mode and back. Combining this with the
existing DDC I2C emulation gives the right behavior on the Versatile
Express emulation passing through the QEMU EDID to the emulated
platform.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180227104903.21353-5-linus.walleij@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: explictly reset ddc_req/ddc_skip_finish/ddc]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/Makefile.objs |   1 +
 hw/display/sii9022.c     | 191 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/trace-events  |   5 ++
 3 files changed, 197 insertions(+)
 create mode 100644 hw/display/sii9022.c

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index d3a4cb396e..3c7c75b94d 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -3,6 +3,7 @@ common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
 common-obj-$(CONFIG_G364FB) += g364fb.o
 common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
 common-obj-$(CONFIG_PL110) += pl110.o
+common-obj-$(CONFIG_SII9022) += sii9022.o
 common-obj-$(CONFIG_SSD0303) += ssd0303.o
 common-obj-$(CONFIG_SSD0323) += ssd0323.o
 common-obj-$(CONFIG_XEN) += xenfb.o
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
new file mode 100644
index 0000000000..eaf11a6e7b
--- /dev/null
+++ b/hw/display/sii9022.c
@@ -0,0 +1,191 @@
+/*
+ * Silicon Image SiI9022
+ *
+ * This is a pretty hollow emulation: all we do is acknowledge that we
+ * exist (chip ID) and confirm that we get switched over into DDC mode
+ * so the emulated host can proceed to read out EDID data. All subsequent
+ * set-up of connectors etc will be acknowledged and ignored.
+ *
+ * Copyright (C) 2018 Linus Walleij
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/i2c-ddc.h"
+#include "trace.h"
+
+#define SII9022_SYS_CTRL_DATA 0x1a
+#define SII9022_SYS_CTRL_PWR_DWN 0x10
+#define SII9022_SYS_CTRL_AV_MUTE 0x08
+#define SII9022_SYS_CTRL_DDC_BUS_REQ 0x04
+#define SII9022_SYS_CTRL_DDC_BUS_GRTD 0x02
+#define SII9022_SYS_CTRL_OUTPUT_MODE 0x01
+#define SII9022_SYS_CTRL_OUTPUT_HDMI 1
+#define SII9022_SYS_CTRL_OUTPUT_DVI 0
+#define SII9022_REG_CHIPID 0x1b
+#define SII9022_INT_ENABLE 0x3c
+#define SII9022_INT_STATUS 0x3d
+#define SII9022_INT_STATUS_HOTPLUG 0x01;
+#define SII9022_INT_STATUS_PLUGGED 0x04;
+
+#define TYPE_SII9022 "sii9022"
+#define SII9022(obj) OBJECT_CHECK(sii9022_state, (obj), TYPE_SII9022)
+
+typedef struct sii9022_state {
+    I2CSlave parent_obj;
+    uint8_t ptr;
+    bool addr_byte;
+    bool ddc_req;
+    bool ddc_skip_finish;
+    bool ddc;
+} sii9022_state;
+
+static const VMStateDescription vmstate_sii9022 = {
+    .name = "sii9022",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),
+        VMSTATE_UINT8(ptr, sii9022_state),
+        VMSTATE_BOOL(addr_byte, sii9022_state),
+        VMSTATE_BOOL(ddc_req, sii9022_state),
+        VMSTATE_BOOL(ddc_skip_finish, sii9022_state),
+        VMSTATE_BOOL(ddc, sii9022_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int sii9022_event(I2CSlave *i2c, enum i2c_event event)
+{
+    sii9022_state *s = SII9022(i2c);
+
+    switch (event) {
+    case I2C_START_SEND:
+        s->addr_byte = true;
+        break;
+    case I2C_START_RECV:
+        break;
+    case I2C_FINISH:
+        break;
+    case I2C_NACK:
+        break;
+    }
+
+    return 0;
+}
+
+static int sii9022_rx(I2CSlave *i2c)
+{
+    sii9022_state *s = SII9022(i2c);
+    uint8_t res = 0x00;
+
+    switch (s->ptr) {
+    case SII9022_SYS_CTRL_DATA:
+        if (s->ddc_req) {
+            /* Acknowledge DDC bus request */
+            res = SII9022_SYS_CTRL_DDC_BUS_GRTD | SII9022_SYS_CTRL_DDC_BUS_REQ;
+        }
+        break;
+    case SII9022_REG_CHIPID:
+        res = 0xb0;
+        break;
+    case SII9022_INT_STATUS:
+        /* Something is cold-plugged in, no interrupts */
+        res = SII9022_INT_STATUS_PLUGGED;
+        break;
+    default:
+        break;
+    }
+
+    trace_sii9022_read_reg(s->ptr, res);
+    s->ptr++;
+
+    return res;
+}
+
+static int sii9022_tx(I2CSlave *i2c, uint8_t data)
+{
+    sii9022_state *s = SII9022(i2c);
+
+    if (s->addr_byte) {
+        s->ptr = data;
+        s->addr_byte = false;
+        return 0;
+    }
+
+    switch (s->ptr) {
+    case SII9022_SYS_CTRL_DATA:
+        if (data & SII9022_SYS_CTRL_DDC_BUS_REQ) {
+            s->ddc_req = true;
+            if (data & SII9022_SYS_CTRL_DDC_BUS_GRTD) {
+                s->ddc = true;
+                /* Skip this finish since we just switched to DDC */
+                s->ddc_skip_finish = true;
+                trace_sii9022_switch_mode("DDC");
+            }
+        } else {
+            s->ddc_req = false;
+            s->ddc = false;
+            trace_sii9022_switch_mode("normal");
+        }
+        break;
+    default:
+        break;
+    }
+
+    trace_sii9022_write_reg(s->ptr, data);
+    s->ptr++;
+
+    return 0;
+}
+
+static void sii9022_reset(DeviceState *dev)
+{
+    sii9022_state *s = SII9022(dev);
+
+    s->ptr = 0;
+    s->addr_byte = false;
+    s->ddc_req = false;
+    s->ddc_skip_finish = false;
+    s->ddc = false;
+}
+
+static void sii9022_realize(DeviceState *dev, Error **errp)
+{
+    I2CBus *bus;
+
+    bus = I2C_BUS(qdev_get_parent_bus(dev));
+    i2c_create_slave(bus, TYPE_I2CDDC, 0x50);
+}
+
+static void sii9022_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = sii9022_event;
+    k->recv = sii9022_rx;
+    k->send = sii9022_tx;
+    dc->reset = sii9022_reset;
+    dc->realize = sii9022_realize;
+    dc->vmsd = &vmstate_sii9022;
+}
+
+static const TypeInfo sii9022_info = {
+    .name          = TYPE_SII9022,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(sii9022_state),
+    .class_init    = sii9022_class_init,
+};
+
+static void sii9022_register_types(void)
+{
+    type_register_static(&sii9022_info);
+}
+
+type_init(sii9022_register_types)
diff --git a/hw/display/trace-events b/hw/display/trace-events
index da498c1def..5a48c6cb6a 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -132,3 +132,8 @@ vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_read_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
 vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
+
+# hw/display/sii9022.c
+sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
+sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
+sii9022_switch_mode(const char *mode) "mode: %s"
-- 
2.16.2
