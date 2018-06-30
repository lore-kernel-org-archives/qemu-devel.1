Received: from eggs.gnu.org ([2001:4830:134:3::10]:33611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3a-0008Fp-El
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3X-0001qU-5s
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 30 Jun 2018 10:13:41 +0100
Message-Id: <20180630091343.14391-2-stefanha@redhat.com>
In-Reply-To: <20180630091343.14391-1-stefanha@redhat.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] hw/arm: extract ARM M Profile base
 class from ARMv7-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, joel@jms.id.au, qemu-arm@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, jusual@mail.ru, Subbaraya Sundeep <sundeep.lkml@gmail.com>, ilg@livius.net, Stefan Hajnoczi <stefanha@redhat.com>

The ARMv7-M code is largely similar to what other M Profile CPUs need.
Extract the common M Profile aspects into the ARMMProfileState base
class.  ARMv6-M will inherit from this class in the following patch.

It might be possible to make ARMv6-M the base class of ARMv7-M, but it
seems cleaner to have an M Profile base class instead of saying an
"ARMv7-M is an ARMv6-M".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/Makefile.objs            |   1 +
 include/hw/arm/arm-m-profile.h  |  65 +++++++++++
 include/hw/arm/arm.h            |  11 +-
 include/hw/arm/armv7m.h         |  22 +---
 hw/arm/arm-m-profile.c          | 192 ++++++++++++++++++++++++++++++++
 hw/arm/armv7m.c                 | 166 ++++++---------------------
 hw/arm/mps2-tz.c                |   3 +-
 hw/arm/mps2.c                   |   4 +-
 hw/arm/msf2-soc.c               |   4 +-
 hw/arm/msf2-som.c               |   4 +-
 hw/arm/netduino2.c              |   4 +-
 hw/arm/stellaris.c              |   3 +-
 default-configs/arm-softmmu.mak |   1 +
 13 files changed, 314 insertions(+), 166 deletions(-)
 create mode 100644 include/hw/arm/arm-m-profile.h
 create mode 100644 hw/arm/arm-m-profile.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index d51fcecaf2..2c43d34c64 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -16,6 +16,7 @@ obj-$(CONFIG_STRONGARM) += collie.o
 obj-$(CONFIG_VERSATILE) += vexpress.o versatilepb.o
 obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
 
+obj-$(CONFIG_ARM_M_PROFILE) += arm-m-profile.o
 obj-$(CONFIG_ARM_V7M) += armv7m.o
 obj-$(CONFIG_EXYNOS4) += exynos4210.o
 obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
