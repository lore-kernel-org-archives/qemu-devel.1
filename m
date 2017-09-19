Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzS-0005DN-A9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzM-0004b3-La
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzM-0004Zj-7X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:46 -0300
Message-Id: <20170919201850.14772-9-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] arm: drop intermediate cpu_model -> cpu
 type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

there are 2 use cases to deal with:
  1: fixed CPU models per board/soc
  2: boards with user configurable cpu_model and fallback to
     default cpu_model if user hasn't specified one explicitly

For the 1st
  drop intermediate cpu_model parsing and use const cpu type
  directly, which replaces:
     typename =3D object_class_get_name(
           cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
     object_new(typename)
  with
     object_new(FOO_CPU_TYPE_NAME)
  or
     cpu_generic_init(BASE_CPU_TYPE, "my cpu model")
  with
     cpu_create(FOO_CPU_TYPE_NAME)

as result 1st use case doesn't have to invoke not necessary
translation and not needed code is removed.

For the 2nd
 1: set default cpu type with MachineClass::default_cpu_type and
 2: use generic cpu_model parsing that done before machine_init()
    is run and:
    2.1: drop custom cpu_model parsing where pattern is:
       typename =3D object_class_get_name(
           cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
       [parse_features(typename, cpu_model, &err) ]

    2.2: or replace cpu_generic_init() which does what
         2.1 does + create_cpu(typename) with just
         create_cpu(machine->cpu_type)
as result cpu_name -> cpu_type translation is done using
generic machine code one including parsing optional features
if supported/present (removes a bunch of duplicated cpu_model
parsing code) and default cpu type is defined in an uniform way
within machine_class_init callbacks instead of adhoc places
in boadr's machine_init code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1505318697-77161-6-git-send-email-imammedo@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/armv7m.h        |  4 ++--
 include/hw/arm/aspeed_soc.h    |  2 +-
 include/hw/arm/stm32f205_soc.h |  2 +-
 target/arm/cpu.h               |  3 +++
 hw/arm/armv7m.c                | 40 +++++-------------------------------
 hw/arm/aspeed_soc.c            | 13 +++++-------
 hw/arm/collie.c                | 10 +++------
 hw/arm/exynos4210.c            |  6 +-----
 hw/arm/gumstix.c               |  5 +++--
 hw/arm/highbank.c              | 10 ++++-----
 hw/arm/integratorcp.c          | 30 ++-------------------------
 hw/arm/mainstone.c             |  9 ++++-----
 hw/arm/mps2.c                  | 17 +++++++---------
 hw/arm/musicpal.c              |  7 ++-----
 hw/arm/netduino2.c             |  2 +-
 hw/arm/nseries.c               |  4 +++-
 hw/arm/omap1.c                 |  7 ++-----
 hw/arm/omap2.c                 |  4 ++--
 hw/arm/omap_sx1.c              |  5 ++++-
 hw/arm/palm.c                  |  5 +++--
 hw/arm/pxa2xx.c                | 10 ++++-----
 hw/arm/realview.c              | 25 +++++------------------
 hw/arm/spitz.c                 | 12 ++++++-----
 hw/arm/stellaris.c             | 16 +++++++--------
 hw/arm/stm32f205_soc.c         |  4 ++--
 hw/arm/strongarm.c             | 10 +++------
 hw/arm/tosa.c                  |  4 ----
 hw/arm/versatilepb.c           | 15 +++-----------
 hw/arm/vexpress.c              | 32 +++++++++--------------------
 hw/arm/virt.c                  | 46 +++++++++---------------------------=
------
 hw/arm/xilinx_zynq.c           | 10 ++-------
 hw/arm/z2.c                    |  9 +++------
 target/arm/cpu.c               |  2 +-
 33 files changed, 115 insertions(+), 265 deletions(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 10eb058027..9ad316c76e 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -35,7 +35,7 @@ typedef struct {
 /* ARMv7M container object.
  * + Unnamed GPIO input lines: external IRQ lines for the NVIC
  * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETRE=
Q
- * + Property "cpu-model": CPU model to instantiate
+ * + Property "cpu-type": CPU type to instantiate
  * + Property "num-irq": number of external IRQ lines
  * + Property "memory": MemoryRegion defining the physical address space
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
@@ -55,7 +55,7 @@ typedef struct ARMv7MState {
     MemoryRegion container;
=20
     /* Properties */
-    char *cpu_model;
+    char *cpu_type;
     /* MemoryRegion the board provides to us (with its devices, RAM, etc=
) */
     MemoryRegion *board_memory;
 } ARMv7MState;
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 0b88baaad0..f26914a2b9 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -49,7 +49,7 @@ typedef struct AspeedSoCState {
=20
 typedef struct AspeedSoCInfo {
     const char *name;
-    const char *cpu_model;
+    const char *cpu_type;
     uint32_t silicon_rev;
     hwaddr sdram_base;
     uint64_t sram_size;
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_so=
c.h
index e2dce1122e..922a733f88 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -52,7 +52,7 @@ typedef struct STM32F205State {
     SysBusDevice parent_obj;
     /*< public >*/
=20
-    char *cpu_model;
+    char *cpu_type;
=20
     ARMv7MState armv7m;
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5a1f957c51..6e50ae2b55 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2091,6 +2091,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
=20
+#define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
+#define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
+
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
=20
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index b64a409b40..57a680687a 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -151,10 +151,6 @@ static void armv7m_realize(DeviceState *dev, Error *=
*errp)
     SysBusDevice *sbd;
     Error *err =3D NULL;
     int i;
-    char **cpustr;
-    ObjectClass *oc;
-    const char *typename;
-    CPUClass *cc;
=20
     if (!s->board_memory) {
         error_setg(errp, "memory property was not set");
@@ -163,29 +159,7 @@ static void armv7m_realize(DeviceState *dev, Error *=
*errp)
=20
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memor=
y, -1);
=20
-    cpustr =3D g_strsplit(s->cpu_model, ",", 2);
-
-    oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!oc) {
-        error_setg(errp, "Unknown CPU model %s", cpustr[0]);
-        g_strfreev(cpustr);
-        return;
-    }
-
-    cc =3D CPU_CLASS(oc);
-    typename =3D object_class_get_name(oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    s->cpu =3D ARM_CPU(object_new(typename));
-    if (!s->cpu) {
-        error_setg(errp, "Unknown CPU model %s", s->cpu_model);
-        return;
-    }
+    s->cpu =3D ARM_CPU(object_new(s->cpu_type));
=20
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "mem=
ory",
                              &error_abort);
@@ -241,7 +215,7 @@ static void armv7m_realize(DeviceState *dev, Error **=
errp)
 }
=20
 static Property armv7m_properties[] =3D {
-    DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_RE=
GION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
@@ -275,20 +249,16 @@ static void armv7m_reset(void *opaque)
    Returns the ARMv7M device.  */
=20
 DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int =
num_irq,
-                      const char *kernel_filename, const char *cpu_model=
)
+                         const char *kernel_filename, const char *cpu_ty=
pe)
 {
     DeviceState *armv7m;
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "cortex-m3";
-    }
-
     armv7m =3D qdev_create(NULL, TYPE_ARMV7M);
     qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
-    qdev_prop_set_string(armv7m, "cpu-model", cpu_model);
+    qdev_prop_set_string(armv7m, "cpu-type", cpu_type);
     object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory())=
,
                                      "memory", &error_abort);
-    /* This will exit with an error if the user passed us a bad cpu_mode=
l */
+    /* This will exit with an error if the user passed us a bad cpu_type=
 */
     qdev_init_nofail(armv7m);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 13c6393350..5aa3d2ddd9 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -54,7 +54,7 @@ static const char *aspeed_soc_ast2500_typenames[] =3D {
 static const AspeedSoCInfo aspeed_socs[] =3D {
     {
         .name         =3D "ast2400-a0",
-        .cpu_model    =3D "arm926",
+        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A0_SILICON_REV,
         .sdram_base   =3D AST2400_SDRAM_BASE,
         .sram_size    =3D 0x8000,
@@ -65,7 +65,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
     }, {
         .name         =3D "ast2400-a1",
-        .cpu_model    =3D "arm926",
+        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A1_SILICON_REV,
         .sdram_base   =3D AST2400_SDRAM_BASE,
         .sram_size    =3D 0x8000,
@@ -76,7 +76,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
     }, {
         .name         =3D "ast2400",
-        .cpu_model    =3D "arm926",
+        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A0_SILICON_REV,
         .sdram_base   =3D AST2400_SDRAM_BASE,
         .sram_size    =3D 0x8000,
@@ -87,7 +87,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
     }, {
         .name         =3D "ast2500-a1",
-        .cpu_model    =3D "arm1176",
+        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
         .silicon_rev  =3D AST2500_A1_SILICON_REV,
         .sdram_base   =3D AST2500_SDRAM_BASE,
         .sram_size    =3D 0x9000,
@@ -128,13 +128,10 @@ static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s =3D ASPEED_SOC(obj);
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
-    char *cpu_typename;
     int i;
=20
-    cpu_typename =3D g_strdup_printf("%s-" TYPE_ARM_CPU, sc->info->cpu_m=
odel);
-    object_initialize(&s->cpu, sizeof(s->cpu), cpu_typename);
+    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
     object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
-    g_free(cpu_typename);
=20
     object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
     object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 8830192d86..f8c566e2e5 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -18,7 +18,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
-#include "qom/cpu.h"
+#include "cpu.h"
=20
 static struct arm_boot_info collie_binfo =3D {
     .loader_start =3D SA_SDCS0,
@@ -27,7 +27,6 @@ static struct arm_boot_info collie_binfo =3D {
=20
 static void collie_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -35,11 +34,7 @@ static void collie_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *sysmem =3D get_system_memory();
=20
-    if (!cpu_model) {
-        cpu_model =3D "sa1110";
-    }
-
-    s =3D sa1110_init(sysmem, collie_binfo.ram_size, cpu_model);
+    s =3D sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
@@ -65,6 +60,7 @@ static void collie_machine_init(MachineClass *mc)
     mc->desc =3D "Sharp SL-5500 (Collie) PDA (SA-1110)";
     mc->init =3D collie_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("sa1110");
 }
=20
 DEFINE_MACHINE("collie", collie_machine_init)
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index ee1438a0f4..e8e1d81e62 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -169,15 +169,11 @@ Exynos4210State *exynos4210_init(MemoryRegion *syst=
em_mem)
     Exynos4210State *s =3D g_new(Exynos4210State, 1);
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
-    ObjectClass *cpu_oc;
     DeviceState *dev;
     int i, n;
=20
-    cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, "cortex-a9");
-    assert(cpu_oc);
-
     for (n =3D 0; n < EXYNOS4210_NCPUS; n++) {
-        Object *cpuobj =3D object_new(object_class_get_name(cpu_oc));
+        Object *cpuobj =3D object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
=20
         /* By default A9 CPUs have EL3 enabled.  This board does not cur=
rently
          * support EL3 so the CPU EL3 property is disabled before realiz=
ation.
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 092ce36ae0..bba9e9f57a 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -44,6 +44,7 @@
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "cpu.h"
=20
 static const int sector_len =3D 128 * 1024;
=20
@@ -86,7 +87,6 @@ static void connex_init(MachineState *machine)
=20
 static void verdex_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     PXA2xxState *cpu;
     DriveInfo *dinfo;
     int be;
@@ -95,7 +95,7 @@ static void verdex_init(MachineState *machine)
     uint32_t verdex_rom =3D 0x02000000;
     uint32_t verdex_ram =3D 0x10000000;
=20
-    cpu =3D pxa270_init(address_space_mem, verdex_ram, cpu_model ?: "pxa=
270-c0");
+    cpu =3D pxa270_init(address_space_mem, verdex_ram, machine->cpu_type=
);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
@@ -144,6 +144,7 @@ static void verdex_class_init(ObjectClass *oc, void *=
data)
     mc->desc =3D "Gumstix Verdex (PXA270)";
     mc->init =3D verdex_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
 }
=20
 static const TypeInfo verdex_type =3D {
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index ba2778948a..354c6b25a8 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -222,7 +222,6 @@ enum cxmachines {
 static void calxeda_init(MachineState *machine, enum cxmachines machine_=
id)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -239,19 +238,20 @@ static void calxeda_init(MachineState *machine, enu=
m cxmachines machine_id)
=20
     switch (machine_id) {
     case CALXEDA_HIGHBANK:
-        cpu_model =3D "cortex-a9";
+        machine->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
         break;
     case CALXEDA_MIDWAY:
-        cpu_model =3D "cortex-a15";
+        machine->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
         break;
+    default:
+        assert(0);
     }
=20
     for (n =3D 0; n < smp_cpus; n++) {
-        ObjectClass *oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
         Object *cpuobj;
         ARMCPU *cpu;
=20
-        cpuobj =3D object_new(object_class_get_name(oc));
+        cpuobj =3D object_new(machine->cpu_type);
         cpu =3D ARM_CPU(cpuobj);
=20
         object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_SMC,
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d603af982a..e8303b83be 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -572,46 +572,19 @@ static struct arm_boot_info integrator_binfo =3D {
 static void integratorcp_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
-    char **cpustr;
-    ObjectClass *cpu_oc;
-    CPUClass *cc;
     Object *cpuobj;
     ARMCPU *cpu;
-    const char *typename;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_alias =3D g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
     int i;
-    Error *err =3D NULL;
=20
-    if (!cpu_model) {
-        cpu_model =3D "arm926";
-    }
-
-    cpustr =3D g_strsplit(cpu_model, ",", 2);
-
-    cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!cpu_oc) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
-    typename =3D object_class_get_name(cpu_oc);
-
-    cc =3D CPU_CLASS(cpu_oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
-    cpuobj =3D object_new(typename);
+    cpuobj =3D object_new(machine->cpu_type);
=20
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
@@ -682,6 +655,7 @@ static void integratorcp_machine_init(MachineClass *m=
c)
     mc->desc =3D "ARM Integrator/CP (ARM926EJ-S)";
     mc->init =3D integratorcp_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
 }
=20
 DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 637f52c052..d07972a966 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "cpu.h"
=20
 /* Device addresses */
 #define MST_FPGA_PHYS	0x08000000
@@ -121,13 +122,10 @@ static void mainstone_common_init(MemoryRegion *add=
ress_space_mem,
     int i;
     int be;
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
-    const char *cpu_model =3D machine->cpu_model;
-
-    if (!cpu_model)
-        cpu_model =3D "pxa270-c5";
=20
     /* Setup CPU & memory */
-    mpu =3D pxa270_init(address_space_mem, mainstone_binfo.ram_size, cpu=
_model);
+    mpu =3D pxa270_init(address_space_mem, mainstone_binfo.ram_size,
+                      machine->cpu_type);
     memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
                            &error_fatal);
     memory_region_set_readonly(rom, true);
@@ -197,6 +195,7 @@ static void mainstone2_machine_init(MachineClass *mc)
     mc->desc =3D "Mainstone II (PXA27x)";
     mc->init =3D mainstone_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c5");
 }
=20
 DEFINE_MACHINE("mainstone", mainstone2_machine_init)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 769cff872c..694fb36866 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -46,7 +46,6 @@ typedef enum MPS2FPGAType {
 typedef struct {
     MachineClass parent;
     MPS2FPGAType fpga_type;
-    const char *cpu_model;
     uint32_t scc_id;
 } MPS2MachineClass;
=20
@@ -107,14 +106,12 @@ static void mps2_common_init(MachineState *machine)
     MPS2MachineState *mms =3D MPS2_MACHINE(machine);
     MPS2MachineClass *mmc =3D MPS2_MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory =3D get_system_memory();
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     DeviceState *armv7m, *sccdev;
=20
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D mmc->cpu_model;
-    }
-
-    if (strcmp(machine->cpu_model, mmc->cpu_model) !=3D 0) {
-        error_report("This board can only be used with CPU %s", mmc->cpu=
_model);
+    if (strcmp(machine->cpu_type, mc->default_cpu_type) !=3D 0) {
+        error_report("This board can only be used with CPU %s",
+                     mc->default_cpu_type);
         exit(1);
     }
=20
@@ -188,7 +185,7 @@ static void mps2_common_init(MachineState *machine)
     default:
         g_assert_not_reached();
     }
-    qdev_prop_set_string(armv7m, "cpu-model", machine->cpu_model);
+    qdev_prop_set_string(armv7m, "cpu-type", machine->cpu_type);
     object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory)=
,
                              "memory", &error_abort);
     object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
@@ -339,7 +336,7 @@ static void mps2_an385_class_init(ObjectClass *oc, vo=
id *data)
=20
     mc->desc =3D "ARM MPS2 with AN385 FPGA image for Cortex-M3";
     mmc->fpga_type =3D FPGA_AN385;
-    mmc->cpu_model =3D "cortex-m3";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id =3D 0x41040000 | (385 << 4);
 }
=20
@@ -350,7 +347,7 @@ static void mps2_an511_class_init(ObjectClass *oc, vo=
id *data)
=20
     mc->desc =3D "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-=
M3";
     mmc->fpga_type =3D FPGA_AN511;
-    mmc->cpu_model =3D "cortex-m3";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id =3D 0x4104000 | (511 << 4);
 }
