Received: from eggs.gnu.org ([2001:4830:134:3::10]:41728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12h-0002vD-Hf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12g-00020x-KE
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12g-00020k-EV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:02 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:17 +0200
Message-Id: <1500040339-119465-27-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 26/28] openrisc: replace cpu_openrisc_init()
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Jia Liu <proljc@gmail.com>
CC: Stafford Horne <shorne@gmail.com>
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
index fc0d096..d6ed968 100644
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
