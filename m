Received: from eggs.gnu.org ([209.51.188.92]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevN-0008Da-W8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002uj-Qt
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002fY-Dx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wr1-x42c.google.com with SMTP id v13so24619441wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:06 +0000
Message-Id: <20190121185118.18550-12-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/23] hw/arm/armsse: Support dual-CPU
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The SSE-200 has two Cortex-M33 CPUs. These see the same view
of memory, with the exception of the "private CPU region" which
has per-CPU devices. Internal device interrupts for SSE-200
devices are mostly wired up to both CPUs, with the exception of
a few per-CPU devices. External GPIO inputs on the SSE-200
device are provided for the second CPU's interrupts above 32,
as is already the case for the first CPU.

Refactor the code to support creation of multiple CPUs.
For the moment we leave all CPUs with the same view of
memory: this will not work in the multiple-CPU case, but
we will fix this in the following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  21 +++-
 hw/arm/armsse.c         | 206 ++++++++++++++++++++++++++++++++--------
 2 files changed, 180 insertions(+), 47 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index e4a05013316..faf5dfed252 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -28,9 +28,16 @@
  *  + QOM property "memory" is a MemoryRegion containing the devices provided
  *    by the board model.
  *  + QOM property "MAINCLK" is the frequency of the main system clock
- *  + QOM property "EXP_NUMIRQ" sets the number of expansion interrupts
- *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts, which
- *    are wired to the NVIC lines 32 .. n+32
+ *  + QOM property "EXP_NUMIRQ" sets the number of expansion interrupts.
+ *    (In hardware, the SSE-200 permits the number of expansion interrupts
+ *    for the two CPUs to be configured separately, but we restrict it to
+ *    being the same for both, to avoid having to have separate Property
+ *    lists for different variants. This restriction can be relaxed later
+ *    if necessary.)
+ *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
+ *    which are wired to its NVIC lines 32 .. n+32
+ *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
+ *    CPU 1, which are wired to its NVIC lines 32 .. n+32
  *  + sysbus MMIO region 0 is the "AHB Slave Expansion" which allows
  *    bus master devices in the board model to make transactions into
  *    all the devices and memory areas in the IoTKit
@@ -95,12 +102,14 @@
 #error Too many SRAM banks
 #endif
 
+#define SSE_MAX_CPUS 2
+
 typedef struct ARMSSE {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    ARMv7MState armv7m;
+    ARMv7MState armv7m[SSE_MAX_CPUS];
     IoTKitSecCtl secctl;
     TZPPC apb_ppc0;
     TZPPC apb_ppc1;
@@ -115,6 +124,8 @@ typedef struct ARMSSE {
     qemu_or_irq mpc_irq_orgate;
     qemu_or_irq nmi_orgate;
 
+    SplitIRQ cpu_irq_splitter[32];
+
     CMSDKAPBDualTimer dualtimer;
 
     CMSDKAPBWatchdog s32kwatchdog;
@@ -130,7 +141,7 @@ typedef struct ARMSSE {
     MemoryRegion alias3;
     MemoryRegion sram[MAX_SRAM_BANKS];
 
-    qemu_irq *exp_irqs;
+    qemu_irq *exp_irqs[SSE_MAX_CPUS];
     qemu_irq ppc0_irq;
     qemu_irq ppc1_irq;
     qemu_irq sec_resp_cfg;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index a2ae5d3c4b9..5cb2b78b1fc 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -21,18 +21,35 @@
 struct ARMSSEInfo {
     const char *name;
     int sram_banks;
+    int num_cpus;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
     {
         .name = TYPE_IOTKIT,
         .sram_banks = 1,
+        .num_cpus = 1,
     },
 };
 
 /* Clock frequency in HZ of the 32KHz "slow clock" */
 #define S32KCLK (32 * 1000)
 
+/* Is internal IRQ n shared between CPUs in a multi-core SSE ? */
+static bool irq_is_common[32] = {
+    [0 ... 5] = true,
+    /* 6, 7: per-CPU MHU interrupts */
+    [8 ... 12] = true,
+    /* 13: per-CPU icache interrupt */
+    /* 14: reserved */
+    [15 ... 20] = true,
+    /* 21: reserved */
+    [22 ... 26] = true,
+    /* 27: reserved */
+    /* 28, 29: per-CPU CTI interrupts */
+    /* 30, 31: reserved */
+};
+
 /* Create an alias region of @size bytes starting at @base
  * which mirrors the memory starting at @orig.
  */
@@ -125,13 +142,18 @@ static void armsse_init(Object *obj)
     int i;
 
     assert(info->sram_banks <= MAX_SRAM_BANKS);
+    assert(info->num_cpus <= SSE_MAX_CPUS);
 
     memory_region_init(&s->container, obj, "armsse-container", UINT64_MAX);
 
-    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
-                          TYPE_ARMV7M);
-    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
-                         ARM_CPU_TYPE_NAME("cortex-m33"));
+    for (i = 0; i < info->num_cpus; i++) {
+        char *name = g_strdup_printf("armv7m%d", i);
+        sysbus_init_child_obj(obj, name, &s->armv7m[i], sizeof(s->armv7m),
+                              TYPE_ARMV7M);
+        qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
+                             ARM_CPU_TYPE_NAME("cortex-m33"));
+        g_free(name);
+    }
 
     sysbus_init_child_obj(obj, "secctl", &s->secctl, sizeof(s->secctl),
                           TYPE_IOTKIT_SECCTL);
