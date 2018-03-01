Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-0003gS-TZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJr-00085O-DN
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJr-00084x-2M
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJq-0000aO-5D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:14 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:35 +0000
Message-Id: <20180301112403.12487-15-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/42] arm/translate-a64: implement
 half-precision F(MIN|MAX)(V|NMV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

This implements the half-precision variants of the across vector
reduction operations. This involves a re-factor of the reduction code
which more closely matches the ARM ARM order (and handles 8 element
reductions).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |   4 ++
 target/arm/helper-a64.c    |  18 ++++++
 target/arm/translate-a64.c | 140 ++++++++++++++++++++++++++++-----------------
 3 files changed, 109 insertions(+), 53 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 85d86741db..cb2a73124d 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -48,3 +48,7 @@ DEF_HELPER_FLAGS_4(paired_cmpxchg64_le_parallel, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be_parallel, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
+DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
+DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
+DEF_HELPER_FLAGS_3(advsimd_minnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 10e08bdc1f..fddd5d242b 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -572,3 +572,21 @@ uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
 {
     return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC());
 }
+
+/*
+ * AdvSIMD half-precision
+ */
+
+#define ADVSIMD_HELPER(name, suffix) HELPER(glue(glue(advsimd_, name), suffix))
+
+#define ADVSIMD_HALFOP(name) \
+float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
+{ \
+    float_status *fpst = fpstp; \
+    return float16_ ## name(a, b, fpst);    \
+}
+
+ADVSIMD_HALFOP(min)
+ADVSIMD_HALFOP(max)
+ADVSIMD_HALFOP(minnum)
+ADVSIMD_HALFOP(maxnum)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 91c2b8ed11..ebaf4571ac 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5741,26 +5741,75 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resh);
 }
 
