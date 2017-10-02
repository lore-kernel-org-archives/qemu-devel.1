Received: from eggs.gnu.org ([2001:4830:134:3::10]:47278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiq-0002Wm-JQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywio-0006KF-Tx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywio-0006Jw-KL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:06 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:16 +0200
Message-Id: <1506935300-132598-35-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 34/38] mips: malta/boston: replace cpu_model
 with cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, paul.burton@imgtec.com, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: paul.burton@imgtec.com
CC: aurelien@aurel32.net
CC: yongbok.kim@imgtec.com
---
 include/hw/mips/cps.h        |  2 +-
 target/mips/cpu.h            |  8 ++++++--
 hw/mips/boston.c             | 11 +++++------
 hw/mips/cps.c                |  4 ++--
 hw/mips/mips_malta.c         | 33 +++++++++++++++------------------
 target/mips/cpu.c            |  2 +-
 target/mips/translate.c      | 20 ++++++--------------
 target/mips/translate_init.c | 12 ------------
 8 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 526b8d0..aab1af9 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -34,7 +34,7 @@ typedef struct MIPSCPSState {
 
     uint32_t num_vp;
     uint32_t num_irq;
-    char *cpu_model;
+    char *cpu_type;
 
     MemoryRegion container;
     MIPSGCRState gcr;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 66265e4..7f8ba5f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -740,8 +740,12 @@ enum {
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
-bool cpu_supports_cps_smp(const char *cpu_model);
-bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
+
+#define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
+#define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
+
+bool cpu_supports_cps_smp(const char *cpu_type);
+bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
 
 /* mips_int.c */
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e815be6..1cb4b6a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -437,7 +437,6 @@ static void boston_mach_init(MachineState *machine)
     DeviceState *dev;
     BostonState *s;
     Error *err = NULL;
-    const char *cpu_model;
     MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
@@ -453,25 +452,24 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    cpu_model = machine->cpu_model ?: "I6400";
-
     dev = qdev_create(NULL, TYPE_MIPS_BOSTON);
     qdev_init_nofail(dev);
 
     s = BOSTON(dev);
     s->mach = machine;
 
-    if (!cpu_supports_cps_smp(cpu_model)) {
+    if (!cpu_supports_cps_smp(machine->cpu_type)) {
         error_report("Boston requires CPUs which support CPS");
         exit(1);
     }
 
-    is_64b = cpu_supports_isa(cpu_model, ISA_MIPS64);
+    is_64b = cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
 
     s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
 
-    object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
+    object_property_set_str(OBJECT(s->cps), machine->cpu_type, "cpu-type",
+                            &err);
     object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
 
@@ -571,6 +569,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_ram_size = 1 * G_BYTE;
     mc->max_cpus = 16;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index fe5c630..4285d19 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
 
     for (i = 0; i < s->num_vp; i++) {
-        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
+        cpu = MIPS_CPU(cpu_create(s->cpu_type));
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -160,7 +160,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 static Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
-    DEFINE_PROP_STRING("cpu-model", MIPSCPSState, cpu_model),
+    DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index b6a58c7..ec6af4a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -923,7 +923,7 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static void create_cpu_without_cps(const char *cpu_model,
+static void create_cpu_without_cps(const char *cpu_type,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     CPUMIPSState *env;
@@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_model,
     int i;
 
     for (i = 0; i < smp_cpus; i++) {
-        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+        cpu = MIPS_CPU(cpu_create(cpu_type));
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -945,7 +945,7 @@ static void create_cpu_without_cps(const char *cpu_model,
     *cbus_irq = env->irq[4];
 }
 
-static void create_cps(MaltaState *s, const char *cpu_model,
+static void create_cps(MaltaState *s, const char *cpu_type,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     Error *err = NULL;
@@ -953,7 +953,7 @@ static void create_cps(MaltaState *s, const char *cpu_model,
     s->cps = MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
 
-    object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err);
+    object_property_set_str(OBJECT(s->cps), cpu_type, "cpu-type", &err);
     object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
     if (err != NULL) {
@@ -967,21 +967,13 @@ static void create_cps(MaltaState *s, const char *cpu_model,
     *cbus_irq = NULL;
 }
 
-static void create_cpu(MaltaState *s, const char *cpu_model,
-                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
+static void mips_create_cpu(MaltaState *s, const char *cpu_type,
+                            qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
-    if (cpu_model == NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model = "20Kc";
-#else
-        cpu_model = "24Kf";
-#endif
-    }
-
-    if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_model)) {
-        create_cps(s, cpu_model, cbus_irq, i8259_irq);
+    if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
+        create_cps(s, cpu_type, cbus_irq, i8259_irq);
     } else {
-        create_cpu_without_cps(cpu_model, cbus_irq, i8259_irq);
+        create_cpu_without_cps(cpu_type, cbus_irq, i8259_irq);
     }
 }
 
@@ -1038,7 +1030,7 @@ void mips_malta_init(MachineState *machine)
     }
 
     /* create CPU */
-    create_cpu(s, machine->cpu_model, &cbus_irq, &i8259_irq);
+    mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
     if (ram_size > (2048u << 20)) {
@@ -1264,6 +1256,11 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 16;
     mc->is_default = 1;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
+#else
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
+#endif
 }
 
 DEFINE_MACHINE("malta", mips_malta_machine_init)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c15b894..24a8907 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -158,7 +158,7 @@ static void mips_cpu_initfn(Object *obj)
 
 static char *mips_cpu_type_name(const char *cpu_model)
 {
-    return g_strdup_printf("%s-" TYPE_MIPS_CPU, cpu_model);
+    return g_strdup_printf(MIPS_CPU_TYPE_NAME("%s"), cpu_model);
 }
 
 static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d16d879..3d76fc6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20523,24 +20523,16 @@ void cpu_mips_realize_env(CPUMIPSState *env)
     mvp_init(env, env->cpu_model);
 }
 
-bool cpu_supports_cps_smp(const char *cpu_model)
+bool cpu_supports_cps_smp(const char *cpu_type)
 {
-    const mips_def_t *def = cpu_mips_find_by_name(cpu_model);
-    if (!def) {
-        return false;
-    }
-
-    return (def->CP0_Config3 & (1 << CP0C3_CMGCR)) != 0;
+    const MIPSCPUClass *mcc = MIPS_CPU_CLASS(object_class_by_name(cpu_type));
+    return (mcc->cpu_def->CP0_Config3 & (1 << CP0C3_CMGCR)) != 0;
 }
 
-bool cpu_supports_isa(const char *cpu_model, unsigned int isa)
+bool cpu_supports_isa(const char *cpu_type, unsigned int isa)
 {
-    const mips_def_t *def = cpu_mips_find_by_name(cpu_model);
-    if (!def) {
-        return false;
-    }
-
-    return (def->insn_flags & isa) != 0;
+    const MIPSCPUClass *mcc = MIPS_CPU_CLASS(object_class_by_name(cpu_type));
+    return (mcc->cpu_def->insn_flags & isa) != 0;
 }
 
 void cpu_set_exception_base(int vp_index, target_ulong address)
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8bbded4..c7ba6ee 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -755,18 +755,6 @@ const mips_def_t mips_defs[] =
 };
 const int mips_defs_number = ARRAY_SIZE(mips_defs);
 
-static const mips_def_t *cpu_mips_find_by_name (const char *name)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(mips_defs); i++) {
-        if (strcasecmp(name, mips_defs[i].name) == 0) {
-            return &mips_defs[i];
-        }
-    }
-    return NULL;
-}
-
 void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
 {
     int i;
-- 
2.7.4
