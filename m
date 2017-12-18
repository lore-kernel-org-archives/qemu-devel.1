Received: from eggs.gnu.org ([2001:4830:134:3::10]:37496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3l-0000eO-6T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3j-0001Pl-BX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:37 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3j-0001On-1y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:35 -0500
Received: by mail-pg0-x243.google.com with SMTP id k134so9403046pga.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:53 -0800
Message-Id: <20171218171758.16964-22-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 21/26] tcg/i386: Add vector
 operations/expansions for mul/extend
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |   4 +-
 tcg/i386/tcg-target.opc.h |   1 +
 tcg/i386/tcg-target.inc.c | 186 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 174 insertions(+), 17 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index fedc3449c1..e77b95cc2c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,8 +184,8 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_extl_vec         0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_extl_vec         1
 #define TCG_TARGET_HAS_exth_vec         0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index 77125ef818..5f05df65e0 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -8,3 +8,4 @@ DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
+DEF(x86_vperm2i128_vec, 1, 2, 1, IMPLVEC)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 694d9e5cb5..e61aeebf3e 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -393,6 +393,14 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PCMPGTW     (0x65 | P_EXT | P_DATA16)
 #define OPC_PCMPGTD     (0x66 | P_EXT | P_DATA16)
 #define OPC_PCMPGTQ     (0x37 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXBW    (0x20 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXWD    (0x23 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXDQ    (0x25 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXBW    (0x30 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXWD    (0x33 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXDQ    (0x35 | P_EXT38 | P_DATA16)
+#define OPC_PMULLW      (0xd5 | P_EXT | P_DATA16)
+#define OPC_PMULLD      (0x40 | P_EXT38 | P_DATA16)
 #define OPC_POR         (0xeb | P_EXT | P_DATA16)
 #define OPC_PSHUFB      (0x00 | P_EXT38 | P_DATA16)
 #define OPC_PSHUFD      (0x70 | P_EXT | P_DATA16)
@@ -2675,6 +2683,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sub_insn[4] = {
         OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
     };
+    static int const mul_insn[4] = {
+        OPC_UD2, OPC_PMULLW, OPC_PMULLD, OPC_UD2
+    };
     static int const shift_imm_insn[4] = {
         OPC_UD2, OPC_PSHIFTW_Ib, OPC_PSHIFTD_Ib, OPC_PSHIFTQ_Ib
     };
@@ -2690,6 +2701,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const punpckh_insn[4] = {
         OPC_PUNPCKHBW, OPC_PUNPCKHWD, OPC_PUNPCKHDQ, OPC_PUNPCKHQDQ
     };
