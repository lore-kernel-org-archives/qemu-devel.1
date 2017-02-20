Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0q-0006g1-IR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0p-0003UO-Ae
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 15:35:57 +0000
Message-Id: <1487604965-23220-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/11] armv7m: QOMify the armv7m container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

Create a proper QOM object for the armv7m container, which
holds the CPU, the NVIC and the bitband regions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h |  51 ++++++++++++++++++
 hw/arm/armv7m.c         | 140 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 179 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/arm/armv7m.h

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
new file mode 100644
index 0000000..193ad71
--- /dev/null
+++ b/include/hw/arm/armv7m.h
@@ -0,0 +1,51 @@
+/*
+ * ARMv7M CPU object
+ *
+ * Copyright (c) 2017 Linaro Ltd
+ * Written by Peter Maydell <peter.maydell@linaro.org>
+ *
+ * This code is licensed under the GPL version 2 or later.
+ */
+
+#ifndef HW_ARM_ARMV7M_H
+#define HW_ARM_ARMV7M_H
+
+#include "hw/sysbus.h"
+#include "hw/arm/armv7m_nvic.h"
+
+#define TYPE_BITBAND "ARM,bitband-memory"
+#define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t base;
+} BitBandState;
+
+#define TYPE_ARMV7M "armv7m"
+#define ARMV7M(obj) OBJECT_CHECK(ARMv7MState, (obj), TYPE_ARMV7M)
+
+#define ARMV7M_NUM_BITBANDS 2
+
+/* ARMv7M container object.
+ * + Unnamed GPIO input lines: external IRQ lines for the NVIC
+ * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
+ * + Property "cpu-model": CPU model to instantiate
+ * + Property "num-irq": number of external IRQ lines
+ */
+typedef struct ARMv7MState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    NVICState nvic;
+    BitBandState bitband[ARMV7M_NUM_BITBANDS];
+    ARMCPU *cpu;
+
+    /* Properties */
+    char *cpu_model;
+} ARMv7MState;
+
+#endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index b2cc6e9..56d02d4 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/arm/armv7m.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -120,18 +121,6 @@ static const MemoryRegionOps bitband_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-#define TYPE_BITBAND "ARM,bitband-memory"
-#define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
-
-typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    uint32_t base;
-} BitBandState;
-
 static void bitband_init(Object *obj)
 {
     BitBandState *s = BITBAND(obj);
@@ -159,6 +148,132 @@ static void armv7m_bitband_init(void)
 
 /* Board init.  */
 
+static const hwaddr bitband_input_addr[ARMV7M_NUM_BITBANDS] = {
+    0x20000000, 0x40000000
+};
+
+static const hwaddr bitband_output_addr[ARMV7M_NUM_BITBANDS] = {
+    0x22000000, 0x42000000
+};
+
+static void armv7m_instance_init(Object *obj)
+{
+    ARMv7MState *s = ARMV7M(obj);
+    int i;
+
+    /* Can't init the cpu here, we don't yet know which model to use */
+
+    object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
+    qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
+    object_property_add_alias(obj, "num-irq",
+                              OBJECT(&s->nvic), "num-irq", &error_abort);
+
+    for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
+        object_initialize(&s->bitband[i], sizeof(s->bitband[i]), TYPE_BITBAND);
+        qdev_set_parent_bus(DEVICE(&s->bitband[i]), sysbus_get_default());
+    }
+}
+
+static void armv7m_realize(DeviceState *dev, Error **errp)
+{
+    /* here realize our children */
+    ARMv7MState *s = ARMV7M(dev);
+    Error *err = NULL;
+    int i;
+    char **cpustr;
+    ObjectClass *oc;
+    const char *typename;
+    CPUClass *cc;
+
+    cpustr = g_strsplit(s->cpu_model, ",", 2);
+
+    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
+    if (!oc) {
+        error_setg(errp, "Unknown CPU model %s", cpustr[0]);
+        g_strfreev(cpustr);
+        return;
+    }
+
+    cc = CPU_CLASS(oc);
+    typename = object_class_get_name(oc);
+    cc->parse_features(typename, cpustr[1], &err);
+    g_strfreev(cpustr);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    s->cpu = ARM_CPU(object_new(typename));
+    if (!s->cpu) {
+        error_setg(errp, "Unknown CPU model %s", s->cpu_model);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Note that we must realize the NVIC after the CPU */
+    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Alias the NVIC's input and output GPIOs as our own so the board
+     * code can wire them up. (We do this in realize because the
+     * NVIC doesn't create the input GPIO array until realize.)
+     */
+    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
+    qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
+
+    /* Wire the NVIC up to the CPU */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->nvic), 0,
+                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
+    s->cpu->env.nvic = &s->nvic;
+
+    for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
+        Object *obj = OBJECT(&s->bitband[i]);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
+
+        object_property_set_int(obj, bitband_input_addr[i], "base", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_bool(obj, true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(sbd, 0, bitband_output_addr[i]);
+    }
+}
+
+static Property armv7m_properties[] = {
+    DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void armv7m_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = armv7m_realize;
+    dc->props = armv7m_properties;
+}
+
+static const TypeInfo armv7m_info = {
+    .name = TYPE_ARMV7M,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ARMv7MState),
+    .instance_init = armv7m_instance_init,
+    .class_init = armv7m_class_init,
+};
+
 static void armv7m_reset(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -264,6 +379,7 @@ static const TypeInfo bitband_info = {
 static void armv7m_register_types(void)
 {
     type_register_static(&bitband_info);
+    type_register_static(&armv7m_info);
 }
 
 type_init(armv7m_register_types)
-- 
2.7.4
