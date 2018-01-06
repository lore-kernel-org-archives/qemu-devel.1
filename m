Received: from eggs.gnu.org ([2001:4830:134:3::10]:48357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevz-0007Z8-Ov
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevx-0005Cq-8G
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:11 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevw-0005As-Ty
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:09 -0500
Received: by mail-pf0-x244.google.com with SMTP id y89so2973684pfk.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:08 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:34 -0800
Message-Id: <20180106031346.6650-12-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 11/23] tcg: Add generic vector helpers with
 a scalar immediate operand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We already have immediate shifts.  Add addition, multiplication,
and logical operations with an immediate.  Subtraction can thus
be done with negation of the constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  14 ++++
 tcg/tcg-op-gvec.h            |  22 ++++-
 accel/tcg/tcg-runtime-gvec.c | 136 +++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 186 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 356 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index ec187a094b..cf0b5e0d9a 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -147,6 +147,11 @@ DEF_HELPER_FLAGS_4(gvec_add16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_add32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_add64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_addi8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_addi16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_addi32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_addi64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_sub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -157,6 +162,11 @@ DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_muli8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_muli16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_muli32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_muli64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_ssadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ssadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ssadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -189,6 +199,10 @@ DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
index bcdf0eb413..a27a2eea87 100644
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
@@ -179,6 +187,11 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+
 /* Saturated arithmetic.  */
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t opsz, uint32_t clsz);
@@ -200,6 +213,13 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
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
index e84c900670..370375c49e 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -97,6 +97,56 @@ void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_addi8)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    uint8_t b = simd_data(desc);
+    vec8 vecb = (vec8){ b, b, b, b, b, b, b, b, b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_addi16)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    uint16_t b = simd_data(desc);
+    vec16 vecb = (vec16){ b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_addi32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32){ b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) + vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_addi64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64){ b, b };
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
@@ -185,6 +235,56 @@ void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_muli8)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    uint8_t b = simd_data(desc);
+    vec8 vecb = (vec8){ b, b, b, b, b, b, b, b, b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muli16)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    uint16_t b = simd_data(desc);
+    vec16 vecb = (vec16){ b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muli32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32){ b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) * vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_muli64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64){ b, b };
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
@@ -343,6 +443,42 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_andi)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64){ b, b };
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
+    vec64 vecb = (vec64){ b, b };
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
+    vec64 vecb = (vec64){ b, b };
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
index 39799f9c3e..fc13dd53c8 100644
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
@@ -922,7 +944,13 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     }
 
  do_ool:
-    tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+    if (g->fno) {
+        tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
+    } else {
+        TCGv_i64 tcg_c = tcg_const_i64(c);
+        tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz, maxsz, c, g->fnoi);
+        tcg_temp_free_i64(tcg_c);
+    }
 }
 
 /* Expand a vector three-operand operation.  */
@@ -1325,6 +1353,59 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
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
+          .fno = gen_helper_gvec_addi8,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_addi16_i64,
+          .fniv = tcg_gen_addi_vec,
+          .fno = gen_helper_gvec_addi16,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_addi_i32,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_addi32,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_addi_i64,
+          .fniv = tcg_gen_addi_vec,
+          .fnoi = gen_helper_gvec_addi64,
+          .opc = INDEX_op_add_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
 /* Perform a vector subtraction using normal subtraction and a mask.
    Compare gen_addv_mask above.  */
 static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
@@ -1433,6 +1514,43 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
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
+          .fno = gen_helper_gvec_muli8,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_muli_vec,
+          .fno = gen_helper_gvec_muli16,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_muli_i32,
+          .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muli32,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_muli_i64,
+          .fniv = tcg_gen_muli_vec,
+          .fnoi = gen_helper_gvec_muli64,
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
                         uint32_t bofs, uint32_t opsz, uint32_t maxsz)
 {
@@ -1665,6 +1783,72 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
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
