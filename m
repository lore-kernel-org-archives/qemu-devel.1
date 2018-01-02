Received: from eggs.gnu.org ([2001:4830:134:3::10]:35960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6I-0001Ve-1u
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6F-00053G-Su
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:41 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6F-000522-Hk
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:21 +0100
Message-Id: <20180102011032.30056-7-laurent@vivier.eu>
In-Reply-To: <20180102011032.30056-1-laurent@vivier.eu>
References: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 06/17] target/m68k: manage 680x0 stack frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

680x0 manages several stack frame formats:
  - format 0: four-word stack frame
  - format 1: four-word throwaway stack frame
  - format 2: six-word stack frame
  - format 3: Floating-Point post-instruction stack frame
  - format 4: eight-word stack frame
  - format 7: access-error stack frame

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/op_helper.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 3 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f899b4b086..0099a92c8c 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -54,7 +54,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     }
 }
 
-static void do_rte(CPUM68KState *env)
+static void cf_rte(CPUM68KState *env)
 {
     uint32_t sp;
     uint32_t fmt;
@@ -68,6 +68,45 @@ static void do_rte(CPUM68KState *env)
     helper_set_sr(env, fmt);
 }
 
+static void m68k_rte(CPUM68KState *env)
+{
+    uint32_t sp;
+    uint16_t fmt;
+    uint16_t sr;
+
+    sp = env->aregs[7];
+throwaway:
+    sr = cpu_lduw_kernel(env, sp);
+    sp += 2;
+    env->pc = cpu_ldl_kernel(env, sp);
+    sp += 4;
+    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
+        /*  all except 68000 */
+        fmt = cpu_lduw_kernel(env, sp);
+        sp += 2;
+        switch (fmt >> 12) {
+        case 0:
+            break;
+        case 1:
+            env->aregs[7] = sp;
+            helper_set_sr(env, sr);
+            goto throwaway;
+        case 2:
+        case 3:
+            sp += 4;
+            break;
+        case 4:
+            sp += 8;
+            break;
+        case 7:
+            sp += 52;
+            break;
+        }
+    }
+    env->aregs[7] = sp;
+    helper_set_sr(env, sr);
+}
+
 static const char *m68k_exception_name(int index)
 {
     switch (index) {
@@ -173,7 +212,7 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
-static void do_interrupt_all(CPUM68KState *env, int is_hw)
+static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = CPU(m68k_env_get_cpu(env));
     uint32_t sp;
@@ -188,7 +227,7 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
         switch (cs->exception_index) {
         case EXCP_RTE:
             /* Return from an exception.  */
-            do_rte(env);
+            cf_rte(env);
             return;
         case EXCP_HALT_INSN:
             if (semihosting_enabled()
@@ -246,6 +285,119 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
     env->pc = cpu_ldl_kernel(env, env->vbr + vector);
 }
 
+static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
+                                  uint16_t format, uint16_t sr,
+                                  uint32_t addr, uint32_t retaddr)
+{
+    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    switch (format) {
+    case 4:
+        *sp -= 4;
+        cpu_stl_kernel(env, *sp, env->pc);
+        *sp -= 4;
+        cpu_stl_kernel(env, *sp, addr);
+        break;
+    case 3:
+    case 2:
+        *sp -= 4;
+        cpu_stl_kernel(env, *sp, addr);
+        break;
+    }
+    *sp -= 2;
+    cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
+    *sp -= 4;
+    cpu_stl_kernel(env, *sp, retaddr);
+    *sp -= 2;
+    cpu_stw_kernel(env, *sp, sr);
+}
+
+static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
+{
+    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    uint32_t sp;
+    uint32_t retaddr;
+    uint32_t vector;
+    uint16_t sr, oldsr;
+
+    retaddr = env->pc;
+
+    if (!is_hw) {
+        switch (cs->exception_index) {
+        case EXCP_RTE:
+            /* Return from an exception.  */
+            m68k_rte(env);
+            return;
+        case EXCP_TRAP0 ...  EXCP_TRAP15:
+            /* Move the PC after the trap instruction.  */
+            retaddr += 2;
+            break;
+        }
+    }
+
+    vector = cs->exception_index << 2;
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        static int count;
+        qemu_log("INT %6d: %s(%#x) pc=%08x sp=%08x sr=%04x\n",
+                 ++count, m68k_exception_name(cs->exception_index),
+                 vector, env->pc, env->aregs[7], env->sr);
+    }
+
+    /*
+     * MC68040UM/AD,  chapter 9.3.10
+     */
+
+    sr = env->sr | cpu_m68k_get_ccr(env);
+    /* "the processor first make an internal copy" */
+    oldsr = sr;
+    /* "set the mode to supervisor" */
+    sr |= SR_S;
+    /* "suppress tracing" */
+    sr &= ~SR_T;
+    /* "sets the processor interrupt mask" */
+    if (is_hw) {
+        sr |= (env->sr & ~SR_I) | (env->pending_level << SR_I_SHIFT);
+    }
+    helper_set_sr(env, sr);
+    sp = env->aregs[7];
+
+    sp &= ~1;
+    if (cs->exception_index == EXCP_ADDRESS) {
+        do_stack_frame(env, &sp, 2, oldsr, 0, retaddr);
+    } else if (cs->exception_index == EXCP_ILLEGAL ||
+               cs->exception_index == EXCP_DIV0 ||
+               cs->exception_index == EXCP_CHK ||
+               cs->exception_index == EXCP_TRAPCC ||
+               cs->exception_index == EXCP_TRACE) {
+        /* FIXME: addr is not only env->pc */
+        do_stack_frame(env, &sp, 2, oldsr, env->pc, retaddr);
+    } else if (is_hw && oldsr & SR_M &&
+               cs->exception_index >= EXCP_SPURIOUS &&
+               cs->exception_index <= EXCP_INT_LEVEL_7) {
+        do_stack_frame(env, &sp, 0, oldsr, 0, retaddr);
+        oldsr = sr;
+        env->aregs[7] = sp;
+        helper_set_sr(env, sr &= ~SR_M);
+        sp = env->aregs[7] & ~1;
+        do_stack_frame(env, &sp, 1, oldsr, 0, retaddr);
+    } else {
+        do_stack_frame(env, &sp, 0, oldsr, 0, retaddr);
+    }
+
+    env->aregs[7] = sp;
+    /* Jump to vector.  */
+    env->pc = cpu_ldl_kernel(env, env->vbr + vector);
+}
+
+static void do_interrupt_all(CPUM68KState *env, int is_hw)
+{
+    if (m68k_feature(env, M68K_FEATURE_M68000)) {
+        m68k_interrupt_all(env, is_hw);
+        return;
+    }
+    cf_interrupt_all(env, is_hw);
+}
+
 void m68k_cpu_do_interrupt(CPUState *cs)
 {
     M68kCPU *cpu = M68K_CPU(cs);
-- 
2.14.3