@@ -192,13 +214,25 @@ static void armsse_init(Object *obj)
                                 TYPE_SPLIT_IRQ, &error_abort, NULL);
         g_free(name);
     }
+    if (info->num_cpus > 1) {
+        for (i = 0; i < ARRAY_SIZE(s->cpu_irq_splitter); i++) {
+            if (irq_is_common[i]) {
+                char *name = g_strdup_printf("cpu-irq-splitter%d", i);
+                SplitIRQ *splitter = &s->cpu_irq_splitter[i];
+
+                object_initialize_child(obj, name, splitter, sizeof(*splitter),
+                                        TYPE_SPLIT_IRQ, &error_abort, NULL);
+                g_free(name);
+            }
+        }
+    }
 }
 
 static void armsse_exp_irq(void *opaque, int n, int level)
 {
-    ARMSSE *s = ARMSSE(opaque);
+    qemu_irq *irqarray = opaque;
 
-    qemu_set_irq(s->exp_irqs[n], level);
+    qemu_set_irq(irqarray[n], level);
 }
 
 static void armsse_mpcexp_status(void *opaque, int n, int level)
@@ -207,6 +241,26 @@ static void armsse_mpcexp_status(void *opaque, int n, int level)
     qemu_set_irq(s->mpcexp_status_in[n], level);
 }
 
