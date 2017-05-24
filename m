Received: from eggs.gnu.org ([2001:4830:134:3::10]:57360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSO-0007fr-FV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSM-00058z-KF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:40 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDeSM-00058U-Dr
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:38 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so28199676qkh.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:08:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 15:08:26 -0700
Message-Id: <20170524220827.21154-4-rth@twiddle.net>
In-Reply-To: <20170524220827.21154-1-rth@twiddle.net>
References: <20170524220827.21154-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 3/4] target/s390x: Implement EXECUTE via new
 TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Previously, helper_ex would construct the insn and then implement
the insn via direct calls other helpers.  This was sufficient to
boot Linux but that is all.

It is easy enough to go the whole nine yards by stashing state for
EXECUTE within the cpu, and then rely on a new TB to be created
that properly and completely interprets the insn.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h        |   4 +-
 target/s390x/helper.c     |   5 ++
 target/s390x/machine.c    |  19 ++++++++
 target/s390x/mem_helper.c | 118 +++++-----------------------------------------
 target/s390x/translate.c  |  80 ++++++++++++++++++-------------
 5 files changed, 85 insertions(+), 141 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4f38ba0..79235cf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -103,6 +103,8 @@ typedef struct CPUS390XState {
     uint64_t cc_dst;
     uint64_t cc_vr;
 
+    uint64_t ex_value;
+
     uint64_t __excp_addr;
     uint64_t psa;
 
@@ -391,7 +393,7 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->psw.addr;
-    *cs_base = 0;
+    *cs_base = env->ex_value;
     *flags = ((env->psw.mask >> 32) & ~FLAG_MASK_CC) |
              ((env->psw.mask & PSW_MASK_32) ? FLAG_MASK_32 : 0);
 }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 9978490..f01811f 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -642,6 +642,11 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         S390CPU *cpu = S390_CPU(cs);
         CPUS390XState *env = &cpu->env;
 
+        if (env->ex_value) {
+            /* Execution of the target insn is indivisible from
+               the parent EXECUTE insn.  */
+            return false;
+        }
         if (env->psw.mask & PSW_MASK_EXT) {
             s390_cpu_do_interrupt(cs);
             return true;
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 8503fa1..8f908bb 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -34,6 +34,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
     return 0;
 }
+
 static void cpu_pre_save(void *opaque)
 {
     S390CPU *cpu = opaque;
@@ -156,6 +157,23 @@ const VMStateDescription vmstate_riccb = {
     }
 };
 
+static bool exval_needed(void *opaque)
+{
+    S390CPU *cpu = opaque;
+    return cpu->env.ex_value != 0;
+}
+
+const VMStateDescription vmstate_exval = {
+    .name = "cpu/exval",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = exval_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.ex_value, S390CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .post_load = cpu_post_load,
@@ -188,6 +206,7 @@ const VMStateDescription vmstate_s390_cpu = {
         &vmstate_fpu,
         &vmstate_vregs,
         &vmstate_riccb,
+        &vmstate_exval,
         NULL
     },
 };
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d57d5b1..3a77edc 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -435,37 +435,6 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
     return d + len;
 }
 
-static uint32_t helper_icm(CPUS390XState *env, uint32_t r1, uint64_t address,
-                           uint32_t mask)
-{
-    int pos = 24; /* top of the lower half of r1 */
-    uint64_t rmask = 0xff000000ULL;
-    uint8_t val = 0;
-    int ccd = 0;
-    uint32_t cc = 0;
-
-    while (mask) {
-        if (mask & 8) {
-            env->regs[r1] &= ~rmask;
-            val = cpu_ldub_data(env, address);
-            if ((val & 0x80) && !ccd) {
-                cc = 1;
-            }
-            ccd = 1;
-            if (val && cc == 0) {
-                cc = 2;
-            }
-            env->regs[r1] |= (uint64_t)val << pos;
-            address++;
-        }
-        mask = (mask << 1) & 0xf;
-        pos -= 8;
-        rmask >>= 8;
-    }
-
-    return cc;
-}
-
 /* load access registers r1 to r3 from memory at a2 */
 void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
