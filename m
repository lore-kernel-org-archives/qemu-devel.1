Received: from eggs.gnu.org ([2001:4830:134:3::10]:37947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro09-0001kT-7j
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro06-00072Z-4d
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:29 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro05-000722-QC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:26 -0400
Received: by mail-pf0-x236.google.com with SMTP id y29so18668673pff.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:03 -0700
Message-Id: <20170912162513.21694-7-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/16] tcg: Add vector infrastructure and
 ops for add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target        |   2 +-
 tcg/tcg-op-gvec.h      |  61 ++++++
 tcg/tcg-runtime.h      |  16 ++
 tcg/tcg.h              |   2 +
 tcg/tcg-op-gvec.c      | 489 +++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-runtime-gvec.c | 192 +++++++++++++++++++
 tcg/tcg.c              |   4 +-
 7 files changed, 763 insertions(+), 3 deletions(-)
 create mode 100644 tcg/tcg-runtime-gvec.c

diff --git a/Makefile.target b/Makefile.target
index e647b6e2cb..9eefe7cbd7 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -95,7 +95,7 @@ obj-y += exec.o
 obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/optimize.o tcg/tcg-common.o
-obj-$(CONFIG_TCG) += tcg/tcg-runtime.o
+obj-$(CONFIG_TCG) += tcg/tcg-runtime.o tcg/tcg-runtime-gvec.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index affb7c2e89..11d04342b6 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -41,3 +41,64 @@ typedef void (gen_helper_gvec_3_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr,
 void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
                         uint32_t data, gen_helper_gvec_3_ptr *fn);
+
+/* Expand a gvec operation.  Either inline or out-of-line depending on
+   the actual vector size and the operations supported by the host.  */
+typedef struct {
+    /* "Small" sizes: expand inline as a 64-bit or 32-bit lane.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Larger sizes: expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_3 *fno;
+    /* Host vector operations.  */
+    TCGOpcode op_v64;
+    TCGOpcode op_v128;
+    TCGOpcode op_v256;
+} GVecGen3;
+
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                    uint32_t opsz, uint32_t clsz, const GVecGen3 *);
+
+/* Expand a specific vector operation.  */
+
+#define DEF(X) \
+    void tcg_gen_gvec_##X(uint32_t dofs, uint32_t aofs, uint32_t bofs, \
+                          uint32_t opsz, uint32_t clsz)
+
+DEF(add8);
+DEF(add16);
+DEF(add32);
+DEF(add64);
+
+DEF(sub8);
+DEF(sub16);
+DEF(sub32);
+DEF(sub64);
+
+DEF(and);
+DEF(or);
+DEF(xor);
+DEF(andc);
+DEF(orc);
+
+#undef DEF
+
+/*
+ * 64-bit vector operations.  Use these when the register has been allocated
+ * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
+ * OPRSZ = MAXSZ = 8.
+ */
+
+#define DEF(X) \
+    void tcg_gen_vec_##X(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+
+DEF(add8);
+DEF(add16);
+DEF(add32);
+
+DEF(sub8);
+DEF(sub16);
+DEF(sub32);
+
+#undef DEF
diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
index c41d38a557..befb0fa659 100644
--- a/tcg/tcg-runtime.h
+++ b/tcg/tcg-runtime.h
@@ -134,3 +134,19 @@ GEN_ATOMIC_HELPERS(xor_fetch)
 GEN_ATOMIC_HELPERS(xchg)
 
 #undef GEN_ATOMIC_HELPERS
+
+DEF_HELPER_FLAGS_4(gvec_add8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_add16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_add32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_add64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_and, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b81c67a754..37ad9fddab 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -824,9 +824,11 @@ int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
 TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
 TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
 
+int tcg_temp_new_internal(TCGType type, int temp_local);
 TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
 TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
 
+void tcg_temp_free_internal(int idx);
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f48415020d..4b39617682 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -24,6 +24,30 @@
 #include "tcg-op-gvec.h"
 #include "tcg-gvec-desc.h"
 
+#define REP8(x)    ((x) * 0x0101010101010101ull)
+#define REP16(x)   ((x) * 0x0001000100010001ull)
+
+#define MAX_UNROLL  4
+
+/* Verify vector size and alignment rules.  OFS should be the OR of all
+   of the operand offsets so that we can check them all at once.  */
+static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
+{
+    uint32_t align = maxsz > 16 || oprsz >= 16 ? 15 : 7;
+    tcg_debug_assert(oprsz > 0);
+    tcg_debug_assert(oprsz <= maxsz);
+    tcg_debug_assert((oprsz & align) == 0);
+    tcg_debug_assert((maxsz & align) == 0);
+    tcg_debug_assert((ofs & align) == 0);
+}
+
+/* Verify vector overlap rules for three operands.  */
+static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s)
+{
+    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
+    tcg_debug_assert(d == b || d + s <= b || b + s <= d);
+    tcg_debug_assert(a == b || a + s <= b || b + s <= a);
+}
 
 /* Create a descriptor from components.  */
 uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
