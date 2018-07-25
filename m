Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeJ-00087u-6Z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeG-00023I-9P
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:59:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 25 Jul 2018 09:59:38 +0100
Message-Id: <20180725085944.11856-2-stefanha@redhat.com>
In-Reply-To: <20180725085944.11856-1-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] hw/arm: rename armv7m_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mail@steffen-goertz.de, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, ilg@livius.net, qemu-arm@nongnu.org, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, jim@groklearning.com, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

ARMv6-M and ARMv8-M need the same kernel loading functionality as
ARMv7-M.  Rename armv7m_load_kernel() to arm_m_profile_load_kernel() so
it's clear that this function isn't specific to ARMv7-M.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/Makefile.objs            |  1 +
 include/hw/arm/arm.h            | 11 +++--
 hw/arm/arm-m-profile.c          | 81 +++++++++++++++++++++++++++++++++
 hw/arm/armv7m.c                 | 60 ------------------------
 hw/arm/mps2-tz.c                |  3 +-
 hw/arm/mps2.c                   |  4 +-
 hw/arm/msf2-som.c               |  4 +-
 hw/arm/netduino2.c              |  4 +-
 hw/arm/stellaris.c              |  3 +-
 default-configs/arm-softmmu.mak |  1 +
 10 files changed, 99 insertions(+), 73 deletions(-)
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
diff --git a/hw/arm/arm-m-profile.c b/hw/arm/arm-m-profile.c
new file mode 100644
index 0000000000..262706ed62
--- /dev/null
+++ b/hw/arm/arm-m-profile.c
@@ -0,0 +1,81 @@
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
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/arm/arm.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "sysemu/qtest.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
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
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 6b07666057..7405a1ec69 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -258,66 +258,6 @@ static const TypeInfo armv7m_info = {
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
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 2432b5e935..cb21ced472 100644
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