=20
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 7a6c0a6deb..b648770882 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1570,7 +1570,6 @@ static struct arm_boot_info musicpal_binfo =3D {
=20
 static void musicpal_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -1590,10 +1589,7 @@ static void musicpal_init(MachineState *machine)
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
-    if (!cpu_model) {
-        cpu_model =3D "arm926";
-    }
-    cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
+    cpu =3D ARM_CPU(cpu_create(machine->cpu_type));
=20
     /* For now we use a fixed - the original - RAM size */
     memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
@@ -1715,6 +1711,7 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->desc =3D "Marvell 88w8618 / MusicPal (ARM926EJ-S)";
     mc->init =3D musicpal_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
 }
=20
 DEFINE_MACHINE("musicpal", musicpal_machine_init)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 9d34d4c214..f936017d4a 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -34,7 +34,7 @@ static void netduino2_init(MachineState *machine)
     DeviceState *dev;
=20
     dev =3D qdev_create(NULL, TYPE_STM32F205_SOC);
-    qdev_prop_set_string(dev, "cpu-model", "cortex-m3");
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3")=
);
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal=
);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a32ac82702..58005b6619 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1310,7 +1310,7 @@ static void n8x0_init(MachineState *machine,
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
     int sdram_size =3D binfo->ram_size;
=20
-    s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_model)=
;
+    s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
=20
     /* Setup peripherals
      *
@@ -1426,6 +1426,7 @@ static void n800_class_init(ObjectClass *oc, void *=
data)
     mc->init =3D n800_init;
     mc->default_boot_order =3D "";
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm1136-r2");
 }
=20
 static const TypeInfo n800_type =3D {
@@ -1442,6 +1443,7 @@ static void n810_class_init(ObjectClass *oc, void *=
data)
     mc->init =3D n810_init;
     mc->default_boot_order =3D "";
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm1136-r2");
 }
=20
 static const TypeInfo n810_type =3D {
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 04e65ce168..b3e7625130 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3850,7 +3850,7 @@ static int omap_validate_tipb_mpui_addr(struct omap=
_mpu_state_s *s,
=20
 struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
                 unsigned long sdram_size,
-                const char *core)
+                const char *cpu_type)
 {
     int i;
     struct omap_mpu_state_s *s =3D g_new0(struct omap_mpu_state_s, 1);
@@ -3858,12 +3858,9 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRe=
gion *system_memory,
     DriveInfo *dinfo;
     SysBusDevice *busdev;
=20
-    if (!core)
-        core =3D "ti925t";
-
     /* Core */
     s->mpu_model =3D omap310;
