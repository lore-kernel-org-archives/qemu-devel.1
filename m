Received: from eggs.gnu.org ([2001:4830:134:3::10]:52341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBO-00074Q-PJ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBN-00037j-1C
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:22 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBM-00036w-Mg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:20 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:40:58 +0100
Message-Id: <20180102234108.32713-8-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

chk and chk2 compare a value to boundaries, and
trigger a CHK exception if the value is out of bounds.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---

Notes:
    v6: use helpers as suggested by Richard

 linux-user/main.c       |  7 +++++
 target/m68k/cpu.c       |  2 ++
 target/m68k/cpu.h       |  1 +
 target/m68k/helper.h    |  3 ++
 target/m68k/op_helper.c | 37 +++++++++++++++++++++++
 target/m68k/translate.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 71696ed33d..99a551b04f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2985,6 +2985,13 @@ void cpu_loop(CPUM68KState *env)
             info._sifields._sigfault._addr = env->pc;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_CHK:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_INTOVF;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_DIV0:
             info.si_signo = TARGET_SIGFPE;
             info.si_errno = 0;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0a3dd83548..57ffcb2114 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -134,6 +134,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CAS);
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
+    m68k_set_feature(env, M68K_FEATURE_CHK2);
 }
 #define m68030_cpu_initfn m68020_cpu_initfn
 #define m68040_cpu_initfn m68020_cpu_initfn
@@ -156,6 +157,7 @@ static void m68060_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CAS);
     m68k_set_feature(env, M68K_FEATURE_BKPT);
     m68k_set_feature(env, M68K_FEATURE_RTD);
+    m68k_set_feature(env, M68K_FEATURE_CHK2);
 }
 
 static void m5208_cpu_initfn(Object *obj)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cd4b3a7c7b..68396bdd70 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -305,6 +305,7 @@ enum m68k_features {
     M68K_FEATURE_CAS,
     M68K_FEATURE_BKPT,
     M68K_FEATURE_RTD,
+    M68K_FEATURE_CHK2,
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index eebe52dae5..78483da003 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -94,3 +94,6 @@ DEF_HELPER_FLAGS_4(bfchg_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfclr_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfset_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
+
+DEF_HELPER_3(chk, void, env, s32, s32)
+DEF_HELPER_4(chk2, void, env, s32, s32, s32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 5c7b27b9ca..38f4746563 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -947,3 +947,40 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
        is already zero.  */
     return n | ffo;
 }
+
+void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
+{
+    if (val < 0 || val > ub) {
+        CPUState *cs = CPU(m68k_env_get_cpu(env));
+
+        /* Recover PC and CC_OP for the beginning of the insn.  */
+        cpu_restore_state(cs, GETPC());
+
+        /* Adjust PC and FLAGS to end of the insn.  */
+        env->pc += 2;
+        helper_flush_flags(env, env->cc_op);
+        env->cc_n = val;
+
+        cs->exception_index = EXCP_CHK;
+        cpu_loop_exit(cs);
+    }
+}
+
+void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
+{
+    helper_flush_flags(env, env->cc_op);
+
+    env->cc_z = val != lb && val != ub;
+    env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
+
+    if (env->cc_c) {
+        CPUState *cs = CPU(m68k_env_get_cpu(env));
+
+        cpu_restore_state(cs, GETPC());
+        env->cc_op = CC_OP_FLAGS;
+        env->pc += 4;
+
+        cs->exception_index = EXCP_CHK;
+        cpu_loop_exit(cs);
+    }
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a1e424e3db..62e955abc7 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4203,6 +4203,81 @@ DISAS_INSN(ff1)
     gen_helper_ff1(reg, reg);
 }
 
+DISAS_INSN(chk)
+{
+    TCGv src, reg;
+    int opsize;
+
+    switch ((insn >> 7) & 3) {
+    case 3:
+        opsize = OS_WORD;
+        break;
+    case 2:
+        if (m68k_feature(env, M68K_FEATURE_CHK2)) {
+            opsize = OS_LONG;
+            break;
+        }
+        /* fallthru */
+    default:
+        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        return;
+    }
+    SRC_EA(env, src, opsize, 1, NULL);
+    reg = gen_extend(DREG(insn, 9), opsize, 1);
+
+    gen_helper_chk(cpu_env, reg, src);
+}
+
+DISAS_INSN(chk2)
+{
+    uint16_t ext;
+    TCGv addr1, addr2, bound1, bound2, reg;
+    int opsize;
+
+    switch ((insn >> 9) & 3) {
+    case 0:
+        opsize = OS_BYTE;
+        break;
+    case 1:
+        opsize = OS_WORD;
+        break;
+    case 2:
+        opsize = OS_LONG;
+        break;
+    default:
+        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        return;
+    }
+
+    ext = read_im16(env, s);
+    if ((ext & 0x0800) == 0) {
+        gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+        return;
+    }
+
+    addr1 = gen_lea(env, s, insn, OS_UNSIZED);
+    addr2 = tcg_temp_new();
+    tcg_gen_addi_i32(addr2, addr1, opsize_bytes(opsize));
+
+    bound1 = gen_load(s, opsize, addr1, 1);
+    tcg_temp_free(addr1);
+    bound2 = gen_load(s, opsize, addr2, 1);
+    tcg_temp_free(addr2);
+
+    reg = tcg_temp_new();
+    if (ext & 0x8000) {
+        tcg_gen_mov_i32(reg, AREG(ext, 12));
+    } else {
+        gen_ext(reg, DREG(ext, 12), opsize, 1);
+    }
+
+    gen_helper_chk2(cpu_env, reg, bound1, bound2);
+    tcg_temp_free(reg);
+    /* Note that chk2 also assigned to env->cc_op.  */
+    s->cc_op = CC_OP_FLAGS;
+    s->cc_op_synced = 1;
+}
+
 static TCGv gen_get_sr(DisasContext *s)
 {
     TCGv ccr;
@@ -5306,7 +5381,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(undef,     0000, 0000);
     INSN(arith_im,  0080, fff8, CF_ISA_A);
     INSN(arith_im,  0000, ff00, M68000);
-    INSN(undef,     00c0, ffc0, M68000);
+    INSN(chk2,      00c0, f9c0, CHK2);
     INSN(bitrev,    00c0, fff8, CF_ISA_APLUSC);
     BASE(bitop_reg, 0100, f1c0);
     BASE(bitop_reg, 0140, f1c0);
@@ -5339,6 +5414,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(move,      1000, f000);
     BASE(move,      2000, f000);
     BASE(move,      3000, f000);
+    INSN(chk,       4000, f040, M68000);
     INSN(strldsr,   40e7, ffff, CF_ISA_APLUSC);
     INSN(negx,      4080, fff8, CF_ISA_A);
     INSN(negx,      4000, ff00, M68000);
-- 
2.14.3
