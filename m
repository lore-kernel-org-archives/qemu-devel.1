Received: from eggs.gnu.org ([2001:4830:134:3::10]:45646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6a-0008LX-QL
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6X-0008EU-Jx
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:51016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6X-0008BU-7F
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:05 -0400
Received: by mail-wr0-x244.google.com with SMTP id p96so9428221wrb.7
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:04 +0200
Message-Id: <20171025093535.10175-21-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/51] qom: Introduce CPUClass.tcg_initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Move target cpu tcg initialization to common code,
called from cpu_exec_realizefn.

Acked-by: Andreas Färber <afaerber@suse.de>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h           |  8 ++++++--
 target/sparc/cpu.h          |  2 +-
 exec.c                      |  7 ++++++-
 target/alpha/cpu.c          |  3 +--
 target/alpha/translate.c    |  6 ------
 target/arm/cpu.c            |  6 +-----
 target/cris/cpu.c           | 16 ++++++----------
 target/hppa/cpu.c           |  3 +--
 target/hppa/translate.c     |  6 ------
 target/i386/cpu.c           |  5 +----
 target/i386/translate.c     |  6 ------
 target/lm32/cpu.c           |  7 +------
 target/m68k/cpu.c           |  7 +------
 target/microblaze/cpu.c     |  7 +------
 target/mips/cpu.c           |  5 +----
 target/mips/translate.c     |  7 -------
 target/moxie/cpu.c          |  7 +------
 target/moxie/translate.c    |  6 ------
 target/nios2/cpu.c          |  7 +------
 target/openrisc/cpu.c       |  7 +------
 target/ppc/translate.c      |  6 ------
 target/ppc/translate_init.c |  5 +----
 target/s390x/cpu.c          |  7 +------
 target/sh4/cpu.c            |  5 +----
 target/sh4/translate.c      |  7 -------
 target/sparc/cpu.c          |  5 +----
 target/sparc/translate.c    |  9 +--------
 target/tilegx/cpu.c         |  7 +------
 target/tricore/cpu.c        |  5 +----
 target/tricore/translate.c  |  5 +----
 target/unicore32/cpu.c      |  7 +------
 target/xtensa/cpu.c         |  7 +------
 32 files changed, 40 insertions(+), 163 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 0efebdbcf4..df0ba86202 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -195,10 +195,8 @@ typedef struct CPUClass {
                                 void *opaque);
 
     const struct VMStateDescription *vmsd;
-    int gdb_num_core_regs;
     const char *gdb_core_xml_file;
     gchar * (*gdb_arch_name)(CPUState *cpu);
-    bool gdb_stop_before_watchpoint;
 
     void (*cpu_exec_enter)(CPUState *cpu);
     void (*cpu_exec_exit)(CPUState *cpu);
@@ -206,6 +204,12 @@ typedef struct CPUClass {
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
+    void (*tcg_initialize)(void);
+
+    /* Keep non-pointer data at the end to minimize holes.  */
+    int gdb_num_core_regs;
+    bool gdb_stop_before_watchpoint;
+    bool tcg_initialized;
 } CPUClass;
 
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 1598f65927..bf2b8931cc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -594,7 +594,7 @@ int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 
 /* translate.c */
-void gen_intermediate_code_init(CPUSPARCState *env);
+void sparc_tcg_init(void);
 
 /* cpu-exec.c */
 
diff --git a/exec.c b/exec.c
index db5ae23118..de03053d32 100644
--- a/exec.c
+++ b/exec.c
@@ -791,10 +791,15 @@ void cpu_exec_initfn(CPUState *cpu)
 
 void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    CPUClass *cc ATTRIBUTE_UNUSED = CPU_GET_CLASS(cpu);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     cpu_list_add(cpu);
 
+    if (tcg_enabled() && !cc->tcg_initialized) {
+        cc->tcg_initialized = true;
+        cc->tcg_initialize();
+    }
+
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b8a21f4e01..bc9520535b 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -260,8 +260,6 @@ static void alpha_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     tlb_flush(cs);
 
