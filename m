Received: from eggs.gnu.org ([2001:4830:134:3::10]:39195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonn-00047F-7A
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonm-00032y-4S
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:23 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVonl-00032b-Sf
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:22 -0400
Received: by mail-pf0-x22a.google.com with SMTP id q1-v6so676563pff.13
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:32 -1000
Message-Id: <20180621015359.12018-9-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 08/35] target/arm: Implement SVE Floating
 Point Accumulating Reduction Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  7 +++++
 target/arm/sve_helper.c    | 56 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 45 ++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  5 ++++
 4 files changed, 113 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index eb0645dd43..68e55a8d03 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -720,6 +720,13 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
+                   i64, i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
+                   i64, i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fadda_d, TCG_CALL_NO_RWG,
+                   i64, i64, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve_fadd_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve_fadd_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aeb4ccadd9..990e5f3900 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2811,6 +2811,62 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
     return predtest_ones(d, oprsz, esz_mask);
 }
 
+uint64_t HELPER(sve_fadda_h)(uint64_t nn, void *vm, void *vg,
+                             void *status, uint32_t desc)
+{
+    intptr_t i = 0, opr_sz = simd_oprsz(desc);
+    float16 result = nn;
+
+    do {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                float16 mm = *(float16 *)(vm + H1_2(i));
+                result = float16_add(result, mm, status);
+            }
+            i += sizeof(float16), pg >>= sizeof(float16);
+        } while (i & 15);
+    } while (i < opr_sz);
+
+    return result;
+}
+
+uint64_t HELPER(sve_fadda_s)(uint64_t nn, void *vm, void *vg,
+                             void *status, uint32_t desc)
+{
+    intptr_t i = 0, opr_sz = simd_oprsz(desc);
+    float32 result = nn;
+
+    do {
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+        do {
+            if (pg & 1) {
+                float32 mm = *(float32 *)(vm + H1_2(i));
+                result = float32_add(result, mm, status);
+            }
+            i += sizeof(float32), pg >>= sizeof(float32);
+        } while (i & 15);
+    } while (i < opr_sz);
+
+    return result;
+}
+
+uint64_t HELPER(sve_fadda_d)(uint64_t nn, void *vm, void *vg,
+                             void *status, uint32_t desc)
+{
+    intptr_t i = 0, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i++) {
+        if (pg[H1(i)] & 1) {
+            nn = float64_add(nn, m[i], status);
+        }
+    }
+
+    return nn;
+}
+
 /* Fully general three-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index acad6374ef..483ad33179 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3383,6 +3383,51 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
+/*
+ *** SVE Floating Point Accumulating Reduction Group
+ */
+
+static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    typedef void fadda_fn(TCGv_i64, TCGv_i64, TCGv_ptr,
+                          TCGv_ptr, TCGv_ptr, TCGv_i32);
+    static fadda_fn * const fns[3] = {
+        gen_helper_sve_fadda_h,
+        gen_helper_sve_fadda_s,
+        gen_helper_sve_fadda_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr t_rm, t_pg, t_fpst;
+    TCGv_i64 t_val;
+    TCGv_i32 t_desc;
+
+    if (a->esz == 0) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    t_val = load_esz(cpu_env, vec_reg_offset(s, a->rn, 0, a->esz), a->esz);
+    t_rm = tcg_temp_new_ptr();
+    t_pg = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(t_rm, cpu_env, vec_full_reg_offset(s, a->rm));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
+    t_fpst = get_fpstatus_ptr(a->esz == MO_16);
+    t_desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+
+    fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
+
+    tcg_temp_free_i32(t_desc);
+    tcg_temp_free_ptr(t_fpst);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_ptr(t_rm);
+
+    write_fp_dreg(s, a->rd, t_val);
+    tcg_temp_free_i64(t_val);
+    return true;
+}
+
 /*
  *** SVE Floating Point Arithmetic - Unpredicated Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 70e5a3aeb5..ba10cddb8a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -676,6 +676,11 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+### SVE FP Accumulating Reduction Group
+
+# SVE floating-point serial reduction (predicated)
+FADDA           01100101 .. 011 000 001 ... ..... .....         @rdn_pg_rm
+
 ### SVE Floating Point Arithmetic - Unpredicated Group
 
 # SVE floating-point arithmetic (unpredicated)
-- 
2.17.1
