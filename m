Received: from eggs.gnu.org ([2001:4830:134:3::10]:41161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUf-0000AE-Vn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUe-0003Cz-VM
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUe-0003Ce-Pb
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:14 -0300
Message-Id: <20170901150317.10380-27-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 26/29] moxie: replace cpu_moxie_init() with
 cpu_generic_init()
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

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-23-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/moxie/cpu.h  | 3 +--
 hw/moxie/moxiesim.c | 2 +-
 target/moxie/cpu.c  | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 8991aaef9a..75decaadd6 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -112,7 +112,6 @@ static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
 
 #define ENV_OFFSET offsetof(MoxieCPU, env)
 
-MoxieCPU *cpu_moxie_init(const char *cpu_model);
 void moxie_cpu_do_interrupt(CPUState *cs);
 void moxie_cpu_dump_state(CPUState *cpu, FILE *f,
                           fprintf_function cpu_fprintf, int flags);
@@ -121,7 +120,7 @@ void moxie_translate_init(void);
 int cpu_moxie_signal_handler(int host_signum, void *pinfo,
                              void *puc);
 
-#define cpu_init(cpu_model) CPU(cpu_moxie_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_moxie_signal_handler
 
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index df3f1249ae..4c27b45c46 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -118,7 +118,7 @@ static void moxiesim_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "MoxieLite-moxie-cpu";
     }
-    cpu = cpu_moxie_init(cpu_model);
+    cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
     if (!cpu) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 927b1a1e44..748d02f29e 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -150,11 +150,6 @@ static const MoxieCPUInfo moxie_cpus[] = {
     { .name = "any",            .initfn = moxie_any_initfn },
 };
 
-MoxieCPU *cpu_moxie_init(const char *cpu_model)
-{
-    return MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
-}
-
 static void cpu_register(const MoxieCPUInfo *info)
 {
     TypeInfo type_info = {
-- 
2.13.5