-    alpha_translate_init();
-
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
@@ -299,6 +297,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_alpha_cpu;
 #endif
     cc->disas_set_info = alpha_cpu_disas_set_info;
+    cc->tcg_initialize = alpha_translate_init;
 
     cc->gdb_num_core_regs = 67;
 }
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index f32c95b9a1..3c8d1dc333 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -124,14 +124,8 @@ void alpha_translate_init(void)
     };
 #endif
 
-    static bool done_init = 0;
     int i;
 
-    if (done_init) {
-        return;
-    }
-    done_init = 1;
-
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88578f360e..056284985d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -534,7 +534,6 @@ static void arm_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     ARMCPU *cpu = ARM_CPU(obj);
-    static bool inited;
 
     cs->env_ptr = &cpu->env;
     cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
@@ -578,10 +577,6 @@ static void arm_cpu_initfn(Object *obj)
 
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
-        if (!inited) {
-            inited = true;
-            arm_translate_init();
-        }
     }
 }
 
@@ -1765,6 +1760,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->disas_set_info = arm_disas_set_info;
+    cc->tcg_initialize = arm_translate_init;
 }
 
 static void cpu_register(const ARMCPUInfo *info)
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 88d93f2d11..527a3448bf 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -181,7 +181,6 @@ static void cris_cpu_initfn(Object *obj)
     CRISCPU *cpu = CRIS_CPU(obj);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
     CPUCRISState *env = &cpu->env;
-    static bool tcg_initialized;
 
     cs->env_ptr = env;
 
@@ -191,15 +190,6 @@ static void cris_cpu_initfn(Object *obj)
     /* IRQ and NMI lines.  */
     qdev_init_gpio_in(DEVICE(cpu), cris_cpu_set_irq, 2);
 #endif
-
-    if (tcg_enabled() && !tcg_initialized) {
-        tcg_initialized = true;
-        if (env->pregs[PR_VR] < 32) {
-            cris_initialize_crisv10_tcg();
-        } else {
-            cris_initialize_tcg();
-        }
-    }
 }
 
 static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
@@ -210,6 +200,7 @@ static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 8;
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+    cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
 
 static void crisv9_cpu_class_init(ObjectClass *oc, void *data)
@@ -220,6 +211,7 @@ static void crisv9_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 9;
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+    cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
 
 static void crisv10_cpu_class_init(ObjectClass *oc, void *data)
@@ -230,6 +222,7 @@ static void crisv10_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 10;
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+    cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
 
 static void crisv11_cpu_class_init(ObjectClass *oc, void *data)
@@ -240,6 +233,7 @@ static void crisv11_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 11;
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+    cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
 
 static void crisv17_cpu_class_init(ObjectClass *oc, void *data)
@@ -250,6 +244,7 @@ static void crisv17_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 17;
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+    cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
 
 static void crisv32_cpu_class_init(ObjectClass *oc, void *data)
@@ -322,6 +317,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_stop_before_watchpoint = true;
 
     cc->disas_set_info = cris_disas_set_info;
+    cc->tcg_initialize = cris_initialize_tcg;
 }
 
 static const TypeInfo cris_cpu_type_info = {
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index a477b452f0..9e7b0d4ccb 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -108,8 +108,6 @@ static void hppa_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     cpu_hppa_loaded_fr0(env);
     set_snan_bit_is_one(true, &env->fp_status);
-
-    hppa_translate_init();
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
@@ -136,6 +134,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
     cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
     cc->disas_set_info = hppa_cpu_disas_set_info;
+    cc->tcg_initialize = hppa_translate_init;
 
     cc->gdb_num_core_regs = 128;
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 26242f4b3c..334ee74e4c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -124,14 +124,8 @@ void hppa_translate_init(void)
         "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
     };
 
-    static bool done_init = 0;
     int i;
 
