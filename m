Received: from eggs.gnu.org ([2001:4830:134:3::10]:39368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooE-0004gg-0s
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooC-0003KT-35
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:50 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:39902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooB-0003K2-QY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:47 -0400
Received: by mail-pl0-x22b.google.com with SMTP id s24-v6so752994plq.6
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:46 -1000
Message-Id: <20180621015359.12018-23-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 22/35] target/arm: Implement SVE
 floating-point trig multiply-add coefficient
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
 target/arm/helper-sve.h    |  4 +++
 target/arm/sve_helper.c    | 70 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 27 +++++++++++++++
 target/arm/sve.decode      |  3 ++
 4 files changed, 104 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 44a98440c9..aca137fc37 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1037,6 +1037,10 @@ DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 06e963e9c2..3dc35d8b12 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3428,6 +3428,76 @@ DO_FPCMP_PPZ0_ALL(sve_fcmlt0, DO_FCMLT)
 DO_FPCMP_PPZ0_ALL(sve_fcmeq0, DO_FCMEQ)
 DO_FPCMP_PPZ0_ALL(sve_fcmne0, DO_FCMNE)
 
+/* FP Trig Multiply-Add. */
+
+void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+{
+    static const float16 coeff[16] = {
+        0x3c00, 0xb155, 0x2030, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+        0x3c00, 0xb800, 0x293a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float16);
+    intptr_t x = simd_data(desc);
+    float16 *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i++) {
+        float16 mm = m[i];
+        intptr_t xx = x;
+        if (float16_is_neg(mm)) {
+            mm = float16_abs(mm);
+            xx += 8;
+        }
+        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, vs);
+    }
+}
+
+void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+{
+    static const float32 coeff[16] = {
+        0x3f800000, 0xbe2aaaab, 0x3c088886, 0xb95008b9,
+        0x36369d6d, 0x00000000, 0x00000000, 0x00000000,
+        0x3f800000, 0xbf000000, 0x3d2aaaa6, 0xbab60705,
+        0x37cd37cc, 0x00000000, 0x00000000, 0x00000000,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float32);
+    intptr_t x = simd_data(desc);
+    float32 *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i++) {
+        float32 mm = m[i];
+        intptr_t xx = x;
+        if (float32_is_neg(mm)) {
+            mm = float32_abs(mm);
+            xx += 8;
+        }
+        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, vs);
+    }
+}
+
+void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
+{
+    static const float64 coeff[16] = {
+        0x3ff0000000000000ull, 0xbfc5555555555543ull,
+        0x3f8111111110f30cull, 0xbf2a01a019b92fc6ull,
+        0x3ec71de351f3d22bull, 0xbe5ae5e2b60f7b91ull,
+        0x3de5d8408868552full, 0x0000000000000000ull,
+        0x3ff0000000000000ull, 0xbfe0000000000000ull,
+        0x3fa5555555555536ull, 0xbf56c16c16c13a0bull,
+        0x3efa01a019b1e8d8ull, 0xbe927e4f7282f468ull,
+        0x3e21ee96d2641b13ull, 0xbda8f76380fbb401ull,
+    };
+    intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float64);
+    intptr_t x = simd_data(desc);
+    float64 *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i++) {
+        float64 mm = m[i];
+        intptr_t xx = x;
+        if (float64_is_neg(mm)) {
+            mm = float64_abs(mm);
+            xx += 8;
+        }
+        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, vs);
+    }
+}
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0c55501935..fb225d56a1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3597,6 +3597,33 @@ DO_PPZ(FCMNE_ppz0, fcmne0)
 
 #undef DO_PPZ
 
+/*
+ *** SVE floating-point trig multiply-add coefficient
+ */
+
+static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[3] = {
+        gen_helper_sve_ftmad_h,
+        gen_helper_sve_ftmad_s,
+        gen_helper_sve_ftmad_d,
+    };
+
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, a->imm, fns[a->esz - 1]);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5dea2e5e88..e29c598783 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -796,6 +796,9 @@ FMINNM_zpzi     01100101 .. 011 101 100 ... 0000 . .....        @rdn_i1
 FMAX_zpzi       01100101 .. 011 110 100 ... 0000 . .....        @rdn_i1
 FMIN_zpzi       01100101 .. 011 111 100 ... 0000 . .....        @rdn_i1
 
+# SVE floating-point trig multiply-add coefficient
+FTMAD           01100101 esz:2 010 imm:3 100000 rm:5 rd:5       rn=%reg_movprfx
+
 ### SVE FP Multiply-Add Group
 
 # SVE floating-point multiply-accumulate writing addend
-- 
2.17.1
