Received: from eggs.gnu.org ([2001:4830:134:3::10]:59326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS7-0007eW-DG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS5-0006Fs-K5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:35 -0400
Received: from orth.archaic.org.uk ([81.2.115.148]:48421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUsS5-000683-8O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsPp-0002xf-Hu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:29:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:29:09 +0100
Message-Id: <1499768952-24990-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
References: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/4] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Add emulation for Exynos4210 Pseudo Random Number Generator which could
work on fixed seeds or with seeds provided by True Random Number
Generator block inside the SoC.

Implement only the fixed seeds part of it in polling mode (no
interrupts).

Emulation tested with two independent Linux kernel exynos-rng drivers:
1. New kcapi-rng interface (targeting Linux v4.12),
2. Old hwrng inteface
   # echo "exynos" > /sys/class/misc/hw_random/rng_current
   # dd if=/dev/hwrng of=/dev/null bs=1 count=16

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Message-id: 20170425180609.11004-1-krzk@kernel.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: wrapped a few overlong lines; more efficient implementation
 of exynos4210_rng_seed_ready()]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs    |   2 +-
 hw/arm/exynos4210.c      |   4 +
 hw/misc/exynos4210_rng.c | 277 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/exynos4210_rng.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 44e0e79..7e373db 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -28,7 +28,7 @@ obj-$(CONFIG_IVSHMEM) += ivshmem.o
 obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 obj-$(CONFIG_NSERIES) += cbus.o
 obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o
+obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o exynos4210_rng.o
 obj-$(CONFIG_IMX) += imx_ccm.o
 obj-$(CONFIG_IMX) += imx31_ccm.o
 obj-$(CONFIG_IMX) += imx25_ccm.o
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0050626..ee851e3 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -87,6 +87,9 @@
 /* Clock controller SFR base address */
 #define EXYNOS4210_CLK_BASE_ADDR            0x10030000
 
+/* PRNG/HASH SFR base address */
+#define EXYNOS4210_RNG_BASE_ADDR            0x10830400
+
 /* Display controllers (FIMD) */
 #define EXYNOS4210_FIMD0_BASE_ADDR          0x11C00000
 
@@ -305,6 +308,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
     sysbus_create_simple("exynos4210.pmu", EXYNOS4210_PMU_BASE_ADDR, NULL);
 
     sysbus_create_simple("exynos4210.clk", EXYNOS4210_CLK_BASE_ADDR, NULL);
