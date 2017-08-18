Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDT-0004BS-7E
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDQ-0000la-Ra
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDQ-0000kI-IH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:20 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:48 +0200
Message-Id: <1503050939-227939-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 16/27] xtensa: replace
 cpu_xtensa_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

call xtensa_irq_init() at realize time which makes
cpu_xtensa_init() like generic cpu creation function.
As result we can replace it with cpu_generic_init()
which does the same job, reducing code duplication a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h    |  4 +---
 hw/xtensa/sim.c        |  2 +-
 hw/xtensa/xtfpga.c     |  2 +-
 target/xtensa/cpu.c    |  3 +++
 target/xtensa/helper.c | 22 ----------------------
 5 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index ee29fb1..4803331 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -475,9 +475,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #endif
 
-XtensaCPU *cpu_xtensa_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_xtensa_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
 
 void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 249cd1e..1b4767f 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -84,7 +84,7 @@ static void xtensa_sim_init(MachineState *machine)
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        cpu = cpu_xtensa_init(cpu_model);
+        cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
         if (cpu == NULL) {
             error_report("unable to find CPU definition '%s'",
                          cpu_model);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 635a4d4..182ec1e 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -232,7 +232,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        cpu = cpu_xtensa_init(cpu_model);
+        cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
         if (cpu == NULL) {
             error_report("unable to find CPU definition '%s'",
                          cpu_model);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index cd7f958..85897df 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -100,9 +100,12 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
+    XtensaCPU *cpu = XTENSA_CPU(dev);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    xtensa_irq_init(&cpu->env);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index bcd0b77..e8fba20 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -113,28 +113,6 @@ void xtensa_breakpoint_handler(CPUState *cs)
     }
 }
 
-XtensaCPU *cpu_xtensa_init(const char *cpu_model)
-{
-    ObjectClass *oc;
-    XtensaCPU *cpu;
-    CPUXtensaState *env;
-
-    oc = cpu_class_by_name(TYPE_XTENSA_CPU, cpu_model);
-    if (oc == NULL) {
-        return NULL;
-    }
-
-    cpu = XTENSA_CPU(object_new(object_class_get_name(oc)));
-    env = &cpu->env;
-
-    xtensa_irq_init(env);
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
-
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
     XtensaConfigList *core = xtensa_cores;
-- 
2.7.4
