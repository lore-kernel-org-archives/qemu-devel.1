Received: from eggs.gnu.org ([209.51.188.92]:33440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jl-0004uI-5h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jk-0007kd-12
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:25 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:45045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9Jj-0007k9-SA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:23 -0500
Received: by mail-pg1-x532.google.com with SMTP id t13so7370214pgr.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:52 -0800
Message-Id: <20190128155907.20607-9-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/23] tcg/i386: Implement vector minmax
 arithmetic
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

The avx instruction set does not directly provide MO_64.
We can still implement 64-bit with comparison and vpblendvb.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 81 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index efbd5a6fc9..7995fe3eab 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -186,7 +186,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index a5791dfaa5..dbf8253718 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -392,6 +392,18 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PCMPGTW     (0x65 | P_EXT | P_DATA16)
 #define OPC_PCMPGTD     (0x66 | P_EXT | P_DATA16)
 #define OPC_PCMPGTQ     (0x37 | P_EXT38 | P_DATA16)
+#define OPC_PMAXSB      (0x3c | P_EXT38 | P_DATA16)
+#define OPC_PMAXSW      (0xee | P_EXT | P_DATA16)
+#define OPC_PMAXSD      (0x3d | P_EXT38 | P_DATA16)
+#define OPC_PMAXUB      (0xde | P_EXT | P_DATA16)
+#define OPC_PMAXUW      (0x3e | P_EXT38 | P_DATA16)
+#define OPC_PMAXUD      (0x3f | P_EXT38 | P_DATA16)
+#define OPC_PMINSB      (0x38 | P_EXT38 | P_DATA16)
+#define OPC_PMINSW      (0xea | P_EXT | P_DATA16)
+#define OPC_PMINSD      (0x39 | P_EXT38 | P_DATA16)
+#define OPC_PMINUB      (0xda | P_EXT | P_DATA16)
+#define OPC_PMINUW      (0x3a | P_EXT38 | P_DATA16)
+#define OPC_PMINUD      (0x3b | P_EXT38 | P_DATA16)
 #define OPC_PMOVSXBW    (0x20 | P_EXT38 | P_DATA16)
 #define OPC_PMOVSXWD    (0x23 | P_EXT38 | P_DATA16)
 #define OPC_PMOVSXDQ    (0x25 | P_EXT38 | P_DATA16)
@@ -2638,6 +2650,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const packus_insn[4] = {
         OPC_PACKUSWB, OPC_PACKUSDW, OPC_UD2, OPC_UD2
     };
+    static int const smin_insn[4] = {
+        OPC_PMINSB, OPC_PMINSW, OPC_PMINSD, OPC_UD2
+    };
+    static int const smax_insn[4] = {
+        OPC_PMAXSB, OPC_PMAXSW, OPC_PMAXSD, OPC_UD2
+    };
+    static int const umin_insn[4] = {
+        OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_UD2
+    };
+    static int const umax_insn[4] = {
+        OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2678,6 +2702,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_xor_vec:
         insn = OPC_PXOR;
         goto gen_simd;
+    case INDEX_op_smin_vec:
+        insn = smin_insn[vece];
+        goto gen_simd;
+    case INDEX_op_umin_vec:
+        insn = umin_insn[vece];
+        goto gen_simd;
+    case INDEX_op_smax_vec:
+        insn = smax_insn[vece];
+        goto gen_simd;
+    case INDEX_op_umax_vec:
+        insn = umax_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3043,6 +3079,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umax_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3115,6 +3155,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
         return vece <= MO_16;
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
+        return vece <= MO_32 ? 1 : -1;
 
     default:
         return 0;
@@ -3343,6 +3388,25 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
     }
 }
 
+static void expand_vec_minmax(TCGType type, unsigned vece,
+                              TCGCond cond, bool min,
+                              TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
+{
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+
+    tcg_debug_assert(vece == MO_64);
+
+    tcg_gen_cmp_vec(cond, vece, t1, v1, v2);
+    if (min) {
+        TCGv_vec t2;
+        t2 = v1, v1 = v2, v2 = t2;
+    }
+    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
+              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
+              tcgv_vec_arg(v2), tcgv_vec_arg(t1));
+    tcg_temp_free_vec(t1);
+}
+
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
@@ -3375,6 +3439,23 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
 
+    case INDEX_op_smin_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_minmax(type, vece, TCG_COND_GT, true, v0, v1, v2);
+        break;
+    case INDEX_op_smax_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_minmax(type, vece, TCG_COND_GT, false, v0, v1, v2);
+        break;
+    case INDEX_op_umin_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_minmax(type, vece, TCG_COND_GTU, true, v0, v1, v2);
+        break;
+    case INDEX_op_umax_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_minmax(type, vece, TCG_COND_GTU, false, v0, v1, v2);
+        break;
+
     default:
         break;
     }
-- 
2.17.2