-    if (done_init) {
-        return;
-    }
-    done_init = 1;
-
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98732cd65f..53ec94ac9b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3719,10 +3719,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (tcg_enabled()) {
-        tcg_x86_init();
-    }
-
 #ifndef CONFIG_USER_ONLY
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
@@ -4216,6 +4212,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #endif
     cc->cpu_exec_enter = x86_cpu_exec_enter;
     cc->cpu_exec_exit = x86_cpu_exec_exit;
+    cc->tcg_initialize = tcg_x86_init;
 
     dc->user_creatable = true;
 }
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d6697f721c..da13fe4d11 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8366,12 +8366,6 @@ void tcg_x86_init(void)
         "bnd0_ub", "bnd1_ub", "bnd2_ub", "bnd3_ub"
     };
     int i;
-    static bool initialized;
-
-    if (initialized) {
-        return;
-    }
-    initialized = true;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index bf081f56d2..7f3a292f2b 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -163,16 +163,10 @@ static void lm32_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     LM32CPU *cpu = LM32_CPU(obj);
     CPULM32State *env = &cpu->env;
-    static bool tcg_initialized;
 
     cs->env_ptr = env;
 
     env->flags = 0;
-
-    if (tcg_enabled() && !tcg_initialized) {
-        tcg_initialized = true;
-        lm32_translate_init();
-    }
 }
 
 static void lm32_basic_cpu_initfn(Object *obj)
@@ -286,6 +280,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->debug_excp_handler = lm32_debug_excp_handler;
     cc->disas_set_info = lm32_cpu_disas_set_info;
+    cc->tcg_initialize = lm32_translate_init;
 }
 
 static void lm32_register_cpu_type(const LM32CPUInfo *info)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 8c70e0805c..5da19e570b 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -247,14 +247,8 @@ static void m68k_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
-    static bool inited;
 
     cs->env_ptr = env;
-
-    if (tcg_enabled() && !inited) {
-        inited = true;
-        m68k_tcg_init();
-    }
 }
 
 static const VMStateDescription vmstate_m68k_cpu = {
@@ -288,6 +282,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
+    cc->tcg_initialize = m68k_tcg_init;
 
     cc->gdb_num_core_regs = 18;
     cc->gdb_core_xml_file = "cf-core.xml";
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ddffe86e9b..5700652e06 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -205,7 +205,6 @@ static void mb_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
     CPUMBState *env = &cpu->env;
-    static bool tcg_initialized;
 
     cs->env_ptr = env;
 
@@ -215,11 +214,6 @@ static void mb_cpu_initfn(Object *obj)
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
 #endif
-
-    if (tcg_enabled() && !tcg_initialized) {
-        tcg_initialized = true;
-        mb_tcg_init();
-    }
 }
 
 static const VMStateDescription vmstate_mb_cpu = {
@@ -289,6 +283,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 32 + 5;
 
     cc->disas_set_info = mb_disas_set_info;
+    cc->tcg_initialize = mb_tcg_init;
 }
 
 static const TypeInfo mb_cpu_type_info = {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c15b894362..0ae70288dd 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -150,10 +150,6 @@ static void mips_cpu_initfn(Object *obj)
 
     cs->env_ptr = env;
     env->cpu_model = mcc->cpu_def;
-
-    if (tcg_enabled()) {
-        mips_tcg_init();
-    }
 }
 
 static char *mips_cpu_type_name(const char *cpu_model)
@@ -202,6 +198,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->vmsd = &vmstate_mips_cpu;
 #endif
     cc->disas_set_info = mips_cpu_disas_set_info;