+    static int const packss_insn[4] = {
+        OPC_PACKSSWB, OPC_PACKSSDW, OPC_UD2, OPC_UD2
+    };
+    static int const packus_insn[4] = {
+        OPC_PACKUSWB, OPC_PACKUSDW, OPC_UD2, OPC_UD2
+    };
+    static int const pmovsx_insn[3] = {
+        OPC_PMOVSXBW, OPC_PMOVSXWD, OPC_PMOVSXDQ
+    };
+    static int const pmovzx_insn[3] = {
+        OPC_PMOVZXBW, OPC_PMOVZXWD, OPC_PMOVZXDQ
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2706,6 +2729,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_insn[vece];
         goto gen_simd;
+    case INDEX_op_mul_vec:
+        insn = mul_insn[vece];
+        goto gen_simd;
     case INDEX_op_and_vec:
         insn = OPC_PAND;
         goto gen_simd;
@@ -2722,30 +2748,33 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = punpckh_insn[vece];
         goto gen_simd;
     case INDEX_op_x86_packss_vec:
-        if (vece == MO_8) {
-            insn = OPC_PACKSSWB;
-        } else if (vece == MO_16) {
-            insn = OPC_PACKSSDW;
-        } else {
-            g_assert_not_reached();
-        }
+        insn = packss_insn[vece];
         goto gen_simd;
     case INDEX_op_x86_packus_vec:
-        if (vece == MO_8) {
-            insn = OPC_PACKUSWB;
-        } else if (vece == MO_16) {
-            insn = OPC_PACKUSDW;
-        } else {
-            g_assert_not_reached();
-        }
+        insn = packus_insn[vece];
         goto gen_simd;
     gen_simd:
+        tcg_debug_assert(insn != OPC_UD2);
         if (type == TCG_TYPE_V256) {
             insn |= P_VEXL;
         }
         tcg_out_vex_modrm(s, insn, a0, a1, a2);
         break;
 
+    case INDEX_op_extsl_vec:
+        insn = pmovsx_insn[vece];
+        goto gen_simd2;
+    case INDEX_op_extul_vec:
+        insn = pmovzx_insn[vece];
+        goto gen_simd2;
+    gen_simd2:
+        tcg_debug_assert(vece < MO_64);
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, 0, a1);
+        break;
+
     case INDEX_op_cmp_vec:
         sub = args[3];
         if (sub == TCG_COND_EQ) {
@@ -2811,6 +2840,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         sub = args[3];
         goto gen_simd_imm8;
+    case INDEX_op_x86_vperm2i128_vec:
+        insn = OPC_VPERM2I128;
+        sub = args[3];
+        goto gen_simd_imm8;
     gen_simd_imm8:
         if (type == TCG_TYPE_V256) {
             insn |= P_VEXL;
@@ -3073,6 +3106,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
@@ -3084,11 +3118,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_x86_blend_vec:
     case INDEX_op_x86_packss_vec:
     case INDEX_op_x86_packus_vec:
+    case INDEX_op_x86_vperm2i128_vec:
         return &x_x_x;
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extul_vec:
     case INDEX_op_x86_psrldq_vec:
         return &x_x;
     case INDEX_op_x86_vpblendvb_vec:
@@ -3109,8 +3146,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extul_vec:
         return 1;
     case INDEX_op_cmp_vec:
+    case INDEX_op_extsh_vec:
+    case INDEX_op_extuh_vec:
         return -1;
 
     case INDEX_op_shli_vec:
@@ -3130,6 +3171,16 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_mul_vec:
+        if (vece == MO_8) {
+            /* We can expand the operation for MO_8.  */
+            return -1;
+        }
+        if (vece == MO_64) {
+            return 0;
+        }
+        return 1;
+
     case INDEX_op_zipl_vec:
         /* We could support v256, but with 3 insns per opcode.
            It is better to expand with v128 instead.  */
@@ -3157,7 +3208,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGArg a1, a2;
-    TCGv_vec v0, v1, v2, t1, t2;
+    TCGv_vec v0, v1, v2, t1, t2, t3, t4;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
@@ -3248,6 +3299,91 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         tcg_temp_free_vec(t1);
         break;
 
+    case INDEX_op_mul_vec:
+        tcg_debug_assert(vece == MO_8);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (type) {
+        case TCG_TYPE_V64:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+            tcg_gen_dup16i_vec(t2, 0);
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t2));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2);
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+
+        case TCG_TYPE_V128:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t3 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t4 = tcg_temp_new_vec(TCG_TYPE_V128);
+            tcg_gen_dup16i_vec(t4, 0);
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_mul_vec(MO_16, t3, t3, t4);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            tcg_gen_shri_vec(MO_16, t3, t3, 8);
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            tcg_temp_free_vec(t3);
+            tcg_temp_free_vec(t4);
+            break;
+
+        case TCG_TYPE_V256:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t3 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t4 = tcg_temp_new_vec(TCG_TYPE_V256);
+            tcg_gen_dup16i_vec(t4, 0);
+            /* a1: A[0-7] ... D[0-7]; a2: W[0-7] ... Z[0-7]
+               t1: extends of B[0-7], D[0-7]
+               t2: extends of X[0-7], Z[0-7]
+               t3: extends of A[0-7], C[0-7]
+               t4: extends of W[0-7], Y[0-7].  */
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
+            /* t1: BX DZ; t2: AW CY.  */
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_mul_vec(MO_16, t3, t3, t4);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            tcg_gen_shri_vec(MO_16, t3, t3, 8);
+            /* a0: AW BX CY DZ.  */
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V256, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            tcg_temp_free_vec(t3);
+            tcg_temp_free_vec(t4);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
     case INDEX_op_ziph_vec:
         tcg_debug_assert(type == TCG_TYPE_V64);
         a1 = va_arg(va, TCGArg);
@@ -3256,6 +3392,26 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         vec_gen_3(INDEX_op_x86_psrldq_vec, TCG_TYPE_V128, MO_64, a0, a0, 8);
         break;
 
+    case INDEX_op_extsh_vec:
+    case INDEX_op_extuh_vec:
+        a1 = va_arg(va, TCGArg);
+        switch (type) {
+        case TCG_TYPE_V64:
+            vec_gen_3(INDEX_op_x86_psrldq_vec, type, MO_64, a0, a1, 4);
+            break;
+        case TCG_TYPE_V128:
+            vec_gen_3(INDEX_op_x86_psrldq_vec, type, MO_64, a0, a1, 8);
+            break;
+        case TCG_TYPE_V256:
+            vec_gen_4(INDEX_op_x86_vperm2i128_vec, type, 4, a0, a1, a1, 0x81);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        vec_gen_2(opc == INDEX_op_extsh_vec ? INDEX_op_extsl_vec
+                  : INDEX_op_extul_vec, type, vece, a0, a0);
+        break;
+
     case INDEX_op_uzpe_vec:
         a1 = va_arg(va, TCGArg);
         a2 = va_arg(va, TCGArg);
-- 
2.14.3
