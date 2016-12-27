Received: from eggs.gnu.org ([2001:4830:134:3::10]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwz-0008VN-TO
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwv-00007K-F6
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:13 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cLvwv-00006x-2c
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:09 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Dec 2016 18:53:54 +0100
Message-Id: <1482861241-17678-6-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
References: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 05/12] target-m68k: add 680x0 divu/divs
 variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Update helper to set the throwing location in case of div-by-0.
Cleanup divX.w and add quad word variants of divX.l.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twidle.net>
[laurent: modified to clear Z on overflow, as found with risu]
---
 linux-user/main.c       |   7 ++
 target/m68k/cpu.h       |   4 --
 target/m68k/helper.h    |   8 ++-
 target/m68k/op_helper.c | 183 +++++++++++++++++++++++++++++++++++++++++-------
 target/m68k/qregs.def   |   2 -
 target/m68k/translate.c |  84 ++++++++++++----------
 6 files changed, 218 insertions(+), 70 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 75b199f..c1d5eb4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2864,6 +2864,13 @@ void cpu_loop(CPUM68KState *env)
             info._sifields._sigfault._addr = env->pc;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_DIV0:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_INTDIV;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_TRAP0:
             {
                 abi_long ret;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 6dfb54e..0b4ed7b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -95,10 +95,6 @@ typedef struct CPUM68KState {
     uint32_t macsr;
     uint32_t mac_mask;
 
-    /* Temporary storage for DIV helpers.  */
-    uint32_t div1;
-    uint32_t div2;
-
     /* MMU status.  */
     struct {
         uint32_t ar;
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 2697e32..6180dc5 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -1,8 +1,12 @@
 DEF_HELPER_1(bitrev, i32, i32)
 DEF_HELPER_1(ff1, i32, i32)
 DEF_HELPER_FLAGS_2(sats, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_2(divu, void, env, i32)
-DEF_HELPER_2(divs, void, env, i32)
+DEF_HELPER_3(divuw, void, env, int, i32)
+DEF_HELPER_3(divsw, void, env, int, s32)
+DEF_HELPER_4(divul, void, env, int, int, i32)
+DEF_HELPER_4(divsl, void, env, int, int, s32)
+DEF_HELPER_4(divull, void, env, int, int, i32)
+DEF_HELPER_4(divsll, void, env, int, int, s32)
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
 DEF_HELPER_3(shr_cc, i32, env, i32, i32)
 DEF_HELPER_3(sar_cc, i32, env, i32, i32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 48e02e4..04246a9 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -166,12 +166,17 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-static void raise_exception(CPUM68KState *env, int tt)
+static void raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
 {
     CPUState *cs = CPU(m68k_env_get_cpu(env));
 
     cs->exception_index = tt;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_restore(cs, raddr);
+}
+
+static void raise_exception(CPUM68KState *env, int tt)
+{
+    raise_exception_ra(env, tt, 0);
 }
 
 void HELPER(raise_exception)(CPUM68KState *env, uint32_t tt)
@@ -179,51 +184,179 @@ void HELPER(raise_exception)(CPUM68KState *env, uint32_t tt)
     raise_exception(env, tt);
 }
 
-void HELPER(divu)(CPUM68KState *env, uint32_t word)
+void HELPER(divuw)(CPUM68KState *env, int destr, uint32_t den)
 {
-    uint32_t num;
-    uint32_t den;
-    uint32_t quot;
-    uint32_t rem;
+    uint32_t num = env->dregs[destr];
+    uint32_t quot, rem;
+
+    if (den == 0) {
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
+    }
+    quot = num / den;
+    rem = num % den;
+
+    env->cc_c = 0; /* always cleared, even if overflow */
+    if (quot > 0xffff) {
+        env->cc_v = -1;
+        /* real 68040 keeps N and unset Z on overflow,
+         * whereas documentation says "undefined"
+         */
+        env->cc_z = 1;
+        return;
+    }
+    env->dregs[destr] = deposit32(quot, 16, 16, rem);
+    env->cc_z = (int16_t)quot;
+    env->cc_n = (int16_t)quot;
+    env->cc_v = 0;
+}
+
+void HELPER(divsw)(CPUM68KState *env, int destr, int32_t den)
+{
+    int32_t num = env->dregs[destr];
+    uint32_t quot, rem;
 
-    num = env->div1;
-    den = env->div2;
-    /* ??? This needs to make sure the throwing location is accurate.  */
     if (den == 0) {
-        raise_exception(env, EXCP_DIV0);
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
     }
     quot = num / den;
     rem = num % den;
 
-    env->cc_v = (word && quot > 0xffff ? -1 : 0);
+    env->cc_c = 0; /* always cleared, even if overflow */
+    if (quot != (int16_t)quot) {
+        env->cc_v = -1;
+        /* nothing else is modified */
+        /* real 68040 keeps N and unset Z on overflow,
+         * whereas documentation says "undefined"
+         */
+        env->cc_z = 1;
+        return;
+    }
+    env->dregs[destr] = deposit32(quot, 16, 16, rem);
+    env->cc_z = (int16_t)quot;
+    env->cc_n = (int16_t)quot;
+    env->cc_v = 0;
+}
+
+void HELPER(divul)(CPUM68KState *env, int numr, int regr, uint32_t den)
+{
+    uint32_t num = env->dregs[numr];
+    uint32_t quot, rem;
+
+    if (den == 0) {
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
+    }
+    quot = num / den;
+    rem = num % den;
+
+    env->cc_c = 0;
     env->cc_z = quot;
     env->cc_n = quot;
+    env->cc_v = 0;
+
+    if (m68k_feature(env, M68K_FEATURE_CF_ISA_A)) {
+        if (numr == regr) {
+            env->dregs[numr] = quot;
+        } else {
+            env->dregs[regr] = rem;
+        }
+    } else {
+        env->dregs[regr] = rem;
+        env->dregs[numr] = quot;
+    }
+}
+
+void HELPER(divsl)(CPUM68KState *env, int numr, int regr, int32_t den)
+{
+    int32_t num = env->dregs[numr];
+    int32_t quot, rem;
+
+    if (den == 0) {
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
+    }
+    quot = num / den;
+    rem = num % den;
+
     env->cc_c = 0;
+    env->cc_z = quot;
+    env->cc_n = quot;
+    env->cc_v = 0;
+
+    if (m68k_feature(env, M68K_FEATURE_CF_ISA_A)) {
+        if (numr == regr) {
+            env->dregs[numr] = quot;
+        } else {
+            env->dregs[regr] = rem;
+        }
+    } else {
+        env->dregs[regr] = rem;
+        env->dregs[numr] = quot;
+    }
+}
+
+void HELPER(divull)(CPUM68KState *env, int numr, int regr, uint32_t den)
+{
+    uint64_t num = deposit64(env->dregs[numr], 32, 32, env->dregs[regr]);
+    uint64_t quot;
+    uint32_t rem;
+
+    if (den == 0) {
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
+    }
+    quot = num / den;
+    rem = num % den;
 
-    env->div1 = quot;
-    env->div2 = rem;
+    env->cc_c = 0; /* always cleared, even if overflow */
+    if (quot > 0xffffffffULL) {
+        env->cc_v = -1;
+        /* real 68040 keeps N and unset Z on overflow,
+         * whereas documentation says "undefined"
+         */
+        env->cc_z = 1;
+        return;
+    }
+    env->cc_z = quot;
+    env->cc_n = quot;
+    env->cc_v = 0;
+
+    /*
+     * If Dq and Dr are the same, the quotient is returned.
+     * therefore we set Dq last.
+     */
+
+    env->dregs[regr] = rem;
+    env->dregs[numr] = quot;
 }
 
-void HELPER(divs)(CPUM68KState *env, uint32_t word)
+void HELPER(divsll)(CPUM68KState *env, int numr, int regr, int32_t den)
 {
-    int32_t num;
-    int32_t den;
-    int32_t quot;
+    int64_t num = deposit64(env->dregs[numr], 32, 32, env->dregs[regr]);
+    int64_t quot;
     int32_t rem;
 
-    num = env->div1;
-    den = env->div2;
     if (den == 0) {
-        raise_exception(env, EXCP_DIV0);
+        raise_exception_ra(env, EXCP_DIV0, GETPC());
     }
     quot = num / den;
     rem = num % den;
 
-    env->cc_v = (word && quot != (int16_t)quot ? -1 : 0);
+    env->cc_c = 0; /* always cleared, even if overflow */
+    if (quot != (int32_t)quot) {
+        env->cc_v = -1;
+        /* real 68040 keeps N and unset Z on overflow,
+         * whereas documentation says "undefined"
+         */
+        env->cc_z = 1;
+        return;
+    }
     env->cc_z = quot;
     env->cc_n = quot;
-    env->cc_c = 0;
+    env->cc_v = 0;
+
+    /*
+     * If Dq and Dr are the same, the quotient is returned.
+     * therefore we set Dq last.
+     */
 
-    env->div1 = quot;
-    env->div2 = rem;
+    env->dregs[regr] = rem;
+    env->dregs[numr] = quot;
 }
diff --git a/target/m68k/qregs.def b/target/m68k/qregs.def
index 156c0f5..51ff43b 100644
--- a/target/m68k/qregs.def
+++ b/target/m68k/qregs.def
@@ -7,7 +7,5 @@ DEFO32(CC_C, cc_c)
 DEFO32(CC_N, cc_n)
 DEFO32(CC_V, cc_v)
 DEFO32(CC_Z, cc_z)
-DEFO32(DIV1, div1)
-DEFO32(DIV2, div2)
 DEFO32(MACSR, macsr)
 DEFO32(MAC_MASK, mac_mask)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6678b57..737009e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1242,64 +1242,74 @@ DISAS_INSN(mulw)
 
 DISAS_INSN(divw)
 {
-    TCGv reg;
-    TCGv tmp;
-    TCGv src;
     int sign;
+    TCGv src;
+    TCGv destr;
+
+    /* divX.w <EA>,Dn    32/16 -> 16r:16q */
 
     sign = (insn & 0x100) != 0;
-    reg = DREG(insn, 9);
-    if (sign) {
-        tcg_gen_ext16s_i32(QREG_DIV1, reg);
-    } else {
-        tcg_gen_ext16u_i32(QREG_DIV1, reg);
-    }
+
+    /* dest.l / src.w */
+
     SRC_EA(env, src, OS_WORD, sign, NULL);
-    tcg_gen_mov_i32(QREG_DIV2, src);
+    destr = tcg_const_i32(REG(insn, 9));
     if (sign) {
-        gen_helper_divs(cpu_env, tcg_const_i32(1));
+        gen_helper_divsw(cpu_env, destr, src);
     } else {
-        gen_helper_divu(cpu_env, tcg_const_i32(1));
+        gen_helper_divuw(cpu_env, destr, src);
     }
-
-    tmp = tcg_temp_new();
-    src = tcg_temp_new();
-    tcg_gen_ext16u_i32(tmp, QREG_DIV1);
-    tcg_gen_shli_i32(src, QREG_DIV2, 16);
-    tcg_gen_or_i32(reg, tmp, src);
+    tcg_temp_free(destr);
 
     set_cc_op(s, CC_OP_FLAGS);
 }
 
 DISAS_INSN(divl)
 {
-    TCGv num;
-    TCGv den;
-    TCGv reg;
+    TCGv num, reg, den;
+    int sign;
     uint16_t ext;
 
     ext = read_im16(env, s);
-    if (ext & 0x87f8) {
-        gen_exception(s, s->pc - 4, EXCP_UNSUPPORTED);
+
+    sign = (ext & 0x0800) != 0;
+
+    if (ext & 0x400) {
+        if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
+            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            return;
+        }
+
+        /* divX.l <EA>, Dr:Dq    64/32 -> 32r:32q */
+
+        SRC_EA(env, den, OS_LONG, 0, NULL);
+        num = tcg_const_i32(REG(ext, 12));
+        reg = tcg_const_i32(REG(ext, 0));
+        if (sign) {
+            gen_helper_divsll(cpu_env, num, reg, den);
+        } else {
+            gen_helper_divull(cpu_env, num, reg, den);
+        }
+        tcg_temp_free(reg);
+        tcg_temp_free(num);
+        set_cc_op(s, CC_OP_FLAGS);
         return;
     }
-    num = DREG(ext, 12);
-    reg = DREG(ext, 0);
-    tcg_gen_mov_i32(QREG_DIV1, num);
+
+    /* divX.l <EA>, Dq        32/32 -> 32q     */
+    /* divXl.l <EA>, Dr:Dq    32/32 -> 32r:32q */
+
     SRC_EA(env, den, OS_LONG, 0, NULL);
-    tcg_gen_mov_i32(QREG_DIV2, den);
-    if (ext & 0x0800) {
-        gen_helper_divs(cpu_env, tcg_const_i32(0));
-    } else {
-        gen_helper_divu(cpu_env, tcg_const_i32(0));
-    }
-    if ((ext & 7) == ((ext >> 12) & 7)) {
-        /* div */
-        tcg_gen_mov_i32 (reg, QREG_DIV1);
+    num = tcg_const_i32(REG(ext, 12));
+    reg = tcg_const_i32(REG(ext, 0));
+    if (sign) {
+        gen_helper_divsl(cpu_env, num, reg, den);
     } else {
-        /* rem */
-        tcg_gen_mov_i32 (reg, QREG_DIV2);
+        gen_helper_divul(cpu_env, num, reg, den);
     }
+    tcg_temp_free(reg);
+    tcg_temp_free(num);
+
     set_cc_op(s, CC_OP_FLAGS);
 }
 
-- 
2.7.4
