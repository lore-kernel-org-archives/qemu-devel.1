Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92j-0001VK-Qk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92g-0002ZG-37
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:47 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92a-0001xM-5w
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:42 -0500
Received: by mail-pl1-x641.google.com with SMTP id a14so7350252plm.12
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:45 -0800
Message-Id: <20181218063911.2112-9-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/34] tcg/i386: Implement vector minmax
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The instruction set does not directly provide MO_64.  We can still
implement signed 64-bit with comparison and vpblendvb.  Since the
ISA has no unsigned comparison, it would take 4 insns to implement
unsigned 64-bit, which is probably quicker as integers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

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
index 3571483bae..c56753763a 100644
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
@@ -3115,6 +3155,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
         return vece <= MO_16;
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+        return vece <= MO_32 ? 1 : -1;
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
+        return vece <= MO_32;
 
     default:
         return 0;
@@ -3370,6 +3416,24 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         }
         break;
 
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+        tcg_debug_assert(vece == MO_64);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        t1 = tcg_temp_new_vec(type);
+        vec_gen_4(INDEX_op_cmp_vec, type, MO_64,
+                  tcgv_vec_arg(t1), a1, a2, TCG_COND_GT);
+        if (opc == INDEX_op_smin_vec) {
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_64,
+                      tcgv_vec_arg(v0), a2, a1, tcgv_vec_arg(t1));
+        } else {
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_64,
+                      tcgv_vec_arg(v0), a1, a2, tcgv_vec_arg(t1));
+        }
+        tcg_temp_free_vec(t1);
+        break;
+
     default:
         break;
     }
-- 
2.17.2