+    sysbus_create_simple("exynos4210.rng", EXYNOS4210_RNG_BASE_ADDR, NULL);
 
     /* PWM */
     sysbus_create_varargs("exynos4210.pwm", EXYNOS4210_PWM_BASE_ADDR,
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
new file mode 100644
index 0000000..31ebe38
--- /dev/null
+++ b/hw/misc/exynos4210_rng.c
@@ -0,0 +1,277 @@
+/*
+ *  Exynos4210 Pseudo Random Nubmer Generator Emulation
+ *
+ *  Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/random.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+
+#define DEBUG_EXYNOS_RNG 0
+
+#define DPRINTF(fmt, ...) \
+    do { \
+        if (DEBUG_EXYNOS_RNG) { \
+            printf("exynos4210_rng: " fmt, ## __VA_ARGS__); \
+        } \
+    } while (0)
+
+#define TYPE_EXYNOS4210_RNG             "exynos4210.rng"
+#define EXYNOS4210_RNG(obj) \
+    OBJECT_CHECK(Exynos4210RngState, (obj), TYPE_EXYNOS4210_RNG)
+
+/*
+ * Exynos4220, PRNG, only polling mode is supported.
+ */
+
+/* RNG_CONTROL_1 register bitfields, reset value: 0x0 */
+#define EXYNOS4210_RNG_CONTROL_1_PRNG           0x8
+#define EXYNOS4210_RNG_CONTROL_1_START_INIT     BIT(4)
+/* RNG_STATUS register bitfields, reset value: 0x1 */
+#define EXYNOS4210_RNG_STATUS_PRNG_ERROR        BIT(7)
+#define EXYNOS4210_RNG_STATUS_PRNG_DONE         BIT(5)
+#define EXYNOS4210_RNG_STATUS_MSG_DONE          BIT(4)
+#define EXYNOS4210_RNG_STATUS_PARTIAL_DONE      BIT(3)
+#define EXYNOS4210_RNG_STATUS_PRNG_BUSY         BIT(2)
+#define EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE BIT(1)
+#define EXYNOS4210_RNG_STATUS_BUFFER_READY      BIT(0)
+#define EXYNOS4210_RNG_STATUS_WRITE_MASK   (EXYNOS4210_RNG_STATUS_PRNG_DONE \
+                                           | EXYNOS4210_RNG_STATUS_MSG_DONE \
+                                           | EXYNOS4210_RNG_STATUS_PARTIAL_DONE)
+
+#define EXYNOS4210_RNG_CONTROL_1                  0x0
+#define EXYNOS4210_RNG_STATUS                    0x10
+#define EXYNOS4210_RNG_SEED_IN                  0x140
+#define EXYNOS4210_RNG_SEED_IN_OFFSET(n)   (EXYNOS4210_RNG_SEED_IN + (n * 0x4))
+#define EXYNOS4210_RNG_PRNG                     0x160
+#define EXYNOS4210_RNG_PRNG_OFFSET(n)      (EXYNOS4210_RNG_PRNG + (n * 0x4))
+
+#define EXYNOS4210_RNG_PRNG_NUM                 5
+
+#define EXYNOS4210_RNG_REGS_MEM_SIZE            0x200
+
+typedef struct Exynos4210RngState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    int32_t randr_value[EXYNOS4210_RNG_PRNG_NUM];
+    /* bits from 0 to EXYNOS4210_RNG_PRNG_NUM if given seed register was set */
+    uint32_t seed_set;
+
+    /* Register values */
+    uint32_t reg_control;
+    uint32_t reg_status;
+} Exynos4210RngState;
+
+static bool exynos4210_rng_seed_ready(const Exynos4210RngState *s)
+{
+    uint32_t mask = MAKE_64BIT_MASK(0, EXYNOS4210_RNG_PRNG_NUM);
+
+    /* Return true if all the seed-set bits are set. */
+    return (s->seed_set & mask) == mask;
+}
+
+static void exynos4210_rng_set_seed(Exynos4210RngState *s, unsigned int i,
+                                    uint64_t val)
+{
+    /*
+     * We actually ignore the seed and always generate true random numbers.
+     * Theoretically this should not match the device as Exynos has
+     * a Pseudo Random Number Generator but testing shown that it always
+     * generates random numbers regardless of the seed value.
+     */
+    s->seed_set |= BIT(i);
+
+    /* If all seeds were written, update the status to reflect it */
+    if (exynos4210_rng_seed_ready(s)) {
+        s->reg_status |= EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE;
+    } else {
+        s->reg_status &= ~EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE;
+    }
+}
+
+static void exynos4210_rng_run_engine(Exynos4210RngState *s)
+{
+    Error *err = NULL;
+    int ret;
+
+    /* Seed set? */
+    if ((s->reg_status & EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE) == 0) {
+        goto out;
+    }
+
+    /* PRNG engine chosen? */
+    if ((s->reg_control & EXYNOS4210_RNG_CONTROL_1_PRNG) == 0) {
+        goto out;
+    }
+
+    /* PRNG engine started? */
+    if ((s->reg_control & EXYNOS4210_RNG_CONTROL_1_START_INIT) == 0) {
+        goto out;
+    }
+
+    /* Get randoms */
+    ret = qcrypto_random_bytes((uint8_t *)s->randr_value,
+                               sizeof(s->randr_value), &err);
+    if (!ret) {
+        /* Notify that PRNG is ready */
+        s->reg_status |= EXYNOS4210_RNG_STATUS_PRNG_DONE;
+    } else {
+        error_report_err(err);
+    }
+
+out:
+    /* Always clear start engine bit */
+    s->reg_control &= ~EXYNOS4210_RNG_CONTROL_1_START_INIT;
+}
+
+static uint64_t exynos4210_rng_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    Exynos4210RngState *s = (Exynos4210RngState *)opaque;
+    uint32_t val = 0;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case EXYNOS4210_RNG_CONTROL_1:
+        val = s->reg_control;
+        break;
+
+    case EXYNOS4210_RNG_STATUS:
+        val = s->reg_status;
+        break;
+
+    case EXYNOS4210_RNG_PRNG_OFFSET(0):
+    case EXYNOS4210_RNG_PRNG_OFFSET(1):
+    case EXYNOS4210_RNG_PRNG_OFFSET(2):
+    case EXYNOS4210_RNG_PRNG_OFFSET(3):
+    case EXYNOS4210_RNG_PRNG_OFFSET(4):
+        val = s->randr_value[(offset - EXYNOS4210_RNG_PRNG_OFFSET(0)) / 4];
+        DPRINTF("returning random @0x%" HWADDR_PRIx ": 0x%" PRIx32 "\n",
+                offset, val);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    return val;
+}
+
+static void exynos4210_rng_write(void *opaque, hwaddr offset,
+                                 uint64_t val, unsigned size)
+{
+    Exynos4210RngState *s = (Exynos4210RngState *)opaque;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case EXYNOS4210_RNG_CONTROL_1:
+        DPRINTF("RNG_CONTROL_1 = 0x%" PRIx64 "\n", val);
+        s->reg_control = val;
+        exynos4210_rng_run_engine(s);
+        break;
+
+    case EXYNOS4210_RNG_STATUS:
+        /* For clearing status fields */
+        s->reg_status &= ~EXYNOS4210_RNG_STATUS_WRITE_MASK;
+        s->reg_status |= val & EXYNOS4210_RNG_STATUS_WRITE_MASK;
+        break;
+
+    case EXYNOS4210_RNG_SEED_IN_OFFSET(0):
+    case EXYNOS4210_RNG_SEED_IN_OFFSET(1):
+    case EXYNOS4210_RNG_SEED_IN_OFFSET(2):
+    case EXYNOS4210_RNG_SEED_IN_OFFSET(3):
+    case EXYNOS4210_RNG_SEED_IN_OFFSET(4):
+        exynos4210_rng_set_seed(s,
+                                (offset - EXYNOS4210_RNG_SEED_IN_OFFSET(0)) / 4,
+                                val);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+}
+
+static const MemoryRegionOps exynos4210_rng_ops = {
+    .read = exynos4210_rng_read,
+    .write = exynos4210_rng_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void exynos4210_rng_reset(DeviceState *dev)
+{
+    Exynos4210RngState *s = EXYNOS4210_RNG(dev);
+
+    s->reg_control = 0;
+    s->reg_status = EXYNOS4210_RNG_STATUS_BUFFER_READY;
+    memset(s->randr_value, 0, sizeof(s->randr_value));
+    s->seed_set = 0;
+}
+
+static void exynos4210_rng_init(Object *obj)
+{
+    Exynos4210RngState *s = EXYNOS4210_RNG(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &exynos4210_rng_ops, s,
+                          TYPE_EXYNOS4210_RNG, EXYNOS4210_RNG_REGS_MEM_SIZE);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static const VMStateDescription exynos4210_rng_vmstate = {
+    .name = TYPE_EXYNOS4210_RNG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32_ARRAY(randr_value, Exynos4210RngState,
+                            EXYNOS4210_RNG_PRNG_NUM),
+        VMSTATE_UINT32(seed_set, Exynos4210RngState),
+        VMSTATE_UINT32(reg_status, Exynos4210RngState),
+        VMSTATE_UINT32(reg_control, Exynos4210RngState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void exynos4210_rng_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = exynos4210_rng_reset;
+    dc->vmsd = &exynos4210_rng_vmstate;
+}
+
+static const TypeInfo exynos4210_rng_info = {
+    .name          = TYPE_EXYNOS4210_RNG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Exynos4210RngState),
+    .instance_init = exynos4210_rng_init,
+    .class_init    = exynos4210_rng_class_init,
+};
+
+static void exynos4210_rng_register(void)
+{
+    type_register_static(&exynos4210_rng_info);
+}
+
+type_init(exynos4210_rng_register)
-- 
2.7.4
