Received: from eggs.gnu.org ([2001:4830:134:3::10]:55643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUP-00089l-V6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUO-0001ww-TN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:09 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUO-0001vm-L9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:08 -0500
Received: by mail-pf0-x244.google.com with SMTP id j28so9963315pfk.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:37 -0800
Message-Id: <20171218174552.18871-9-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/23] target/arm: Handle SVE registers in
 write_fp_dreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

When storing to an AdvSIMD FP register, all of the high
bits of the SVE register are zeroed.  At the same time,
export the function for use in translate-sve.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h |  1 +
 target/arm/translate-a64.c | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9014b5bf8b..07861fa9c6 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -35,6 +35,7 @@ TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
 TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
 TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
+void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
 
 /* We should have at some point before trying to access an FP register
  * done the necessary access check, so assert that
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8be1660661..b951045820 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -533,13 +533,28 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
     return v;
 }
 
-static void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
+/* Clear the bits above an 64-bit vector.
+ * If SVE is not enabled, then there are only 128 bits in the vector.
+ */
+static void clear_vec_high(DisasContext *s, int rd)
 {
+    unsigned ofs = fp_reg_offset(s, rd, MO_64);
+    unsigned vsz = vec_full_reg_size(s);
     TCGv_i64 tcg_zero = tcg_const_i64(0);
 
-    tcg_gen_st_i64(v, cpu_env, fp_reg_offset(s, reg, MO_64));
-    tcg_gen_st_i64(tcg_zero, cpu_env, fp_reg_hi_offset(s, reg));
+    tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
     tcg_temp_free_i64(tcg_zero);
+    if (vsz > 16) {
+        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
+    }
+}
+
+void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
+{
+    unsigned ofs = fp_reg_offset(s, reg, MO_64);
+
+    tcg_gen_st_i64(v, cpu_env, ofs);
+    clear_vec_high(s, reg);
 }
 
 static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
@@ -1015,17 +1030,6 @@ static void write_vec_element_i32(DisasContext *s, TCGv_i32 tcg_src,
     }
 }
 
-/* Clear the high 64 bits of a 128 bit vector (in general non-quad
- * vector ops all need to do this).
- */
-static void clear_vec_high(DisasContext *s, int rd)
-{
-    TCGv_i64 tcg_zero = tcg_const_i64(0);
-
-    write_vec_element(s, tcg_zero, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_zero);
-}
-
 /* Store from vector register to memory */
 static void do_vec_st(DisasContext *s, int srcidx, int element,
                       TCGv_i64 tcg_addr, int size)
-- 
2.14.3
