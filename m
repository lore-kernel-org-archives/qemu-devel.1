Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3j-0000c8-Ep
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3b-0001Gr-QP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:35 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3b-0001Fg-Ba
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:27 -0500
Received: by mail-pl0-x244.google.com with SMTP id bi12so5200667plb.6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:48 -0800
Message-Id: <20171218171758.16964-17-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 16/26] tcg/i386: Add vector
 operations/expansions for shift/cmp/interleave
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
 tcg/i386/tcg-target.h     |   6 +-
 tcg/i386/tcg-target.opc.h |   7 +
 tcg/i386/tcg-target.inc.c | 595 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 598 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 46c4dca7be..60d3684750 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -177,13 +177,13 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_zip_vec          0
+#define TCG_TARGET_HAS_zip_vec          1
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
-#define TCG_TARGET_HAS_cmp_vec          0
+#define TCG_TARGET_HAS_cmp_vec          1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index 4816a6c3d4..77125ef818 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -1,3 +1,10 @@
 /* Target-specific opcodes for host vector expansion.  These will be
    emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
    consider these to be UNSPEC with names.  */
+
+DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
+DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
+DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
+DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
+DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
+DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 062cf16607..694d9e5cb5 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -324,6 +324,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 # define P_REXB_RM	0
 # define P_GS           0
 #endif
+#define P_EXT3A         0x10000         /* 0x0f 0x3a opcode prefix */
 #define P_SIMDF3        0x20000         /* 0xf3 opcode prefix */
 #define P_SIMDF2        0x40000         /* 0xf2 opcode prefix */
 #define P_VEXL          0x80000         /* Set VEX.L = 1 */
@@ -333,6 +334,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_BLENDPS     (0x0c | P_EXT3A | P_DATA16)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
 #define OPC_BSWAP	(0xc8 | P_EXT)
@@ -372,15 +374,33 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PACKSSDW    (0x6b | P_EXT | P_DATA16)
+#define OPC_PACKSSWB    (0x63 | P_EXT | P_DATA16)
+#define OPC_PACKUSDW    (0x2b | P_EXT38 | P_DATA16)
+#define OPC_PACKUSWB    (0x67 | P_EXT | P_DATA16)
 #define OPC_PADDB       (0xfc | P_EXT | P_DATA16)
 #define OPC_PADDW       (0xfd | P_EXT | P_DATA16)
 #define OPC_PADDD       (0xfe | P_EXT | P_DATA16)
 #define OPC_PADDQ       (0xd4 | P_EXT | P_DATA16)
 #define OPC_PAND        (0xdb | P_EXT | P_DATA16)
 #define OPC_PANDN       (0xdf | P_EXT | P_DATA16)
+#define OPC_PBLENDW     (0x0e | P_EXT3A | P_DATA16)
 #define OPC_PCMPEQB     (0x74 | P_EXT | P_DATA16)
+#define OPC_PCMPEQW     (0x75 | P_EXT | P_DATA16)
+#define OPC_PCMPEQD     (0x76 | P_EXT | P_DATA16)
+#define OPC_PCMPEQQ     (0x29 | P_EXT38 | P_DATA16)
+#define OPC_PCMPGTB     (0x64 | P_EXT | P_DATA16)
+#define OPC_PCMPGTW     (0x65 | P_EXT | P_DATA16)
+#define OPC_PCMPGTD     (0x66 | P_EXT | P_DATA16)
+#define OPC_PCMPGTQ     (0x37 | P_EXT38 | P_DATA16)
 #define OPC_POR         (0xeb | P_EXT | P_DATA16)
+#define OPC_PSHUFB      (0x00 | P_EXT38 | P_DATA16)
 #define OPC_PSHUFD      (0x70 | P_EXT | P_DATA16)
+#define OPC_PSHUFLW     (0x70 | P_EXT | P_SIMDF2)
+#define OPC_PSHUFHW     (0x70 | P_EXT | P_SIMDF3)
+#define OPC_PSHIFTW_Ib  (0x71 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSHIFTD_Ib  (0x72 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSHIFTQ_Ib  (0x73 | P_EXT | P_DATA16) /* /2 /6 /4 */
 #define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
 #define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
 #define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
@@ -389,6 +409,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PUNPCKLWD   (0x61 | P_EXT | P_DATA16)
 #define OPC_PUNPCKLDQ   (0x62 | P_EXT | P_DATA16)
 #define OPC_PUNPCKLQDQ  (0x6c | P_EXT | P_DATA16)
