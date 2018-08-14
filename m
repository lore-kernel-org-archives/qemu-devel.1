Received: from eggs.gnu.org ([2001:4830:134:3::10]:52948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdw3-0005Oj-7N
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduO-0006ua-Q0
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduO-0006uC-H3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduN-0007Qi-FY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:19:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:14 +0100
Message-Id: <20180814181815.23348-45-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/45] target/arm: Reorganize SVE WHILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The pseudocode for this operation is an increment + compare loop,
so comparing <= the maximum integer produces an all-true predicate.

Rather than bound in both the inline code and the helper, pass the
helper the number of predicate bits to set instead of the number
of predicate elements to set.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c    |  5 ----
 target/arm/translate-sve.c | 49 +++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9bd0694d55e..87594a8adb4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2846,11 +2846,6 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
         return flags;
     }
 
-    /* Scale from predicate element count to bits.  */
-    count <<= esz;
-    /* Bound to the bits in the predicate.  */
-    count = MIN(count, oprsz * 8);
-
     /* Set all of the requested bits.  */
     for (i = 0; i < count / 64; ++i) {
         d->p[i] = esz_mask;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9dd4c38bab7..89efc80ee70 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3173,19 +3173,19 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a, uint32_t insn)
 
 static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
 {
-    if (!sve_access_check(s)) {
-        return true;
-    }
-
-    TCGv_i64 op0 = read_cpu_reg(s, a->rn, 1);
-    TCGv_i64 op1 = read_cpu_reg(s, a->rm, 1);
-    TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2, t3;
     TCGv_ptr ptr;
     unsigned desc, vsz = vec_full_reg_size(s);
     TCGCond cond;
 
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    op0 = read_cpu_reg(s, a->rn, 1);
+    op1 = read_cpu_reg(s, a->rm, 1);
+
     if (!a->sf) {
         if (a->u) {
             tcg_gen_ext32u_i64(op0, op0);
@@ -3198,32 +3198,47 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
 
     /* For the helper, compress the different conditions into a computation
      * of how many iterations for which the condition is true.
-     *
-     * This is slightly complicated by 0 <= UINT64_MAX, which is nominally
-     * 2**64 iterations, overflowing to 0.  Of course, predicate registers
-     * aren't that large, so any value >= predicate size is sufficient.
      */
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     tcg_gen_sub_i64(t0, op1, op0);
 
-    /* t0 = MIN(op1 - op0, vsz).  */
-    tcg_gen_movi_i64(t1, vsz);
-    tcg_gen_umin_i64(t0, t0, t1);
+    tmax = tcg_const_i64(vsz >> a->esz);
     if (a->eq) {
         /* Equality means one more iteration.  */
         tcg_gen_addi_i64(t0, t0, 1);
+
+        /* If op1 is max (un)signed integer (and the only time the addition
+         * above could overflow), then we produce an all-true predicate by
+         * setting the count to the vector length.  This is because the
+         * pseudocode is described as an increment + compare loop, and the
+         * max integer would always compare true.
+         */
+        tcg_gen_movi_i64(t1, (a->sf
+                              ? (a->u ? UINT64_MAX : INT64_MAX)
+                              : (a->u ? UINT32_MAX : INT32_MAX)));
+        tcg_gen_movcond_i64(TCG_COND_EQ, t0, op1, t1, tmax, t0);
     }
 
-    /* t0 = (condition true ? t0 : 0).  */
+    /* Bound to the maximum.  */
+    tcg_gen_umin_i64(t0, t0, tmax);
+    tcg_temp_free_i64(tmax);
+
+    /* Set the count to zero if the condition is false.  */
     cond = (a->u
             ? (a->eq ? TCG_COND_LEU : TCG_COND_LTU)
             : (a->eq ? TCG_COND_LE : TCG_COND_LT));
     tcg_gen_movi_i64(t1, 0);
     tcg_gen_movcond_i64(cond, t0, op0, op1, t0, t1);
+    tcg_temp_free_i64(t1);
 
+    /* Since we're bounded, pass as a 32-bit type.  */
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, t0);
     tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+
+    /* Scale elements to bits.  */
+    tcg_gen_shli_i32(t2, t2, a->esz);
 
     desc = (vsz / 8) - 2;
     desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
-- 
2.18.0