diff --git a/include/hw/arm/arm-m-profile.h b/include/hw/arm/arm-m-profile.h
new file mode 100644
index 0000000000..a9c3300411
--- /dev/null
+++ b/include/hw/arm/arm-m-profile.h
@@ -0,0 +1,65 @@
+/*
+ * ARM M Profile CPU base class
+ *
+ * Copyright (c) 2017 Linaro Ltd
+ * Written by Peter Maydell <peter.maydell@linaro.org>
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.
+ */
+
+#ifndef HW_ARM_ARM_M_PROFILE_H
+#define HW_ARM_ARM_M_PROFILE_H
+
+#include "hw/sysbus.h"
+#include "hw/intc/armv7m_nvic.h"
+
+#define TYPE_ARM_M_PROFILE "arm-m-profile"
+#define ARM_M_PROFILE(obj) OBJECT_CHECK(ARMMProfileState, (obj), \
+                                        TYPE_ARM_M_PROFILE)
+#define ARM_M_PROFILE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(ARMMProfileClass, (klass), TYPE_ARM_M_PROFILE)
+#define ARM_M_PROFILE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(ARMMProfileClass, (obj), TYPE_ARM_M_PROFILE)
+
+/* ARM M Profile container object.
+ * + Unnamed GPIO input lines: external IRQ lines for the NVIC
+ * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
+ * + Property "cpu-type": CPU type to instantiate
+ * + Property "num-irq": number of external IRQ lines
+ * + Property "memory": MemoryRegion defining the physical address space
+ *   that CPU accesses see. (The NVIC and other CPU-internal devices will be
+ *   automatically layered on top of this view.)
+ */
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    NVICState nvic;
+    ARMCPU *cpu;
+
+    /* MemoryRegion we pass to the CPU, with our devices layered on
+     * top of the ones the board provides in board_memory.
+     */
+    MemoryRegion container;
+
+    /* Properties */
+    char *cpu_type;
+    /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
+    MemoryRegion *board_memory;
+} ARMMProfileState;
+
+typedef struct {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+
+    /*< public >*/
+    /**
+     * Initialize the CPU object, for example by setting properties, before it
+     * gets realized.  May be NULL.
+     */
+    void (*cpu_init)(ARMMProfileState *s, Error **errp);
+} ARMMProfileClass;
+
+#endif
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ffed39252d..2b919e57ee 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -24,16 +24,17 @@ typedef enum {
 } arm_endianness;
 
 /**
- * armv7m_load_kernel:
+ * arm_m_profile_load_kernel:
  * @cpu: CPU
  * @kernel_filename: file to load
- * @mem_size: mem_size: maximum image size to load
+ * @mem_size: maximum image size to load
  *
- * Load the guest image for an ARMv7M system. This must be called by
- * any ARMv7M board. (This is necessary to ensure that the CPU resets
+ * Load the guest image for an ARM M Profile system. This must be called by
+ * any ARM M Profile board. (This is necessary to ensure that the CPU resets
  * correctly on system reset, as well as for kernel loading.)
  */
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
+void arm_m_profile_load_kernel(ARMCPU *cpu, const char *kernel_filename,
+                               int mem_size);
 
 /* arm_boot.c */
 struct arm_boot_info {
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 78308d1484..c9b6ab37e7 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -10,8 +10,7 @@
 #ifndef HW_ARM_ARMV7M_H
 #define HW_ARM_ARMV7M_H
 
-#include "hw/sysbus.h"
-#include "hw/intc/armv7m_nvic.h"
+#include "hw/arm/arm-m-profile.h"
 #include "target/arm/idau.h"
 
 #define TYPE_BITBAND "ARM,bitband-memory"
@@ -34,33 +33,16 @@ typedef struct {
 #define ARMV7M_NUM_BITBANDS 2
 
 /* ARMv7M container object.
- * + Unnamed GPIO input lines: external IRQ lines for the NVIC
- * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
- * + Property "cpu-type": CPU type to instantiate
- * + Property "num-irq": number of external IRQ lines
- * + Property "memory": MemoryRegion defining the physical address space
- *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
- *   devices will be automatically layered on top of this view.)
  * + Property "idau": IDAU interface (forwarded to CPU object)
  * + Property "init-svtor": secure VTOR reset value (forwarded to CPU object)
  */
 typedef struct ARMv7MState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    ARMMProfileState parent_obj;
     /*< public >*/
-    NVICState nvic;
     BitBandState bitband[ARMV7M_NUM_BITBANDS];
-    ARMCPU *cpu;
-
-    /* MemoryRegion we pass to the CPU, with our devices layered on
-     * top of the ones the board provides in board_memory.
-     */
-    MemoryRegion container;
 
     /* Properties */
-    char *cpu_type;
-    /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
-    MemoryRegion *board_memory;
     Object *idau;
     uint32_t init_svtor;
 } ARMv7MState;
diff --git a/hw/arm/arm-m-profile.c b/hw/arm/arm-m-profile.c
new file mode 100644
index 0000000000..c0c8afb2e8
--- /dev/null
+++ b/hw/arm/arm-m-profile.c
@@ -0,0 +1,192 @@
+/*
+ * ARM M Profile System emulation.
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * Copyright (c) 2006-2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/arm-m-profile.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/arm/arm.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "sysemu/qtest.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+#include "target/arm/idau.h"
+
+static void arm_m_profile_instance_init(Object *obj)
+{
+    ARMMProfileState *s = ARM_M_PROFILE(obj);
+
+    /* Can't init the cpu here, we don't yet know which model to use */
+
+    memory_region_init(&s->container, obj, "arm-m-profile-container",
+                       UINT64_MAX);
+
+    object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
+    qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
+    object_property_add_alias(obj, "num-irq",
+                              OBJECT(&s->nvic), "num-irq", &error_abort);
+}
+
+static void arm_m_profile_realize(DeviceState *dev, Error **errp)
+{
+    ARMMProfileState *s = ARM_M_PROFILE(dev);
+    ARMMProfileClass *mc = ARM_M_PROFILE_GET_CLASS(dev);
+    SysBusDevice *sbd;
+    Error *err = NULL;
+
+    if (!s->board_memory) {
+        error_setg(errp, "memory property was not set");
+        return;
+    }
+
+    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
+
+    s->cpu = ARM_CPU(object_new(s->cpu_type));
+
+    object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
+                             &error_abort);
+
+    /* Tell the CPU where the NVIC is; it will fail realize if it doesn't
+     * have one.
+     */
+    s->cpu->env.nvic = &s->nvic;
+
+    if (mc->cpu_init) {
+        mc->cpu_init(s, &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
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
+    sbd = SYS_BUS_DEVICE(&s->nvic);
+    sysbus_connect_irq(sbd, 0,
+                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
+
+    memory_region_add_subregion(&s->container, 0xe000e000,
+                                sysbus_mmio_get_region(sbd, 0));
+}
+
+static Property arm_m_profile_properties[] = {
+    DEFINE_PROP_STRING("cpu-type", ARMMProfileState, cpu_type),
+    DEFINE_PROP_LINK("memory", ARMMProfileState, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void arm_m_profile_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = arm_m_profile_realize;
+    dc->props = arm_m_profile_properties;
+}
+
+static const TypeInfo arm_m_profile_info = {
+    .name = TYPE_ARM_M_PROFILE,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ARMMProfileState),
+    .instance_init = arm_m_profile_instance_init,
+    .abstract = true,
+    .class_size = sizeof(ARMMProfileClass),
+    .class_init = arm_m_profile_class_init,
+};
+
+static void arm_m_profile_reset(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
+void arm_m_profile_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
+{
+    int image_size;
+    uint64_t entry;
+    uint64_t lowaddr;
+    int big_endian;
+    AddressSpace *as;
+    int asidx;
+    CPUState *cs = CPU(cpu);
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    big_endian = 1;
+#else
+    big_endian = 0;
+#endif
+
+    if (!kernel_filename && !qtest_enabled()) {
+        error_report("Guest image must be specified (using -kernel)");
+        exit(1);
+    }
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+        asidx = ARMASIdx_S;
+    } else {
+        asidx = ARMASIdx_NS;
+    }
+    as = cpu_get_address_space(cs, asidx);
+
+    if (kernel_filename) {
+        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
+                                 NULL, big_endian, EM_ARM, 1, 0, as);
+        if (image_size < 0) {
+            image_size = load_image_targphys_as(kernel_filename, 0,
+                                                mem_size, as);
+            lowaddr = 0;
+        }
+        if (image_size < 0) {
+            error_report("Could not load kernel '%s'", kernel_filename);
+            exit(1);
+        }
+    }
+
+    /* CPU objects (unlike devices) are not automatically reset on system
+     * reset, so we must always register a handler to do so. Unlike
+     * A-profile CPUs, we don't need to do anything special in the
+     * handler to arrange that it starts correctly.
+     * This is arguably the wrong place to do this, but it matches the
+     * way A-profile does it. Note that this means that every M profile
+     * board must call this function!
+     */
+    qemu_register_reset(arm_m_profile_reset, cpu);
+}
+
+static void arm_m_profile_register_types(void)
+{
+    type_register_static(&arm_m_profile_info);
+}
+
+type_init(arm_m_profile_register_types)
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 9e00d4037c..18688b7441 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -130,88 +130,50 @@ static void armv7m_instance_init(Object *obj)
     ARMv7MState *s = ARMV7M(obj);
     int i;
 
-    /* Can't init the cpu here, we don't yet know which model to use */
-
-    memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
-
-    object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
-    qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
-    object_property_add_alias(obj, "num-irq",
-                              OBJECT(&s->nvic), "num-irq", &error_abort);
-
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
         object_initialize(&s->bitband[i], sizeof(s->bitband[i]), TYPE_BITBAND);
         qdev_set_parent_bus(DEVICE(&s->bitband[i]), sysbus_get_default());
     }
 }
 
