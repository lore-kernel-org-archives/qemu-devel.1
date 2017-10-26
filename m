Received: from eggs.gnu.org ([2001:4830:134:3::10]:44787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioH-0005e2-5n
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioA-0001L6-CB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ioA-0001KI-2M
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:58 +0200
Message-Id: <20171026140404.21948-34-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/39] mips: malta/boston: replace cpu_model
 with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-37-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 526b8d0b11..aab1af926d 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -34,7 +34,7 @@ typedef struct MIPSCPSState {
=20
     uint32_t num_vp;
     uint32_t num_irq;
-    char *cpu_model;
+    char *cpu_type;
=20
     MemoryRegion container;
     MIPSGCRState gcr;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 66265e4eb6..7f8ba5ff3e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -740,8 +740,12 @@ enum {
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
=20
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
=20
 /* mips_int.c */
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e815be6a6c..1cb4b6aca2 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -437,7 +437,6 @@ static void boston_mach_init(MachineState *machine)
     DeviceState *dev;
     BostonState *s;
     Error *err =3D NULL;
-    const char *cpu_model;
     MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem =3D get_system_memory();
     XilinxPCIEHost *pcie2;
@@ -453,25 +452,24 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
=20
-    cpu_model =3D machine->cpu_model ?: "I6400";
-
     dev =3D qdev_create(NULL, TYPE_MIPS_BOSTON);
     qdev_init_nofail(dev);
=20
     s =3D BOSTON(dev);
     s->mach =3D machine;
=20
-    if (!cpu_supports_cps_smp(cpu_model)) {
+    if (!cpu_supports_cps_smp(machine->cpu_type)) {
         error_report("Boston requires CPUs which support CPS");
         exit(1);
     }
=20
-    is_64b =3D cpu_supports_isa(cpu_model, ISA_MIPS64);
+    is_64b =3D cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
=20
     s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
=20
-    object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err=
);
+    object_property_set_str(OBJECT(s->cps), machine->cpu_type, "cpu-type=
",
+                            &err);
     object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
=20
@@ -571,6 +569,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->block_default_type =3D IF_IDE;
     mc->default_ram_size =3D 1 * G_BYTE;
     mc->max_cpus =3D 16;
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("I6400");
 }
=20
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index fe5c630af6..4285d1964e 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
     bool itu_present =3D false;
=20
     for (i =3D 0; i < s->num_vp; i++) {
-        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
+        cpu =3D MIPS_CPU(cpu_create(s->cpu_type));
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -160,7 +160,7 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
 static Property mips_cps_properties[] =3D {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
-    DEFINE_PROP_STRING("cpu-model", MIPSCPSState, cpu_model),
+    DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index b6a58c7f21..ec6af4a277 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -923,7 +923,7 @@ static void main_cpu_reset(void *opaque)
     }
 }
=20
-static void create_cpu_without_cps(const char *cpu_model,
+static void create_cpu_without_cps(const char *cpu_type,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_i=
rq)
 {
     CPUMIPSState *env;
@@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_mo=
del,
     int i;
=20
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+        cpu =3D MIPS_CPU(cpu_create(cpu_type));
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -945,7 +945,7 @@ static void create_cpu_without_cps(const char *cpu_mo=
del,
     *cbus_irq =3D env->irq[4];
 }
=20
-static void create_cps(MaltaState *s, const char *cpu_model,
+static void create_cps(MaltaState *s, const char *cpu_type,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     Error *err =3D NULL;
@@ -953,7 +953,7 @@ static void create_cps(MaltaState *s, const char *cpu=
_model,
     s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
     qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
=20
-    object_property_set_str(OBJECT(s->cps), cpu_model, "cpu-model", &err=
);
+    object_property_set_str(OBJECT(s->cps), cpu_type, "cpu-type", &err);
     object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
     if (err !=3D NULL) {
@@ -967,21 +967,13 @@ static void create_cps(MaltaState *s, const char *c=
pu_model,
     *cbus_irq =3D NULL;
 }
=20
-static void create_cpu(MaltaState *s, const char *cpu_model,
-                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
+static void mips_create_cpu(MaltaState *s, const char *cpu_type,
+                            qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
-    if (cpu_model =3D=3D NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model =3D "20Kc";
-#else
-        cpu_model =3D "24Kf";
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
=20
@@ -1038,7 +1030,7 @@ void mips_malta_init(MachineState *machine)
     }
=20
     /* create CPU */
-    create_cpu(s, machine->cpu_model, &cbus_irq, &i8259_irq);
+    mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
=20
     /* allocate RAM */
     if (ram_size > (2048u << 20)) {
@@ -1264,6 +1256,11 @@ static void mips_malta_machine_init(MachineClass *=
mc)
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 16;
     mc->is_default =3D 1;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("20Kc");
+#else
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
+#endif
 }
=20
 DEFINE_MACHINE("malta", mips_malta_machine_init)
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0ae70288dd..ba9355b76a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -154,7 +154,7 @@ static void mips_cpu_initfn(Object *obj)
=20
 static char *mips_cpu_type_name(const char *cpu_model)
 {
-    return g_strdup_printf("%s-" TYPE_MIPS_CPU, cpu_model);
+    return g_strdup_printf(MIPS_CPU_TYPE_NAME("%s"), cpu_model);
 }
=20
 static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 82622c550e..1848500625 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20512,24 +20512,16 @@ void cpu_mips_realize_env(CPUMIPSState *env)
     mvp_init(env, env->cpu_model);
 }
=20
-bool cpu_supports_cps_smp(const char *cpu_model)
+bool cpu_supports_cps_smp(const char *cpu_type)
 {
-    const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
-    if (!def) {
-        return false;
-    }
-
-    return (def->CP0_Config3 & (1 << CP0C3_CMGCR)) !=3D 0;
+    const MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(object_class_by_name(cpu_=
type));
+    return (mcc->cpu_def->CP0_Config3 & (1 << CP0C3_CMGCR)) !=3D 0;
 }
=20
-bool cpu_supports_isa(const char *cpu_model, unsigned int isa)
+bool cpu_supports_isa(const char *cpu_type, unsigned int isa)
 {
-    const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
-    if (!def) {
-        return false;
-    }
-
-    return (def->insn_flags & isa) !=3D 0;
+    const MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(object_class_by_name(cpu_=
type));
+    return (mcc->cpu_def->insn_flags & isa) !=3D 0;
 }
=20
 void cpu_set_exception_base(int vp_index, target_ulong address)
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8bbded46c4..c7ba6ee5f9 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -755,18 +755,6 @@ const mips_def_t mips_defs[] =3D
 };
 const int mips_defs_number =3D ARRAY_SIZE(mips_defs);
=20
-static const mips_def_t *cpu_mips_find_by_name (const char *name)
-{
-    int i;
-
-    for (i =3D 0; i < ARRAY_SIZE(mips_defs); i++) {
-        if (strcasecmp(name, mips_defs[i].name) =3D=3D 0) {
-            return &mips_defs[i];
-        }
-    }
-    return NULL;
-}
-
 void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
 {
     int i;
--=20
2.13.6