+#define OPC_PUNPCKHBW   (0x68 | P_EXT | P_DATA16)
+#define OPC_PUNPCKHWD   (0x69 | P_EXT | P_DATA16)
+#define OPC_PUNPCKHDQ   (0x6a | P_EXT | P_DATA16)
+#define OPC_PUNPCKHQDQ  (0x6d | P_EXT | P_DATA16)
 #define OPC_PXOR        (0xef | P_EXT | P_DATA16)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
@@ -401,19 +425,26 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHIFT_Ib	(0xc1)
 #define OPC_SHIFT_cl	(0xd3)
 #define OPC_SARX        (0xf7 | P_EXT38 | P_SIMDF3)
+#define OPC_SHUFPS      (0xc6 | P_EXT)
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
+#define OPC_UD2         (0x0b | P_EXT)
+#define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
+#define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
 #define OPC_VPBROADCASTB (0x78 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_REXW)
+#define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
 #define OPC_GRP3_Ev	(0xf7)
 #define OPC_GRP5	(0xff)
+#define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -519,10 +550,12 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
         tcg_out8(s, (uint8_t)(rex | 0x40));
     }
 
-    if (opc & (P_EXT | P_EXT38)) {
+    if (opc & (P_EXT | P_EXT38 | P_EXT3A)) {
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
 
@@ -539,10 +572,12 @@ static void tcg_out_opc(TCGContext *s, int opc)
     } else if (opc & P_SIMDF2) {
         tcg_out8(s, 0xf2);
     }
-    if (opc & (P_EXT | P_EXT38)) {
+    if (opc & (P_EXT | P_EXT38 | P_EXT3A)) {
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
     tcg_out8(s, opc);
@@ -566,7 +601,7 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 
     /* Use the two byte form if possible, which cannot encode
        VEX.W, VEX.B, VEX.X, or an m-mmmm field other than P_EXT.  */
-    if ((opc & (P_EXT | P_EXT38 | P_REXW)) == P_EXT
+    if ((opc & (P_EXT | P_EXT38 | P_EXT3A | P_REXW)) == P_EXT
         && ((rm | index) & 8) == 0) {
         /* Two byte VEX prefix.  */
         tcg_out8(s, 0xc5);
@@ -577,7 +612,9 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
         tcg_out8(s, 0xc4);
 
         /* VEX.m-mmmm */
-        if (opc & P_EXT38) {
+        if (opc & P_EXT3A) {
+            tmp = 3;
+        } else if (opc & P_EXT38) {
             tmp = 2;
         } else if (opc & P_EXT) {
             tmp = 1;
@@ -2638,9 +2675,24 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sub_insn[4] = {
         OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
     };
+    static int const shift_imm_insn[4] = {
+        OPC_UD2, OPC_PSHIFTW_Ib, OPC_PSHIFTD_Ib, OPC_PSHIFTQ_Ib
+    };
+    static int const cmpeq_insn[4] = {
+        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
+    };
+    static int const cmpgt_insn[4] = {
+        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
+    };
+    static int const punpckl_insn[4] = {
+        OPC_PUNPCKLBW, OPC_PUNPCKLWD, OPC_PUNPCKLDQ, OPC_PUNPCKLQDQ
+    };
+    static int const punpckh_insn[4] = {
+        OPC_PUNPCKHBW, OPC_PUNPCKHWD, OPC_PUNPCKHDQ, OPC_PUNPCKHQDQ
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
-    int insn;
+    int insn, sub;
     TCGArg a0, a1, a2;
 
     a0 = args[0];
@@ -2662,6 +2714,31 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
     case INDEX_op_xor_vec:
         insn = OPC_PXOR;
+        goto gen_simd;
+    case INDEX_op_zipl_vec:
+        insn = punpckl_insn[vece];
+        goto gen_simd;
+    case INDEX_op_ziph_vec:
+        insn = punpckh_insn[vece];
+        goto gen_simd;
+    case INDEX_op_x86_packss_vec:
+        if (vece == MO_8) {
+            insn = OPC_PACKSSWB;
+        } else if (vece == MO_16) {
+            insn = OPC_PACKSSDW;
+        } else {
+            g_assert_not_reached();
+        }
+        goto gen_simd;
+    case INDEX_op_x86_packus_vec:
+        if (vece == MO_8) {
+            insn = OPC_PACKUSWB;
+        } else if (vece == MO_16) {
+            insn = OPC_PACKUSDW;
+        } else {
+            g_assert_not_reached();
+        }
+        goto gen_simd;
     gen_simd:
         if (type == TCG_TYPE_V256) {
             insn |= P_VEXL;
@@ -2669,6 +2746,17 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_vex_modrm(s, insn, a0, a1, a2);
         break;
 
+    case INDEX_op_cmp_vec:
+        sub = args[3];
+        if (sub == TCG_COND_EQ) {
+            insn = cmpeq_insn[vece];
+        } else if (sub == TCG_COND_GT) {
+            insn = cmpgt_insn[vece];
+        } else {
+            g_assert_not_reached();
+        }
+        goto gen_simd;
+
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
         if (type == TCG_TYPE_V256) {
@@ -2677,6 +2765,25 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_vex_modrm(s, insn, a0, a2, a1);
         break;
 
+    case INDEX_op_shli_vec:
+        sub = 6;
+        goto gen_shift;
+    case INDEX_op_shri_vec:
+        sub = 2;
+        goto gen_shift;
+    case INDEX_op_sari_vec:
+        tcg_debug_assert(vece != MO_64);
+        sub = 4;
+    gen_shift:
+        tcg_debug_assert(vece != MO_8);
+        insn = shift_imm_insn[vece];
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, sub, a0, a1);
+        tcg_out8(s, a2);
+        break;
+
     case INDEX_op_ld_vec:
         tcg_out_ld(s, type, a0, a1, a2);
         break;
@@ -2690,6 +2797,42 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dup_vec(s, type, vece, a0, a1);
         break;
 
+    case INDEX_op_x86_shufps_vec:
+        insn = OPC_SHUFPS;
+        sub = args[3];
+        goto gen_simd_imm8;
+    case INDEX_op_x86_blend_vec:
+        if (vece == MO_16) {
+            insn = OPC_PBLENDW;
+        } else if (vece == MO_32) {
+            insn = (have_avx2 ? OPC_VPBLENDD : OPC_BLENDPS);
+        } else {
+            g_assert_not_reached();
+        }
+        sub = args[3];
+        goto gen_simd_imm8;
+    gen_simd_imm8:
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out8(s, sub);
+        break;
+
+    case INDEX_op_x86_vpblendvb_vec:
+        insn = OPC_VPBLENDVB;
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out8(s, args[3] << 4);
+        break;
+
+    case INDEX_op_x86_psrldq_vec:
+        tcg_out_vex_modrm(s, OPC_GRP14, 3, a0, a1);
+        tcg_out8(s, a2);
+        break;
+
     default:
         g_assert_not_reached();
     }
@@ -2720,6 +2863,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "L", "L", "L", "L" } };
     static const TCGTargetOpDef x_x = { .args_ct_str = { "x", "x" } };
     static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
+    static const TCGTargetOpDef x_x_x_x
+        = { .args_ct_str = { "x", "x", "x", "x" } };
     static const TCGTargetOpDef x_r = { .args_ct_str = { "x", "r" } };
 
     switch (op) {
@@ -2932,9 +3077,22 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_zipl_vec:
+    case INDEX_op_ziph_vec:
+    case INDEX_op_x86_shufps_vec:
+    case INDEX_op_x86_blend_vec:
+    case INDEX_op_x86_packss_vec:
+    case INDEX_op_x86_packus_vec:
         return &x_x_x;
     case INDEX_op_dup_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_x86_psrldq_vec:
         return &x_x;
+    case INDEX_op_x86_vpblendvb_vec:
+        return &x_x_x_x;
 
     default:
         break;
@@ -2951,16 +3109,439 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
-        return true;
+        return 1;
+    case INDEX_op_cmp_vec:
+        return -1;
+
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+        /* We must expand the operation for MO_8.  */
+        return vece == MO_8 ? -1 : 1;
+
+    case INDEX_op_sari_vec:
+        /* We must expand the operation for MO_8.  */
+        if (vece == MO_8) {
+            return -1;
+        }
+        /* We can emulate this for MO_64, but it does not pay off
+           unless we're producing at least 4 values.  */
+        if (vece == MO_64) {
+            return type >= TCG_TYPE_V256 ? -1 : 0;
+        }
+        return 1;
+
+    case INDEX_op_zipl_vec:
+        /* We could support v256, but with 3 insns per opcode.
+           It is better to expand with v128 instead.  */
+        return type <= TCG_TYPE_V128;
+    case INDEX_op_ziph_vec:
+        if (type == TCG_TYPE_V64) {
+            return -1;
+        }
+        return type == TCG_TYPE_V128;
+
+    case INDEX_op_uzpe_vec:
+    case INDEX_op_uzpo_vec:
+    case INDEX_op_trne_vec:
+    case INDEX_op_trno_vec:
+        /* ??? Not implemented for V256.  */
+        return -(type <= TCG_TYPE_V128);
 
     default:
-        return false;
+        return 0;
     }
 }
 
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
+    va_list va;
+    TCGArg a1, a2;
+    TCGv_vec v0, v1, v2, t1, t2;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+
+    switch (opc) {
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+        tcg_debug_assert(vece == MO_8);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        /* Unpack to W, shift, and repack.  Tricky bits:
+           (1) Use punpck*bw x,x to produce DDCCBBAA,
+               i.e. duplicate in other half of the 16-bit lane.
+           (2) For right-shift, add 8 so that the high half of
+               the lane becomes zero.  For left-shift, we must
+               shift up and down again.
+           (3) Step 2 leaves high half zero such that PACKUSWB
+               (pack with unsigned saturation) does not modify
+               the quantity.  */
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        vec_gen_3(INDEX_op_zipl_vec, type, MO_8, tcgv_vec_arg(t1), a1, a1);
+        vec_gen_3(INDEX_op_ziph_vec, type, MO_8, tcgv_vec_arg(t2), a1, a1);
+        if (opc == INDEX_op_shri_vec) {
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+        } else {
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), 8);
+        }
+        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                 a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
+    case INDEX_op_sari_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        if (vece == MO_8) {
+            /* Unpack to W, shift, and repack, as above.  */
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_zipl_vec, type, MO_8, tcgv_vec_arg(t1), a1, a1);
+            vec_gen_3(INDEX_op_ziph_vec, type, MO_8, tcgv_vec_arg(t2), a1, a1);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
+                      tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+            vec_gen_3(INDEX_op_x86_packss_vec, type, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        }
+        tcg_debug_assert(vece == MO_64);
+        /* MO_64: If the shift is <= 32, we can emulate the sign extend by
+           performing an arithmetic 32-bit shift and overwriting the high
+           half of the result (note that the ISA says shift of 32 is valid). */
+        if (a2 <= 32) {
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_32, tcgv_vec_arg(t1), a1, a2);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_64, a0, a1, a2);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, a0, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        }
+        /* Otherwise we will need to use a compare vs 0 to produce the
+           sign-extend, shift and merge.  */
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_const_zeros_vec(type);
+        vec_gen_4(INDEX_op_cmp_vec, type, MO_64,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t2), a1, TCG_COND_GT);
+        tcg_temp_free_vec(t2);
+        vec_gen_3(INDEX_op_shri_vec, type, MO_64, a0, a1, a2);
+        vec_gen_3(INDEX_op_shli_vec, type, MO_64,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t1), 64 - a2);
+        vec_gen_3(INDEX_op_or_vec, type, MO_64, a0, a0, tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_ziph_vec:
+        tcg_debug_assert(type == TCG_TYPE_V64);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, vece, a0, a1, a2);
+        vec_gen_3(INDEX_op_x86_psrldq_vec, TCG_TYPE_V128, MO_64, a0, a0, 8);
+        break;
+
+    case INDEX_op_uzpe_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        v1 = temp_tcgv_vec(arg_temp(a1));
+        v2 = temp_tcgv_vec(arg_temp(a2));
+
+        if (type == TCG_TYPE_V128) {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dup16i_vec(t2, 0x00ff);
+                tcg_gen_and_vec(MO_16, t1, v2, t2);
+                tcg_gen_and_vec(MO_16, v0, v1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dup32i_vec(t2, 0x0000ffff);
+                tcg_gen_and_vec(MO_32, t1, v2, t2);
+                tcg_gen_and_vec(MO_32, v0, v1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_16,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_32:
+                vec_gen_4(INDEX_op_x86_shufps_vec, type, MO_32,
+                          a0, a1, a2, 0x88);
+                break;
+            case MO_64:
+                tcg_gen_zipl_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_debug_assert(type == TCG_TYPE_V64);
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+                tcg_gen_dup16i_vec(t2, 0x00ff);
+                tcg_gen_and_vec(MO_16, t1, t1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+                tcg_gen_dup32i_vec(t2, 0x0000ffff);
+                tcg_gen_and_vec(MO_32, t1, t1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_16,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_32:
+                tcg_gen_zipl_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        break;
+
+    case INDEX_op_uzpo_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        v1 = temp_tcgv_vec(arg_temp(a1));
+        v2 = temp_tcgv_vec(arg_temp(a2));
+
+        if (type == TCG_TYPE_V128) {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(type);
+                tcg_gen_shri_vec(MO_16, t1, v2, 8);
+                tcg_gen_shri_vec(MO_16, v0, v1, 8);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(type);
+                tcg_gen_shri_vec(MO_32, t1, v2, 16);
+                tcg_gen_shri_vec(MO_32, v0, v1, 16);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_16,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_32:
+                vec_gen_4(INDEX_op_x86_shufps_vec, type, MO_32,
+                          a0, a1, a2, 0xdd);
+                break;
+            case MO_64:
+                tcg_gen_ziph_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                tcg_gen_shri_vec(MO_16, t1, t1, 8);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                tcg_gen_shri_vec(MO_32, t1, t1, 16);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_16,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_32:
+                tcg_gen_ziph_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        break;
+
+    case INDEX_op_trne_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (vece) {
+        case MO_8:
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                      tcgv_vec_arg(t1), a2, 8);
+            tcg_gen_dup16i_vec(t2, 0xff00);
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_8,
+                      a0, a1, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        case MO_16:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_32,
+                      tcgv_vec_arg(t1), a2, 16);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_16,
+                      a0, a1, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_32:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_64,
+                      tcgv_vec_arg(t1), a2, 32);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, a1, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_64:
+            vec_gen_3(INDEX_op_zipl_vec, type, MO_64, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_trno_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (vece) {
+        case MO_8:
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                      tcgv_vec_arg(t1), a1, 8);
+            tcg_gen_dup16i_vec(t2, 0xff00);
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_8,
+                      a0, tcgv_vec_arg(t1), a2, tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        case MO_16:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_32,
+                      tcgv_vec_arg(t1), a1, 16);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_16,
+                      a0, tcgv_vec_arg(t1), a2, 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_32:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_64,
+                      tcgv_vec_arg(t1), a1, 32);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, tcgv_vec_arg(t1), a2, 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_64:
+            vec_gen_3(INDEX_op_ziph_vec, type, MO_64, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_cmp_vec:
+        {
+            enum {
+                NEED_SWAP = 1,
+                NEED_INV  = 2,
+                NEED_BIAS = 4
+            };
+            static const uint8_t fixups[16] = {
+                [0 ... 15] = -1,
+                [TCG_COND_EQ] = 0,
+                [TCG_COND_NE] = NEED_INV,
+                [TCG_COND_GT] = 0,
+                [TCG_COND_LT] = NEED_SWAP,
+                [TCG_COND_LE] = NEED_INV,
+                [TCG_COND_GE] = NEED_SWAP | NEED_INV,
+                [TCG_COND_GTU] = NEED_BIAS,
+                [TCG_COND_LTU] = NEED_BIAS | NEED_SWAP,
+                [TCG_COND_LEU] = NEED_BIAS | NEED_INV,
+                [TCG_COND_GEU] = NEED_BIAS | NEED_SWAP | NEED_INV,
+            };
+
+            TCGCond cond;
+            uint8_t fixup;
+
+            a1 = va_arg(va, TCGArg);
+            a2 = va_arg(va, TCGArg);
+            cond = va_arg(va, TCGArg);
+            fixup = fixups[cond & 15];
+            tcg_debug_assert(fixup != 0xff);
+
+            if (fixup & NEED_INV) {
+                cond = tcg_invert_cond(cond);
+            }
+            if (fixup & NEED_SWAP) {
+                TCGArg t;
+                t = a1, a1 = a2, a2 = t;
+                cond = tcg_swap_cond(cond);
+            }
+
+            t1 = t2 = NULL;
+            if (fixup & NEED_BIAS) {
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
+                tcg_gen_sub_vec(vece, t1, temp_tcgv_vec(arg_temp(a1)), t2);
+                tcg_gen_sub_vec(vece, t2, temp_tcgv_vec(arg_temp(a2)), t2);
+                a1 = tcgv_vec_arg(t1);
+                a2 = tcgv_vec_arg(t2);
+                cond = tcg_signed_cond(cond);
+            }
+
+            tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
+            vec_gen_4(INDEX_op_cmp_vec, type, vece, a0, a1, a2, cond);
+
+            if (fixup & NEED_BIAS) {
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+            }
+            if (fixup & NEED_INV) {
+                tcg_gen_not_vec(vece, v0, v0);
+            }
+        }
+        break;
+
+    default:
+        break;
+    }
+
+    va_end(va);
 }
 
 static const int tcg_target_callee_save_regs[] = {
-- 
2.14.3
