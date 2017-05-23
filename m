Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06V-0005ZF-Ad
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06T-0003gY-Bw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06T-0003gN-6H
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so20683400qte.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:21 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:43 -0700
Message-Id: <20170523030312.6360-3-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via new
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

Previously, helper_ex would construct the insn and then implement
the insn via direct calls other helpers.  This was sufficient to
boot Linux but that is all.

It is easy enough to go the whole nine yards by stashing state for
EXECUTE within the cpu, and then relying on a new TB to be created
that properly and completely interprets the insn.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h         |   4 +-
 target/s390x/helper.h      |   2 +-
 target/s390x/insn-data.def |   4 +-
 target/s390x/machine.c     |  19 +++++++
 target/s390x/mem_helper.c  | 136 +++++++++++----------------------------------
 target/s390x/translate.c   | 124 +++++++++++++++++++++++++----------------
 6 files changed, 133 insertions(+), 156 deletions(-)

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
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1fae191..d6cc513 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -14,7 +14,7 @@ DEF_HELPER_4(srst, i64, env, i64, i64, i64)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_4(mvpg, void, env, i64, i64, i64)
 DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
-DEF_HELPER_5(ex, i32, env, i32, i64, i64, i64)
+DEF_HELPER_FLAGS_4(ex, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_4(mvcle, i32, env, i32, i64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index cac0f51..3c3541c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -327,9 +327,9 @@
     C(0xeb57, XIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, xor, nz64)
 
 /* EXECUTE */
-    C(0x4400, EX,      RX_a,  Z,   r1_o, a2, 0, 0, ex, 0)
+    C(0x4400, EX,      RX_a,  Z,   0, a2, 0, 0, ex, 0)
 /* EXECUTE RELATIVE LONG */
-    C(0xc600, EXRL,    RIL_b, EE,  r1_o, ri2, 0, 0, ex, 0)
+    C(0xc600, EXRL,    RIL_b, EE,  0, ri2, 0, 0, ex, 0)
 
 /* EXTRACT ACCESS */
     C(0xb24f, EAR,     RRE,   Z,   0, 0, new, r1_32, ear, 0)
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
index e3325a4..db80d53 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -405,115 +405,41 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
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
+/* Execute instruction.  This instruction executes an insn modified with
+   the contents of r1.  It does not change the executed instruction in memory;
+   it does not change the program counter.
 
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
-/* execute instruction
-   this instruction executes an insn modified with the contents of r1
-   it does not change the executed instruction in memory
-   it does not change the program counter
-   in other words: tricky...
-   currently implemented by interpreting the cases it is most commonly used in
+   Perform this by recording the modified instruction in env->ex_value.
+   This will be noticed by cpu_get_tb_cpu_state and thus tb translation.
 */
-uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
-                    uint64_t addr, uint64_t ret)
+void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t v1, uint64_t addr)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
-    uint16_t insn = cpu_lduw_code(env, addr);
-
-    HELPER_LOG("%s: v1 0x%lx addr 0x%lx insn 0x%x\n", __func__, v1, addr,
-               insn);
-    if ((insn & 0xf0ff) == 0xd000) {
-        uint32_t l, insn2, b1, b2, d1, d2;
-
-        l = v1 & 0xff;
-        insn2 = cpu_ldl_code(env, addr + 2);
-        b1 = (insn2 >> 28) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d1 = (insn2 >> 16) & 0xfff;
-        d2 = insn2 & 0xfff;
-        switch (insn & 0xf00) {
-        case 0x200:
-            helper_mvc(env, l, get_address(env, 0, b1, d1),
-                       get_address(env, 0, b2, d2));
-            break;
-        case 0x400:
-            cc = helper_nc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x500:
-            cc = helper_clc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x600:
-            cc = helper_oc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        case 0x700:
-            cc = helper_xc(env, l, get_address(env, 0, b1, d1),
-                           get_address(env, 0, b2, d2));
-            break;
-        case 0xc00:
-            helper_tr(env, l, get_address(env, 0, b1, d1),
-                      get_address(env, 0, b2, d2));
-            break;
-        case 0xd00:
-            cc = helper_trt(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
-            break;
-        default:
-            goto abort;
-        }
-    } else if ((insn & 0xff00) == 0x0a00) {
-        /* supervisor call */
-        HELPER_LOG("%s: svc %ld via execute\n", __func__, (insn | v1) & 0xff);
-        env->psw.addr = ret - 4;
-        env->int_svc_code = (insn | v1) & 0xff;
-        env->int_svc_ilen = 4;
-        helper_exception(env, EXCP_SVC);
-    } else if ((insn & 0xff00) == 0xbf00) {
-        uint32_t insn2, r1, r3, b2, d2;
-
-        insn2 = cpu_ldl_code(env, addr + 2);
-        r1 = (insn2 >> 20) & 0xf;
-        r3 = (insn2 >> 16) & 0xf;
-        b2 = (insn2 >> 12) & 0xf;
-        d2 = insn2 & 0xfff;
-        cc = helper_icm(env, r1, get_address(env, 0, b2, d2), r3);
-    } else {
-    abort:
-        cpu_abort(CPU(cpu), "EXECUTE on instruction prefix 0x%x not implemented\n",
-                  insn);
+    uintptr_t ra = GETPC();
+    uint64_t insn = cpu_lduw_code_ra(env, addr, ra);
+
+    /* Or in the contents of R1[56:63].  */
+    insn |= v1 & 0xff;
+
+    /* Load the rest of the instruction.  */
+    insn <<= 48;
+    switch (get_ilen(insn >> 56)) {
+    case 2:
+        break;
+    case 4:
+        insn |= (uint64_t)cpu_lduw_code_ra(env, addr + 2, ra) << 32;
+        break;
+    case 6:
+        insn |= (uint64_t)(uint32_t)cpu_ldl_code_ra(env, addr + 2, ra) << 16;
+        break;
+    default:
+        g_assert_not_reached();
     }
-    return cc;
+
+    /* Record the insn we want to execute as well as the ilen to use
+       during the execution of the target insn.  This will also ensure
+       that ex_value is non-zero, which flags that we are in a state
+       that requires such execution.  */
+    env->ex_value = insn | ilen;
 }
 
 /* load access registers r1 to r3 from memory at a2 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d6736e4..3a72c38 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -57,7 +57,9 @@ struct DisasContext {
     struct TranslationBlock *tb;
     const DisasInsn *insn;
     DisasFields *fields;
+    uint64_t ex_value;
     uint64_t pc, next_pc;
+    uint32_t ilen;
     enum cc_op cc_op;
     bool singlestep_enabled;
 };
@@ -349,7 +351,7 @@ static void gen_program_exception(DisasContext *s, int code)
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_code));
     tcg_temp_free_i32(tmp);
 
-    tmp = tcg_const_i32(s->next_pc - s->pc);
+    tmp = tcg_const_i32(s->ilen);
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_ilen));
     tcg_temp_free_i32(tmp);
 
@@ -2153,27 +2155,30 @@ static ExitStatus op_epsw(DisasContext *s, DisasOps *o)
 
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
-    TCGv_i64 tmp;
+    int r1 = get_field(s->fields, r1);
+    TCGv_i32 ilen;
+    TCGv v1;
 
-    update_psw_addr(s);
-    gen_op_calc_cc(s);
+    /* Nested EXECUTE is not allowed.  */
+    if (unlikely(s->ex_value)) {
+        gen_program_exception(s, PGM_EXECUTE);
+        return EXIT_NORETURN;
+    }
 
-    tmp = tcg_const_i64(s->next_pc);
-    gen_helper_ex(cc_op, cpu_env, cc_op, o->in1, o->in2, tmp);
-    tcg_temp_free_i64(tmp);
+    if (r1 == 0) {
+        v1 = tcg_const_i64(0);
+    } else {
+        v1 = regs[r1];
+    }
+    ilen = tcg_const_i32(s->ilen);
+    gen_helper_ex(cpu_env, ilen, v1, o->in2);
+    tcg_temp_free_i32(ilen);
+    if (r1 == 0) {
+        tcg_temp_free_i64(v1);
+    }
 
-    return NO_EXIT;
+    /* End the TB; a new TB will be created for modified insn.  */
+    return EXIT_PC_STALE;
 }
 
 static ExitStatus op_fieb(DisasContext *s, DisasOps *o)
