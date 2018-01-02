Received: from eggs.gnu.org ([2001:4830:134:3::10]:36005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6I-0001W5-WF
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6G-00053c-Bg
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:42 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6G-00052V-1X
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:40 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:22 +0100
Message-Id: <20180102011032.30056-8-laurent@vivier.eu>
In-Reply-To: <20180102011032.30056-1-laurent@vivier.eu>
References: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 07/17] target/m68k: add chk and chk2
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

chk and chk2 compares a value to boundaries, and
triggers a CHK exception if the values is out of bounds.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c       |   7 +++
 target/m68k/cpu.c       |   2 +
 target/m68k/cpu.h       |   1 +
 target/m68k/translate.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 146 insertions(+), 1 deletion(-)

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
index acc2629216..42c358d1a7 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -304,6 +304,7 @@ enum m68k_features {
     M68K_FEATURE_CAS,
     M68K_FEATURE_BKPT,
     M68K_FEATURE_RTD,
+    M68K_FEATURE_CHK2,
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a1e424e3db..6ef4c3a53c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4203,6 +4203,140 @@ DISAS_INSN(ff1)
     gen_helper_ff1(reg, reg);
 }
 
+DISAS_INSN(chk)
+{
+    TCGv tsrc, src, reg;
+    int opsize;
+    TCGLabel *l1, *l2;
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
+    SRC_EA(env, tsrc, opsize, 1, NULL);
+    src = tcg_temp_local_new();
+    tcg_gen_mov_i32(src, tsrc);
+
+    reg = tcg_temp_local_new();
+    gen_ext(reg, DREG(insn, 9), opsize, 1);
+    gen_flush_flags(s);
+    update_cc_op(s);
+
+    l1 = gen_new_label();
+    l2 = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_GE, reg, 0, l1);
+    tcg_gen_movi_i32(QREG_CC_N, -1);
+    tcg_gen_movi_i32(QREG_PC, s->pc);
+    gen_raise_exception(EXCP_CHK);
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_brcond_i32(TCG_COND_LE, reg, src, l2);
+    tcg_gen_movi_i32(QREG_CC_N, 0);
+    tcg_gen_movi_i32(QREG_PC, s->pc);
+    gen_raise_exception(EXCP_CHK);
+    gen_set_label(l2);
+    tcg_temp_free(src);
+    tcg_temp_free(reg);
+}
+
+DISAS_INSN(chk2)
+{
+    uint16_t ext;
+    TCGv addr1, addr2, bound1, bound2, res1, res2, reg, one, tmp;
+    int opsize;
+    TCGLabel *l1;
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
+    gen_flush_flags(s);
+
+    /* Z is set if reg is equal to either bound, cleared otherwise,
+     * QREG_CC_Z is 0 if Z is true, 1 if Z if false
+     */
+    tmp = tcg_const_i32(0);
+    tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_Z, reg, bound1);
+    tcg_gen_movcond_i32(TCG_COND_EQ, QREG_CC_Z, reg, bound2, tmp, QREG_CC_Z);
+
+    /* from real m68040:
+     * if bound1 <= bound2, trap if reg < bound1 or  reg > bound2
+     * if bound1 > bound2,  trap if reg > bound2 and reg < bound1
+    */
+    one = tcg_const_i32(1);
+
+    /* reg < bound1 or reg > bound2 */
+    res1 = tcg_temp_new();
+    tcg_gen_setcond_i32(TCG_COND_LT, res1, reg, bound1);
+    tcg_gen_movcond_i32(TCG_COND_GT, res1, reg, bound2, one, res1);
+
+    /* reg > bound2 and reg < bound1 */
+    res2 = tcg_temp_new();
+    tcg_gen_setcond_i32(TCG_COND_GT, res2, reg, bound2);
+    tcg_gen_setcond_i32(TCG_COND_LT, tmp, reg, bound1);
+    tcg_gen_and_i32(res2, res2, tmp);
+    tcg_temp_free(tmp);
+
+    /* if bound1 <= bound2, C = res1 else C = res2 */
+    tcg_gen_movcond_i32(TCG_COND_LE, QREG_CC_C, bound1, bound2, res1, res2);
+
+    tcg_temp_free(res1);
+    tcg_temp_free(res2);
+    tcg_temp_free(bound1);
+    tcg_temp_free(bound2);
+    tcg_temp_free(reg);
+
+    update_cc_op(s);
+    l1 = gen_new_label();
+    tcg_gen_brcond_i32(TCG_COND_NE, QREG_CC_C, one, l1);
+    tcg_gen_movi_i32(QREG_PC, s->pc);
+    gen_raise_exception(EXCP_CHK);
+    gen_set_label(l1);
+}
+
 static TCGv gen_get_sr(DisasContext *s)
 {
     TCGv ccr;
@@ -5306,7 +5440,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(undef,     0000, 0000);
     INSN(arith_im,  0080, fff8, CF_ISA_A);
     INSN(arith_im,  0000, ff00, M68000);
-    INSN(undef,     00c0, ffc0, M68000);
+    INSN(chk2,      00c0, f9c0, CHK2);
     INSN(bitrev,    00c0, fff8, CF_ISA_APLUSC);
     BASE(bitop_reg, 0100, f1c0);
     BASE(bitop_reg, 0140, f1c0);
@@ -5339,6 +5473,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(move,      1000, f000);
     BASE(move,      2000, f000);
     BASE(move,      3000, f000);
+    INSN(chk,       4000, f040, M68000);
     INSN(strldsr,   40e7, ffff, CF_ISA_APLUSC);
     INSN(negx,      4080, fff8, CF_ISA_A);
     INSN(negx,      4000, ff00, M68000);
-- 
2.14.3
