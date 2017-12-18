Received: from eggs.gnu.org ([2001:4830:134:3::10]:56119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUm-0008WJ-9r
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUk-0002Mn-5Z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:32 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUk-0002LB-0v
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:30 -0500
Received: by mail-pl0-x243.google.com with SMTP id g2so5248770pli.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:51 -0800
Message-Id: <20171218174552.18871-23-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/23] target/arm: Implement SVE floating-point
 trig select coefficient
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
 target/arm/helper-sve.h    |  4 ++++
 target/arm/sve_helper.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 target/arm/sve.def         |  3 +++
 4 files changed, 68 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c72ae3390f..ccf5405d63 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -383,6 +383,10 @@ DEF_HELPER_FLAGS_3(sve_fexpa_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fexpa_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fexpa_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ftssel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ftssel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ftssel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 936a6ec648..5341f6d0e5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1104,6 +1104,48 @@ void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
     }
 }
 
+void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    uint16_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint16_t nn = n[i];
+        uint16_t mm = m[i];
+        if (mm & 1) {
+            nn = float16_one;
+        }
+        d[i] = nn ^ (mm & 2) << 14;
+    }
+}
+
+void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint32_t nn = n[i];
+        uint32_t mm = m[i];
+        if (mm & 1) {
+            nn = float32_one;
+        }
+        d[i] = nn ^ (mm & 2) << 30;
+    }
+}
+
+void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        uint64_t mm = m[i];
+        if (mm & 1) {
+            nn = float64_one;
+        }
+        d[i] = nn ^ (mm & 2) << 62;
+    }
+}
+
 void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
 {
     intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b671462611..a6c31e0e9c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -757,6 +757,25 @@ void trans_FEXPA(DisasContext *s, arg_rr_esz *a, uint32_t insn)
                        vsz, vsz, 0, fns[a->esz]);
 }
 
+void trans_FTSSEL(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_ftssel_h,
+        gen_helper_sve_ftssel_s,
+        gen_helper_sve_ftssel_d,
+    };
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+        return;
+    }
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       vsz, vsz, 0, fns[a->esz]);
+}
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index c0fc8b7665..df2730eb73 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -272,6 +272,9 @@ ADR_p64			00000100 11 1 ..... 1010 .. ..... .....		@rd_rn_msz_rm
 # SVE floating-point exponential accelerator
 FEXPA			00000100 .. 1 00000 101110 ..... .....		@rd_rn_esz # Note size != 0
 
+# SVE floating-point trig select coefficient
+FTSSEL			00000100 .. 1 ..... 101100 ..... .....		@rd_rn_rm_esz # Note size != 0
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3
