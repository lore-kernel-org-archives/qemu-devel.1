Received: from eggs.gnu.org ([2001:4830:134:3::10]:55628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewsM-0003cX-C1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewsJ-0002qf-6v
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:48:34 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eewsI-0002qQ-Tw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:48:31 -0500
Received: by mail-pg0-x244.google.com with SMTP id m136so6591572pga.12
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 21:48:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Jan 2018 20:57:27 -0800
Message-Id: <20180126045742.5487-6-richard.henderson@linaro.org>
In-Reply-To: <20180126045742.5487-1-richard.henderson@linaro.org>
References: <20180126045742.5487-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v11 05/20] tcg: Add generic vector ops for
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
 tcg/tcg-op-gvec.h            |  35 ++++++
 tcg/tcg-op.h                 |   4 +
 tcg/tcg-opc.h                |  12 ++
 tcg/tcg.h                    |   3 +
 accel/tcg/tcg-runtime-gvec.c | 144 ++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 276 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  45 +++++++
 tcg/tcg.c                    |  12 ++
 tcg/README                   |  29 +++++
 10 files changed, 575 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 76ee41ce58..df23c9aea9 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -163,3 +163,18 @@ DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
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
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 5a7d640a9d..b9f9eb7b84 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -95,6 +95,25 @@ typedef struct {
     bool prefer_i64;
 } GVecGen2;
 
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, int64_t);
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
@@ -137,6 +156,8 @@ typedef struct {
 
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, int64_t c, const GVecGen2i *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
@@ -179,6 +200,13 @@ void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
 void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
 void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
 
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
@@ -196,3 +224,10 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index f8ba63340e..98e2dfbe90 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -925,6 +925,10 @@ void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 
+void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 801b0b1e16..43ef67bf46 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -228,6 +228,18 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
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
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #if TCG_TARGET_MAYBE_vec
diff --git a/tcg/tcg.h b/tcg/tcg.h
index ec8f1bc72e..8c19a1f41d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -178,6 +178,9 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index e093922225..f0964aadb2 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -323,3 +323,147 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
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
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 85570c983a..ab946a064c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -534,6 +534,26 @@ static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i32(t0);
 }
 
+static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          int32_t c, bool load_dest,
+                          void (*fni)(TCGv_i32, TCGv_i32, int32_t))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 4) {
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
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -597,6 +617,26 @@ static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i64(t0);
 }
 
+static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          int64_t c, bool load_dest,
+                          void (*fni)(TCGv_i64, TCGv_i64, int64_t))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 8) {
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
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -661,6 +701,29 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t0);
 }
 
+/* Expand OPSZ bytes worth of two-vector operands and an immediate operand
+   using host vectors.  */
+static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                          int64_t c, bool load_dest,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, int64_t))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
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
                          uint32_t bofs, uint32_t oprsz,
@@ -764,6 +827,55 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, int64_t c, const GVecGen2i *g)
+{
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+       Expand with successively smaller host vector sizes.  The intent is
+       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+
+    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
+        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_2i_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                      c, g->load_dest, g->fniv);
+        if (some == oprsz) {
+            goto done;
+        }
+        dofs += some;
+        aofs += some;
+        oprsz -= some;
+        maxsz -= some;
+    }
+
+    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
+        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        expand_2i_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                      c, g->load_dest, g->fniv);
+    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
+               && g->fniv && check_size_impl(oprsz, 8)
+               && (!g->opc
+                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+        expand_2i_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                      c, g->load_dest, g->fniv);
+    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
+        expand_2i_i64(dofs, aofs, oprsz, c, g->load_dest, g->fni8);
+    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+        expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);
+    } else {
+        tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+        return;
+    }
+
+ done:
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
 /* Expand a vector three-operand operation.  */
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
@@ -1306,3 +1418,167 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
 }
+
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_8, 0xff << c);
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff << c);
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
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
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
+    }
+}
+
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_8, 0xff >> c);
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff >> c);
+    tcg_gen_shri_i64(d, a, c);
+    tcg_gen_andi_i64(d, d, mask);
+}
+
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
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
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
+    }
+}
+
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t s_mask = dup_const(MO_8, 0x80 >> c);
+    uint64_t c_mask = dup_const(MO_8, 0xff >> c);
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
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t s_mask = dup_const(MO_16, 0x8000 >> c);
+    uint64_t c_mask = dup_const(MO_16, 0xffff >> c);
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
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz)
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
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
+    }
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ac5b69ccf6..6f3060325e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -297,3 +297,48 @@ void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
         tcg_temp_free_vec(t);
     }
 }
+
+static void do_shifti(TCGOpcode opc, unsigned vece,
+                      TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGType type = rt->base_type;
+    int can;
+
+    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(i >= 0 && i < (8 << vece));
+
+    if (i == 0) {
+        tcg_gen_mov_vec(r, a);
+        return;
+    }
+
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_3(opc, type, vece, ri, ai, i);
+    } else {
+        /* We leave the choice of expansion via scalar or vector shift
+           to the target.  Often, but not always, dupi can feed a vector
+           shift easier than a scalar.  */
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(opc, type, vece, ri, ai, i);
+    }
+}
+
+void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    do_shifti(INDEX_op_shli_vec, vece, r, a, i);
+}
+
+void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    do_shifti(INDEX_op_shri_vec, vece, r, a, i);
+}
+
+void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    do_shifti(INDEX_op_sari_vec, vece, r, a, i);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0862cff58a..47fb73eecc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1402,6 +1402,18 @@ bool tcg_op_supported(TCGOpcode op)
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
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
diff --git a/tcg/README b/tcg/README
index f4695307bd..42d301961b 100644
--- a/tcg/README
+++ b/tcg/README
@@ -552,6 +552,35 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
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
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.14.3