+    cc->tcg_initialize = mips_tcg_init;
 
     cc->gdb_num_core_regs = 73;
     cc->gdb_stop_before_watchpoint = true;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ac05f3aa09..ef07fa827e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20453,11 +20453,6 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 void mips_tcg_init(void)
 {
     int i;
-    static int inited;
-
-    /* Initialize various static tables. */
-    if (inited)
-        return;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
@@ -20506,8 +20501,6 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
-
-    inited = 1;
 }
 
 #include "translate_init.c"
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 30bd44fcad..24ab3f3708 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -77,14 +77,8 @@ static void moxie_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     MoxieCPU *cpu = MOXIE_CPU(obj);
-    static int inited;
 
     cs->env_ptr = &cpu->env;
-
-    if (tcg_enabled() && !inited) {
-        inited = 1;
-        moxie_translate_init();
-    }
 }
 
 static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
@@ -122,6 +116,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
     cc->vmsd = &vmstate_moxie_cpu;
 #endif
     cc->disas_set_info = moxie_cpu_disas_set_info;
+    cc->tcg_initialize = moxie_translate_init;
 }
 
 static void moxielite_initfn(Object *obj)
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 3cfd232558..eaf5103920 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -94,7 +94,6 @@ void moxie_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 void moxie_translate_init(void)
 {
     int i;
-    static int done_init;
     static const char * const gregnames[16] = {
         "$fp", "$sp", "$r0", "$r1",
         "$r2", "$r3", "$r4", "$r5",
@@ -102,9 +101,6 @@ void moxie_translate_init(void)
         "$r10", "$r11", "$r12", "$r13"
     };
 
-    if (done_init) {
-        return;
-    }
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
@@ -118,8 +114,6 @@ void moxie_translate_init(void)
                                   offsetof(CPUMoxieState, cc_a), "cc_a");
     cc_b = tcg_global_mem_new_i32(cpu_env,
                                   offsetof(CPUMoxieState, cc_b), "cc_b");
-
-    done_init = 1;
 }
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 5b02fb67ea..4742e52c78 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -69,18 +69,12 @@ static void nios2_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     Nios2CPU *cpu = NIOS2_CPU(obj);
     CPUNios2State *env = &cpu->env;
-    static bool tcg_initialized;
 
     cs->env_ptr = env;
 
 #if !defined(CONFIG_USER_ONLY)
     mmu_init(env);
 #endif
-
-    if (tcg_enabled() && !tcg_initialized) {
-        tcg_initialized = true;
-        nios2_tcg_init();
-    }
 }
 
 static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
@@ -215,6 +209,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = nios2_cpu_gdb_read_register;
     cc->gdb_write_register = nios2_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 49;
+    cc->tcg_initialize = nios2_tcg_init;
 }
 
 static const TypeInfo nios2_cpu_type_info = {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a6d2049684..a8db869e50 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -86,18 +86,12 @@ static void openrisc_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
-    static int inited;
 
     cs->env_ptr = &cpu->env;
 
 #ifndef CONFIG_USER_ONLY
     cpu_openrisc_mmu_init(cpu);
 #endif
-
-    if (tcg_enabled() && !inited) {
-        inited = 1;
-        openrisc_translate_init();
-    }
 }
 
 /* CPU models */
@@ -169,6 +163,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_openrisc_cpu;
 #endif
     cc->gdb_num_core_regs = 32 + 3;
+    cc->tcg_initialize = openrisc_translate_init;
 }
 
 static void cpu_register(const OpenRISCCPUInfo *info)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 616cf8f50e..b61f4f0bad 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -84,10 +84,6 @@ void ppc_translate_init(void)
     int i;
     char* p;
     size_t cpu_reg_names_size;
-    static int done_init = 0;
-
-    if (done_init)
-        return;
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
@@ -191,8 +187,6 @@ void ppc_translate_init(void)
 
     cpu_access_type = tcg_global_mem_new_i32(cpu_env,
                                              offsetof(CPUPPCState, access_type), "access_type");
-
-    done_init = 1;
 }
 
 /* internal defines */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 7b9bf6a773..2cb58b855b 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10499,10 +10499,6 @@ static void ppc_cpu_initfn(Object *obj)
         env->sps = (env->mmu_model & POWERPC_MMU_64K) ? defsps_64k : defsps_4k;
     }
 #endif /* defined(TARGET_PPC64) */
