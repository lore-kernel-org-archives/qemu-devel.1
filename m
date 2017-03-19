Received: from eggs.gnu.org ([2001:4830:134:3::10]:45877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cpZXo-0005st-Dw
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cpZXl-0003y1-BA
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:44 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
	id 1cpZXl-0003xO-3M
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:41 -0400
Received: by mail-pf0-x244.google.com with SMTP id p189so8185605pfp.0
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 05:02:40 -0700 (PDT)
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Sun, 19 Mar 2017 17:32:05 +0530
Message-Id: <1489924926-28368-2-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1489924926-28368-1-git-send-email-sundeep.lkml@gmail.com>
References: <1489924926-28368-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu-devel RFC 2/3] msf2: Microsemi Smartfusion2
 System Register block.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Added Sytem register block of Smartfusion2.
This block has PLL registers which are accessed by guest.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 hw/misc/Makefile.objs |   1 +
 hw/misc/msf2_sysreg.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 hw/misc/msf2_sysreg.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c8b4893..aee53df 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -56,3 +56,4 @@ obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+obj-$(CONFIG_MSF2) += msf2_sysreg.o
diff --git a/hw/misc/msf2_sysreg.c b/hw/misc/msf2_sysreg.c
new file mode 100644
index 0000000..4873463
--- /dev/null
+++ b/hw/misc/msf2_sysreg.c
@@ -0,0 +1,168 @@
+/*
+ * System Register block model of Microsemi SmartFusion2.
+ *
+ * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
+#include "qemu/log.h"
+
+#ifndef MSF2_SYSREG_ERR_DEBUG
+#define MSF2_SYSREG_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT(...) do { \
+        if (MSF2_SYSREG_ERR_DEBUG) { \
+            fprintf(stderr,  ": %s: ", __func__); \
+            fprintf(stderr, ## __VA_ARGS__); \
+        } \
+    } while (0);
+
+#define R_PSS_RST_CTRL_SOFT_RST 0x1
+
+enum {
+    ESRAM_CR        = 0x00 / 4,
+    ESRAM_MAX_LAT,
+    DDR_CR,
+    ENVM_CR,
+    ENVM_REMAP_BASE_CR,
+    ENVM_REMAP_FAB_CR,
+    CC_CR,
+    CC_REGION_CR,
+    CC_LOCK_BASE_ADDR_CR,
+    CC_FLUSH_INDX_CR,
+    DDRB_BUF_TIMER_CR,
+    DDRB_NB_ADDR_CR,
+    DDRB_NB_SIZE_CR,
+    DDRB_CR,
+
+    SOFT_RESET_CR  = 0x48 / 4,
+    M3_CR,
+
+    GPIO_SYSRESET_SEL_CR = 0x58 / 4,
+
+    MDDR_CR = 0x60 / 4,
+
+    MSSDDR_PLL_STATUS_LOW_CR = 0x90 / 4,
+    MSSDDR_PLL_STATUS_HIGH_CR,
+    MSSDDR_FACC1_CR,
+    MSSDDR_FACC2_CR,
+
+    MSSDDR_PLL_STATUS = 0x150 / 4,
+
+};
+
+#define MSF2_SYSREG_MMIO_SIZE     0x300
+#define MSF2_SYSREG_NUM_REGS      (MSF2_SYSREG_MMIO_SIZE / 4)
+
+#define TYPE_MSF2_SYSREG          "msf2-sysreg"
+#define MSF2_SYSREG(obj)  OBJECT_CHECK(Sf2SysregState, (obj), TYPE_MSF2_SYSREG)
+
+typedef struct Sf2SysregState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[MSF2_SYSREG_NUM_REGS];
+} Sf2SysregState;
+
+static void msf2_sysreg_reset(DeviceState *d)
+{
+    Sf2SysregState *s = MSF2_SYSREG(d);
+
+    DB_PRINT("RESET\n");
+
+    s->regs[MSSDDR_PLL_STATUS_LOW_CR] = 0x02420041;
+    s->regs[MSSDDR_FACC1_CR] = 0x0A482124;
+    s->regs[MSSDDR_PLL_STATUS] = 0x3;
+}
+
+static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
+    unsigned size)
+{
+    Sf2SysregState *s = opaque;
+    offset /= 4;
+    uint32_t ret = s->regs[offset];
+
+    DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx32 "\n", offset * 4, ret);
+
+   return ret;
+}
+
+static void msf2_sysreg_write(void *opaque, hwaddr offset,
+                          uint64_t val, unsigned size)
+{
+    Sf2SysregState *s = (Sf2SysregState *)opaque;
+    offset /= 4;
+
+    DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx64 "\n", offset * 4, val);
+
+    switch (offset) {
+    case MSSDDR_PLL_STATUS:
+        break;
+
+    default:
+        s->regs[offset] = val;
+        break;
+    }
+}
+
+static const MemoryRegionOps sysreg_ops = {
+    .read = msf2_sysreg_read,
+    .write = msf2_sysreg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void msf2_sysreg_init(Object *obj)
+{
+    Sf2SysregState *s = MSF2_SYSREG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &sysreg_ops, s, "sysreg",
+                          MSF2_SYSREG_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription vmstate_msf2_sysreg = {
+    .name = "msf2_sysreg",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, Sf2SysregState, MSF2_SYSREG_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_msf2_sysreg;
+    dc->reset = msf2_sysreg_reset;
+}
+
+static const TypeInfo msf2_sysreg_info = {
+    .class_init = msf2_sysreg_class_init,
+    .name  = TYPE_MSF2_SYSREG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(Sf2SysregState),
+    .instance_init = msf2_sysreg_init,
+};
+
+static void msf2_sysreg_register_types(void)
+{
+    type_register_static(&msf2_sysreg_info);
+}
+
+type_init(msf2_sysreg_register_types)
-- 
2.5.0
