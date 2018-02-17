Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79f-0000mM-37
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79d-0001mo-PN
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:11 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79d-0001mK-HR
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:09 -0500
Received: by mail-pl0-x241.google.com with SMTP id s13so3436999plq.6
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:42 -0800
Message-Id: <20180217182323.25885-27-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 26/67] target/arm: Implement SVE Permute -
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  2 ++
 target/arm/sve_helper.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 +++++++++++++++++
 target/arm/sve.decode      |  9 +++++-
 4 files changed, 120 insertions(+), 1 deletion(-)

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
index 6a95d1ec48..fb3f54300b 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1469,3 +1469,84 @@ void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
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
index dd085b084b..07a5eac092 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1790,6 +1790,35 @@ static void trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
     tcg_temp_free_i64(t_imm);
 }
 
+/*
+ *** SVE Permute Extract Group
+ */
+
+static void trans_EXT(DisasContext *s, arg_EXT *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned n_ofs = a->imm >= vsz ? 0 : a->imm;
+    unsigned n_siz = vsz - n_ofs;
+    unsigned d = vec_full_reg_offset(s, a->rd);
+    unsigned n = vec_full_reg_offset(s, a->rn);
+    unsigned m = vec_full_reg_offset(s, a->rm);
+
+    /* Use host vector move insns if we have appropriate sizes
+       and no unfortunate overlap.  */
+    if (m != d
+        && n_ofs == size_for_gvec(n_ofs)
+        && n_siz == size_for_gvec(n_siz)
+        && (d != n || n_siz <= n_ofs)) {
+        tcg_gen_gvec_mov(0, d, n + n_ofs, n_siz, n_siz);
+        if (n_ofs != 0) {
+            tcg_gen_gvec_mov(0, d + n_siz, m, n_ofs, n_ofs);
+        }
+        return;
+    }
+
+    tcg_gen_gvec_3_ool(d, n, m, vsz, vsz, n_ofs, gen_helper_sve_ext);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e6e10a4f84..5e3a9839d4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -22,8 +22,9 @@
 ###########################################################################
 # Named fields.  These are primarily for disjoint fields.
 
-%imm4_16_p1             16:4 !function=plus1
+%imm4_16_p1	16:4 !function=plus1
 %imm6_22_5	22:1 5:5
+%imm8_16_10	16:5 10:3
 %imm9_16_10	16:s6 10:3
 %preg4_5	5:4
 
@@ -363,6 +364,12 @@ FCPY		00000101 .. 01 .... 110 imm:8 .....		@rdn_pg4
 CPY_m_i		00000101 .. 01 .... 01 . ........ .....   @rdn_pg4 imm=%sh8_i8s
 CPY_z_i		00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
 
+### SVE Permute - Extract Group
+
+# SVE extract vector (immediate offset)
+EXT		00000101 001 ..... 000 ... rm:5 rd:5 \
+		&rrri rn=%reg_movprfx imm=%imm8_16_10
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
