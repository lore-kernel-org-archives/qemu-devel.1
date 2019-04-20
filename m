Received: from eggs.gnu.org ([209.51.188.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWs-0000E5-7s
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWr-0008NC-1W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWq-0008LU-S7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:16 -0400
Received: by mail-pg1-x52f.google.com with SMTP id z9so3580511pgu.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:22 -1000
Message-Id: <20190420073442.7488-19-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/38] tcg/i386: Support vector scalar shift
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b240633455..618aa520d2 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -183,7 +183,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 04e609c7b2..85b68e4326 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -420,6 +420,14 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PSHIFTW_Ib  (0x71 | P_EXT | P_DATA16) /* /2 /6 /4 */
 #define OPC_PSHIFTD_Ib  (0x72 | P_EXT | P_DATA16) /* /2 /6 /4 */
 #define OPC_PSHIFTQ_Ib  (0x73 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSLLW       (0xf1 | P_EXT | P_DATA16)
+#define OPC_PSLLD       (0xf2 | P_EXT | P_DATA16)
+#define OPC_PSLLQ       (0xf3 | P_EXT | P_DATA16)
+#define OPC_PSRAW       (0xe1 | P_EXT | P_DATA16)
+#define OPC_PSRAD       (0xe2 | P_EXT | P_DATA16)
+#define OPC_PSRLW       (0xd1 | P_EXT | P_DATA16)
+#define OPC_PSRLD       (0xd2 | P_EXT | P_DATA16)
+#define OPC_PSRLQ       (0xd3 | P_EXT | P_DATA16)
 #define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
 #define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
 #define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
@@ -2722,6 +2730,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         /* TODO: AVX512 adds support for MO_16, MO_64.  */
         OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
     };
+    static int const shls_insn[4] = {
+        OPC_UD2, OPC_PSLLW, OPC_PSLLD, OPC_PSLLQ
+    };
+    static int const shrs_insn[4] = {
+        OPC_UD2, OPC_PSRLW, OPC_PSRLD, OPC_PSRLQ
+    };
+    static int const sars_insn[4] = {
+        OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2783,6 +2800,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         insn = sarv_insn[vece];
         goto gen_simd;
+    case INDEX_op_shls_vec:
+        insn = shls_insn[vece];
+        goto gen_simd;
+    case INDEX_op_shrs_vec:
+        insn = shrs_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sars_vec:
+        insn = sars_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3163,6 +3189,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3220,6 +3249,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+        return vece >= MO_16;
+    case INDEX_op_sars_vec:
+        return vece >= MO_16 && vece <= MO_32;
+
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
         return have_avx2 && vece >= MO_32;
-- 
2.17.1
