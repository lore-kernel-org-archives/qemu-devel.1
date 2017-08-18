Received: from eggs.gnu.org ([2001:4830:134:3::10]:60785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDT-0004Bx-HA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDS-0000n8-FZ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDS-0000mc-96
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 487917E425
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C07C266D62
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:20 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:50 +0200
Message-Id: <1503050939-227939-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 18/27] sh4: replace cpu_sh4_init()
 with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sh4/cpu.h | 3 +--
 hw/sh4/r2d.c     | 2 +-
 hw/sh4/shix.c    | 2 +-
 target/sh4/cpu.c | 5 -----
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 3c47f0d..79f85d3 100644
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
index a0462ad..22bc534 100644
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
index e22eaf0..7f8a4b6 100644
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
index 8536f6d..6ce7cba 100644
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
