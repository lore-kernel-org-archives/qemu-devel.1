Received: from eggs.gnu.org ([2001:4830:134:3::10]:37594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3q-0000iB-F6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3o-0001Y2-L6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:42 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:39324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3o-0001X6-BO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:40 -0500
Received: by mail-pf0-x241.google.com with SMTP id l24so9940974pfj.6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:56 -0800
Message-Id: <20171218171758.16964-25-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 24/26] tcg: Add support for 4 operand vector
 ops
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
 tcg/tcg-op-gvec.h |  45 +++++++++--
 tcg/tcg-op-gvec.c | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 188c3368bd..91459b9c38 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -30,29 +30,43 @@
 
 /* Expand a call to a gvec-style helper, with pointers to two vector
    operands, and a descriptor (see tcg-gvec-desc.h).  */
-typedef void (gen_helper_gvec_2)(TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void gen_helper_gvec_2(TCGv_ptr, TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
                         uint32_t oprsz, uint32_t maxsz, int32_t data,
                         gen_helper_gvec_2 *fn);
 
 /* Similarly, passing an extra pointer (e.g. env or float_status).  */
-typedef void (gen_helper_gvec_2_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void gen_helper_gvec_2_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
                         TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
                         int32_t data, gen_helper_gvec_2_ptr *fn);
 
 /* Similarly, with three vector operands.  */
-typedef void (gen_helper_gvec_3)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+typedef void gen_helper_gvec_3(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t oprsz, uint32_t maxsz, int32_t data,
                         gen_helper_gvec_3 *fn);
 
-typedef void (gen_helper_gvec_3_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                                     TCGv_ptr, TCGv_i32);
+/* Similarly, with four vector operands.  */
+typedef void gen_helper_gvec_4(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                               TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
+                        int32_t data, gen_helper_gvec_4 *fn);
+
+typedef void gen_helper_gvec_3_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_i32);
 void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
                         int32_t data, gen_helper_gvec_3_ptr *fn);
 
+typedef void gen_helper_gvec_4_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_4_ptr *fn);
+
 /* Expand a gvec operation.  Either inline or out-of-line depending on
    the actual vector size and the operations supported by the host.  */
 typedef struct {
@@ -114,12 +128,33 @@ typedef struct {
     bool load_dest;
 } GVecGen3;
 
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_4 *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The data argument to the out-of-line helper.  */
+    uint32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+} GVecGen4;
+
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t opsz, uint32_t clsz, const GVecGen2 *);
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t opsz,
                      uint32_t clsz, unsigned c, const GVecGen2i *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t opsz, uint32_t clsz, const GVecGen3 *);
+void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
+                    uint32_t opsz, uint32_t clsz, const GVecGen4 *);
 
 /* Expand a specific vector operation.  */
 
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 8ec1817727..5f58859a1e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -55,6 +55,18 @@ static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s)
     check_overlap_2(a, b, s);
 }
 
+/* Verify vector overlap rules for four operands.  */
+static void check_overlap_4(uint32_t d, uint32_t a, uint32_t b,
+                            uint32_t c, uint32_t s)
+{
+    check_overlap_2(d, a, s);
+    check_overlap_2(d, b, s);
+    check_overlap_2(d, c, s);
+    check_overlap_2(a, b, s);
+    check_overlap_2(a, c, s);
+    check_overlap_2(b, c, s);
+}
+
 /* Create a descriptor from components.  */
 uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 {
@@ -118,6 +130,33 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_i32(desc);
 }
 
+/* Generate a call to a gvec-style helper with four vector operands.  */
+void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
+                        int32_t data, gen_helper_gvec_4 *fn)
+{
+    TCGv_ptr a0, a1, a2, a3;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+    a3 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);
+
+    fn(a0, a1, a2, a3, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_ptr(a3);
+    tcg_temp_free_i32(desc);
+}
+
 /* Generate a call to a gvec-style helper with three vector operands
    and an extra pointer operand.  */
 void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