+static void armv7m_cpu_init(ARMMProfileState *s_, Error **errp)
+{
+    ARMv7MState *s = ARMV7M(s_);
+    ARMCPU *cpu = s_->cpu;
+    Error *err = NULL;
+
+    if (object_property_find(OBJECT(cpu), "idau", NULL)) {
+        object_property_set_link(OBJECT(cpu), s->idau, "idau", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+    if (object_property_find(OBJECT(cpu), "init-svtor", NULL)) {
+        object_property_set_uint(OBJECT(cpu), s->init_svtor,
+                                 "init-svtor", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+}
+
 static void armv7m_realize(DeviceState *dev, Error **errp)
 {
     ARMv7MState *s = ARMV7M(dev);
-    SysBusDevice *sbd;
+    ObjectClass *klass = object_get_class(OBJECT(dev));
+    ObjectClass *parent_class = object_class_get_parent(klass);
+    DeviceRealize parent_realize = DEVICE_CLASS(parent_class)->realize;
     Error *err = NULL;
     int i;
 
-    if (!s->board_memory) {
-        error_setg(errp, "memory property was not set");
-        return;
-    }
-
-    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
-
-    s->cpu = ARM_CPU(object_new(s->cpu_type));
-
-    object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
-                             &error_abort);
-    if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
-        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
-    }
-    if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
-        object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
-                                 "init-svtor", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
-    }
-
-    /* Tell the CPU where the NVIC is; it will fail realize if it doesn't
-     * have one.
-     */
-    s->cpu->env.nvic = &s->nvic;
-
-    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    /* Note that we must realize the NVIC after the CPU */
-    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
-    if (err != NULL) {
+    parent_realize(dev, &err);
+    if (err) {
         error_propagate(errp, err);
         return;
     }
 
-    /* Alias the NVIC's input and output GPIOs as our own so the board
-     * code can wire them up. (We do this in realize because the
-     * NVIC doesn't create the input GPIO array until realize.)
-     */
-    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
-    qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
-
-    /* Wire the NVIC up to the CPU */
-    sbd = SYS_BUS_DEVICE(&s->nvic);
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
-
-    memory_region_add_subregion(&s->container, 0xe000e000,
-                                sysbus_mmio_get_region(sbd, 0));
-
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
         Object *obj = OBJECT(&s->bitband[i]);
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
@@ -221,7 +183,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_link(obj, OBJECT(s->board_memory),
+        object_property_set_link(obj, OBJECT(s->parent_obj.board_memory),
                                  "source-memory", &error_abort);
         object_property_set_bool(obj, true, "realized", &err);
         if (err != NULL) {
@@ -229,15 +191,13 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        memory_region_add_subregion(&s->container, bitband_output_addr[i],
+        memory_region_add_subregion(&s->parent_obj.container,
+                                    bitband_output_addr[i],
                                     sysbus_mmio_get_region(sbd, 0));
     }
 }
 
 static Property armv7m_properties[] = {
-    DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
-    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
     DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Object *),
     DEFINE_PROP_UINT32("init-svtor", ARMv7MState, init_svtor, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -246,79 +206,21 @@ static Property armv7m_properties[] = {
 static void armv7m_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ARMMProfileClass *mc = ARM_M_PROFILE_CLASS(klass);
 
     dc->realize = armv7m_realize;
     dc->props = armv7m_properties;
+    mc->cpu_init = armv7m_cpu_init;
 }
 
 static const TypeInfo armv7m_info = {
     .name = TYPE_ARMV7M,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_ARM_M_PROFILE,
     .instance_size = sizeof(ARMv7MState),
     .instance_init = armv7m_instance_init,
     .class_init = armv7m_class_init,
 };
 
-static void armv7m_reset(void *opaque)
-{
-    ARMCPU *cpu = opaque;
-
-    cpu_reset(CPU(cpu));
-}
-
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
-{
-    int image_size;
-    uint64_t entry;
-    uint64_t lowaddr;
-    int big_endian;
-    AddressSpace *as;
-    int asidx;
-    CPUState *cs = CPU(cpu);
-
-#ifdef TARGET_WORDS_BIGENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
-
-    if (!kernel_filename && !qtest_enabled()) {
-        error_report("Guest image must be specified (using -kernel)");
-        exit(1);
-    }
-
-    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
-        asidx = ARMASIdx_S;
-    } else {
-        asidx = ARMASIdx_NS;
-    }
-    as = cpu_get_address_space(cs, asidx);
-
-    if (kernel_filename) {
-        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
-                                 NULL, big_endian, EM_ARM, 1, 0, as);
-        if (image_size < 0) {
-            image_size = load_image_targphys_as(kernel_filename, 0,
-                                                mem_size, as);
-            lowaddr = 0;
-        }
-        if (image_size < 0) {
-            error_report("Could not load kernel '%s'", kernel_filename);
-            exit(1);
-        }
-    }
-
-    /* CPU objects (unlike devices) are not automatically reset on system
-     * reset, so we must always register a handler to do so. Unlike
-     * A-profile CPUs, we don't need to do anything special in the
-     * handler to arrange that it starts correctly.
-     * This is arguably the wrong place to do this, but it matches the
-     * way A-profile does it. Note that this means that every M profile
-     * board must call this function!
-     */
-    qemu_register_reset(armv7m_reset, cpu);
-}
-
 static Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
     DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 22180c56fb..af10ee0cc9 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -487,7 +487,8 @@ static void mps2tz_common_init(MachineState *machine)
 
     create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400000);
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                              0x400000);
 }
 
 static void mps2tz_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index c3946da317..bcc7070104 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -315,8 +315,8 @@ static void mps2_common_init(MachineState *machine)
 
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       0x400000);
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                              0x400000);
 }
 
 static void mps2_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 75c44adf7d..2ac870d17b 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -88,6 +88,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     MSF2State *s = MSF2_SOC(dev_soc);
     DeviceState *dev, *armv7m;
