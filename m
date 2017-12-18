Received: from eggs.gnu.org ([2001:4830:134:3::10]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3e-0000Xm-1D
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3V-00018g-G7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:29 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3V-00017i-40
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:21 -0500
Received: by mail-pf0-x243.google.com with SMTP id j28so9930738pfk.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:44 -0800
Message-Id: <20171218171758.16964-13-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 12/26] tcg: Add generic vector ops for
 constant shifts
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

Opcodes are added for scalar and vector shifts, but considering the
varied semantics of these do not expose them to the front ends.  Do
go ahead and provide them in case they are needed for backend expansion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  15 +++
 tcg/i386/tcg-target.h        |   3 +
 tcg/tcg-op-gvec.h            |  35 ++++++
 tcg/tcg-op.h                 |   5 +
 tcg/tcg-opc.h                |  12 ++
 tcg/tcg.h                    |   3 +
 accel/tcg/tcg-runtime-gvec.c | 149 ++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 291 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  40 ++++++
 tcg/tcg.c                    |  12 ++
 tcg/README                   |  29 +++++
 11 files changed, 594 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c6de749134..cb05a755b8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -164,6 +164,21 @@ DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_shl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shl64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_shr8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shr16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shr32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_shr64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sar8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_zip8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_zip16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_zip32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index ff0ad7dcdb..92d533eb92 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -177,6 +177,9 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_zip_vec          0
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 64270a3c74..de2c0e669a 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -74,6 +74,25 @@ typedef struct {
     bool prefer_i64;
 } GVecGen2;
 
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, unsigned);
+    void (*fni4)(TCGv_i32, TCGv_i32, unsigned);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, unsigned);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_2 *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen2i;
+
 typedef struct {
     /* Expand inline as a 64-bit or 32-bit integer.
        Only one of these will be non-NULL.  */
@@ -97,6 +116,8 @@ typedef struct {
 
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t opsz, uint32_t clsz, const GVecGen2 *);
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t opsz,
+                     uint32_t clsz, unsigned c, const GVecGen2i *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t opsz, uint32_t clsz, const GVecGen3 *);
 
@@ -137,6 +158,13 @@ void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
 void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
 void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
 
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift);
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift);
+void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift);
+
 void tcg_gen_gvec_zipl(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
 void tcg_gen_gvec_ziph(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -167,3 +195,10 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 733e29b5f8..83478ab006 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -927,6 +927,11 @@ void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+
+void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i);
+void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i);
+void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i);
+
 void tcg_gen_zipl_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_ziph_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_uzpe_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index c911d62442..a085fc077b 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -229,6 +229,18 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
 DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
 DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
 
+DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
+DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
+DEF(sari_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
+
+DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
+DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
+DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
+
+DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
+DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
+DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
+
 DEF(zipl_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_zip_vec))
 DEF(ziph_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_zip_vec))
 DEF(uzpe_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_uzp_vec))
diff --git a/tcg/tcg.h b/tcg/tcg.h
index d0678ac769..bdfe058c45 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -178,6 +178,9 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_zip_vec          0
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 628df811b2..fba62f1192 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -36,6 +36,11 @@ typedef uint16_t vec16 __attribute__((vector_size(16)));
 typedef uint32_t vec32 __attribute__((vector_size(16)));
 typedef uint64_t vec64 __attribute__((vector_size(16)));
 
+typedef int8_t svec8 __attribute__((vector_size(16)));
+typedef int16_t svec16 __attribute__((vector_size(16)));
+typedef int32_t svec32 __attribute__((vector_size(16)));
+typedef int64_t svec64 __attribute__((vector_size(16)));
+
 static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
 {
     intptr_t maxsz = simd_maxsz(desc);
@@ -294,6 +299,150 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_shl8i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) << shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl16i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) << shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl32i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) << shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl64i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) << shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr8i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr16i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr32i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr64i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar8i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(svec8 *)(d + i) = *(svec8 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar16i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(svec16 *)(d + i) = *(svec16 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar32i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(svec32 *)(d + i) = *(svec32 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(svec64 *)(d + i) = *(svec64 *)(a + i) >> shift;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 /* The size of the alloca in the following is currently bounded to 2k.  */
 
 #define DO_ZIP(NAME, TYPE) \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 6e2e84c210..efdb009d2a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -424,6 +424,26 @@ static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t opsz,
     tcg_temp_free_i32(t0);
 }
 
+static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t opsz,
+                          unsigned c, bool load_dest,
+                          void (*fni)(TCGv_i32, TCGv_i32, unsigned))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0, c);
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_3_i32(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t opsz, bool load_dest,
@@ -463,6 +483,26 @@ static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t opsz,
     tcg_temp_free_i64(t0);
 }
 