-    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
+    s->cpu =3D ARM_CPU(cpu_create(cpu_type));
     s->sdram_size =3D sdram_size;
     s->sram_size =3D OMAP15XX_SRAM_SIZE;
=20
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 5821477950..3f6076ede8 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2250,7 +2250,7 @@ static const struct dma_irq_map omap2_dma_irq_map[]=
 =3D {
=20
 struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
                 unsigned long sdram_size,
-                const char *core)
+                const char *cpu_type)
 {
     struct omap_mpu_state_s *s =3D g_new0(struct omap_mpu_state_s, 1);
     qemu_irq dma_irqs[4];
@@ -2261,7 +2261,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sysmem,
=20
     /* Core */
     s->mpu_model =3D omap2420;
-    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r=
2"));
+    s->cpu =3D ARM_CPU(cpu_create(cpu_type));
     s->sdram_size =3D sdram_size;
     s->sram_size =3D OMAP242X_SRAM_SIZE;
=20
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 45356172e8..9a14270795 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -36,6 +36,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
+#include "cpu.h"
=20
 /***********************************************************************=
******/
 /* Siemens SX1 Cellphone V1 */
@@ -120,7 +121,7 @@ static void sx1_init(MachineState *machine, const int=
 version)
     }
=20
     mpu =3D omap310_mpu_init(address_space, sx1_binfo.ram_size,
-                           machine->cpu_model);
+                           machine->cpu_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
@@ -224,6 +225,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc=
, void *data)
     mc->desc =3D "Siemens SX1 (OMAP310) V2";
     mc->init =3D sx1_init_v2;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
 }
