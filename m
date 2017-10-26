Received: from eggs.gnu.org ([2001:4830:134:3::10]:56464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjw-0007pQ-5d
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjr-0002jt-HT
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:20 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7fjq-0002jT-P3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:15 -0400
Received: by mail-wr0-x241.google.com with SMTP id y9so2727216wrb.2
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:50:05 +0200
Message-Id: <20171026105007.31777-3-richard.henderson@linaro.org>
In-Reply-To: <20171026105007.31777-1-richard.henderson@linaro.org>
References: <20171026105007.31777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/4] target/i386: Implement all TBM
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/cc_helper_template.h |  18 ++++++
 target/i386/cpu.h                |   7 ++-
 target/i386/cc_helper.c          |  28 +++++++--
 target/i386/cpu.c                |   3 +-
 target/i386/translate.c          | 123 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 170 insertions(+), 9 deletions(-)

diff --git a/target/i386/cc_helper_template.h b/target/i386/cc_helper_template.h
index 607311f195..6ce63b7ca9 100644
--- a/target/i386/cc_helper_template.h
+++ b/target/i386/cc_helper_template.h
@@ -235,6 +235,24 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return src1 == 0;
 }
 
+static int glue(compute_all_tbmadd, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    int cf, pf, af, zf, sf, of;
+
+    cf = (src1 == (DATA_TYPE)-1);
+    pf = 0; /* undefined */
+    af = 0; /* undefined */
+    zf = (dst == 0) * CC_Z;
+    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
+    of = 0;
+    return cf | pf | af | zf | sf | of;
+}
+
+static int glue(compute_c_tbmadd, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    return src1 == (DATA_TYPE)-1;
+}
+
 #undef DATA_BITS
 #undef SIGN_MASK
 #undef DATA_TYPE
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..6c520a90fb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -774,11 +774,16 @@ typedef enum {
     CC_OP_SARL,
     CC_OP_SARQ,
 
-    CC_OP_BMILGB, /* Z,S via CC_DST, C = SRC==0; O=0; P,A undefined */
+    CC_OP_BMILGB, /* Z,S via DST, C = SRC==0; O=0; P,A undefined */
     CC_OP_BMILGW,
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
+    CC_OP_TBMADDB, /* Z,S via DST; C = SRC==-1; O=0; P,A undefined */
+    CC_OP_TBMADDW,
+    CC_OP_TBMADDL,
+    CC_OP_TBMADDQ,
+
     CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
     CC_OP_ADOX, /* CC_DST = O, CC_SRC = rest.  */
     CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
diff --git a/target/i386/cc_helper.c b/target/i386/cc_helper.c
index c9c90e10db..2f12c3b6cb 100644
--- a/target/i386/cc_helper.c
+++ b/target/i386/cc_helper.c
@@ -98,9 +98,6 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
                                    target_ulong src2, int op)
 {
     switch (op) {
-    default: /* should never happen */
-        return 0;
-
     case CC_OP_EFLAGS:
         return src1;
     case CC_OP_CLR:
@@ -185,6 +182,13 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_BMILGL:
         return compute_all_bmilgl(dst, src1);
 
+    case CC_OP_TBMADDB:
+        return compute_all_tbmaddb(dst, src1);
+    case CC_OP_TBMADDW:
+        return compute_all_tbmaddw(dst, src1);
+    case CC_OP_TBMADDL:
+        return compute_all_tbmaddl(dst, src1);
+
     case CC_OP_ADCX:
         return compute_all_adcx(dst, src1, src2);
     case CC_OP_ADOX:
@@ -215,7 +219,12 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         return compute_all_sarq(dst, src1);
     case CC_OP_BMILGQ:
         return compute_all_bmilgq(dst, src1);
+    case CC_OP_TBMADDQ:
+        return compute_all_tbmaddq(dst, src1);
 #endif
+
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -228,7 +237,6 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
                                  target_ulong src2, int op)
 {
     switch (op) {
-    default: /* should never happen */
     case CC_OP_LOGICB:
     case CC_OP_LOGICW:
     case CC_OP_LOGICL:
@@ -307,6 +315,13 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_BMILGL:
         return compute_c_bmilgl(dst, src1);
 
+    case CC_OP_TBMADDB:
+        return compute_c_tbmaddb(dst, src1);
+    case CC_OP_TBMADDW:
+        return compute_c_tbmaddw(dst, src1);
+    case CC_OP_TBMADDL:
+        return compute_c_tbmaddl(dst, src1);
+
 #ifdef TARGET_X86_64
     case CC_OP_ADDQ:
         return compute_c_addq(dst, src1);
@@ -320,7 +335,12 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
         return compute_c_shlq(dst, src1);
     case CC_OP_BMILGQ:
         return compute_c_bmilgq(dst, src1);
+    case CC_OP_TBMADDQ:
+        return compute_c_tbmaddq(dst, src1);
 #endif
+
+    default:
+        g_assert_not_reached();
     }
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 53ec94ac9b..f36844fd95 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -227,7 +227,8 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
           TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
-          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A)
+          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
+          CPUID_EXT3_TBM)
 #define TCG_EXT4_FEATURES 0
 #define TCG_SVM_FEATURES 0
 #define TCG_KVM_FEATURES 0