@@ -4027,7 +4032,7 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_code));
     tcg_temp_free_i32(t);
 
-    t = tcg_const_i32(s->next_pc - s->pc);
+    t = tcg_const_i32(s->ilen);
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_ilen));
     tcg_temp_free_i32(t);
 
@@ -5169,23 +5174,38 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     int op, op2, ilen;
     const DisasInsn *info;
 
-    insn = ld_code2(env, pc);
-    op = (insn >> 8) & 0xff;
-    ilen = get_ilen(op);
-    s->next_pc = s->pc + ilen;
-
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
+    if (unlikely(s->ex_value)) {
+        /* Drop the EX data now, so that it's clear on exception paths.  */
+        TCGv_i64 zero = tcg_const_i64(0);
+        tcg_gen_st_i64(zero, cpu_env, offsetof(CPUS390XState, ex_value));
+        tcg_temp_free_i64(zero);
+
+        /* Extract the values saved by EXECUTE.  */
+        insn = s->ex_value & 0xffffffffffff0000ull;
+        ilen = s->ex_value & 0xff;
+        op = insn >> 56;
+        s->ilen = ilen;
+        s->next_pc = s->pc;
+    } else {
+        insn = ld_code2(env, pc);
+        op = (insn >> 8) & 0xff;
+        ilen = get_ilen(op);
+        s->ilen = ilen;
+        s->next_pc = s->pc + ilen;
+
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
 
     /* We can't actually determine the insn format until we've looked up
@@ -5403,6 +5423,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     dc.tb = tb;
     dc.pc = pc_start;
     dc.cc_op = CC_OP_DYNAMIC;
+    dc.ex_value = tb->cs_base;
     do_debug = dc.singlestep_enabled = cs->singlestep_enabled;
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
@@ -5444,13 +5465,17 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
-        if (status == NO_EXIT
-            && (dc.pc >= next_page_start
-                || tcg_op_buf_full()
-                || num_insns >= max_insns
-                || singlestep
-                || cs->singlestep_enabled)) {
-            status = EXIT_PC_STALE;
+        if (status == NO_EXIT) {
+            if (unlikely(dc.ex_value)) {
+                /* The PC on entry is already advanced.  */
+                status = EXIT_PC_UPDATED;
+            } else if (dc.pc >= next_page_start
+                       || tcg_op_buf_full()
+                       || num_insns >= max_insns
+                       || singlestep
+                       || cs->singlestep_enabled) {
+                status = EXIT_PC_STALE;
+            }
         }
     } while (status == NO_EXIT);
 
@@ -5489,9 +5514,14 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
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