=20
 static const TypeInfo sx1_machine_v2_type =3D {
@@ -239,6 +241,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc=
, void *data)
     mc->desc =3D "Siemens SX1 (OMAP310) V1";
     mc->init =3D sx1_init_v1;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
 }
=20
 static const TypeInfo sx1_machine_v1_type =3D {
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index bf070a2d9c..b8753e2b5c 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -29,6 +29,7 @@
 #include "hw/devices.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
+#include "cpu.h"
=20
 static uint32_t static_readb(void *opaque, hwaddr offset)
 {
@@ -195,7 +196,6 @@ static struct arm_boot_info palmte_binfo =3D {
=20
 static void palmte_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -211,7 +211,7 @@ static void palmte_init(MachineState *machine)
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *cs =3D g_new(MemoryRegion, 4);
=20
-    mpu =3D omap310_mpu_init(address_space_mem, sdram_size, cpu_model);
+    mpu =3D omap310_mpu_init(address_space_mem, sdram_size, machine->cpu=
_type);
=20
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
@@ -275,6 +275,7 @@ static void palmte_machine_init(MachineClass *mc)
     mc->desc =3D "Palm Tungsten|E aka. Cheetah PDA (OMAP310)";
     mc->init =3D palmte_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
 }
=20
 DEFINE_MACHINE("cheetah", palmte_machine_init)
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index c16657da86..cf07234578 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2052,21 +2052,19 @@ static void pxa2xx_reset(void *opaque, int line, =
int level)
=20
 /* Initialise a PXA270 integrated chip (ARM based core).  */
 PXA2xxState *pxa270_init(MemoryRegion *address_space,
-                         unsigned int sdram_size, const char *revision)
+                         unsigned int sdram_size, const char *cpu_type)
 {
     PXA2xxState *s;
     int i;
     DriveInfo *dinfo;
     s =3D g_new0(PXA2xxState, 1);
=20
-    if (revision && strncmp(revision, "pxa27", 5)) {
+    if (strncmp(cpu_type, "pxa27", 5)) {
         fprintf(stderr, "Machine requires a PXA27x processor.\n");
         exit(1);
     }
-    if (!revision)
-        revision =3D "pxa270";
=20
-    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
+    s->cpu =3D ARM_CPU(cpu_create(cpu_type));
     s->reset =3D qemu_allocate_irq(pxa2xx_reset, s, 0);
=20
     /* SDRAM & Internal Memory Storage */
@@ -2192,7 +2190,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_spac=
e, unsigned int sdram_size)
=20
     s =3D g_new0(PXA2xxState, 1);
=20
-    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
+    s->cpu =3D ARM_CPU(cpu_create(ARM_CPU_TYPE_NAME("pxa255")));
     s->reset =3D qemu_allocate_irq(pxa2xx_reset, s, 0);
=20
     /* SDRAM & Internal Memory Storage */
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f3a49b6420..87cd1e583c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -57,7 +57,6 @@ static void realview_init(MachineState *machine,
 {
     ARMCPU *cpu =3D NULL;
     CPUARMState *env;
-    ObjectClass *cpu_oc;
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *ram_lo;
     MemoryRegion *ram_hi =3D g_new(MemoryRegion, 1);
@@ -98,14 +97,8 @@ static void realview_init(MachineState *machine,
         break;
     }
=20
-    cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, machine->cpu_model);
-    if (!cpu_oc) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
-
     for (n =3D 0; n < smp_cpus; n++) {
-        Object *cpuobj =3D object_new(object_class_get_name(cpu_oc));
+        Object *cpuobj =3D object_new(machine->cpu_type);
=20
         /* By default A9,A15 and ARM1176 CPUs have EL3 enabled.  This bo=
ard
          * does not currently support EL3 so the CPU EL3 property is dis=
abled
@@ -361,33 +354,21 @@ static void realview_init(MachineState *machine,
=20
 static void realview_eb_init(MachineState *machine)
 {
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "arm926";
-    }
     realview_init(machine, BOARD_EB);
 }
=20
 static void realview_eb_mpcore_init(MachineState *machine)
 {
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "arm11mpcore";
-    }
     realview_init(machine, BOARD_EB_MPCORE);
 }
=20
 static void realview_pb_a8_init(MachineState *machine)
 {
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "cortex-a8";
-    }
     realview_init(machine, BOARD_PB_A8);
 }
=20
 static void realview_pbx_a9_init(MachineState *machine)
 {
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "cortex-a9";
-    }
     realview_init(machine, BOARD_PBX_A9);
 }
=20
@@ -399,6 +380,7 @@ static void realview_eb_class_init(ObjectClass *oc, v=
oid *data)
     mc->init =3D realview_eb_init;
     mc->block_default_type =3D IF_SCSI;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
 }
=20
 static const TypeInfo realview_eb_type =3D {
@@ -416,6 +398,7 @@ static void realview_eb_mpcore_class_init(ObjectClass=
 *oc, void *data)
     mc->block_default_type =3D IF_SCSI;
     mc->max_cpus =3D 4;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm11mpcore");
 }
=20
 static const TypeInfo realview_eb_mpcore_type =3D {
@@ -431,6 +414,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc=
, void *data)
     mc->desc =3D "ARM RealView Platform Baseboard for Cortex-A8";
     mc->init =3D realview_pb_a8_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a8");
 }
=20
 static const TypeInfo realview_pb_a8_type =3D {
@@ -447,6 +431,7 @@ static void realview_pbx_a9_class_init(ObjectClass *o=
c, void *data)
     mc->init =3D realview_pbx_a9_init;
     mc->max_cpus =3D 4;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
 }
=20
 static const TypeInfo realview_pbx_a9_type =3D {
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 6406421d0c..feccdb00d3 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "cpu.h"
=20
 #undef REG_FMT
 #define REG_FMT			"0x%02lx"
@@ -909,13 +910,10 @@ static void spitz_common_init(MachineState *machine=
,
     DeviceState *scp0, *scp1 =3D NULL;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
-    const char *cpu_model =3D machine->cpu_model;
-
-    if (!cpu_model)
-        cpu_model =3D (model =3D=3D terrier) ? "pxa270-c5" : "pxa270-c0"=
;
=20
     /* Setup CPU & memory */
-    mpu =3D pxa270_init(address_space_mem, spitz_binfo.ram_size, cpu_mod=
el);
+    mpu =3D pxa270_init(address_space_mem, spitz_binfo.ram_size,
+                      machine->cpu_type);
=20
     sl_flash_register(mpu, (model =3D=3D spitz) ? FLASH_128M : FLASH_102=
4M);
=20
@@ -984,6 +982,7 @@ static void akitapda_class_init(ObjectClass *oc, void=
 *data)
     mc->desc =3D "Sharp SL-C1000 (Akita) PDA (PXA270)";
     mc->init =3D akita_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
 }
=20
 static const TypeInfo akitapda_type =3D {
@@ -1000,6 +999,7 @@ static void spitzpda_class_init(ObjectClass *oc, voi=
d *data)
     mc->init =3D spitz_init;
     mc->block_default_type =3D IF_IDE;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
 }
=20
 static const TypeInfo spitzpda_type =3D {
@@ -1016,6 +1016,7 @@ static void borzoipda_class_init(ObjectClass *oc, v=
oid *data)
     mc->init =3D borzoi_init;
     mc->block_default_type =3D IF_IDE;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
 }
=20
 static const TypeInfo borzoipda_type =3D {
@@ -1032,6 +1033,7 @@ static void terrierpda_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D terrier_init;
     mc->block_default_type =3D IF_IDE;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c5");
 }
=20
 static const TypeInfo terrierpda_type =3D {
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b3aad23bdf..de7c0fc4a6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -22,6 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/char/pl011.h"
 #include "hw/misc/unimp.h"
+#include "cpu.h"
=20
 #define GPIO_A 0
 #define GPIO_B 1
@@ -1225,8 +1226,7 @@ static stellaris_board_info stellaris_boards[] =3D =
{
   }
 };
=20
-static void stellaris_init(const char *kernel_filename, const char *cpu_=
model,
-                           stellaris_board_info *board)
+static void stellaris_init(MachineState *ms, stellaris_board_info *board=
)
 {
     static const int uart_irq[] =3D {5, 6, 33, 34};
     static const int timer_irq[] =3D {19, 21, 23, 35};
@@ -1298,7 +1298,7 @@ static void stellaris_init(const char *kernel_filen=
ame, const char *cpu_model,
     memory_region_add_subregion(system_memory, 0x20000000, sram);
=20
     nvic =3D armv7m_init(system_memory, flash_size, NUM_IRQ_LINES,
-                      kernel_filename, cpu_model);
+                       ms->kernel_filename, ms->cpu_type);
=20
     qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
                                 qemu_allocate_irq(&do_sys_reset, NULL, 0=
));
@@ -1435,16 +1435,12 @@ static void stellaris_init(const char *kernel_fil=
ename, const char *cpu_model,
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
 static void lm3s811evb_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
-    const char *kernel_filename =3D machine->kernel_filename;
-    stellaris_init(kernel_filename, cpu_model, &stellaris_boards[0]);
+    stellaris_init(machine, &stellaris_boards[0]);
 }
=20
 static void lm3s6965evb_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
-    const char *kernel_filename =3D machine->kernel_filename;
-    stellaris_init(kernel_filename, cpu_model, &stellaris_boards[1]);
+    stellaris_init(machine, &stellaris_boards[1]);
 }
=20
 static void lm3s811evb_class_init(ObjectClass *oc, void *data)
@@ -1454,6 +1450,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, =
void *data)
     mc->desc =3D "Stellaris LM3S811EVB";
     mc->init =3D lm3s811evb_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m3");
 }
