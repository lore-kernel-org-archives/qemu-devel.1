Received: from eggs.gnu.org ([2001:4830:134:3::10]:41113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUc-00005A-9B
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUU-000397-H8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUU-00038n-9X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:09 -0300
Message-Id: <20170901150317.10380-22-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] sh4: replace cpu_sh4_init() with
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
Message-Id: <1503592308-93913-18-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sh4/cpu.h | 3 +--
 hw/sh4/r2d.c     | 2 +-
 hw/sh4/shix.c    | 2 +-
 target/sh4/cpu.c | 5 -----
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 3c47f0de89..79f85d3365 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -238,7 +238,6 @@ void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     int mmu_idx, uintptr_t retaddr);
 
 void sh4_translate_init(void);
-SuperHCPU *cpu_sh4_init(const char *cpu_model);
 int cpu_sh4_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
@@ -269,7 +268,7 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define cpu_init(cpu_model) CPU(cpu_sh4_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index a0462adb97..22bc534e5f 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -246,7 +246,7 @@ static void r2d_init(MachineState *machine)
         cpu_model = "SH7751R";
     }
 
-    cpu = cpu_sh4_init(cpu_model);
+    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index e22eaf0c8f..7f8a4b6484 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -56,7 +56,7 @@ static void shix_init(MachineState *machine)
     if (!cpu_model)
         cpu_model = "any";
 
-    cpu = cpu_sh4_init(cpu_model);
+    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8536f6d002..6ce7cba5a9 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -156,11 +156,6 @@ static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-SuperHCPU *cpu_sh4_init(const char *cpu_model)
-{
-    return SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
-}
-
 static void sh7750r_cpu_initfn(Object *obj)
 {
     SuperHCPU *cpu = SUPERH_CPU(obj);
-- 
2.13.5
