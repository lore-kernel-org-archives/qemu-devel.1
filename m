Received: from eggs.gnu.org ([209.51.188.92]:38456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRi-0006hz-VZ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRf-00032a-0l
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:45877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRd-00030S-ON
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id i21so4414956pgi.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:28 -0700
Message-Id: <20190501050536.15580-22-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 21/29] tcg/i386: Support vector absolute
 value
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
 tcg/i386/tcg-target.inc.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7445f05885..66f16fbe3c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -182,7 +182,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0ba1587da4..aafd01cb49 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -369,6 +369,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PABSB       (0x1c | P_EXT38 | P_DATA16)
+#define OPC_PABSW       (0x1d | P_EXT38 | P_DATA16)
+#define OPC_PABSD       (0x1e | P_EXT38 | P_DATA16)
 #define OPC_PACKSSDW    (0x6b | P_EXT | P_DATA16)
 #define OPC_PACKSSWB    (0x63 | P_EXT | P_DATA16)
 #define OPC_PACKUSDW    (0x2b | P_EXT38 | P_DATA16)
@@ -2741,6 +2744,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sars_insn[4] = {
         OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
     };
+    static int const abs_insn[4] = {
+        /* TODO: AVX512 adds support for MO_64.  */
+        OPC_PABSB, OPC_PABSW, OPC_PABSD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2829,6 +2836,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = OPC_PUNPCKLDQ;
         goto gen_simd;
 #endif
+    case INDEX_op_abs_vec:
+        insn = abs_insn[vece];
+        a2 = a1;
+        a1 = 0;
+        goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
         if (type == TCG_TYPE_V256) {
@@ -3206,6 +3218,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
 #endif
         return &x_x_x;
+    case INDEX_op_abs_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
@@ -3283,6 +3296,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
         return vece <= MO_32 ? 1 : -1;
+    case INDEX_op_abs_vec:
+        return vece <= MO_32;
 
     default:
         return 0;
-- 
2.17.1