+static qemu_irq armsse_get_common_irq_in(ARMSSE *s, int irqno)
+{
+    /*
+     * Return a qemu_irq which can be used to signal IRQ n to
+     * all CPUs in the SSE.
+     */
+    ARMSSEClass *asc = ARMSSE_GET_CLASS(s);
+    const ARMSSEInfo *info = asc->info;
+
+    assert(irq_is_common[irqno]);
+
+    if (info->num_cpus == 1) {
+        /* Only one CPU -- just connect directly to it */
+        return qdev_get_gpio_in(DEVICE(&s->armv7m[0]), irqno);
+    } else {
+        /* Connect to the splitter which feeds all CPUs */
+        return qdev_get_gpio_in(DEVICE(&s->cpu_irq_splitter[irqno]), 0);
+    }
+}
+
 static void armsse_realize(DeviceState *dev, Error **errp)
 {
     ARMSSE *s = ARMSSE(dev);
@@ -280,37 +334,105 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
 
-    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", s->exp_numirq + 32);
-    /* In real hardware the initial Secure VTOR is set from the INITSVTOR0
-     * register in the IoT Kit System Control Register block, and the
-     * initial value of that is in turn specifiable by the FPGA that
-     * instantiates the IoT Kit. In QEMU we don't implement this wrinkle,
-     * and simply set the CPU's init-svtor to the IoT Kit default value.
-     */
-    qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-svtor", 0x10000000);
-    object_property_set_link(OBJECT(&s->armv7m), OBJECT(&s->container),
-                             "memory", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    object_property_set_link(OBJECT(&s->armv7m), OBJECT(s), "idau", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i = 0; i < info->num_cpus; i++) {
+        DeviceState *cpudev = DEVICE(&s->armv7m[i]);
+        Object *cpuobj = OBJECT(&s->armv7m[i]);
+        int j;
+        char *gpioname;
+
+        qdev_prop_set_uint32(cpudev, "num-irq", s->exp_numirq + 32);
+        /*
+         * In real hardware the initial Secure VTOR is set from the INITSVTOR0
+         * register in the IoT Kit System Control Register block, and the
+         * initial value of that is in turn specifiable by the FPGA that
+         * instantiates the IoT Kit. In QEMU we don't implement this wrinkle,
+         * and simply set the CPU's init-svtor to the IoT Kit default value.
+         * In SSE-200 the situation is similar, except that the default value
+         * is a reset-time signal input. Typically a board using the SSE-200
+         * will have a system control processor whose boot firmware initializes
+         * the INITSVTOR* registers before powering up the CPUs in any case,
+         * so the hardware's default value doesn't matter. QEMU doesn't emulate
+         * the control processor, so instead we behave in the way that the
+         * firmware does. All boards currently known about have firmware that
+         * sets the INITSVTOR0 and INITSVTOR1 registers to 0x10000000, like the
+         * IoTKit default. We can make this more configurable if necessary.
+         */
+        qdev_prop_set_uint32(cpudev, "init-svtor", 0x10000000);
+        /*
+         * Start all CPUs except CPU0 powered down. In real hardware it is
+         * a configurable property of the SSE-200 which CPUs start powered up
+         * (via the CPUWAIT0_RST and CPUWAIT1_RST parameters), but since all
+         * the boards we care about start CPU0 and leave CPU1 powered off,
+         * we hard-code that for now. We can add QOM properties for this
+         * later if necessary.
+         */
+        if (i > 0) {
+            object_property_set_bool(cpuobj, true, "start-powered-off", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+        }
+        object_property_set_link(cpuobj, OBJECT(&s->container), "memory", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_bool(cpuobj, true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        /* Connect EXP_IRQ/EXP_CPUn_IRQ GPIOs to the NVIC's lines 32 and up */
+        s->exp_irqs[i] = g_new(qemu_irq, s->exp_numirq);
+        for (j = 0; j < s->exp_numirq; j++) {
+            s->exp_irqs[i][j] = qdev_get_gpio_in(cpudev, i + 32);
+        }
+        if (i == 0) {
+            gpioname = g_strdup("EXP_IRQ");
+        } else {
+            gpioname = g_strdup_printf("EXP_CPU%d_IRQ", i);
+        }
+        qdev_init_gpio_in_named_with_opaque(dev, armsse_exp_irq,
+                                            s->exp_irqs[i],
+                                            gpioname, s->exp_numirq);
+        g_free(gpioname);
     }
 
-    /* Connect our EXP_IRQ GPIOs to the NVIC's lines 32 and up. */
-    s->exp_irqs = g_new(qemu_irq, s->exp_numirq);
-    for (i = 0; i < s->exp_numirq; i++) {
-        s->exp_irqs[i] = qdev_get_gpio_in(DEVICE(&s->armv7m), i + 32);
+    /* Wire up the splitters that connect common IRQs to all CPUs */
+    if (info->num_cpus > 1) {
+        for (i = 0; i < ARRAY_SIZE(s->cpu_irq_splitter); i++) {
+            if (irq_is_common[i]) {
+                Object *splitter = OBJECT(&s->cpu_irq_splitter[i]);
+                DeviceState *devs = DEVICE(splitter);
+                int cpunum;
+
+                object_property_set_int(splitter, info->num_cpus,
+                                        "num-lines", &err);
+                if (err) {
+                    error_propagate(errp, err);
+                    return;
+                }
+                object_property_set_bool(splitter, true, "realized", &err);
+                if (err) {
+                    error_propagate(errp, err);
+                    return;
+                }
+                for (cpunum = 0; cpunum < info->num_cpus; cpunum++) {
+                    DeviceState *cpudev = DEVICE(&s->armv7m[cpunum]);
+
+                    qdev_connect_gpio_out(devs, cpunum,
+                                          qdev_get_gpio_in(cpudev, i));
+                }
+            }
+        }
     }
-    qdev_init_gpio_in_named(dev, armsse_exp_irq, "EXP_IRQ", s->exp_numirq);
 
     /* Set up the big aliases first */
     make_alias(s, &s->alias1, "alias 1", 0x10000000, 0x10000000, 0x00000000);
@@ -407,7 +529,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->mpc_irq_orgate), 0,
-                          qdev_get_gpio_in(DEVICE(&s->armv7m), 9));
+                          armsse_get_common_irq_in(s, 9));
 
     /* Devices behind APB PPC0:
      *   0x40000000: timer0
@@ -424,7 +546,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 3));
+                       armsse_get_common_irq_in(s, 3));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer0), 0);
     object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]", &err);
     if (err) {
@@ -439,7 +561,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 4));
+                       armsse_get_common_irq_in(s, 4));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
     object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]", &err);
     if (err) {
@@ -455,7 +577,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 5));
+                       armsse_get_common_irq_in(s, 5));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dualtimer), 0);
     object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]", &err);
     if (err) {
@@ -513,7 +635,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->ppc_irq_orgate), 0,
-                          qdev_get_gpio_in(DEVICE(&s->armv7m), 10));
+                          armsse_get_common_irq_in(s, 10));
 
     /* 0x40010000 .. 0x4001ffff: private CPU region: unused in IoTKit */
 
@@ -528,7 +650,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 2));
+                       armsse_get_common_irq_in(s, 2));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
     object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]", &err);
     if (err) {
@@ -609,7 +731,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->nswatchdog), 0,
-                       qdev_get_gpio_in(DEVICE(&s->armv7m), 1));
+                       armsse_get_common_irq_in(s, 1));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
 
     qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
@@ -715,7 +837,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     qdev_pass_gpios(dev_secctl, dev, "mscexp_clear");
     qdev_pass_gpios(dev_secctl, dev, "mscexp_ns");
     qdev_connect_gpio_out_named(dev_secctl, "msc_irq", 0,
-                                qdev_get_gpio_in(DEVICE(&s->armv7m), 11));
+                                armsse_get_common_irq_in(s, 11));
 
     /*
      * Expose our container region to the board model; this corresponds
-- 
2.20.1
