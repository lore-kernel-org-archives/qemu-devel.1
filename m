Received: from eggs.gnu.org ([2001:4830:134:3::10]:40945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUH-0008Bv-8d
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnU9-00030Z-8J
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnU8-00030L-VY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:03 -0300
Message-Id: <20170901150317.10380-16-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] m68k: replace cpu_m68k_init() with
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

call register_m68k_insns() at realize time which makes
cpu_m68k_init() typical object creation function.
As result we can replace it with cpu_generic_init()
which does the same job, reducing code duplication a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1503592308-93913-12-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/m68k/cpu.h    |  3 +--
 hw/m68k/an5206.c     |  2 +-
 hw/m68k/mcf5208.c    |  2 +-
 target/m68k/cpu.c    |  2 ++
 target/m68k/helper.c | 20 --------------------
 5 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 38a7e11b92..d9365476e5 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -163,7 +163,6 @@ int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void m68k_tcg_init(void);
 void m68k_cpu_init_gdb(M68kCPU *cpu);
-M68kCPU *cpu_m68k_init(const char *cpu_model);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
@@ -322,7 +321,7 @@ void register_m68k_insns (CPUM68KState *env);
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) CPU(cpu_m68k_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_M68K_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_m68k_signal_handler
 #define cpu_list m68k_cpu_list
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index c76244176f..7b9b15d6c4 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -42,7 +42,7 @@ static void an5206_init(MachineState *machine)
     if (!cpu_model) {
         cpu_model = "m5206";
     }
-    cpu = cpu_m68k_init(cpu_model);
+    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
     if (!cpu) {
         error_report("Unable to find m68k CPU definition");
         exit(1);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index f4b1387c0d..1a0f18073a 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -232,7 +232,7 @@ static void mcf5208evb_init(MachineState *machine)
     if (!cpu_model) {
         cpu_model = "m5208";
     }
-    cpu = cpu_m68k_init(cpu_model);
+    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
     if (!cpu) {
         fprintf(stderr, "Unable to find m68k CPU definition\n");
         exit(1);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index a14b6dda7f..55bf24bae6 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    register_m68k_insns(&cpu->env);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index caae29100c..7e50ff5871 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -156,26 +156,6 @@ static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-M68kCPU *cpu_m68k_init(const char *cpu_model)
-{
-    M68kCPU *cpu;
-    CPUM68KState *env;
-    ObjectClass *oc;
-
-    oc = cpu_class_by_name(TYPE_M68K_CPU, cpu_model);
-    if (oc == NULL) {
-        return NULL;
-    }
-    cpu = M68K_CPU(object_new(object_class_get_name(oc)));
-    env = &cpu->env;
-
-    register_m68k_insns(env);
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 void m68k_cpu_init_gdb(M68kCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-- 
2.13.5