-
-    if (tcg_enabled()) {
-        ppc_translate_init();
-    }
 }
 
 static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr)
@@ -10582,6 +10578,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
 #endif
+    cc->tcg_initialize = ppc_translate_init;
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 95f4283188..824dfd6b65 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -241,7 +241,6 @@ static void s390_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     S390CPU *cpu = S390_CPU(obj);
     CPUS390XState *env = &cpu->env;
-    static bool inited;
 #if !defined(CONFIG_USER_ONLY)
     struct tm tm;
 #endif
@@ -259,11 +258,6 @@ static void s390_cpu_initfn(Object *obj)
     env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
 #endif
-
-    if (tcg_enabled() && !inited) {
-        inited = true;
-        s390x_translate_init();
-    }
 }
 
 static void s390_cpu_finalize(Object *obj)
@@ -503,6 +497,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
+    cc->tcg_initialize = s390x_translate_init;
 
     cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
     cc->gdb_core_xml_file = "s390x-core64.xml";
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 252440e019..89abce2472 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -258,10 +258,6 @@ static void superh_cpu_initfn(Object *obj)
     cs->env_ptr = env;
 
     env->movcal_backup_tail = &(env->movcal_backup);
-
-    if (tcg_enabled()) {
-        sh4_translate_init();
-    }
 }
 
 static const VMStateDescription vmstate_sh_cpu = {
@@ -297,6 +293,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = superh_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = superh_cpu_disas_set_info;
+    cc->tcg_initialize = sh4_translate_init;
 
     cc->gdb_num_core_regs = 59;
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8db9fba26e..b4e4fd3782 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -81,7 +81,6 @@ static TCGv cpu_flags, cpu_delayed_pc, cpu_delayed_cond;
 void sh4_translate_init(void)
 {
     int i;
-    static int done_init = 0;
     static const char * const gregnames[24] = {
         "R0_BANK0", "R1_BANK0", "R2_BANK0", "R3_BANK0",
         "R4_BANK0", "R5_BANK0", "R6_BANK0", "R7_BANK0",
@@ -100,10 +99,6 @@ void sh4_translate_init(void)
         "FPR12_BANK1", "FPR13_BANK1", "FPR14_BANK1", "FPR15_BANK1",
     };
 
-    if (done_init) {
-        return;
-    }
-
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
@@ -163,8 +158,6 @@ void sh4_translate_init(void)
         cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
                                               offsetof(CPUSH4State, fregs[i]),
                                               fregnames[i]);
-
-    done_init = 1;
 }
 
 void superh_cpu_dump_state(CPUState *cs, FILE *f,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index beab90f3e6..47d0927707 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -784,10 +784,6 @@ static void sparc_cpu_initfn(Object *obj)
 
     cs->env_ptr = env;
 
-    if (tcg_enabled()) {
-        gen_intermediate_code_init(env);
-    }
-
     if (scc->cpu_def) {
         env->def = *scc->cpu_def;
     }
@@ -891,6 +887,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->vmsd = &vmstate_sparc_cpu;
 #endif
     cc->disas_set_info = cpu_sparc_disas_set_info;
+    cc->tcg_initialize = sparc_tcg_init;
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     cc->gdb_num_core_regs = 86;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 83a7d8e3ee..65939693d7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5857,9 +5857,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 #endif
 }
 
