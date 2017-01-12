Received: from eggs.gnu.org ([2001:4830:134:3::10]:45960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0002ol-8u
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjq-0006MR-4k
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:23 +1100
Message-Id: <20170112020327.24882-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/67] target-ppc: rename CRF_* defines as
 CRF_*_BIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Add _BIT to CRF_[GT,LT,EQ_SO] and introduce CRF_[GT,LT,EQ,SO] for usage
without shifts in the code. This would simplify the code.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        | 21 +++++++++++++--------
 target/ppc/int_helper.c | 30 +++++++++++++++---------------
 target/ppc/translate.c  | 14 +++++++-------
 3 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2a50c43..b6782ba 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1301,14 +1301,19 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
 
 /*****************************************************************************/
 /* CRF definitions */
-#define CRF_LT        3
-#define CRF_GT        2
-#define CRF_EQ        1
-#define CRF_SO        0
-#define CRF_CH        (1 << CRF_LT)
-#define CRF_CL        (1 << CRF_GT)
-#define CRF_CH_OR_CL  (1 << CRF_EQ)
-#define CRF_CH_AND_CL (1 << CRF_SO)
+#define CRF_LT_BIT    3
+#define CRF_GT_BIT    2
+#define CRF_EQ_BIT    1
+#define CRF_SO_BIT    0
+#define CRF_LT        (1 << CRF_LT_BIT)
+#define CRF_GT        (1 << CRF_GT_BIT)
+#define CRF_EQ        (1 << CRF_EQ_BIT)
+#define CRF_SO        (1 << CRF_SO_BIT)
+/* For SPE extensions */
+#define CRF_CH        (1 << CRF_LT_BIT)
+#define CRF_CL        (1 << CRF_GT_BIT)
+#define CRF_CH_OR_CL  (1 << CRF_EQ_BIT)
+#define CRF_CH_AND_CL (1 << CRF_SO_BIT)
 
 /* XER definitions */
 #define XER_SO  31
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 2d57c9a..1667c94 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -167,7 +167,7 @@ target_ulong helper_cnttzw(target_ulong t)
 
 uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 {
-    return hasvalue(rb, ra) ? 1 << CRF_GT : 0;
+    return hasvalue(rb, ra) ? CRF_GT : 0;
 }
 
 #undef pattern
@@ -2563,9 +2563,9 @@ static void bcd_put_digit(ppc_avr_t *bcd, uint8_t digit, int n)
 static int bcd_cmp_zero(ppc_avr_t *bcd)
 {
     if (bcd->u64[HI_IDX] == 0 && (bcd->u64[LO_IDX] >> 4) == 0) {
-        return 1 << CRF_EQ;
+        return CRF_EQ;
     } else {
-        return (bcd_get_sgn(bcd) == 1) ? 1 << CRF_GT : 1 << CRF_LT;
+        return (bcd_get_sgn(bcd) == 1) ? CRF_GT : CRF_LT;
     }
 }
 
@@ -2677,25 +2677,25 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
         if (sgna == sgnb) {
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
             zero = bcd_add_mag(&result, a, b, &invalid, &overflow);
-            cr = (sgna > 0) ? 1 << CRF_GT : 1 << CRF_LT;
+            cr = (sgna > 0) ? CRF_GT : CRF_LT;
         } else if (bcd_cmp_mag(a, b) > 0) {
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
             zero = bcd_sub_mag(&result, a, b, &invalid, &overflow);
-            cr = (sgna > 0) ? 1 << CRF_GT : 1 << CRF_LT;
+            cr = (sgna > 0) ? CRF_GT : CRF_LT;
         } else {
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
             zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
-            cr = (sgnb > 0) ? 1 << CRF_GT : 1 << CRF_LT;
+            cr = (sgnb > 0) ? CRF_GT : CRF_LT;
         }
     }
 
     if (unlikely(invalid)) {
         result.u64[HI_IDX] = result.u64[LO_IDX] = -1;
-        cr = 1 << CRF_SO;
+        cr = CRF_SO;
     } else if (overflow) {
-        cr |= 1 << CRF_SO;
+        cr |= CRF_SO;
     } else if (zero) {
-        cr = 1 << CRF_EQ;
+        cr = CRF_EQ;
     }
 
     *r = result;
@@ -2745,7 +2745,7 @@ uint32_t helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     cr = bcd_cmp_zero(&ret);
 
     if (unlikely(invalid)) {
-        cr = 1 << CRF_SO;
+        cr = CRF_SO;
     }
 
     *r = ret;
@@ -2775,11 +2775,11 @@ uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     cr = bcd_cmp_zero(b);
 
     if (ox_flag) {
-        cr |= 1 << CRF_SO;
+        cr |= CRF_SO;
     }
 
     if (unlikely(invalid)) {
-        cr = 1 << CRF_SO;
+        cr = CRF_SO;
     }
 
     *r = ret;
@@ -2823,7 +2823,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     cr = bcd_cmp_zero(&ret);
 
     if (unlikely(invalid)) {
-        cr = 1 << CRF_SO;
+        cr = CRF_SO;
     }
 
     *r = ret;
@@ -2862,11 +2862,11 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     cr = bcd_cmp_zero(b);
 
     if (ox_flag) {
-        cr |= 1 << CRF_SO;
+        cr |= CRF_SO;
     }
 
     if (unlikely(invalid)) {
-        cr = 1 << CRF_SO;
+        cr = CRF_SO;
     }
 
     *r = ret;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6bdc433..d3bda1b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -612,17 +612,17 @@ static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 
     tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1);
     tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_LT);
+    tcg_gen_shli_i32(t1, t1, CRF_LT_BIT);
     tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
 
     tcg_gen_setcond_tl((s ? TCG_COND_GT: TCG_COND_GTU), t0, arg0, arg1);
     tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_GT);
+    tcg_gen_shli_i32(t1, t1, CRF_GT_BIT);
     tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
 
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, arg0, arg1);
     tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_EQ);
+    tcg_gen_shli_i32(t1, t1, CRF_EQ_BIT);
     tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
 
     tcg_temp_free(t0);
@@ -748,7 +748,7 @@ static void gen_cmprb(DisasContext *ctx)
         tcg_gen_and_i32(src2lo, src2lo, src2hi);
         tcg_gen_or_i32(crf, crf, src2lo);
     }
-    tcg_gen_shli_i32(crf, crf, CRF_GT);
+    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
     tcg_temp_free_i32(src1);
     tcg_temp_free_i32(src2);
     tcg_temp_free_i32(src2lo);
@@ -2978,7 +2978,7 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
     l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 1 << CRF_EQ);
+    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
     tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_reserve, -1);
@@ -3072,7 +3072,7 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
     l1 = gen_new_label();
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 1 << CRF_EQ);
+    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
 
     if (unlikely(ctx->le_mode)) {
         gpr1 = cpu_gpr[reg + 1];
@@ -4253,7 +4253,7 @@ static void gen_slbfee_(DisasContext *ctx)
     l2 = gen_new_label();
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rS(ctx->opcode)], -1, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 1 << CRF_EQ);
+    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rS(ctx->opcode)], 0);
-- 
2.9.3