+static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t opsz,
+                          unsigned c, bool load_dest,
+                          void (*fni)(TCGv_i64, TCGv_i64, unsigned))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0, c);
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
 static void expand_3_i64(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t opsz, bool load_dest,
@@ -503,6 +543,29 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t0);
 }
 
+/* Expand OPSZ bytes worth of two-vector operands and an immediate operand
+   using host vectors.  */
+static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t opsz, uint32_t tysz, TCGType type,
+                          unsigned c, bool load_dest,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, unsigned))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
+        }
+        fni(vece, t1, t0, c);
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
 static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t opsz,
@@ -605,6 +668,85 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
 }
 
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, unsigned c, const GVecGen2i *g)
+{
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    /* Quick check for sizes we won't support inline.  */
+    if (oprsz > MAX_UNROLL * 32 || maxsz > MAX_UNROLL * 32) {
+        goto do_ool;
+    }
+
+    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+       Expand with successively smaller host vector sizes.  The intent is
+       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+    /* ??? For maxsz > oprsz, the host may be able to use an op-sized
+       operation, zeroing the balance of the register.  We can then
+       use a cl-sized store to implement the clearing without an extra
+       store operation.  This is true for aarch64 and x86_64 hosts.  */
+
+    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
+        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_2i_vec(g->vece, dofs, aofs, done, 32, TCG_TYPE_V256,
+                      c, g->load_dest, g->fniv);
+        dofs += done;
+        aofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
+        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
+        expand_2i_vec(g->vece, dofs, aofs, done, 16, TCG_TYPE_V128,
+                      c, g->load_dest, g->fniv);
+        dofs += done;
+        aofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (check_size_impl(oprsz, 8)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
+        if (TCG_TARGET_HAS_v64 && !g->prefer_i64
+            && (!g->opc
+                || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+            expand_2i_vec(g->vece, dofs, aofs, done, 8, TCG_TYPE_V64,
+                          c, g->load_dest, g->fniv);
+        } else if (g->fni8) {
+            expand_2i_i64(dofs, aofs, done, c, g->load_dest, g->fni8);
+        } else {
+            done = 0;
+        }
+        dofs += done;
+        aofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (g->fni4 && check_size_impl(oprsz, 4)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
+        expand_2i_i32(dofs, aofs, done, c, g->load_dest, g->fni4);
+        dofs += done;
+        aofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (oprsz == 0) {
+        if (maxsz != 0) {
+            expand_clr(dofs, maxsz);
+        }
+        return;
+    }
+
+ do_ool:
+    tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, 0, g->fno);
+}
+
 /* Expand a vector three-operand operation.  */
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
@@ -1106,6 +1248,155 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g);
 }
 
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t mask = ((0xff << c) & 0xff) * (-1ull / 0xff);
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t mask = ((0xffff << c) & 0xffff) * (-1ull / 0xffff);
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift)
+{
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_shl8i_i64,
+          .fniv = tcg_gen_shli_vec,
+          .fno = gen_helper_gvec_shl8i,
+          .opc = INDEX_op_shli_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_shl16i_i64,
+          .fniv = tcg_gen_shli_vec,
+          .fno = gen_helper_gvec_shl16i,
+          .opc = INDEX_op_shli_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shli_i32,
+          .fniv = tcg_gen_shli_vec,
+          .fno = gen_helper_gvec_shl32i,
+          .opc = INDEX_op_shli_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shli_i64,
+          .fniv = tcg_gen_shli_vec,
+          .fno = gen_helper_gvec_shl64i,
+          .opc = INDEX_op_shli_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, opsz, clsz, shift, &g[vece]);
+}
+
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t mask = (0xff >> c) * (-1ull / 0xff);
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t mask = (0xffff >> c) * (-1ull / 0xffff);
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift)
+{
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_shr8i_i64,
+          .fniv = tcg_gen_shri_vec,
+          .fno = gen_helper_gvec_shr8i,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_shr16i_i64,
+          .fniv = tcg_gen_shri_vec,
+          .fno = gen_helper_gvec_shr16i,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shri_i32,
+          .fniv = tcg_gen_shri_vec,
+          .fno = gen_helper_gvec_shr32i,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shri_i64,
+          .fniv = tcg_gen_shri_vec,
+          .fno = gen_helper_gvec_shr64i,
+          .opc = INDEX_op_shri_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, opsz, clsz, shift, &g[vece]);
+}
+
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t s_mask = (0x80 >> c) * (-1ull / 0xff);
+    uint64_t c_mask = (0xff >> c) * (-1ull / 0xff);
+    TCGv_i64 s = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
+    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
+    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
+    tcg_gen_or_i64(d, d, s);         /* include sign extension */
+    tcg_temp_free_i64(s);
+}
+
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, unsigned c)
+{
+    uint64_t s_mask = (0x8000 >> c) * (-1ull / 0xffff);
+    uint64_t c_mask = (0xffff >> c) * (-1ull / 0xffff);
+    TCGv_i64 s = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
+    tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
+    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
+    tcg_gen_or_i64(d, d, s);         /* include sign extension */
+    tcg_temp_free_i64(s);
+}
+
+void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t opsz, uint32_t clsz, unsigned shift)
+{
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_sar8i_i64,
+          .fniv = tcg_gen_sari_vec,
+          .fno = gen_helper_gvec_sar8i,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_sar16i_i64,
+          .fniv = tcg_gen_sari_vec,
+          .fno = gen_helper_gvec_sar16i,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_sari_i32,
+          .fniv = tcg_gen_sari_vec,
+          .fno = gen_helper_gvec_sar32i,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_sari_i64,
+          .fniv = tcg_gen_sari_vec,
+          .fno = gen_helper_gvec_sar64i,
+          .opc = INDEX_op_sari_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, opsz, clsz, shift, &g[vece]);
+}
+
 static void do_zip(unsigned vece, uint32_t dofs, uint32_t aofs,
                    uint32_t bofs, uint32_t oprsz, uint32_t maxsz,
                    bool high)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index a5d0ff89c3..a441193b8e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -381,6 +381,46 @@ void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
     }
 }
 
