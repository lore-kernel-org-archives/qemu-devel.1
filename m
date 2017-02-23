Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVk-0005L0-RM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVg-0001jP-Nx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVg-0001j6-In
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:04 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrbKd034265
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t5vvh9d7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:03 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:00 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:30 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 05/15] target/ppc: add
 gen_op_update_ov_legacy() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Update cpu_ov/so using the helper

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 84 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ae7b43d..4c0e985 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -797,24 +797,43 @@ static inline void gen_op_update_ca_legacy(TCGv ca)
     tcg_gen_mov_tl(cpu_ca, ca);
 }
 
+static inline void gen_op_update_ov_legacy(TCGv ov)
+{
+    tcg_gen_mov_tl(cpu_ov, ov);
+    tcg_gen_or_tl(cpu_so, ov);
+}
+
+/* Sub functions with one operand and one immediate */
+#define GEN_UPDATE_OV(name, const_val)          \
+static void glue(gen_op_, name)(void)           \
+{                                               \
+    TCGv t0 = tcg_const_tl(const_val);          \
+    gen_op_update_ov_legacy(t0);                \
+    tcg_temp_free(t0);                          \
+}
+GEN_UPDATE_OV(set_ov, 1);
+GEN_UPDATE_OV(clear_ov, 0);
+
 static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
                                            TCGv arg1, TCGv arg2, int sub)
 {
     TCGv t0 = tcg_temp_new();
+    TCGv ov = tcg_temp_new();
 
-    tcg_gen_xor_tl(cpu_ov, arg0, arg2);
+    tcg_gen_xor_tl(ov, arg0, arg2);
     tcg_gen_xor_tl(t0, arg1, arg2);
     if (sub) {
-        tcg_gen_and_tl(cpu_ov, cpu_ov, t0);
+        tcg_gen_and_tl(ov, ov, t0);
     } else {
-        tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
+        tcg_gen_andc_tl(ov, ov, t0);
     }
     tcg_temp_free(t0);
     if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+        tcg_gen_ext32s_tl(ov, ov);
     }
-    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+    tcg_gen_shri_tl(ov, ov, TARGET_LONG_BITS - 1);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 }
 
 /* Common add function */
@@ -997,8 +1016,10 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_extu_i32_tl(ret, t3);
     }
     if (compute_ov) {
-        tcg_gen_extu_i32_tl(cpu_ov, t2);
-        tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+        TCGv ov = tcg_temp_new();
+        tcg_gen_extu_i32_tl(ov, t2);
+        gen_op_update_ov_legacy(ov);
+        tcg_temp_free(ov);
     }
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
@@ -1068,8 +1089,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_divu_i64(ret, t0, t1);
     }
     if (compute_ov) {
-        tcg_gen_mov_tl(cpu_ov, t2);
-        tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+        gen_op_update_ov_legacy(t2);
     }
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1249,6 +1269,7 @@ static void gen_mullwo(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv ov = tcg_temp_new();
 
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);
@@ -1261,8 +1282,9 @@ static void gen_mullwo(DisasContext *ctx)
 
     tcg_gen_sari_i32(t0, t0, 31);
     tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t1);
-    tcg_gen_extu_i32_tl(cpu_ov, t0);
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+    tcg_gen_extu_i32_tl(ov, t0);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
@@ -1316,14 +1338,16 @@ static void gen_mulldo(DisasContext *ctx)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv ov = tcg_temp_new();
 
     tcg_gen_muls2_i64(t0, t1, cpu_gpr[rA(ctx->opcode)],
                       cpu_gpr[rB(ctx->opcode)]);
     tcg_gen_mov_i64(cpu_gpr[rD(ctx->opcode)], t0);
 
     tcg_gen_sari_i64(t0, t0, 63);
-    tcg_gen_setcond_i64(TCG_COND_NE, cpu_ov, t0, t1);
-    tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
+    tcg_gen_setcond_i64(TCG_COND_NE, ov, t0, t1);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -4586,12 +4610,13 @@ static void gen_abso(DisasContext *ctx)
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
     TCGLabel *l3 = gen_new_label();
+    TCGv ov = tcg_temp_local_new();
+
     /* Start with XER OV disabled, the most likely case */
