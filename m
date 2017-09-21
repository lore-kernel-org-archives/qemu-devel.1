Received: from eggs.gnu.org ([2001:4830:134:3::10]:60477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XV-0003DU-Pz
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XT-0003Sm-MZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XT-0003Oh-7k
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XS-0005El-0G
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:36 +0100
Message-Id: <1506012099-13605-29-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/31] msf2: Microsemi Smartfusion2 System
 Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

Added Sytem register block of Smartfusion2.
This block has PLL registers which are accessed by guest.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170920201737.25723-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs         |   1 +
 include/hw/misc/msf2-sysreg.h |  77 ++++++++++++++++++++
 hw/misc/msf2-sysreg.c         | 160 ++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   5 ++
 4 files changed, 243 insertions(+)
 create mode 100644 include/hw/misc/msf2-sysreg.h
 create mode 100644 hw/misc/msf2-sysreg.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 29fb922..e8f0a02 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -59,3 +59,4 @@ obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-y += mmio_interface.o
+obj-$(CONFIG_MSF2) += msf2-sysreg.o
diff --git a/include/hw/misc/msf2-sysreg.h b/include/hw/misc/msf2-sysreg.h
new file mode 100644
index 0000000..5993f67
--- /dev/null
+++ b/include/hw/misc/msf2-sysreg.h
@@ -0,0 +1,77 @@
+/*
+ * Microsemi SmartFusion2 SYSREG
+ *
+ * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_MSF2_SYSREG_H
+#define HW_MSF2_SYSREG_H
+
+#include "hw/sysbus.h"
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
+};
+
+#define MSF2_SYSREG_MMIO_SIZE     0x300
+
+#define TYPE_MSF2_SYSREG          "msf2-sysreg"
+#define MSF2_SYSREG(obj)  OBJECT_CHECK(MSF2SysregState, (obj), TYPE_MSF2_SYSREG)
+
+typedef struct MSF2SysregState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t apb0div;
+    uint8_t apb1div;
+
+    uint32_t regs[MSF2_SYSREG_MMIO_SIZE / 4];
+} MSF2SysregState;
+
+#endif /* HW_MSF2_SYSREG_H */
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
new file mode 100644
index 0000000..6eb5011
--- /dev/null
+++ b/hw/misc/msf2-sysreg.c
@@ -0,0 +1,160 @@
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
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/misc/msf2-sysreg.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+static inline int msf2_divbits(uint32_t div)
+{
+    int r = ctz32(div);
+
+    return (div < 8) ? r : r + 1;
+}
+
+static void msf2_sysreg_reset(DeviceState *d)
+{
+    MSF2SysregState *s = MSF2_SYSREG(d);
+
+    s->regs[MSSDDR_PLL_STATUS_LOW_CR] = 0x021A2358;
+    s->regs[MSSDDR_PLL_STATUS] = 0x3;
+    s->regs[MSSDDR_FACC1_CR] = msf2_divbits(s->apb0div) << 5 |
+                               msf2_divbits(s->apb1div) << 2;
+}
+
+static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
+    unsigned size)
+{
+    MSF2SysregState *s = opaque;
+    uint32_t ret = 0;
+
+    offset >>= 2;
+    if (offset < ARRAY_SIZE(s->regs)) {
+        ret = s->regs[offset];
+        trace_msf2_sysreg_read(offset << 2, ret);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: Bad offset 0x%08" HWADDR_PRIx "\n", __func__,
+                    offset << 2);
+    }
+
+    return ret;
+}
+
+static void msf2_sysreg_write(void *opaque, hwaddr offset,
+                          uint64_t val, unsigned size)
+{
+    MSF2SysregState *s = opaque;
+    uint32_t newval = val;
+
+    offset >>= 2;
+
+    switch (offset) {
+    case MSSDDR_PLL_STATUS:
+        trace_msf2_sysreg_write_pll_status();
+        break;
+
+    case ESRAM_CR:
+    case DDR_CR:
+    case ENVM_REMAP_BASE_CR:
+        if (newval != s->regs[offset]) {
+            qemu_log_mask(LOG_UNIMP,
+                       TYPE_MSF2_SYSREG": remapping not supported\n");
+        }
+        break;
+
+    default:
+        if (offset < ARRAY_SIZE(s->regs)) {
+            trace_msf2_sysreg_write(offset << 2, newval, s->regs[offset]);
+            s->regs[offset] = newval;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                        "%s: Bad offset 0x%08" HWADDR_PRIx "\n", __func__,
+                        offset << 2);
+        }
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
+    MSF2SysregState *s = MSF2_SYSREG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &sysreg_ops, s, TYPE_MSF2_SYSREG,
+                          MSF2_SYSREG_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription vmstate_msf2_sysreg = {
+    .name = TYPE_MSF2_SYSREG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, MSF2SysregState, MSF2_SYSREG_MMIO_SIZE / 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property msf2_sysreg_properties[] = {
+    /* default divisors in Libero GUI */
+    DEFINE_PROP_UINT8("apb0divisor", MSF2SysregState, apb0div, 2),
+    DEFINE_PROP_UINT8("apb1divisor", MSF2SysregState, apb1div, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void msf2_sysreg_realize(DeviceState *dev, Error **errp)
+{
+    MSF2SysregState *s = MSF2_SYSREG(dev);
+
+    if ((s->apb0div > 32 || !is_power_of_2(s->apb0div))
+        || (s->apb1div > 32 || !is_power_of_2(s->apb1div))) {
+        error_setg(errp, "Invalid apb divisor value");
+        error_append_hint(errp, "apb divisor must be a power of 2"
+                           " and maximum value is 32\n");
+    }
+}
+
+static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_msf2_sysreg;
+    dc->reset = msf2_sysreg_reset;
+    dc->props = msf2_sysreg_properties;
+    dc->realize = msf2_sysreg_realize;
+}
+
+static const TypeInfo msf2_sysreg_info = {
+    .name  = TYPE_MSF2_SYSREG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .class_init = msf2_sysreg_class_init,
+    .instance_size  = sizeof(MSF2SysregState),
+    .instance_init = msf2_sysreg_init,
+};
+
+static void msf2_sysreg_register_types(void)
+{
+    type_register_static(&msf2_sysreg_info);
+}
+
+type_init(msf2_sysreg_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 3313585..616579a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -61,3 +61,8 @@ mps2_scc_reset(void) "MPS2 SCC: reset"
 mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
 mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
 mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
+
+# hw/misc/msf2-sysreg.c
+msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" HWADDR_PRIx " data 0x%" PRIx32 " prev 0x%" PRIx32
+msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr 0x%08" HWADDR_PRIx " data 0x%08" PRIx32
+msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL status register"
-- 
2.7.4