@@ -165,6 +204,35 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_i32(desc);
 }
 
+/* Generate a call to a gvec-style helper with four vector operands
+   and an extra pointer operand.  */
+void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_4_ptr *fn)
+{
+    TCGv_ptr a0, a1, a2, a3;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+    a3 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);
+
+    fn(a0, a1, a2, a3, ptr, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_ptr(a3);
+    tcg_temp_free_i32(desc);
+}
+
 /* Return true if we want to implement something of OPRSZ bytes
    in units of LNSZ.  This limits the expansion of inline code.  */
 static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
@@ -468,6 +536,30 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i32(t0);
 }
 
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
+static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                         uint32_t cofs, uint32_t opsz,
+                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 4) {
+        tcg_gen_ld_i32(t1, cpu_env, aofs + i);
+        tcg_gen_ld_i32(t2, cpu_env, bofs + i);
+        tcg_gen_ld_i32(t3, cpu_env, cofs + i);
+        fni(t0, t1, t2, t3);
+        tcg_gen_st_i32(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+}
+
 /* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
 static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t opsz,
                          void (*fni)(TCGv_i64, TCGv_i64))
@@ -527,6 +619,30 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i64(t0);
 }
 
+/* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
+static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                         uint32_t cofs, uint32_t opsz,
+                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 4) {
+        tcg_gen_ld_i64(t1, cpu_env, aofs + i);
+        tcg_gen_ld_i64(t2, cpu_env, bofs + i);
+        tcg_gen_ld_i64(t3, cpu_env, cofs + i);
+        fni(t0, t1, t2, t3);
+        tcg_gen_st_i64(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t3);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t0);
+}
+
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
 static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t opsz, uint32_t tysz, TCGType type,
@@ -591,6 +707,32 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t0);
 }
 
+/* Expand OPSZ bytes worth of four-operand operations using host vectors.  */
+static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                         uint32_t bofs, uint32_t cofs, uint32_t opsz,
+                         uint32_t tysz, TCGType type,
+                         void (*fni)(unsigned, TCGv_vec, TCGv_vec,
+                                     TCGv_vec, TCGv_vec))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    TCGv_vec t2 = tcg_temp_new_vec(type);
+    TCGv_vec t3 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += tysz) {
+        tcg_gen_ld_vec(t1, cpu_env, aofs + i);
+        tcg_gen_ld_vec(t2, cpu_env, bofs + i);
+        tcg_gen_ld_vec(t3, cpu_env, cofs + i);
+        fni(vece, t0, t1, t2, t3);
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t3);
+    tcg_temp_free_vec(t2);
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t0);
+}
+
 /* Expand a vector two-operand operation.  */
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
@@ -831,6 +973,90 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, g->data, g->fno);
 }
 
+/* Expand a vector four-operand operation.  */
+void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
+{
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
+    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
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
+        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, done,
+                     32, TCG_TYPE_V256, g->fniv);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
+        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
+        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, done,
+                     16, TCG_TYPE_V128, g->fniv);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (check_size_impl(oprsz, 8)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
+        if (TCG_TARGET_HAS_v64 && !g->prefer_i64
+            && (!g->opc
+                || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+            expand_4_vec(g->vece, dofs, aofs, bofs, cofs, done,
+                         8, TCG_TYPE_V64, g->fniv);
+        } else if (g->fni8) {
+            expand_4_i64(dofs, aofs, bofs, cofs, done, g->fni8);
+        } else {
+            done = 0;
+        }
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (g->fni4 && check_size_impl(oprsz, 4)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
+        expand_4_i32(dofs, aofs, bofs, cofs, done, g->fni4);
+        dofs += done;
+        aofs += done;
+        bofs += done;
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
+    tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs, oprsz, maxsz, g->data, g->fno);
+}
+
 /*
  * Expand specific vector operations.
  */
-- 
2.14.3
