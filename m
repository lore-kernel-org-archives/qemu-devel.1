Received: from eggs.gnu.org ([2001:4830:134:3::10]:39062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqN0-0006nf-QK
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqMx-0003kO-Ov
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:22 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqMx-0003jn-F5
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:19 -0500
Received: by mail-pl0-x243.google.com with SMTP id 13so9225673plb.5
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:15:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:14:24 -0800
Message-Id: <20180117161435.28981-10-richard.henderson@linaro.org>
In-Reply-To: <20180117161435.28981-1-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v10.5 09/20] tcg: Add generic vector helpers
 with a scalar operand
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

Use dup to convert a non-constant scalar to a third vector.

Add addition, multiplication, and logical operations with an immediate.
Add addition and subtraction with a non-constant scalar.  Allow for the
front-end to build operations in which the scalar operand comes first.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  19 +++
 tcg/tcg-op-gvec.h            |  50 +++++-
 accel/tcg/tcg-runtime-gvec.c | 180 ++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 393 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 640 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index f224a975e8..d7e4583e7b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -147,16 +147,31 @@ DEF_HELPER_FLAGS_4(gvec_add16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_add32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_add64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_adds8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_adds16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_adds32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_adds64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_sub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_subs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_mul8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_muls8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_muls16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_muls32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_muls64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_ssadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ssadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ssadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -189,6 +204,10 @@ DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_andi, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_xori, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_ori, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_3(gvec_shl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_shl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_shl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index d0d43dcc62..f4ade86983 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -35,6 +35,12 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
                         uint32_t oprsz, uint32_t maxsz, int32_t data,
                         gen_helper_gvec_2 *fn);
 
+/* Similarly, passing an extra data value.  */
+typedef void gen_helper_gvec_2i(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
+void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
+                         uint32_t oprsz, uint32_t maxsz, int32_t data,
+                         gen_helper_gvec_2i *fn);
+
 /* Similarly, passing an extra pointer (e.g. env or float_status).  */
 typedef void gen_helper_gvec_2_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
@@ -102,8 +108,10 @@ typedef struct {
     void (*fni4)(TCGv_i32, TCGv_i32, int32_t);
     /* Expand inline with a host vector type.  */
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, int64_t);
-    /* Expand out-of-line helper w/descriptor.  */
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
     gen_helper_gvec_2 *fno;
+    /* Expand out-of-line helper w/descriptor, data as argument.  */
+    gen_helper_gvec_2i *fnoi;
     /* The opcode, if any, to which this corresponds.  */
     TCGOpcode opc;
     /* The vector element size, if applicable.  */
@@ -114,6 +122,27 @@ typedef struct {
     bool load_dest;
 } GVecGen2i;
 
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_2i *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The data argument to the out-of-line helper.  */
+    uint32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load scalar as 1st source operand.  */
+    bool scalar_first;
+} GVecGen2s;
+
 typedef struct {
     /* Expand inline as a 64-bit or 32-bit integer.
        Only one of these will be non-NULL.  */
@@ -158,6 +187,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *);
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
@@ -179,6 +210,16 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+
 /* Saturated arithmetic.  */
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
@@ -200,6 +241,13 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      int64_t c, uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t s, uint32_t m);
 void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 70a23224c8..fdc9df0d66 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -122,6 +122,54 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_adds8)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec8 vecb = (vec8)DUP16(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_adds16)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec16 vecb = (vec16)DUP8(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_adds32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32)DUP4(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_adds64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
@@ -166,6 +214,54 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec8 vecb = (vec8)DUP16(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec16 vecb = (vec16)DUP8(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32)DUP4(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_mul8)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
@@ -210,6 +306,54 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_muls8)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec8 vecb = (vec8)DUP16(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muls16)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec16 vecb = (vec16)DUP8(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muls32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32)DUP4(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muls64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
@@ -368,6 +512,42 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_andi)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) & vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_xori)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_ori)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64)DUP2(b);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) | vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_shl8i)(void *d, void *a, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 368ab2f1de..3eedeaf15f 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -106,6 +106,28 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i32(desc);
 }
 
+/* Generate a call to a gvec-style helper with two vector operands
+   and one scalar operand.  */
+void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
+                         uint32_t oprsz, uint32_t maxsz, int32_t data,
+                         gen_helper_gvec_2i *fn)
+{
+    TCGv_ptr a0, a1;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);
+
+    fn(a0, a1, c, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_i32(desc);
+}
+
 /* Generate a call to a gvec-style helper with three vector operands.  */
 void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t oprsz, uint32_t maxsz, int32_t data,
@@ -554,6 +576,27 @@ static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i32(t1);
 }
 
+static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          TCGv_i32 c, bool scalar_first,
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(t1, c, t0);
+        } else {
+            fni(t1, t0, c);
+        }
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_3_i32(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -637,6 +680,27 @@ static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i64(t1);
 }
 
+static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          TCGv_i64 c, bool scalar_first,
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(t1, c, t0);
+        } else {
+            fni(t1, t0, c);
+        }
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
 static void expand_3_i64(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -724,6 +788,28 @@ static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t1);
 }
 
+static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                          TCGv_vec c, bool scalar_first,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(vece, t1, c, t0);
+        } else {
+            fni(vece, t1, t0, c);
+        }
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
 static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz,
@@ -823,6 +909,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     }
 }
 