+    ARMMProfileState *arm_m_profile;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -116,6 +117,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
 
     armv7m = DEVICE(&s->armv7m);
+    arm_m_profile = ARM_M_PROFILE(armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
@@ -132,7 +134,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    qdev_connect_gpio_out_named(DEVICE(&s->armv7m.nvic), "SYSRESETREQ", 0,
+    qdev_connect_gpio_out_named(DEVICE(&arm_m_profile->nvic), "SYSRESETREQ", 0,
                                 qemu_allocate_irq(&do_sys_reset, NULL, 0));
 
     system_clock_scale = NANOSECONDS_PER_SECOND / s->m3clk;
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 0795a3a3a1..8eb7564f0a 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -91,8 +91,8 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       soc->envm_size);
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                              soc->envm_size);
 }
 
 static void emcraft_sf2_machine_init(MachineClass *mc)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..e18d377f94 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -37,8 +37,8 @@ static void netduino2_init(MachineState *machine)
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       FLASH_SIZE);
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                              FLASH_SIZE);
 }
 
 static void netduino2_machine_init(MachineClass *mc)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index dc521b4a5a..68e52367c0 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1440,7 +1440,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size);
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename,
+                              flash_size);
 }
 
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 834d45cfaf..e704cb6e34 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -48,6 +48,7 @@ CONFIG_ARM11MPCORE=y
 CONFIG_A9MPCORE=y
 CONFIG_A15MPCORE=y
 
+CONFIG_ARM_M_PROFILE=y
 CONFIG_ARM_V7M=y
 CONFIG_NETDUINO2=y
 
-- 
2.17.1
