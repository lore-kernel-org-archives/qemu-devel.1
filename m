Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDY-0004I9-8b
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDX-0000qF-7U
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDX-0000pe-1H
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B17CC0587D4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:26 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94B335D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:56 +0200
Message-Id: <1503050939-227939-25-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 24/27] openrisc: replace
 cpu_openrisc_init() with cpu_generic_init()
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
Acked-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/openrisc/cpu.h      | 4 +---
 hw/openrisc/openrisc_sim.c | 2 +-
 target/openrisc/cpu.c      | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 2721432..f51b89a 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -347,8 +347,6 @@ static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
 
 #define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
-OpenRISCCPU *cpu_openrisc_init(const char *cpu_model);
-
 void cpu_openrisc_list(FILE *f, fprintf_function cpu_fprintf);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
@@ -390,7 +388,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
                                int *prot, target_ulong address, int rw);
 #endif
 
-#define cpu_init(cpu_model) CPU(cpu_openrisc_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model)
 
 #include "exec/cpu-all.h"
 
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e1eeffc..243d802 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -109,7 +109,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        cpu = cpu_openrisc_init(cpu_model);
+        cpu = OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
         if (cpu == NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 1d6330c..a979f0b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -210,11 +210,6 @@ static void openrisc_cpu_register_types(void)
     }
 }
 
-OpenRISCCPU *cpu_openrisc_init(const char *cpu_model)
-{
-    return OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
-}
-
 /* Sort alphabetically by type name, except for "any". */
 static gint openrisc_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
-- 
2.7.4