=20
 static const TypeInfo lm3s811evb_type =3D {
@@ -1469,6 +1466,7 @@ static void lm3s6965evb_class_init(ObjectClass *oc,=
 void *data)
     mc->desc =3D "Stellaris LM3S6965EVB";
     mc->init =3D lm3s6965evb_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m3");
 }
=20
 static const TypeInfo lm3s6965evb_type =3D {
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index f61e735f0f..1cd6374e07 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -112,7 +112,7 @@ static void stm32f205_soc_realize(DeviceState *dev_so=
c, Error **errp)
=20
     armv7m =3D DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
-    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memor=
y()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err)=
;
@@ -200,7 +200,7 @@ static void stm32f205_soc_realize(DeviceState *dev_so=
c, Error **errp)
 }
=20
 static Property stm32f205_soc_properties[] =3D {
-    DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
+    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index c1145dd723..3d1a231d9e 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1581,23 +1581,19 @@ static const TypeInfo strongarm_ssp_info =3D {
=20
 /* Main CPU functions */
 StrongARMState *sa1110_init(MemoryRegion *sysmem,
-                            unsigned int sdram_size, const char *rev)
+                            unsigned int sdram_size, const char *cpu_typ=
e)
 {
     StrongARMState *s;
     int i;
=20
     s =3D g_new0(StrongARMState, 1);
=20
-    if (!rev) {
-        rev =3D "sa1110-b5";
-    }
-
-    if (strncmp(rev, "sa1110", 6)) {
+    if (strncmp(cpu_type, "sa1110", 6)) {
         error_report("Machine requires a SA1110 processor.");
         exit(1);
     }
=20
-    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
+    s->cpu =3D ARM_CPU(cpu_create(cpu_type));
=20
     memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdr=
am",
                                          sdram_size);
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 1134cf74db..044796350a 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -219,7 +219,6 @@ static struct arm_boot_info tosa_binfo =3D {
=20
 static void tosa_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -229,9 +228,6 @@ static void tosa_init(MachineState *machine)
     TC6393xbState *tmio;
     DeviceState *scp0, *scp1;
=20
-    if (!cpu_model)
-        cpu_model =3D "pxa255";
-
     mpu =3D pxa255_init(address_space_mem, tosa_binfo.ram_size);
=20
     memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal=
);
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 76664e4722..418792cd02 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -181,7 +181,6 @@ static struct arm_boot_info versatile_binfo;
=20
 static void versatile_init(MachineState *machine, int board_id)
 {
-    ObjectClass *cpu_oc;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem =3D get_system_memory();
@@ -207,17 +206,7 @@ static void versatile_init(MachineState *machine, in=
t board_id)
         exit(1);
     }
=20
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "arm926";
-    }
-
-    cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, machine->cpu_model);
-    if (!cpu_oc) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
-
-    cpuobj =3D object_new(object_class_get_name(cpu_oc));
+    cpuobj =3D object_new(machine->cpu_type);
=20
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
@@ -404,6 +393,7 @@ static void versatilepb_class_init(ObjectClass *oc, v=
oid *data)
     mc->init =3D vpb_init;
     mc->block_default_type =3D IF_SCSI;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
 }
