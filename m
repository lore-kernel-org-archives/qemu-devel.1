Received: from eggs.gnu.org ([2001:4830:134:3::10]:41580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12V-0002Xv-PW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12T-0001ui-Hx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12T-0001uR-8K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:11 +0200
Message-Id: <1500040339-119465-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 20/28] sh4: replace cpu_sh4_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h | 3 +--
 hw/sh4/r2d.c     | 2 +-
 hw/sh4/shix.c    | 2 +-
 target/sh4/cpu.c | 5 -----
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ffb9168..9b66c63 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -223,7 +223,6 @@ void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     int mmu_idx, uintptr_t retaddr);
 
 void sh4_translate_init(void);
-SuperHCPU *cpu_sh4_init(const char *cpu_model);
 int cpu_sh4_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 int superh_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
@@ -254,7 +253,7 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define cpu_init(cpu_model) CPU(cpu_sh4_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e6fc74e..b3d6869 100644
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
index fd00cc5..3deba6c 100644
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
index 9da7e1e..88043ba 100644
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
2.7.4
