Received: from eggs.gnu.org ([2001:4830:134:3::10]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtiru-0003WM-FS
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirp-0007dg-CT
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:54 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirp-0007dP-7K
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:49 -0400
Received: by mail-qk0-x244.google.com with SMTP id g128so4581394qke.0
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 16:20:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Sep 2017 20:20:10 -0300
Message-Id: <20170917232010.14183-7-f4bug@amsat.org>
In-Reply-To: <20170917232010.14183-1-f4bug@amsat.org>
References: <20170917232010.14183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/6] mips: replace cpu_mips_init() with
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
index 4ef337d5c4..708899cf92 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     bool itu_present = false;
 
     for (i = 0; i < s->num_vp; i++) {
-        cpu = cpu_mips_init(s->cpu_model);
+        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
         if (cpu == NULL) {
             error_setg(errp, "%s: CPU initialization failed",  __func__);
             return;
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 3532399a13..5d9462ec35 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -280,7 +280,7 @@ static void mips_fulong2e_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "Loongson-2E";
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index df2262a2a8..c1402de1ce 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
     if (cpu_model == NULL) {
         cpu_model = "R4000";
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index af678f5784..9ecdc818b1 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_model,
     int i;
 
     for (i = 0; i < smp_cpus; i++) {
-        cpu = cpu_mips_init(cpu_model);
+        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
         if (cpu == NULL) {
             fprintf(stderr, "Unable to find CPU definition\n");
             exit(1);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 07fc4c2300..1166834f54 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -163,7 +163,7 @@ mips_mipssim_init(MachineState *machine)
         cpu_model = "24Kf";
 #endif
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 2f5ced7409..de212f5c13 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -193,7 +193,7 @@ void mips_r4k_init(MachineState *machine)
         cpu_model = "24Kf";
 #endif
     }
-    cpu = cpu_mips_init(cpu_model);
+    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
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