-void gen_intermediate_code_init(CPUSPARCState *env)
+void sparc_tcg_init(void)
 {
-    static int inited;
     static const char gregnames[32][4] = {
         "g0", "g1", "g2", "g3", "g4", "g5", "g6", "g7",
         "o0", "o1", "o2", "o3", "o4", "o5", "o6", "o7",
@@ -5912,12 +5911,6 @@ void gen_intermediate_code_init(CPUSPARCState *env)
 
     unsigned int i;
 
-    /* init various static tables */
-    if (inited) {
-        return;
-    }
-    inited = 1;
-
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 7345f5a8b5..2ef8ea7daa 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -103,14 +103,8 @@ static void tilegx_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     TileGXCPU *cpu = TILEGX_CPU(obj);
     CPUTLGState *env = &cpu->env;
-    static bool tcg_initialized;
 
     cs->env_ptr = env;
-
-    if (tcg_enabled() && !tcg_initialized) {
-        tcg_initialized = true;
-        tilegx_tcg_init();
-    }
 }
 
 static void tilegx_cpu_do_interrupt(CPUState *cs)
@@ -161,6 +155,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = tilegx_cpu_set_pc;
     cc->handle_mmu_fault = tilegx_cpu_handle_mmu_fault;
     cc->gdb_num_core_regs = 0;
+    cc->tcg_initialize = tilegx_tcg_init;
 }
 
 static const TypeInfo tilegx_cpu_type_info = {
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 871eb35453..cd93806d47 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -109,10 +109,6 @@ static void tricore_cpu_initfn(Object *obj)
     CPUTriCoreState *env = &cpu->env;
 
     cs->env_ptr = env;
-
-    if (tcg_enabled()) {
-        tricore_tcg_init();
-    }
 }
 
 static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
@@ -182,6 +178,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = tricore_cpu_set_pc;
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
     cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
+    cc->tcg_initialize = tricore_tcg_init;
 }
 
 static void cpu_register(const TriCoreCPUInfo *info)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4e4198e887..b6cfbdfa9f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8880,10 +8880,7 @@ static void tricore_tcg_init_csfr(void)
 void tricore_tcg_init(void)
 {
     int i;
-    static int inited;
-    if (inited) {
-        return;
-    }
+
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
     /* reg init */
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 138acc9dd8..526604ff78 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -117,7 +117,6 @@ static void uc32_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     UniCore32CPU *cpu = UNICORE32_CPU(obj);
     CPUUniCore32State *env = &cpu->env;
-    static bool inited;
 
     cs->env_ptr = env;
 
@@ -130,11 +129,6 @@ static void uc32_cpu_initfn(Object *obj)
 #endif
 
     tlb_flush(cs);
-
-    if (tcg_enabled() && !inited) {
-        inited = true;
-        uc32_translate_init();
-    }
 }
 
 static const VMStateDescription vmstate_uc32_cpu = {
@@ -162,6 +156,7 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
 #else
     cc->get_phys_page_debug = uc32_cpu_get_phys_page_debug;
 #endif
+    cc->tcg_initialize = uc32_translate_init;
     dc->vmsd = &vmstate_uc32_cpu;
 }
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index dcdc765a86..a5651e5dab 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -121,7 +121,6 @@ static void xtensa_cpu_initfn(Object *obj)
     XtensaCPU *cpu = XTENSA_CPU(obj);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
     CPUXtensaState *env = &cpu->env;
-    static bool tcg_inited;
 
     cs->env_ptr = env;
     env->config = xcc->config;
@@ -131,11 +130,6 @@ static void xtensa_cpu_initfn(Object *obj)
     memory_region_init_io(env->system_er, NULL, NULL, env, "er",
                           UINT64_C(0x100000000));
     address_space_init(env->address_space_er, env->system_er, "ER");
-
-    if (tcg_enabled() && !tcg_inited) {
-        tcg_inited = true;
-        xtensa_translate_init();
-    }
 }
 
 static const VMStateDescription vmstate_xtensa_cpu = {
@@ -170,6 +164,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_unassigned_access = xtensa_cpu_do_unassigned_access;
 #endif
     cc->debug_excp_handler = xtensa_breakpoint_handler;
+    cc->tcg_initialize = xtensa_translate_init;
     dc->vmsd = &vmstate_xtensa_cpu;
 }
 
-- 
2.13.6
