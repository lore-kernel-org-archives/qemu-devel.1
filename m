Received: from eggs.gnu.org ([2001:4830:134:3::10]:37932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0c-0004SO-HT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0X-0008Hk-Rv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0X-0008Gi-M5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:05 -0400
Received: by mail-qt0-x241.google.com with SMTP id l25so2418089qtf.2
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:50:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Sep 2017 16:49:34 -0300
Message-Id: <20170920194934.23071-7-f4bug@amsat.org>
In-Reply-To: <20170920194934.23071-1-f4bug@amsat.org>
References: <20170920194934.23071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 6/6] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Igor Mammedov <imammedo@redhat.com>

now cpu_mips_init() reimplements subset of cpu_generic_init()
tasks, so just drop it and use cpu_generic_init() directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: use internal.h instead of cpu.h]
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/mips/cpu.h       |  3 +--
 hw/mips/cps.c           |  2 +-
 hw/mips/mips_fulong2e.c |  2 +-
 hw/mips/mips_jazz.c     |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 hw/mips/mips_mipssim.c  |  2 +-
 hw/mips/mips_r4k.c      |  2 +-
 target/mips/translate.c | 17 -----------------
 8 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 2f81e0f950..66265e4eb6 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -737,10 +737,9 @@ enum {
  */
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
 
-MIPSCPU *cpu_mips_init(const char *cpu_model);
 int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
-#define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
 bool cpu_supports_cps_smp(const char *cpu_model);
 bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 79d4c5e30a..fe5c630af6 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
 
     for (i = 0; i < s->num_vp; i++) {
-        cpu = cpu_mips_init(s->cpu_model);
+        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 439a3d7a66..75318680e1 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -280,7 +280,7 @@ static void mips_fulong2e_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "Loongson-2E";
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index ae10670efd..7e6626dc88 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
     if (cpu_model == NULL) {
         cpu_model = "R4000";
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e87cd3230b..2adb9bcf89 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_model,
     int i;
 
     for (i = 0; i < smp_cpus; i++) {
-        cpu = cpu_mips_init(cpu_model);
+        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 49cd38d680..a092072e2a 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -163,7 +163,7 @@ mips_mipssim_init(MachineState *machine)
         cpu_model = "24Kf";
 #endif
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 7efee94431..1272d4ef9d 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -193,7 +193,7 @@ void mips_r4k_init(MachineState *machine)
         cpu_model = "24Kf";
 #endif
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f7128bc91d..d16d879df7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20523,23 +20523,6 @@ void cpu_mips_realize_env(CPUMIPSState *env)
     mvp_init(env, env->cpu_model);
 }
 
-MIPSCPU *cpu_mips_init(const char *cpu_model)
-{
-    ObjectClass *oc;
-    MIPSCPU *cpu;
-
-    oc = cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
-    if (oc == NULL) {
-        return NULL;
-    }
-
-    cpu = MIPS_CPU(object_new(object_class_get_name(oc)));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 bool cpu_supports_cps_smp(const char *cpu_model)
 {
     const mips_def_t *def = cpu_mips_find_by_name(cpu_model);
-- 
2.14.1
