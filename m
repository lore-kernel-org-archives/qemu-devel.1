Received: from eggs.gnu.org ([2001:4830:134:3::10]:56129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUn-00005M-1l
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUl-0002PO-Q8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:33 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUl-0002OU-IF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id b11so9422099pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:52 -0800
Message-Id: <20171218174552.18871-24-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/23] target/arm: Implement SVE Element Count
 Group, register destinations
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.def         |  18 ++++++++
 2 files changed, 121 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a6c31e0e9c..91eb4e797a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -61,6 +61,11 @@ static int tszimm_shl(int x)
     return x - tszimm_esz(x);
 }
 
+static inline int plus1(int x)
+{
+    return x + 1;
+}
+
 /*
  * Include the generated decoder.
  */
@@ -815,6 +820,104 @@ static unsigned decode_pred_count(unsigned fullsz, int pattern, int esz)
     }
 }
 
+void trans_CNT_r(DisasContext *s, arg_CNT_r *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+
+    tcg_gen_movi_i64(cpu_reg(s, a->rd), numelem * a->imm);
+}
+
+void trans_INC_DEC_r(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm * (a->d ? -1 : 1);
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+
+    tcg_gen_addi_i64(reg, reg, inc);
+}
+
+void trans_sat_INC_DEC_r_32(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm * (a->d ? -1 : 1);
+    int64_t ibound;
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+    TCGv_i64 bound;
+    TCGCond cond;
+
+    /* Use normal 64-bit arithmetic to detect 32-bit overflow.  */
+    if (a->u) {
+        tcg_gen_ext32u_i64(reg, reg);
+    } else {
+        tcg_gen_ext32s_i64(reg, reg);
+    }
+    tcg_gen_addi_i64(reg, reg, inc);
+    if (a->d) {
+        if (a->u) {
+            ibound = 0;
+            cond = TCG_COND_LTU;
+        } else {
+            ibound = INT32_MIN;
+            cond = TCG_COND_LT;
+        }
+    } else {
+        if (a->u) {
+            ibound = UINT32_MAX;
+            cond = TCG_COND_GTU;
+        } else {
+            ibound = INT32_MAX;
+            cond = TCG_COND_GT;
+        }
+    }
+    bound = tcg_const_i64(ibound);
+    tcg_gen_movcond_i64(cond, reg, reg, bound, bound, reg);
+    tcg_temp_free_i64(bound);
+}
+
+void trans_sat_INC_DEC_r_64(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm * (a->d ? -1 : 1);
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 zero;
+
+    if (a->u) {
+        tcg_gen_addi_i64(t0, reg, inc);
+
+        /* Bound the result.  */
+        if (a->d) {
+            tcg_gen_movi_i64(t1, 0);
+            tcg_gen_movcond_i64(TCG_COND_LTU, reg, t0, reg, t0, t1);
+        } else {
+            tcg_gen_movi_i64(t1, -1);
+            tcg_gen_movcond_i64(TCG_COND_LTU, reg, reg, t0, t0, t1);
+        }
+    } else {
+        /* Detect signed overflow for addition.  */
+        tcg_gen_xori_i64(t0, reg, inc);
+        tcg_gen_addi_i64(reg, reg, inc);
+        tcg_gen_xori_i64(t0, reg, inc);
+        tcg_gen_andc_i64(t0, t1, t0);
+
+        /* Because we know the increment, we know which way it overflowed.  */
+        tcg_gen_movi_i64(t1, a->d ? INT64_MIN : INT64_MAX);
+
+        /* Bound the result.  */
+        zero = tcg_const_i64(0);
+        tcg_gen_movcond_i64(TCG_COND_LT, reg, t0, zero, t1, reg);
+
+        tcg_temp_free_i64(zero);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /* For PTRUE, PTRUES, PFALSE, SETFFR.  */
 void trans_pred_set(DisasContext *s, arg_pred_set *a, uint32_t insn)
 {
diff --git a/target/arm/sve.def b/target/arm/sve.def
index df2730eb73..da533ba666 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -24,6 +24,7 @@
 
 %imm9_16_10		16:s6 10:3
 %imm6_22_5		22:1 5:5
+%imm4_16_p1             16:4 !function=plus1
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz		22:2 5:5 !function=tszimm_esz
@@ -56,6 +57,7 @@
 &rprrr_esz		rd pg rn rm ra esz
 &rpri_esz		rd pg rn imm esz
 &pred_set		rd pat esz i s
+&incdec_cnt		rd pat esz imm d u
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -101,6 +103,10 @@
 @pd_rn_i9		........ ........ ...... rn:5 . rd:4		&rri imm=%imm9_16_10
 @rd_rn_i9		........ ........ ...... rn:5 rd:5		&rri imm=%imm9_16_10
 
+# One register, pattern, and uint4+1.
+# User must fill in U and D.
+@incdec_cnt		........ esz:2 .. .... ...... pat:5 rd:5	&incdec_cnt imm=%imm4_16_p1
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -275,6 +281,18 @@ FEXPA			00000100 .. 1 00000 101110 ..... .....		@rd_rn_esz # Note size != 0
 # SVE floating-point trig select coefficient
 FTSSEL			00000100 .. 1 ..... 101100 ..... .....		@rd_rn_rm_esz # Note size != 0
 
+### SVE Element Count Group
+
+# SVE element count
+CNT_r			00000100 .. 10 .... 1110 0   0   ..... .....	@incdec_cnt d=0 u=1
+
+# SVE inc/dec register by element count
+INC_DEC_r		00000100 .. 11 .... 1110 0   d:1 ..... .....	@incdec_cnt u=1
+
+# SVE saturating inc/dec register by element count
+sat_INC_DEC_r_32	00000100 .. 10 .... 1111 d:1 u:1 ..... .....	@incdec_cnt
+sat_INC_DEC_r_64	00000100 .. 11 .... 1111 d:1 u:1 ..... .....	@incdec_cnt
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3
