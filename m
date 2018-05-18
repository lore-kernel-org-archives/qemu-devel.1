Received: from eggs.gnu.org ([2001:4830:134:3::10]:36256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3U-0000uT-F5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3T-0007h4-7r
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3S-0007fI-IY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3R-0004xl-FK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:20:09 +0100
Message-Id: <20180518172009.14416-33-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 32/32] target/arm: Implement SVE Permute -
 Extract Group
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  2 +
 target/arm/sve_helper.c    | 81 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 34 ++++++++++++++++
 target/arm/sve.decode      |  7 ++++
 4 files changed, 124 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 79493ab647..94f4356ce9 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -414,6 +414,8 @@ DEF_HELPER_FLAGS_4(sve_cpy_z_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_cpy_z_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_cpy_z_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
+DEF_HELPER_FLAGS_4(sve_ext, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8c7ea989b1..b825e44cb5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1479,3 +1479,84 @@ void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
         d[i] = (pg[H1(i)] & 1 ? val : 0);
     }
 }
+
+/* Big-endian hosts need to frob the byte indicies.  If the copy
+ * happens to be 8-byte aligned, then no frobbing necessary.
+ */
+static void swap_memmove(void *vd, void *vs, size_t n)
+{
+    uintptr_t d = (uintptr_t)vd;
+    uintptr_t s = (uintptr_t)vs;
+    uintptr_t o = (d | s | n) & 7;
+    size_t i;
+
+#ifndef HOST_WORDS_BIGENDIAN
+    o = 0;
+#endif
+    switch (o) {
+    case 0:
+        memmove(vd, vs, n);
+        break;
+
+    case 4:
+        if (d < s || d >= s + n) {
+            for (i = 0; i < n; i += 4) {
+                *(uint32_t *)H1_4(d + i) = *(uint32_t *)H1_4(s + i);
+            }
+        } else {
+            for (i = n; i > 0; ) {
+                i -= 4;
+                *(uint32_t *)H1_4(d + i) = *(uint32_t *)H1_4(s + i);
+            }
+        }
+        break;
+
+    case 2:
+    case 6:
+        if (d < s || d >= s + n) {
+            for (i = 0; i < n; i += 2) {
+                *(uint16_t *)H1_2(d + i) = *(uint16_t *)H1_2(s + i);
+            }
+        } else {
+            for (i = n; i > 0; ) {
+                i -= 2;
+                *(uint16_t *)H1_2(d + i) = *(uint16_t *)H1_2(s + i);
+            }
+        }
+        break;
+
+    default:
+        if (d < s || d >= s + n) {
+            for (i = 0; i < n; i++) {
+                *(uint8_t *)H1(d + i) = *(uint8_t *)H1(s + i);
+            }
+        } else {
+            for (i = n; i > 0; ) {
+                i -= 1;
+                *(uint8_t *)H1(d + i) = *(uint8_t *)H1(s + i);
+            }
+        }
+        break;
+    }
+}
+
+void HELPER(sve_ext)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    size_t n_ofs = simd_data(desc);
+    size_t n_siz = opr_sz - n_ofs;
+
+    if (vd != vm) {
+        swap_memmove(vd, vn + n_ofs, n_siz);
+        swap_memmove(vd + n_siz, vm, n_ofs);
+    } else if (vd != vn) {
+        swap_memmove(vd + n_siz, vd, n_ofs);
+        swap_memmove(vd, vn + n_ofs, n_siz);
+    } else {
+        /* vd == vn == vm.  Need temp space.  */
+        ARMVectorReg tmp;
+        swap_memmove(&tmp, vm, n_ofs);
+        swap_memmove(vd, vd + n_ofs, n_siz);
+        memcpy(vd + n_siz, &tmp, n_ofs);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9bdd61ff84..c48d4b530a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1922,6 +1922,40 @@ static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Permute Extract Group
+ */
+
+static bool trans_EXT(DisasContext *s, arg_EXT *a, uint32_t insn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned n_ofs = a->imm >= vsz ? 0 : a->imm;
+    unsigned n_siz = vsz - n_ofs;
+    unsigned d = vec_full_reg_offset(s, a->rd);
+    unsigned n = vec_full_reg_offset(s, a->rn);
+    unsigned m = vec_full_reg_offset(s, a->rm);
+
+    /* Use host vector move insns if we have appropriate sizes
+     * and no unfortunate overlap.
+     */
+    if (m != d
+        && n_ofs == size_for_gvec(n_ofs)
+        && n_siz == size_for_gvec(n_siz)
+        && (d != n || n_siz <= n_ofs)) {
+        tcg_gen_gvec_mov(0, d, n + n_ofs, n_siz, n_siz);
+        if (n_ofs != 0) {
+            tcg_gen_gvec_mov(0, d + n_siz, m, n_ofs, n_ofs);
+        }
+    } else {
+        tcg_gen_gvec_3_ool(d, n, m, vsz, vsz, n_ofs, gen_helper_sve_ext);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4ee7c78cda..4761d1921e 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -24,6 +24,7 @@
 
 %imm4_16_p1     16:4 !function=plus1
 %imm6_22_5      22:1 5:5
+%imm8_16_10     16:5 10:3
 %imm9_16_10     16:s6 10:3
 
 # A combination of tsz:imm3 -- extract esize.
@@ -362,6 +363,12 @@ FCPY            00000101 .. 01 .... 110 imm:8 .....             @rdn_pg4
 CPY_m_i         00000101 .. 01 .... 01 . ........ .....   @rdn_pg4 imm=%sh8_i8s
 CPY_z_i         00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
 
+### SVE Permute - Extract Group
+
+# SVE extract vector (immediate offset)
+EXT             00000101 001 ..... 000 ... rm:5 rd:5 \
+                &rrri rn=%reg_movprfx imm=%imm8_16_10
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.0
