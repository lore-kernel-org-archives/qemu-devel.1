Received: from eggs.gnu.org ([2001:4830:134:3::10]:37444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGche-0001nQ-9E
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchd-0006XE-1J
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:58 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:17 -0600
Message-Id: <20171120032420.9134-10-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 09/12] nvram: add AT24Cx i2c eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/nvram/Makefile.objs  |   1 +
 hw/nvram/eeprom_at24c.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 hw/nvram/eeprom_at24c.c

diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index c018f6b2ff..0f4ee71dcb 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -1,5 +1,6 @@
 common-obj-$(CONFIG_DS1225Y) += ds1225y.o
 common-obj-y += eeprom93xx.o
+common-obj-y += eeprom_at24c.o
 common-obj-y += fw_cfg.o
 common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
new file mode 100644
index 0000000000..efa3621ac6
--- /dev/null
+++ b/hw/nvram/eeprom_at24c.c
@@ -0,0 +1,205 @@
+/*
+ * *AT24C* series I2C EEPROM
+ *
+ * Copyright (c) 2015 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ */
+
+#include <string.h>
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/i2c/i2c.h"
+#include "sysemu/block-backend.h"
+
+/* #define DEBUG_AT24C */
+
+#ifdef DEBUG_AT24C
+#define DPRINTK(FMT, ...) printf(TYPE_AT24C_EE " : " FMT, ## __VA_ARGS__)
+#else
+#define DPRINTK(FMT, ...) do {} while (0)
+#endif
+
+#define ERR(FMT, ...) fprintf(stderr, TYPE_AT24C_EE " : " FMT, \
+                            ## __VA_ARGS__)
+
+#define TYPE_AT24C_EE "at24c-eeprom"
+#define AT24C_EE(obj) OBJECT_CHECK(EEPROMState, (obj), TYPE_AT24C_EE)
+
+typedef struct EEPROMState {
+    I2CSlave parent_obj;
+
+    /* address counter */
+    uint16_t cur;
+    /* total size in bytes */
+    uint32_t rsize;
+    bool writable;
+    /* cells changed since last START? */
+    bool changed;
+    /* during WRITE, # of address bytes transfered */
+    uint8_t haveaddr;
+
+    uint8_t *mem;
+
+    BlockBackend *blk;
+} EEPROMState;
+
+static
+int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
+{
+    EEPROMState *ee = container_of(s, EEPROMState, parent_obj);
+
+    switch (event) {
+    case I2C_START_SEND:
+    case I2C_START_RECV:
+    case I2C_FINISH:
+        ee->haveaddr = 0;
+        DPRINTK("clear\n");
+        if (ee->blk && ee->changed) {
+            int len = blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
+            if (len != ee->rsize) {
+                ERR(TYPE_AT24C_EE
+                        " : failed to write backing file\n");
+            }
+            DPRINTK("Wrote to backing file\n");
+        }
+        ee->changed = false;
+        break;
+    case I2C_NACK:
+        break;
+    }
+    return 0;
+}
+
+static
+int at24c_eeprom_recv(I2CSlave *s)
+{
+    EEPROMState *ee = AT24C_EE(s);
+    int ret;
+
+    ret = ee->mem[ee->cur];
+
+    ee->cur = (ee->cur + 1u) % ee->rsize;
+    DPRINTK("Recv %02x %c\n", ret, ret);
+
+    return ret;
+}
+
+static
+int at24c_eeprom_send(I2CSlave *s, uint8_t data)
+{
+    EEPROMState *ee = AT24C_EE(s);
+
+    if (ee->haveaddr < 2) {
+        ee->cur <<= 8;
+        ee->cur |= data;
+        ee->haveaddr++;
+        if (ee->haveaddr == 2) {
+            ee->cur %= ee->rsize;
+            DPRINTK("Set pointer %04x\n", ee->cur);
+        }
+
+    } else {
+        if (ee->writable) {
+            DPRINTK("Send %02x\n", data);
+            ee->mem[ee->cur] = data;
+            ee->changed = true;
+        } else {
+            DPRINTK("Send error %02x read-only\n", data);
+        }
+        ee->cur = (ee->cur + 1u) % ee->rsize;
+
+    }
+
+    return 0;
+}
+
+static
+int at24c_eeprom_init(I2CSlave *i2c)
+{
+    EEPROMState *ee = AT24C_EE(i2c);
+
+    ee->mem = g_malloc0(ee->rsize);
+
+    if (ee->blk) {
+        int64_t len = blk_getlength(ee->blk);
+
+        if (len != ee->rsize) {
+            ERR(TYPE_AT24C_EE " : Backing file size %lu != %u\n",
+                    (unsigned long)len, (unsigned)ee->rsize);
+            exit(1);
+        }
+
+        if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                         BLK_PERM_ALL, &error_fatal) < 0)
+        {
+            ERR(TYPE_AT24C_EE
+                    " : Backing file incorrect permission\n");
+            exit(1);
+        }
+    }
+    return 0;
+}
+
+static
+void at24c_eeprom_reset(DeviceState *state)
+{
+    EEPROMState *ee = AT24C_EE(state);
+
+    ee->changed = false;
+    ee->cur = 0;
+    ee->haveaddr = 0;
+
+    memset(ee->mem, 0, ee->rsize);
+
+    if (ee->blk) {
+        int len = blk_pread(ee->blk, 0, ee->mem, ee->rsize);
+
+        if (len != ee->rsize) {
+            ERR(TYPE_AT24C_EE
+                    " : Failed initial sync with backing file\n");
+        }
+        DPRINTK("Reset read backing file\n");
+    }
+}
+
+static Property at24c_eeprom_props[] = {
+    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
+    DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
+    DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static
+void at24c_eeprom_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->init = &at24c_eeprom_init;
+    k->event = &at24c_eeprom_event;
+    k->recv = &at24c_eeprom_recv;
+    k->send = &at24c_eeprom_send;
+
+    dc->props = at24c_eeprom_props;
+    dc->reset = at24c_eeprom_reset;
+}
+
+static
+const TypeInfo at24c_eeprom_type = {
+    .name = TYPE_AT24C_EE,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(EEPROMState),
+    .class_size = sizeof(I2CSlaveClass),
+    .class_init = at24c_eeprom_class_init,
+};
+
+static void at24c_eeprom_register(void)
+{
+    type_register_static(&at24c_eeprom_type);
+}
+
+type_init(at24c_eeprom_register)
-- 
2.11.0
