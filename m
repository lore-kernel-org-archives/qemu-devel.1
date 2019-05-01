Received: from eggs.gnu.org ([209.51.188.92]:38378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRZ-0006YI-BL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRV-0002wU-KD
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRT-0002vP-Sx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id y13so8131579pfm.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:22 -0700
Message-Id: <20190501050536.15580-16-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 15/29] tcg/i386: Support vector variable
 shift opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 241bf19413..b240633455 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,7 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          have_avx2
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5b33bbd99b..c9448b6d84 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -467,6 +467,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
 #define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_REXW)
 #define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
+#define OPC_VPSLLVD     (0x47 | P_EXT38 | P_DATA16)
+#define OPC_VPSLLVQ     (0x47 | P_EXT38 | P_DATA16 | P_REXW)
+#define OPC_VPSRAVD     (0x46 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_REXW)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
@@ -2707,6 +2712,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const umax_insn[4] = {
         OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_UD2
     };
+    static int const shlv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSLLVD, OPC_VPSLLVQ
+    };
+    static int const shrv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRLVD, OPC_VPSRLVQ
+    };
+    static int const sarv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16, MO_64.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2759,6 +2776,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_insn[vece];
         goto gen_simd;
+    case INDEX_op_shlv_vec:
+        insn = shlv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_shrv_vec:
+        insn = shrv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sarv_vec:
+        insn = sarv_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3136,6 +3162,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3193,6 +3222,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+        return have_avx2 && vece >= MO_32;
+    case INDEX_op_sarv_vec:
+        return have_avx2 && vece == MO_32;
+
     case INDEX_op_mul_vec:
         if (vece == MO_8) {
             /* We can expand the operation for MO_8.  */
-- 
2.17.1