@@ -91,3 +115,468 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
     tcg_temp_free_i32(desc);
 }
+
+/* Return true if we want to implement something of OPRSZ bytes
+   in units of LNSZ.  This limits the expansion of inline code.  */
+static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
+{
+    uint32_t lnct = oprsz / lnsz;
+    return lnct >= 1 && lnct <= MAX_UNROLL;
+}
+
+/* Clear MAXSZ bytes at DOFS using elements of TYPE.  LNSZ = sizeof(TYPE);
+   OPC_MV is the opcode that zeros; OPC_ST is the opcode that stores.  */
+static void expand_clr_v(uint32_t dofs, uint32_t maxsz, uint32_t lnsz,
+                         TCGType type, TCGOpcode opc_mv, TCGOpcode opc_st)
+{
+    TCGArg t0 = tcg_temp_new_internal(type, 0);
+    TCGArg env = GET_TCGV_PTR(tcg_ctx.tcg_env);
+    uint32_t i;
+
+    tcg_gen_op2(&tcg_ctx, opc_mv, t0, 0);
+    for (i = 0; i < maxsz; i += lnsz) {
+        tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
+    }
+    tcg_temp_free_internal(t0);
+}
+
+/* Clear MAXSZ bytes at DOFS.  */
+static void expand_clr(uint32_t dofs, uint32_t maxsz)
+{
+    if (maxsz >= 32 && TCG_TARGET_HAS_v256) {
+        uint32_t done = QEMU_ALIGN_DOWN(maxsz, 32);
+        expand_clr_v(dofs, done, 32, TCG_TYPE_V256,
+                     INDEX_op_movi_v256, INDEX_op_st_v256);
+        dofs += done;
+        maxsz -= done;
+    }
+
+    if (maxsz >= 16 && TCG_TARGET_HAS_v128) {
+        uint16_t done = QEMU_ALIGN_DOWN(maxsz, 16);
+        expand_clr_v(dofs, done, 16, TCG_TYPE_V128,
+                     INDEX_op_movi_v128, INDEX_op_st_v128);
+        dofs += done;
+        maxsz -= done;
+    }
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        expand_clr_v(dofs, maxsz, 8, TCG_TYPE_I64,
+                     INDEX_op_movi_i64, INDEX_op_st_i64);
+    } else if (TCG_TARGET_HAS_v64) {
+        expand_clr_v(dofs, maxsz, 8, TCG_TYPE_V64,
+                     INDEX_op_movi_v64, INDEX_op_st_v64);
+    } else {
+        expand_clr_v(dofs, maxsz, 4, TCG_TYPE_I32,
+                     INDEX_op_movi_i32, INDEX_op_st_i32);
+    }
+}
+
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
+static void expand_3x4(uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t opsz,
+                       void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 4) {
+        tcg_gen_ld_i32(t0, tcg_ctx.tcg_env, aofs + i);
+        tcg_gen_ld_i32(t1, tcg_ctx.tcg_env, bofs + i);
+        fni(t0, t0, t1);
+        tcg_gen_st_i32(t0, tcg_ctx.tcg_env, dofs + i);
+    }
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+}
+
+/* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
+static void expand_3x8(uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t opsz,
+                       void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 8) {
+        tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
+        tcg_gen_ld_i64(t1, tcg_ctx.tcg_env, bofs + i);
+        fni(t0, t0, t1);
+        tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
+    }
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t0);
+}
+
+/* Expand OPSZ bytes worth of three-operand operations using vector elements.
+   OPC_OP is the operation, OPC_LD is the load, OPC_ST is the store.  */
+static void expand_3_v(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                       uint32_t oprsz, uint32_t lnsz, TCGType type,
+                       TCGOpcode opc_op, TCGOpcode opc_ld, TCGOpcode opc_st)
+{
+    TCGArg t0 = tcg_temp_new_internal(type, 0);
+    TCGArg env = GET_TCGV_PTR(tcg_ctx.tcg_env);
+    uint32_t i;
+
+    if (aofs == bofs) {
+        for (i = 0; i < oprsz; i += lnsz) {
+            tcg_gen_op3(&tcg_ctx, opc_ld, t0, env, aofs + i);
+            tcg_gen_op3(&tcg_ctx, opc_op, t0, t0, t0);
+            tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
+        }
+    } else {
+        TCGArg t1 = tcg_temp_new_internal(type, 0);
+        for (i = 0; i < oprsz; i += lnsz) {
+            tcg_gen_op3(&tcg_ctx, opc_ld, t0, env, aofs + i);
+            tcg_gen_op3(&tcg_ctx, opc_ld, t1, env, bofs + i);
+            tcg_gen_op3(&tcg_ctx, opc_op, t0, t0, t1);
+            tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
+        }
+        tcg_temp_free_internal(t1);
+    }
+    tcg_temp_free_internal(t0);
+}
+
+/* Expand a vector three-operand operation.  */
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
+{
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, maxsz);
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
+    if (check_size_impl(oprsz, 32) && tcg_op_supported(g->op_v256)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_3_v(dofs, aofs, bofs, done, 32, TCG_TYPE_V256,
+                   g->op_v256, INDEX_op_ld_v256, INDEX_op_st_v256);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (check_size_impl(oprsz, 16) && tcg_op_supported(g->op_v128)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
+        expand_3_v(dofs, aofs, bofs, done, 16, TCG_TYPE_V128,
+                   g->op_v128, INDEX_op_ld_v128, INDEX_op_st_v128);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (check_size_impl(oprsz, 8)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
+        if (tcg_op_supported(g->op_v64)) {
+            expand_3_v(dofs, aofs, bofs, done, 8, TCG_TYPE_V64,
+                       g->op_v64, INDEX_op_ld_v64, INDEX_op_st_v64);
+        } else if (g->fni8) {
+            expand_3x8(dofs, aofs, bofs, done, g->fni8);
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
+    if (check_size_impl(oprsz, 4)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
+        expand_3x4(dofs, aofs, bofs, done, g->fni4);
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
+    tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, g->fno);
+}
+
+/*
+ * Expand specific vector operations.
+ */
+
+static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+
+    tcg_gen_andc_i64(t1, a, m);
+    tcg_gen_andc_i64(t2, b, m);
+    tcg_gen_xor_i64(t3, a, b);
+    tcg_gen_add_i64(d, t1, t2);
+    tcg_gen_and_i64(t3, t3, m);
+    tcg_gen_xor_i64(d, d, t3);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
+}
+
+void tcg_gen_vec_add8(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 m = tcg_const_i64(REP8(0x80));
+    gen_addv_mask(d, a, b, m);
+    tcg_temp_free_i64(m);
+}
+
+void tcg_gen_vec_add16(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
+    gen_addv_mask(d, a, b, m);
+    tcg_temp_free_i64(m);
+}
+
+void tcg_gen_vec_add32(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t1, a, ~0xffffffffull);
+    tcg_gen_add_i64(t2, a, b);
+    tcg_gen_add_i64(t1, t1, b);
+    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+void tcg_gen_gvec_add8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                       uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_vec_add8,
+        .fno = gen_helper_gvec_add8,
+        .op_v64 = INDEX_op_add8_v64,
+        .op_v128 = INDEX_op_add8_v128,
+        .op_v256 = INDEX_op_add8_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_add16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_vec_add16,
+        .fno = gen_helper_gvec_add16,
+        .op_v64 = INDEX_op_add16_v64,
+        .op_v128 = INDEX_op_add16_v128,
+        .op_v256 = INDEX_op_add16_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_add32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni4 = tcg_gen_add_i32,
+        .fno = gen_helper_gvec_add32,
+        .op_v64 = INDEX_op_add32_v64,
+        .op_v128 = INDEX_op_add32_v128,
+        .op_v256 = INDEX_op_add32_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_add64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_add_i64,
+        .fno = gen_helper_gvec_add64,
+        .op_v128 = INDEX_op_add64_v128,
+        .op_v256 = INDEX_op_add64_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    TCGv_i64 t3 = tcg_temp_new_i64();
+
+    tcg_gen_or_i64(t1, a, m);
+    tcg_gen_andc_i64(t2, b, m);
+    tcg_gen_eqv_i64(t3, a, b);
+    tcg_gen_sub_i64(d, t1, t2);
+    tcg_gen_and_i64(t3, t3, m);
+    tcg_gen_xor_i64(d, d, t3);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
+}
+
+void tcg_gen_vec_sub8(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 m = tcg_const_i64(REP8(0x80));
+    gen_subv_mask(d, a, b, m);
+    tcg_temp_free_i64(m);
+}
+
+void tcg_gen_vec_sub16(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
+    gen_subv_mask(d, a, b, m);
+    tcg_temp_free_i64(m);
+}
+
+void tcg_gen_vec_sub32(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t1, b, ~0xffffffffull);
+    tcg_gen_sub_i64(t2, a, b);
+    tcg_gen_sub_i64(t1, a, t1);
+    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+void tcg_gen_gvec_sub8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                       uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_vec_sub8,
+        .fno = gen_helper_gvec_sub8,
+        .op_v64 = INDEX_op_sub8_v64,
+        .op_v128 = INDEX_op_sub8_v128,
+        .op_v256 = INDEX_op_sub8_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_sub16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_vec_sub16,
+        .fno = gen_helper_gvec_sub16,
+        .op_v64 = INDEX_op_sub16_v64,
+        .op_v128 = INDEX_op_sub16_v128,
+        .op_v256 = INDEX_op_sub16_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_sub32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni4 = tcg_gen_sub_i32,
+        .fno = gen_helper_gvec_sub32,
+        .op_v64 = INDEX_op_sub32_v64,
+        .op_v128 = INDEX_op_sub32_v128,
+        .op_v256 = INDEX_op_sub32_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_sub64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_sub_i64,
+        .fno = gen_helper_gvec_sub64,
+        .op_v128 = INDEX_op_sub64_v128,
+        .op_v256 = INDEX_op_sub64_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_and(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                      uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_and_i64,
+        .fno = gen_helper_gvec_and,
+        .op_v64 = INDEX_op_and_v64,
+        .op_v128 = INDEX_op_and_v128,
+        .op_v256 = INDEX_op_and_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_or(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_or_i64,
+        .fno = gen_helper_gvec_or,
+        .op_v64 = INDEX_op_or_v64,
+        .op_v128 = INDEX_op_or_v128,
+        .op_v256 = INDEX_op_or_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_xor(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                      uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_xor_i64,
+        .fno = gen_helper_gvec_xor,
+        .op_v64 = INDEX_op_xor_v64,
+        .op_v128 = INDEX_op_xor_v128,
+        .op_v256 = INDEX_op_xor_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_andc(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                       uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_andc_i64,
+        .fno = gen_helper_gvec_andc,
+        .op_v64 = INDEX_op_andc_v64,
+        .op_v128 = INDEX_op_andc_v128,
+        .op_v256 = INDEX_op_andc_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
+
+void tcg_gen_gvec_orc(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                      uint32_t opsz, uint32_t clsz)
+{
+    static const GVecGen3 g = {
+        .fni8 = tcg_gen_orc_i64,
+        .fno = gen_helper_gvec_orc,
+        .op_v64 = INDEX_op_orc_v64,
+        .op_v128 = INDEX_op_orc_v128,
+        .op_v256 = INDEX_op_orc_v256,
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
+}
diff --git a/tcg/tcg-runtime-gvec.c b/tcg/tcg-runtime-gvec.c
new file mode 100644
index 0000000000..ff0f896629
--- /dev/null
+++ b/tcg/tcg-runtime-gvec.c
@@ -0,0 +1,192 @@
+/*
+ *  Generic vectorized operation runtime
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "tcg-gvec-desc.h"
+
+
+/* Virtually all hosts support 16-byte vectors.  Those that don't can emulate
+   them via GCC's generic vector extension.  This turns out to be simpler and
+   more reliable than getting the compiler to autovectorize.
+
+   In tcg-op-gvec.c, we asserted that both the size and alignment
+   of the data are multiples of 16.  */
+
+typedef uint8_t vec8 __attribute__((vector_size(16)));
+typedef uint16_t vec16 __attribute__((vector_size(16)));
+typedef uint32_t vec32 __attribute__((vector_size(16)));
+typedef uint64_t vec64 __attribute__((vector_size(16)));
+
+static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
+{
+    intptr_t maxsz = simd_maxsz(desc);
+    intptr_t i;
+
+    if (unlikely(maxsz > oprsz)) {
+        for (i = oprsz; i < maxsz; i += sizeof(vec64)) {
+            *(vec64 *)(d + i) = (vec64){ 0 };
+        }
+    }
+}
+
+void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) + *(vec8 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) + *(vec16 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) + *(vec32 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) + *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) - *(vec8 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) - *(vec16 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) - *(vec32 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) - *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_and)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) & *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_or)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) | *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_xor)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_andc)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8fca202bec..240bcaa8d5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -602,7 +602,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
     return temp_idx(s, ts);
 }
 
-static int tcg_temp_new_internal(TCGType type, int temp_local)
+int tcg_temp_new_internal(TCGType type, int temp_local)
 {
     TCGContext *s = &tcg_ctx;
     TCGTemp *ts;
@@ -664,7 +664,7 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
     return MAKE_TCGV_I64(idx);
 }
 
-static void tcg_temp_free_internal(int idx)
+void tcg_temp_free_internal(int idx)
 {
     TCGContext *s = &tcg_ctx;
     TCGTemp *ts;
-- 
2.13.5
