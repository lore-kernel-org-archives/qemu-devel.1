Received: from eggs.gnu.org ([2001:4830:134:3::10]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVl-0005Mb-JI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVh-0001js-CK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVh-0001jE-3K
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJshXZ009646
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t6050x9v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:03 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:00 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:29 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 04/15] target/ppc: add
 gen_op_update_ca_legacy() helper
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

Update cpu_ca using the helper routine. This will help in consolidating
xer flags code

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 91 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b09e16f..ae7b43d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -792,6 +792,11 @@ static void gen_cmpb(DisasContext *ctx)
 
 /***                           Integer arithmetic                          ***/
 
+static inline void gen_op_update_ca_legacy(TCGv ca)
+{
+    tcg_gen_mov_tl(cpu_ca, ca);
+}
+
 static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
                                            TCGv arg1, TCGv arg2, int sub)
 {
@@ -818,11 +823,16 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                                     bool compute_ov, bool compute_rc0)
 {
     TCGv t0 = ret;
+    TCGv ca = tcg_temp_new();
 
     if (compute_ca || compute_ov) {
         t0 = tcg_temp_new();
     }
 
+    if (add_ca) {
+        tcg_gen_mov_tl(ca, cpu_ca);
+    }
+
     if (compute_ca) {
         if (NARROW_MODE(ctx)) {
             /* Caution: a non-obvious corner case of the spec is that we
@@ -832,32 +842,34 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_gen_xor_tl(t1, arg1, arg2);        /* add without carry */
             tcg_gen_add_tl(t0, arg1, arg2);
             if (add_ca) {
-                tcg_gen_add_tl(t0, t0, cpu_ca);
+                tcg_gen_add_tl(t0, t0, ca);
             }
-            tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ carry */
+            tcg_gen_xor_tl(ca, t0, t1);        /* bits changed w/ carry */
             tcg_temp_free(t1);
-            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
-            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            tcg_gen_extract_tl(ca, ca, 32, 1);
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
-                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, cpu_ca, zero);
-                tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, arg2, zero);
+                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
+                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
             } else {
-                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
+                tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
             tcg_temp_free(zero);
         }
     } else {
         tcg_gen_add_tl(t0, arg1, arg2);
         if (add_ca) {
-            tcg_gen_add_tl(t0, t0, cpu_ca);
+            tcg_gen_add_tl(t0, t0, ca);
         }
     }
 
     if (compute_ov) {
         gen_op_arith_compute_ov(ctx, t0, arg1, arg2, 0);
     }
+    if (compute_ca) {
+        gen_op_update_ca_legacy(ca);
+    }
     if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, t0);
     }
@@ -866,6 +878,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_mov_tl(ret, t0);
         tcg_temp_free(t0);
     }
+    tcg_temp_free(ca);
 }
 /* Add functions with two operands */
 #define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)         \
@@ -1327,10 +1340,14 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      bool compute_ov, bool compute_rc0)
 {
     TCGv t0 = ret;
+    TCGv ca = tcg_temp_new();
 
     if (compute_ca || compute_ov) {
         t0 = tcg_temp_new();
     }
+    if (add_ca) {
+        tcg_gen_extract_tl(ca, cpu_xer, XER_CA_BIT, 1);
+    }
 
     if (compute_ca) {
         /* dest = ~arg1 + arg2 [+ ca].  */
@@ -1342,34 +1359,33 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             TCGv t1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
             if (add_ca) {
-                tcg_gen_add_tl(t0, arg2, cpu_ca);
+                tcg_gen_add_tl(t0, arg2, ca);
             } else {
                 tcg_gen_addi_tl(t0, arg2, 1);
             }
             tcg_gen_xor_tl(t1, arg2, inv1);         /* add without carry */
             tcg_gen_add_tl(t0, t0, inv1);
             tcg_temp_free(inv1);
-            tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes w/ carry */
+            tcg_gen_xor_tl(ca, t0, t1);         /* bits changes w/ carry */
             tcg_temp_free(t1);
-            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
-            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            tcg_gen_extract_tl(ca, ca, 32, 1);    /* extract bit 32 */
         } else if (add_ca) {
             TCGv zero, inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
             zero = tcg_const_tl(0);
-            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
-            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            tcg_gen_add2_tl(t0, ca, arg2, zero, ca, zero);
+            tcg_gen_add2_tl(t0, ca, t0, ca, inv1, zero);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
-            tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
+            tcg_gen_setcond_tl(TCG_COND_GEU, ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
            standard ~arg1 + arg2 + ca to arg2 - arg1 + ca - 1.  */
         tcg_gen_sub_tl(t0, arg2, arg1);
-        tcg_gen_add_tl(t0, t0, cpu_ca);
+        tcg_gen_add_tl(t0, t0, ca);
         tcg_gen_subi_tl(t0, t0, 1);
     } else {
         tcg_gen_sub_tl(t0, arg2, arg1);
@@ -1378,6 +1394,9 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
     if (compute_ov) {
         gen_op_arith_compute_ov(ctx, t0, arg1, arg2, 1);
     }
+    if (compute_ca) {
+        gen_op_update_ca_legacy(ca);
+    }
     if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, t0);
     }
@@ -1386,6 +1405,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_mov_tl(ret, t0);
         tcg_temp_free(t0);
     }
