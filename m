Received: from eggs.gnu.org ([2001:4830:134:3::10]:33498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gf-0007h2-2a
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006qx-F4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:41 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:24141)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006qZ-50
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:36 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:10 +0100
Message-ID: <1506001091-8296-7-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Igor Mammedov <imammedo@redhat.com>

now cpu_mips_init() reimplements subset of cpu_generic_init()
tasks, so just drop it and use cpu_generic_init() directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[PMD: use internal.h instead of cpu.h]
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/mips/cps.c           |  2 +-
 hw/mips/mips_fulong2e.c |  2 +-
 hw/mips/mips_jazz.c     |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 hw/mips/mips_mipssim.c  |  2 +-
 hw/mips/mips_r4k.c      |  2 +-
 target/mips/cpu.h       |  3 +--
 target/mips/translate.c | 17 -----------------
 8 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 79d4c5e..fe5c630 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
     bool itu_present =3D false;
=20
     for (i =3D 0; i < s->num_vp; i++) {
-        cpu =3D cpu_mips_init(s->cpu_model);
+        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 439a3d7..7531868 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -280,7 +280,7 @@ static void mips_fulong2e_init(MachineState *machine)
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "Loongson-2E";
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env =3D &cpu->env;
=20
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index ae10670..7e6626d 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "R4000";
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env =3D &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e87cd32..2adb9bc 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_mo=
del,
     int i;
=20
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D cpu_mips_init(cpu_model);
+        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 49cd38d..a092072 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -163,7 +163,7 @@ mips_mipssim_init(MachineState *machine)
         cpu_model =3D "24Kf";
 #endif
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 7efee94..1272d4e 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -193,7 +193,7 @@ void mips_r4k_init(MachineState *machine)
         cpu_model =3D "24Kf";
 #endif
     }
-    cpu =3D cpu_mips_init(cpu_model);
+    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 2f81e0f..66265e4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -737,10 +737,9 @@ enum {
  */
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
=20
-MIPSCPU *cpu_mips_init(const char *cpu_model);
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
=20
-#define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
 bool cpu_supports_cps_smp(const char *cpu_model);
 bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f7128bc..d16d879 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20523,23 +20523,6 @@ void cpu_mips_realize_env(CPUMIPSState *env)
     mvp_init(env, env->cpu_model);
 }
=20
-MIPSCPU *cpu_mips_init(const char *cpu_model)
-{
-    ObjectClass *oc;
-    MIPSCPU *cpu;
-
-    oc =3D cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
-    if (oc =3D=3D NULL) {
-        return NULL;
-    }
-
-    cpu =3D MIPS_CPU(object_new(object_class_get_name(oc)));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 bool cpu_supports_cps_smp(const char *cpu_model)
 {
     const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
--=20
2.7.4