=20
 static const TypeInfo versatilepb_type =3D {
@@ -420,6 +410,7 @@ static void versatileab_class_init(ObjectClass *oc, v=
oid *data)
     mc->init =3D vab_init;
     mc->block_default_type =3D IF_SCSI;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
 }
=20
 static const TypeInfo versatileab_type =3D {
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index e3acab6adf..2e5f670c2b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -186,7 +186,7 @@ typedef struct {
=20
 typedef void DBoardInitFn(const VexpressMachineState *machine,
                           ram_addr_t ram_size,
-                          const char *cpu_model,
+                          const char *cpu_type,
                           qemu_irq *pic);
=20
 struct VEDBoardInfo {
@@ -202,22 +202,16 @@ struct VEDBoardInfo {
     DBoardInitFn *init;
 };
=20
-static void init_cpus(const char *cpu_model, const char *privdev,
+static void init_cpus(const char *cpu_type, const char *privdev,
                       hwaddr periphbase, qemu_irq *pic, bool secure)
 {
-    ObjectClass *cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
     DeviceState *dev;
     SysBusDevice *busdev;
     int n;
=20
-    if (!cpu_oc) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
-
     /* Create the actual CPUs */
     for (n =3D 0; n < smp_cpus; n++) {
-        Object *cpuobj =3D object_new(object_class_get_name(cpu_oc));
+        Object *cpuobj =3D object_new(cpu_type);
=20
         if (!secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
@@ -262,7 +256,7 @@ static void init_cpus(const char *cpu_model, const ch=
ar *privdev,
=20
 static void a9_daughterboard_init(const VexpressMachineState *vms,
                                   ram_addr_t ram_size,
-                                  const char *cpu_model,
+                                  const char *cpu_type,
                                   qemu_irq *pic)
 {
     MemoryRegion *sysmem =3D get_system_memory();
@@ -270,10 +264,6 @@ static void a9_daughterboard_init(const VexpressMach=
ineState *vms,
     MemoryRegion *lowram =3D g_new(MemoryRegion, 1);
     ram_addr_t low_ram_size;
=20
-    if (!cpu_model) {
-        cpu_model =3D "cortex-a9";
-    }
-
     if (ram_size > 0x40000000) {
         /* 1GB is the maximum the address space permits */
         fprintf(stderr, "vexpress-a9: cannot model more than 1GB RAM\n")=
;
@@ -295,7 +285,7 @@ static void a9_daughterboard_init(const VexpressMachi=
neState *vms,
     memory_region_add_subregion(sysmem, 0x60000000, ram);
=20
     /* 0x1e000000 A9MPCore (SCU) private memory region */
-    init_cpus(cpu_model, TYPE_A9MPCORE_PRIV, 0x1e000000, pic, vms->secur=
e);
+    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic, vms->secure=
);
=20
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
=20
@@ -351,17 +341,13 @@ static VEDBoardInfo a9_daughterboard =3D {
=20
 static void a15_daughterboard_init(const VexpressMachineState *vms,
                                    ram_addr_t ram_size,
-                                   const char *cpu_model,
+                                   const char *cpu_type,
                                    qemu_irq *pic)
 {
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
-    if (!cpu_model) {
-        cpu_model =3D "cortex-a15";
-    }
-
     {
         /* We have to use a separate 64 bit variable here to avoid the g=
cc
          * "comparison is always false due to limited range of data type=
"
@@ -380,7 +366,7 @@ static void a15_daughterboard_init(const VexpressMach=
ineState *vms,
     memory_region_add_subregion(sysmem, 0x80000000, ram);
=20
     /* 0x2c000000 A15MPCore private memory region (GIC) */
-    init_cpus(cpu_model, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secu=
re);
+    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secur=
e);
=20
     /* A15 daughterboard peripherals: */
=20
@@ -560,7 +546,7 @@ static void vexpress_common_init(MachineState *machin=
e)
     const hwaddr *map =3D daughterboard->motherboard_map;
     int i;
=20
-    daughterboard->init(vms, machine->ram_size, machine->cpu_model, pic)=
;
+    daughterboard->init(vms, machine->ram_size, machine->cpu_type, pic);
=20
     /*
      * If a bios file was provided, attempt to map it into memory
@@ -761,6 +747,7 @@ static void vexpress_a9_class_init(ObjectClass *oc, v=
oid *data)
     VexpressMachineClass *vmc =3D VEXPRESS_MACHINE_CLASS(oc);
=20
     mc->desc =3D "ARM Versatile Express for Cortex-A9";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
=20
     vmc->daughterboard =3D &a9_daughterboard;
 }
@@ -771,6 +758,7 @@ static void vexpress_a15_class_init(ObjectClass *oc, =
void *data)
     VexpressMachineClass *vmc =3D VEXPRESS_MACHINE_CLASS(oc);
=20
     mc->desc =3D "ARM Versatile Express for Cortex-A15";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
=20
     vmc->daughterboard =3D &a15_daughterboard;
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cfd834d0cc..65d68bc50d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -163,13 +163,13 @@ static const int a15irqmap[] =3D {
 };
=20
 static const char *valid_cpus[] =3D {
-    "cortex-a15",
-    "cortex-a53",
-    "cortex-a57",
-    "host",
+    ARM_CPU_TYPE_NAME("cortex-a15"),
+    ARM_CPU_TYPE_NAME("cortex-a53"),
+    ARM_CPU_TYPE_NAME("cortex-a57"),
+    ARM_CPU_TYPE_NAME("host"),
 };
=20
-static bool cpuname_valid(const char *cpu)
+static bool cpu_type_valid(const char *cpu)
 {
     int i;
=20
@@ -1259,18 +1259,8 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *secure_sysmem =3D NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
-    const char *cpu_model =3D machine->cpu_model;
-    char **cpustr;
-    ObjectClass *oc;
-    const char *typename;
-    CPUClass *cc;
-    Error *err =3D NULL;
     bool firmware_loaded =3D bios_name || drive_get(IF_PFLASH, 0, 0);
=20
-    if (!cpu_model) {
-        cpu_model =3D "cortex-a15";
-    }
-
     /* We can probe only here because during property set
      * KVM is not available yet
      */
@@ -1287,11 +1277,8 @@ static void machvirt_init(MachineState *machine)
         }
     }
=20
-    /* Separate the actual CPU model name from any appended features */
-    cpustr =3D g_strsplit(cpu_model, ",", 2);
-
-    if (!cpuname_valid(cpustr[0])) {
-        error_report("mach-virt: CPU %s not supported", cpustr[0]);
+    if (!cpu_type_valid(machine->cpu_type)) {
+        error_report("mach-virt: CPU type %s not supported", machine->cp=
u_type);
         exit(1);
     }
=20
@@ -1361,22 +1348,6 @@ static void machvirt_init(MachineState *machine)
=20
     create_fdt(vms);
=20
-    oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!oc) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
-    typename =3D object_class_get_name(oc);
-
-    /* convert -smp CPU options specified by the user into global props =
*/
-    cc =3D CPU_CLASS(oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
     possible_cpus =3D mc->possible_cpu_arch_ids(machine);
     for (n =3D 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
@@ -1386,7 +1357,7 @@ static void machvirt_init(MachineState *machine)
             break;
         }
=20
-        cpuobj =3D object_new(typename);
+        cpuobj =3D object_new(machine->cpu_type);
         object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
=20
@@ -1631,6 +1602,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->minimum_page_bits =3D 12;
     mc->possible_cpu_arch_ids =3D virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
 }
=20
 static const TypeInfo virt_machine_info =3D {
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3759cf8dc3..1836a4ed45 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -158,11 +158,9 @@ static inline void zynq_init_spi_flashes(uint32_t ba=
se_addr, qemu_irq irq,
 static void zynq_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
-    ObjectClass *cpu_oc;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
@@ -174,12 +172,7 @@ static void zynq_init(MachineState *machine)
     qemu_irq pic[64];
     int n;
=20
-    if (!cpu_model) {
-        cpu_model =3D "cortex-a9";
-    }
-    cpu_oc =3D cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
-
-    cpu =3D ARM_CPU(object_new(object_class_get_name(cpu_oc)));
+    cpu =3D ARM_CPU(object_new(machine->cpu_type));
=20
     /* By default A9 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
@@ -327,6 +320,7 @@ static void zynq_machine_init(MachineClass *mc)
     mc->max_cpus =3D 1;
     mc->no_sdcard =3D 1;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
 }
=20
 DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 417bc1ac33..60561c7b7c 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -26,6 +26,7 @@
 #include "audio/audio.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "cpu.h"
=20
 #ifdef DEBUG_Z2
 #define DPRINTF(fmt, ...) \
@@ -296,7 +297,6 @@ static const TypeInfo aer915_info =3D {
=20
 static void z2_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -309,12 +309,8 @@ static void z2_init(MachineState *machine)
     I2CBus *bus;
     DeviceState *wm;
=20
-    if (!cpu_model) {
-        cpu_model =3D "pxa270-c5";
-    }
-
     /* Setup CPU & memory */
-    mpu =3D pxa270_init(address_space_mem, z2_binfo.ram_size, cpu_model)=
;
+    mpu =3D pxa270_init(address_space_mem, z2_binfo.ram_size, machine->c=
pu_type);
=20
 #ifdef TARGET_WORDS_BIGENDIAN
     be =3D 1;
@@ -371,6 +367,7 @@ static void z2_machine_init(MachineClass *mc)
     mc->desc =3D "Zipit Z2 (PXA27x)";
     mc->init =3D z2_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c5");
 }
=20
 DEFINE_MACHINE("z2", z2_machine_init)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 412e94c7ad..20a3445bda 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -911,7 +911,7 @@ static ObjectClass *arm_cpu_class_by_name(const char =
*cpu_model)
     }
=20
     cpuname =3D g_strsplit(cpu_model, ",", 1);
-    typename =3D g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
+    typename =3D g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
     oc =3D object_class_by_name(typename);
     g_strfreev(cpuname);
     g_free(typename);
--=20
2.13.5
