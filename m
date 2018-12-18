Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92t-0001fJ-Rp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92q-0002ow-58
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:59 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92p-0001vu-PB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:55 -0500
Received: by mail-pg1-x541.google.com with SMTP id d72so7337986pga.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:43 -0800
Message-Id: <20181218063911.2112-7-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/34] tcg/i386: Implement vector saturating
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

Only MO_8 and MO_16 are implemented, since that's all the
instruction set provides.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 42 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 44381062e6..f50234d97b 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -185,7 +185,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index c21c3272f2..3571483bae 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -377,6 +377,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PADDW       (0xfd | P_EXT | P_DATA16)
 #define OPC_PADDD       (0xfe | P_EXT | P_DATA16)
 #define OPC_PADDQ       (0xd4 | P_EXT | P_DATA16)
+#define OPC_PADDSB      (0xec | P_EXT | P_DATA16)
+#define OPC_PADDSW      (0xed | P_EXT | P_DATA16)
+#define OPC_PADDUB      (0xdc | P_EXT | P_DATA16)
+#define OPC_PADDUW      (0xdd | P_EXT | P_DATA16)
 #define OPC_PAND        (0xdb | P_EXT | P_DATA16)
 #define OPC_PANDN       (0xdf | P_EXT | P_DATA16)
 #define OPC_PBLENDW     (0x0e | P_EXT3A | P_DATA16)
@@ -408,6 +412,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
 #define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
 #define OPC_PSUBQ       (0xfb | P_EXT | P_DATA16)
+#define OPC_PSUBSB      (0xe8 | P_EXT | P_DATA16)
+#define OPC_PSUBSW      (0xe9 | P_EXT | P_DATA16)
+#define OPC_PSUBUB      (0xd8 | P_EXT | P_DATA16)
+#define OPC_PSUBUW      (0xd9 | P_EXT | P_DATA16)
 #define OPC_PUNPCKLBW   (0x60 | P_EXT | P_DATA16)
 #define OPC_PUNPCKLWD   (0x61 | P_EXT | P_DATA16)
 #define OPC_PUNPCKLDQ   (0x62 | P_EXT | P_DATA16)
@@ -2591,9 +2599,21 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const add_insn[4] = {
         OPC_PADDB, OPC_PADDW, OPC_PADDD, OPC_PADDQ
     };
+    static int const ssadd_insn[4] = {
+        OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
+    };
+    static int const usadd_insn[4] = {
+        OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
+    };
     static int const sub_insn[4] = {
         OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
     };
+    static int const sssub_insn[4] = {
+        OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
+    };
+    static int const ussub_insn[4] = {
+        OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
+    };
     static int const mul_insn[4] = {
         OPC_UD2, OPC_PMULLW, OPC_PMULLD, OPC_UD2
     };
@@ -2631,9 +2651,21 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_add_vec:
         insn = add_insn[vece];
         goto gen_simd;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_insn[vece];
+        goto gen_simd;
+    case INDEX_op_usadd_vec:
+        insn = usadd_insn[vece];
+        goto gen_simd;
     case INDEX_op_sub_vec:
         insn = sub_insn[vece];
         goto gen_simd;
+    case INDEX_op_sssub_vec:
+        insn = sssub_insn[vece];
+        goto gen_simd;
+    case INDEX_op_ussub_vec:
+        insn = ussub_insn[vece];
+        goto gen_simd;
     case INDEX_op_mul_vec:
         insn = mul_insn[vece];
         goto gen_simd;
@@ -3007,6 +3039,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3074,6 +3110,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
+        return vece <= MO_16;
+
     default:
         return 0;
     }
-- 
2.17.2