@@ -1222,19 +1191,17 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 }
 #endif
 
-/* execute instruction
-   this instruction executes an insn modified with the contents of r1
-   it does not change the executed instruction in memory
-   it does not change the program counter
-   in other words: tricky...
-   currently implemented by interpreting the cases it is most commonly used.
+/* Execute instruction.  This instruction executes an insn modified with
+   the contents of r1.  It does not change the executed instruction in memory;
+   it does not change the program counter.
+
+   Perform this by recording the modified instruction in env->ex_value.
+   This will be noticed by cpu_get_tb_cpu_state and thus tb translation.
 */
 void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t insn = cpu_lduw_code(env, addr);
     uint8_t opc = insn >> 8;
-    uint32_t cc;
 
     /* Or in the contents of R1[56:63].  */
     insn |= r1 & 0xff;
@@ -1254,72 +1221,9 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         g_assert_not_reached();
     }
 
-    HELPER_LOG("%s: addr 0x%lx insn 0x%" PRIx64 "\n", __func__, addr, insn);
-
-    if ((opc & 0xf0) == 0xd0) {
-        uint32_t l, b1, b2, d1, d2;
-
-        l = extract64(insn, 48, 8);
-        b1 = extract64(insn, 44, 4);
-        b2 = extract64(insn, 28, 4);
-        d1 = extract64(insn, 32, 12);
-        d2 = extract64(insn, 16, 12);
-
-        cc = env->cc_op;
-        switch (opc & 0xf) {
-        case 0x2:
-            do_helper_mvc(env, l, get_address(env, 0, b1, d1),
-                          get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x4:
-            cc = do_helper_nc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x5:
-            cc = do_helper_clc(env, l, get_address(env, 0, b1, d1),
-                               get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x6:
-            cc = do_helper_oc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0x7:
-            cc = do_helper_xc(env, l, get_address(env, 0, b1, d1),
-                              get_address(env, 0, b2, d2), 0);
-            break;
-        case 0xc:
-            do_helper_tr(env, l, get_address(env, 0, b1, d1),
-                         get_address(env, 0, b2, d2), 0);
-            break;
-        case 0xd:
-            cc = do_helper_trt(env, l, get_address(env, 0, b1, d1),
-                               get_address(env, 0, b2, d2), 0);
-            break;
-        default:
-            goto abort;
-        }
-    } else if (opc == 0x0a) {
-        /* supervisor call */
-        env->int_svc_code = extract64(insn, 48, 8);
-        env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
-        g_assert_not_reached();
-    } else if (opc == 0xbf) {
-        uint32_t r1, r3, b2, d2;
-
-        r1 = extract64(insn, 52, 4);
-        r3 = extract64(insn, 48, 4);
-        b2 = extract64(insn, 44, 4);
-        d2 = extract64(insn, 32, 12);
-        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
-    } else {
- abort:
-        cpu_abort(CPU(cpu),
-                  "EXECUTE on instruction prefix 0x%x not implemented\n",
-                  opc);
-        g_assert_not_reached();
-    }
-
-    env->cc_op = cc;
-    env->psw.addr += ilen;
+    /* Record the insn we want to execute as well as the ilen to use
+       during the execution of the target insn.  This will also ensure
+       that ex_value is non-zero, which flags that we are in a state
+       that requires such execution.  */
+    env->ex_value = insn | ilen;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 70212c8..97ca639 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -57,6 +57,7 @@ struct DisasContext {
     struct TranslationBlock *tb;
     const DisasInsn *insn;
     DisasFields *fields;
+    uint64_t ex_value;
     uint64_t pc, next_pc;
     uint32_t ilen;
     enum cc_op cc_op;
@@ -2186,23 +2187,18 @@ static ExitStatus op_epsw(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_ex(DisasContext *s, DisasOps *o)
 {
-    /* ??? Perhaps a better way to implement EXECUTE is to set a bit in
-       tb->flags, (ab)use the tb->cs_base field as the address of
-       the template in memory, and grab 8 bits of tb->flags/cflags for
-       the contents of the register.  We would then recognize all this
-       in gen_intermediate_code_internal, generating code for exactly
-       one instruction.  This new TB then gets executed normally.
-
-       On the other hand, this seems to be mostly used for modifying
-       MVC inside of memcpy, which needs a helper call anyway.  So
-       perhaps this doesn't bear thinking about any further.  */
-
     int r1 = get_field(s->fields, r1);
     TCGv_i32 ilen;
     TCGv_i64 v1;
 
+    /* Nested EXECUTE is not allowed.  */
+    if (unlikely(s->ex_value)) {
+        gen_program_exception(s, PGM_EXECUTE);
+        return EXIT_NORETURN;
+    }
+
     update_psw_addr(s);
-    gen_op_calc_cc(s);
+    update_cc_op(s);
 
     if (r1 == 0) {
         v1 = tcg_const_i64(0);
@@ -5190,25 +5186,36 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     int op, op2, ilen;
     const DisasInsn *info;
 
-    insn = ld_code2(env, pc);
-    op = (insn >> 8) & 0xff;
-    ilen = get_ilen(op);
-    s->next_pc = s->pc + ilen;
-    s->ilen = ilen;
+    if (unlikely(s->ex_value)) {
+        /* Drop the EX data now, so that it's clear on exception paths.  */
+        TCGv_i64 zero = tcg_const_i64(0);
+        tcg_gen_st_i64(zero, cpu_env, offsetof(CPUS390XState, ex_value));
+        tcg_temp_free_i64(zero);
 
-    switch (ilen) {
-    case 2:
-        insn = insn << 48;
-        break;
-    case 4:
-        insn = ld_code4(env, pc) << 32;
-        break;
-    case 6:
-        insn = (insn << 48) | (ld_code4(env, pc + 2) << 16);
-        break;
-    default:
-        abort();
+        /* Extract the values saved by EXECUTE.  */
+        insn = s->ex_value & 0xffffffffffff0000ull;
+        ilen = s->ex_value & 0xf;
+        op = insn >> 56;
+    } else {
+        insn = ld_code2(env, pc);
+        op = (insn >> 8) & 0xff;
+        ilen = get_ilen(op);
+        switch (ilen) {
+        case 2:
+            insn = insn << 48;
+            break;
+        case 4:
+            insn = ld_code4(env, pc) << 32;
+            break;
+        case 6:
+            insn = (insn << 48) | (ld_code4(env, pc + 2) << 16);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
+    s->next_pc = s->pc + ilen;
+    s->ilen = ilen;
 
     /* We can't actually determine the insn format until we've looked up
        the full insn opcode.  Which we can't do without locating the
@@ -5425,6 +5432,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     dc.tb = tb;
     dc.pc = pc_start;
     dc.cc_op = CC_OP_DYNAMIC;
+    dc.ex_value = tb->cs_base;
     do_debug = dc.singlestep_enabled = cs->singlestep_enabled;
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
@@ -5471,7 +5479,8 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
-                || cs->singlestep_enabled)) {
+                || cs->singlestep_enabled
+                || dc.ex_value)) {
             status = EXIT_PC_STALE;
         }
     } while (status == NO_EXIT);
@@ -5513,9 +5522,14 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc.pc - pc_start, 1);
-        qemu_log("\n");
+        if (unlikely(dc.ex_value)) {
+            /* ??? Unfortunately log_target_disas can't use host memory.  */
+            qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
+        } else {
+            qemu_log("IN: %s\n", lookup_symbol(pc_start));
+            log_target_disas(cs, pc_start, dc.pc - pc_start, 1);
+            qemu_log("\n");
+        }
         qemu_log_unlock();
     }
 #endif
-- 
2.9.4