+static void do_shifti(TCGOpcode opc, unsigned vece,
+                      TCGv_vec r, TCGv_vec a, unsigned i)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGType type = rt->base_type;
+    unsigned vecl = type - TCG_TYPE_V64;
+    int can;
+
+    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(i < (8 << vece));
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_3(opc, type, vece, ri, ai, i);
+    } else {
+        /* We leave the choice of expansion via scalar or vector shift
+           to the target.  Often, but not always, dupi can feed a vector
+           shift easier than a scalar.  */
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(opc, vecl, vece, ri, ai, i);
+    }
+}
+
+void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i)
+{
+    do_shifti(INDEX_op_shli_vec, vece, r, a, i);
+}
+
+void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i)
+{
+    do_shifti(INDEX_op_shri_vec, vece, r, a, i);
+}
+
+void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, unsigned i)
+{
+    do_shifti(INDEX_op_sari_vec, vece, r, a, i);
+}
+
 static void do_interleave(TCGOpcode opc, unsigned vece,
                           TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 33e3c03cbc..f82d6e80b0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1403,6 +1403,18 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
         return have_vec && TCG_TARGET_HAS_orc_vec;
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+        return have_vec && TCG_TARGET_HAS_shi_vec;
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
+        return have_vec && TCG_TARGET_HAS_shs_vec;
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        return have_vec && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_zipl_vec:
     case INDEX_op_ziph_vec:
         return have_vec && TCG_TARGET_HAS_zip_vec;
diff --git a/tcg/README b/tcg/README
index 8ab8d3ab7e..75db47922d 100644
--- a/tcg/README
+++ b/tcg/README
@@ -561,6 +561,35 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
   Similarly, logical operations with and without compliment.
   Note that VECE is unused.
 
+* shli_vec   v0, v1, i2
+* shls_vec   v0, v1, s2
+
+  Shift all elements from v1 by a scalar i2/s2.  I.e.
+
+    for (i = 0; i < VECL/VECE; ++i) {
+      v0[i] = v1[i] << s2;
+    }
+
+* shri_vec   v0, v1, i2
+* sari_vec   v0, v1, i2
+* shrs_vec   v0, v1, s2
+* sars_vec   v0, v1, s2
+
+  Similarly for logical and arithmetic right shift.
+
+* shlv_vec   v0, v1, v2
+
+  Shift elements from v1 by elements from v2.  I.e.
+
+    for (i = 0; i < VECL/VECE; ++i) {
+      v0[i] = v1[i] << v2[i];
+    }
+
+* shrv_vec   v0, v1, v2
+* sarv_vec   v0, v1, v2
+
+  Similarly for logical and arithmetic right shift.
+
 * zipl_vec  v0, v1, v2
 * ziph_vec  v0, v1, v2
 
-- 
2.14.3