-static void do_minmaxop(DisasContext *s, TCGv_i32 tcg_elt1, TCGv_i32 tcg_elt2,
-                        int opc, bool is_min, TCGv_ptr fpst)
+/*
+ * do_reduction_op helper
+ *
+ * This mirrors the Reduce() pseudocode in the ARM ARM. It is
+ * important for correct NaN propagation that we do these
+ * operations in exactly the order specified by the pseudocode.
+ *
+ * This is a recursive function, TCG temps should be freed by the
+ * calling function once it is done with the values.
+ */
+static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
+                                int esize, int size, int vmap, TCGv_ptr fpst)
 {
-    /* Helper function for disas_simd_across_lanes: do a single precision
-     * min/max operation on the specified two inputs,
-     * and return the result in tcg_elt1.
-     */
-    if (opc == 0xc) {
-        if (is_min) {
-            gen_helper_vfp_minnums(tcg_elt1, tcg_elt1, tcg_elt2, fpst);
-        } else {
-            gen_helper_vfp_maxnums(tcg_elt1, tcg_elt1, tcg_elt2, fpst);
-        }
+    if (esize == size) {
+        int element;
+        TCGMemOp msize = esize == 16 ? MO_16 : MO_32;
+        TCGv_i32 tcg_elem;
+
+        /* We should have one register left here */
+        assert(ctpop8(vmap) == 1);
+        element = ctz32(vmap);
+        assert(element < 8);
+
+        tcg_elem = tcg_temp_new_i32();
+        read_vec_element_i32(s, tcg_elem, rn, element, msize);
+        return tcg_elem;
     } else {
-        assert(opc == 0xf);
-        if (is_min) {
-            gen_helper_vfp_mins(tcg_elt1, tcg_elt1, tcg_elt2, fpst);
-        } else {
-            gen_helper_vfp_maxs(tcg_elt1, tcg_elt1, tcg_elt2, fpst);
+        int bits = size / 2;
+        int shift = ctpop8(vmap) / 2;
+        int vmap_lo = (vmap >> shift) & vmap;
+        int vmap_hi = (vmap & ~vmap_lo);
+        TCGv_i32 tcg_hi, tcg_lo, tcg_res;
+
+        tcg_hi = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_hi, fpst);
+        tcg_lo = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_lo, fpst);
+        tcg_res = tcg_temp_new_i32();
+
+        switch (fpopcode) {
+        case 0x0c: /* fmaxnmv half-precision */
+            gen_helper_advsimd_maxnumh(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x0f: /* fmaxv half-precision */
+            gen_helper_advsimd_maxh(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x1c: /* fminnmv half-precision */
+            gen_helper_advsimd_minnumh(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x1f: /* fminv half-precision */
+            gen_helper_advsimd_minh(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x2c: /* fmaxnmv */
+            gen_helper_vfp_maxnums(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x2f: /* fmaxv */
+            gen_helper_vfp_maxs(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x3c: /* fminnmv */
+            gen_helper_vfp_minnums(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        case 0x3f: /* fminv */
+            gen_helper_vfp_mins(tcg_res, tcg_lo, tcg_hi, fpst);
+            break;
+        default:
+            g_assert_not_reached();
         }
+
+        tcg_temp_free_i32(tcg_hi);
+        tcg_temp_free_i32(tcg_lo);
+        return tcg_res;
     }
 }
 
@@ -5802,16 +5851,21 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
         break;
     case 0xc: /* FMAXNMV, FMINNMV */
     case 0xf: /* FMAXV, FMINV */
-        if (!is_u || !is_q || extract32(size, 0, 1)) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* Bit 1 of size field encodes min vs max, and actual size is always
-         * 32 bits: adjust the size variable so following code can rely on it
+        /* Bit 1 of size field encodes min vs max and the actual size
+         * depends on the encoding of the U bit. If not set (and FP16
+         * enabled) then we do half-precision float instead of single
+         * precision.
          */
         is_min = extract32(size, 1, 1);
         is_fp = true;
-        size = 2;
+        if (!is_u && arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            size = 1;
+        } else if (!is_u || !is_q || extract32(size, 0, 1)) {
+            unallocated_encoding(s);
+            return;
+        } else {
+            size = 2;
+        }
         break;
     default:
         unallocated_encoding(s);
@@ -5868,38 +5922,18 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
 
         }
     } else {
-        /* Floating point ops which work on 32 bit (single) intermediates.
+        /* Floating point vector reduction ops which work across 32
+         * bit (single) or 16 bit (half-precision) intermediates.
          * Note that correct NaN propagation requires that we do these
          * operations in exactly the order specified by the pseudocode.
          */
-        TCGv_i32 tcg_elt1 = tcg_temp_new_i32();
-        TCGv_i32 tcg_elt2 = tcg_temp_new_i32();
-        TCGv_i32 tcg_elt3 = tcg_temp_new_i32();
-        TCGv_ptr fpst = get_fpstatus_ptr(false);
-
-        assert(esize == 32);
-        assert(elements == 4);
-
-        read_vec_element(s, tcg_elt, rn, 0, MO_32);
-        tcg_gen_extrl_i64_i32(tcg_elt1, tcg_elt);
-        read_vec_element(s, tcg_elt, rn, 1, MO_32);
-        tcg_gen_extrl_i64_i32(tcg_elt2, tcg_elt);
-
-        do_minmaxop(s, tcg_elt1, tcg_elt2, opcode, is_min, fpst);
-
-        read_vec_element(s, tcg_elt, rn, 2, MO_32);
-        tcg_gen_extrl_i64_i32(tcg_elt2, tcg_elt);
-        read_vec_element(s, tcg_elt, rn, 3, MO_32);
-        tcg_gen_extrl_i64_i32(tcg_elt3, tcg_elt);
-
-        do_minmaxop(s, tcg_elt2, tcg_elt3, opcode, is_min, fpst);
-
-        do_minmaxop(s, tcg_elt1, tcg_elt2, opcode, is_min, fpst);
-
-        tcg_gen_extu_i32_i64(tcg_res, tcg_elt1);
-        tcg_temp_free_i32(tcg_elt1);
-        tcg_temp_free_i32(tcg_elt2);
-        tcg_temp_free_i32(tcg_elt3);
+        TCGv_ptr fpst = get_fpstatus_ptr(size == MO_16);
+        int fpopcode = opcode | is_min << 4 | is_u << 5;
+        int vmap = (1 << elements) - 1;
+        TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, esize,
+                                             (is_q ? 128 : 64), vmap, fpst);
+        tcg_gen_extu_i32_i64(tcg_res, tcg_res32);
+        tcg_temp_free_i32(tcg_res32);
         tcg_temp_free_ptr(fpst);
     }
 
-- 
2.16.2