diff --git a/target/i386/translate.c b/target/i386/translate.c
index db88cc4764..409b195d37 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -217,6 +217,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_SHLB ... CC_OP_SHLQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
+    [CC_OP_TBMADDB ... CC_OP_TBMADDQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
@@ -781,6 +782,12 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         t0 = gen_ext_tl(reg, cpu_cc_src, size, false);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
 
+    case CC_OP_TBMADDB ... CC_OP_TBMADDQ:
+        size = s->cc_op - CC_OP_TBMADDB;
+        t0 = gen_ext_tl(reg, cpu_cc_src, size, true);
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0,
+                             .mask = -1, .imm = -1 };
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
@@ -8322,9 +8329,119 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_sse(env, s, b, pc_start, rex_r);
         break;
 
-    case 0x800 ... 0x8ff: /* XOP opcode map 8 */
-    case 0x900 ... 0x9ff: /* XOP opcode map 9 */
-    case 0xa00 ... 0xaff: /* XOP opcode map 10 */
+    case 0x901:
+    case 0x902: /* most tbm insns */
+        if (!(s->cpuid_ext3_features & CPUID_EXT3_TBM)
+            || s->vex_l != 0) {
+            goto illegal_op;
+        }
+        modrm = x86_ldub_code(env, s);
+        mod = (modrm >> 6) & 3;
+        rm = (modrm & 7) | REX_B(s);
+        ot = mo_64_32(s->dflag);
+        if (mod != 3) {
+            gen_lea_modrm(env, s, modrm);
+            gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        } else {
+            gen_op_mov_v_reg(ot, cpu_T0, rm);
+        }
+
+        tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
+        switch ((b & 2) * 4 + ((modrm >> 3) & 7)) {
+        case 1: /* blcfill */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
+            break;
+        case 2: /* blsfill */
+            op = CC_OP_BMILGB;
+            tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_T1);
+            break;
+        case 3: /* blcs */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_T1);
+            break;
+        case 4: /* tzmsk */
+            op = CC_OP_BMILGB;
+            tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_andc_tl(cpu_T0, cpu_T1, cpu_T0);
+            break;
+        case 5: /* blcic */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_andc_tl(cpu_T0, cpu_T1, cpu_T0);
+            break;
+        case 6: /* blsic */
+            op = CC_OP_BMILGB;
+            tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_orc_tl(cpu_T0, cpu_T1, cpu_T0);
+            break;
+        case 7: /* t1mskc */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_orc_tl(cpu_T0, cpu_T1, cpu_T0);
+            break;
+        case 8 + 1: /* blcmsk */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
+            break;
+        case 8 + 6: /* blci */
+            op = CC_OP_TBMADDB;
+            tcg_gen_addi_tl(cpu_T1, cpu_T0, 1);
+            tcg_gen_orc_tl(cpu_T0, cpu_T0, cpu_T1);
+            break;
+        default:
+            goto unknown_op;
+        }
+        gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
+        tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
+        set_cc_op(s, op + ot);
+        break;
+
+    case 0xa10: /* bextr Gy, Ey, imm4 */
+        {
+            int ofs, len, max;
+
+            if (!(s->cpuid_ext3_features & CPUID_EXT3_TBM)
+                || s->vex_l != 0) {
+                goto illegal_op;
+            }
+
+            s->rip_offset = 4;
+            modrm = cpu_ldub_code(env, s->pc++);
+            reg = ((modrm >> 3) & 7) | rex_r;
+            mod = (modrm >> 6) & 3;
+            rm = (modrm & 7) | REX_B(s);
+            ot = mo_64_32(s->dflag);
+            if (mod != 3) {
+                gen_lea_modrm(env, s, modrm);
+                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+            } else {
+                gen_op_mov_v_reg(ot, cpu_T0, rm);
+            }
+            val = cpu_ldl_code(env, s->pc);
+            s->pc += 4;
+
+            ofs = extract32(val, 0, 8);
+            len = extract32(val, 8, 8);
+            max = 8 << ot;
+            if (len == 0 || ofs >= max) {
+                tcg_gen_movi_tl(cpu_T0, 0);
+            } else {
+                len = MIN(len, max - ofs);
+                tcg_gen_extract_tl(cpu_T0, cpu_T0, ofs, len);
+            }
+            tcg_gen_mov_tl(cpu_regs[reg], cpu_T0);
+            gen_op_update1_cc();
+            /* Z is set as per result, C/O = 0, S/A/P = undefined.
+               Which is less strict than LOGIC, but accurate.  */
+            set_cc_op(s, CC_OP_LOGICB + ot);
+        }
+        break;
+
     default:
         goto unknown_op;
     }
-- 
2.13.6