-    tcg_gen_movi_tl(cpu_ov, 0);
+    tcg_gen_movi_tl(ov, 0);
     tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rA(ctx->opcode)], 0, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, cpu_gpr[rA(ctx->opcode)], 0x80000000, l1);
-    tcg_gen_movi_tl(cpu_ov, 1);
-    tcg_gen_movi_tl(cpu_so, 1);
+    tcg_gen_movi_tl(ov, 1);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
@@ -4601,6 +4626,8 @@ static void gen_abso(DisasContext *ctx)
     gen_set_label(l3);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 }
 
 /* clcs */
@@ -4671,8 +4698,9 @@ static void gen_dozo(DisasContext *ctx)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
+    TCGv ov = tcg_temp_local_new();
     /* Start with XER OV disabled, the most likely case */
-    tcg_gen_movi_tl(cpu_ov, 0);
+    tcg_gen_movi_tl(ov, 0);
     tcg_gen_brcond_tl(TCG_COND_GE, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], l1);
     tcg_gen_sub_tl(t0, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     tcg_gen_xor_tl(t1, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
@@ -4680,8 +4708,7 @@ static void gen_dozo(DisasContext *ctx)
     tcg_gen_andc_tl(t1, t1, t2);
     tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], t0);
     tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l2);
-    tcg_gen_movi_tl(cpu_ov, 1);
-    tcg_gen_movi_tl(cpu_so, 1);
+    tcg_gen_movi_tl(ov, 1);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], 0);
@@ -4691,6 +4718,8 @@ static void gen_dozo(DisasContext *ctx)
     tcg_temp_free(t2);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 }
 
 /* dozi */
@@ -4795,9 +4824,10 @@ static void gen_mulo(DisasContext *ctx)
     TCGLabel *l1 = gen_new_label();
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv ov = tcg_temp_local_new();
     TCGv t2 = tcg_temp_new();
     /* Start with XER OV disabled, the most likely case */
-    tcg_gen_movi_tl(cpu_ov, 0);
+    tcg_gen_movi_tl(ov, 0);
     tcg_gen_extu_tl_i64(t0, cpu_gpr[rA(ctx->opcode)]);
     tcg_gen_extu_tl_i64(t1, cpu_gpr[rB(ctx->opcode)]);
     tcg_gen_mul_i64(t0, t0, t1);
@@ -4807,14 +4837,15 @@ static void gen_mulo(DisasContext *ctx)
     tcg_gen_trunc_i64_tl(cpu_gpr[rD(ctx->opcode)], t1);
     tcg_gen_ext32s_i64(t1, t0);
     tcg_gen_brcond_i64(TCG_COND_EQ, t0, t1, l1);
-    tcg_gen_movi_tl(cpu_ov, 1);
-    tcg_gen_movi_tl(cpu_so, 1);
+    tcg_gen_movi_tl(ov, 1);
     gen_set_label(l1);
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
     tcg_temp_free(t2);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    gen_op_update_ov_legacy(ov);
+    tcg_temp_free(ov);
 }
 
 /* nabs - nabs. */
@@ -4844,7 +4875,7 @@ static void gen_nabso(DisasContext *ctx)
     tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     gen_set_label(l2);
     /* nabs never overflows */
-    tcg_gen_movi_tl(cpu_ov, 0);
+    gen_op_clear_ov();
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
 }
@@ -5474,7 +5505,7 @@ static inline void gen_405_mulladd_insn(DisasContext *ctx, int opc2, int opc3,
 
             if (opc3 & 0x10) {
                 /* Start with XER OV disabled, the most likely case */
-                tcg_gen_movi_tl(cpu_ov, 0);
+                gen_op_clear_ov();
             }
             if (opc3 & 0x01) {
                 /* Signed */
@@ -5497,8 +5528,7 @@ static inline void gen_405_mulladd_insn(DisasContext *ctx, int opc2, int opc3,
             }
             if (opc3 & 0x10) {
                 /* Check overflow */
-                tcg_gen_movi_tl(cpu_ov, 1);
-                tcg_gen_movi_tl(cpu_so, 1);
+                gen_op_set_ov();
             }
             gen_set_label(l1);
             tcg_gen_mov_tl(cpu_gpr[rt], t0);
-- 
2.7.4