+/* Expand a vector operation with two vectors and an immediate.  */
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
 {
@@ -859,7 +946,93 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     } else if (g->fni4 && check_size_impl(oprsz, 4)) {
         expand_2i_i32(dofs, aofs, oprsz, c, g->load_dest, g->fni4);
     } else {
-        tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+        if (g->fno) {
+            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+        } else {
+            TCGv_i64 tcg_c = tcg_const_i64(c);
+            tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz, maxsz, c, g->fnoi);
+            tcg_temp_free_i64(tcg_c);
+        }
+        return;
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
+/* Expand a vector operation with two vectors and a scalar.  */
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *g)
+{
+    TCGType type;
+
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    type = 0;
+    if (g->fniv) {
+        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
+            type = TCG_TYPE_V256;
+        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
+            type = TCG_TYPE_V128;
+        } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
+               && check_size_impl(oprsz, 8)) {
+            type = TCG_TYPE_V64;
+        }
+    }
+    if (type != 0) {
+        TCGv_vec t_vec = tcg_temp_new_vec(type);
+        uint32_t done;
+
+        tcg_gen_dup_i64_vec(g->vece, t_vec, c);
+
+        /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+           Expand with successively smaller host vector sizes.  The intent is
+           that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+        switch (type) {
+        case TCG_TYPE_V256:
+            done = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_2s_vec(g->vece, dofs, aofs, done, 32, TCG_TYPE_V256,
+                          t_vec, g->scalar_first, g->fniv);
+            dofs += done;
+            aofs += done;
+            oprsz -= done;
+            maxsz -= done;
+            if (oprsz == 0) {
+                break;
+            }
+            /* fallthru */
+
+        case TCG_TYPE_V128:
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                          t_vec, g->scalar_first, g->fniv);
+            break;
+
+        case TCG_TYPE_V64:
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                          t_vec, g->scalar_first, g->fniv);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_vec(t_vec);
+    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
+        TCGv_i64 t64 = tcg_temp_new_i64();
+
+        gen_dup_i64(g->vece, t64, c);
+        expand_2s_i64(dofs, aofs, oprsz, t64, g->scalar_first, g->fni8);
+        tcg_temp_free_i64(t64);
+    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+
+        tcg_gen_extrl_i64_i32(t32, c);
+        gen_dup_i32(g->vece, t32, t32);
+        expand_2s_i32(dofs, aofs, oprsz, t32, g->scalar_first, g->fni4);
+        tcg_temp_free_i32(t32);
+    } else {
+        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, 0, g->fno);
         return;
     }
 
@@ -1183,6 +1356,121 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+static void tcg_gen_vec_addi8_i64(TCGv_i64 d, TCGv_i64 a, int64_t b)
+{
+    TCGv_i64 t = tcg_const_i64((b & 0xff) * (-1ull / 0xff));
+    tcg_gen_vec_add8_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+static void tcg_gen_vec_addi16_i64(TCGv_i64 d, TCGv_i64 a, int64_t b)
+{
+    TCGv_i64 t = tcg_const_i64((b & 0xffff) * (-1ull / 0xffff));
+    tcg_gen_vec_add16_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+static void tcg_gen_addi_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, t, b);
+    tcg_gen_add_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_addi8_i64,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_adds8,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_addi16_i64,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_adds16,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_addi_i32,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_adds32,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_addi_i64,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_adds64,
+          .opc = INDEX_op_add_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2s g[4] = {
+        { .fni8 = tcg_gen_vec_add8_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds8,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_add16_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds16,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_add_i32,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds32,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_add_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds64,
+          .opc = INDEX_op_add_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2s g[4] = {
+        { .fni8 = tcg_gen_vec_sub8_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs8,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_sub16_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs16,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_sub_i32,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs32,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_sub_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs64,
+          .opc = INDEX_op_sub_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
 /* Perform a vector subtraction using normal subtraction and a mask.
    Compare gen_addv_mask above.  */
 static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
@@ -1291,6 +1579,43 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+static void tcg_gen_muli_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, t, b);
+    tcg_gen_mul_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2i g[4] = {
+        { .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muls8,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muls16,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_muli_i32,
+          .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muls32,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_muli_i64,
+          .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muls64,
+          .opc = INDEX_op_mul_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
@@ -1523,6 +1848,72 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
 }
 
+static void tcg_gen_andi_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, t, b);
+    tcg_gen_and_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2i g = {
+        .fni8 = tcg_gen_andi_i64,
+        .fniv = tcg_gen_andi_vec,
+        .fnoi = gen_helper_gvec_andi,
+        .opc = INDEX_op_and_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .vece = MO_64
+    };
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g);
+}
+
+static void tcg_gen_xori_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, t, b);
+    tcg_gen_xor_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2i g = {
+        .fni8 = tcg_gen_xori_i64,
+        .fniv = tcg_gen_xori_vec,
+        .fnoi = gen_helper_gvec_xori,
+        .opc = INDEX_op_xor_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .vece = MO_64
+    };
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g);
+}
+
+static void tcg_gen_ori_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    tcg_gen_dupi_vec(vece, t, b);
+    tcg_gen_or_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2i g = {
+        .fni8 = tcg_gen_ori_i64,
+        .fniv = tcg_gen_ori_vec,
+        .fnoi = gen_helper_gvec_ori,
+        .opc = INDEX_op_or_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .vece = MO_64
+    };
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g);
+}
+
 void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 {
     uint64_t mask = ((0xff << c) & 0xff) * (-1ull / 0xff);
-- 
2.14.3