+    tcg_temp_free(ca);
 }
 /* Sub functions with Two operands functions */
 #define GEN_INT_ARITH_SUBF(name, opc3, add_ca, compute_ca, compute_ov)        \
@@ -2119,23 +2139,27 @@ static void gen_srawi(DisasContext *ctx)
     int sh = SH(ctx->opcode);
     TCGv dst = cpu_gpr[rA(ctx->opcode)];
     TCGv src = cpu_gpr[rS(ctx->opcode)];
+    TCGv ca = tcg_temp_new();
+
     if (sh == 0) {
         tcg_gen_ext32s_tl(dst, src);
-        tcg_gen_movi_tl(cpu_ca, 0);
+        tcg_gen_movi_tl(ca, 0);
     } else {
         TCGv t0;
         tcg_gen_ext32s_tl(dst, src);
-        tcg_gen_andi_tl(cpu_ca, dst, (1ULL << sh) - 1);
+        tcg_gen_andi_tl(ca, dst, (1ULL << sh) - 1);
         t0 = tcg_temp_new();
         tcg_gen_sari_tl(t0, dst, TARGET_LONG_BITS - 1);
-        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
+        tcg_gen_and_tl(ca, ca, t0);
         tcg_temp_free(t0);
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        tcg_gen_setcondi_tl(TCG_COND_NE, ca, ca, 0);
         tcg_gen_sari_tl(dst, dst, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
+    gen_op_update_ca_legacy(ca);
+    tcg_temp_free(ca);
 }
 
 /* srw & srw. */
@@ -2197,22 +2221,25 @@ static inline void gen_sradi(DisasContext *ctx, int n)
     int sh = SH(ctx->opcode) + (n << 5);
     TCGv dst = cpu_gpr[rA(ctx->opcode)];
     TCGv src = cpu_gpr[rS(ctx->opcode)];
+    TCGv ca = tcg_temp_new();
     if (sh == 0) {
         tcg_gen_mov_tl(dst, src);
-        tcg_gen_movi_tl(cpu_ca, 0);
+        tcg_gen_movi_tl(ca, 0);
     } else {
         TCGv t0;
-        tcg_gen_andi_tl(cpu_ca, src, (1ULL << sh) - 1);
+        tcg_gen_andi_tl(ca, src, (1ULL << sh) - 1);
         t0 = tcg_temp_new();
         tcg_gen_sari_tl(t0, src, TARGET_LONG_BITS - 1);
-        tcg_gen_and_tl(cpu_ca, cpu_ca, t0);
+        tcg_gen_and_tl(ca, ca, t0);
         tcg_temp_free(t0);
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
+        tcg_gen_setcondi_tl(TCG_COND_NE, ca, ca, 0);
         tcg_gen_sari_tl(dst, src, sh);
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
+    gen_op_update_ca_legacy(ca);
+    tcg_temp_free(ca);
 }
 
 static void gen_sradi0(DisasContext *ctx)
@@ -4990,16 +5017,20 @@ static void gen_sraiq(DisasContext *ctx)
     TCGLabel *l1 = gen_new_label();
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
+    TCGv ca = tcg_temp_local_new();
+
     tcg_gen_shri_tl(t0, cpu_gpr[rS(ctx->opcode)], sh);
     tcg_gen_shli_tl(t1, cpu_gpr[rS(ctx->opcode)], 32 - sh);
     tcg_gen_or_tl(t0, t0, t1);
     gen_store_spr(SPR_MQ, t0);
-    tcg_gen_movi_tl(cpu_ca, 0);
+    tcg_gen_movi_tl(ca, 0);
     tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
     tcg_gen_brcondi_tl(TCG_COND_GE, cpu_gpr[rS(ctx->opcode)], 0, l1);
-    tcg_gen_movi_tl(cpu_ca, 1);
+    tcg_gen_movi_tl(ca, 1);
     gen_set_label(l1);
     tcg_gen_sari_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], sh);
+    gen_op_update_ca_legacy(ca);
+    tcg_temp_free(ca);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     if (unlikely(Rc(ctx->opcode) != 0))
@@ -5014,6 +5045,8 @@ static void gen_sraq(DisasContext *ctx)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_local_new();
     TCGv t2 = tcg_temp_local_new();
+    TCGv ca = tcg_temp_local_new();
+
     tcg_gen_andi_tl(t2, cpu_gpr[rB(ctx->opcode)], 0x1F);
     tcg_gen_shr_tl(t0, cpu_gpr[rS(ctx->opcode)], t2);
     tcg_gen_sar_tl(t1, cpu_gpr[rS(ctx->opcode)], t2);
@@ -5028,11 +5061,13 @@ static void gen_sraq(DisasContext *ctx)
     gen_set_label(l1);
     tcg_temp_free(t0);
     tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], t1);
-    tcg_gen_movi_tl(cpu_ca, 0);
+    tcg_gen_movi_tl(ca, 0);
     tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l2);
     tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l2);
-    tcg_gen_movi_tl(cpu_ca, 1);
+    tcg_gen_movi_tl(ca, 1);
     gen_set_label(l2);
+    gen_op_update_ca_legacy(ca);
+    tcg_temp_free(ca);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
     if (unlikely(Rc(ctx->opcode) != 0))
-- 
2.7.4
