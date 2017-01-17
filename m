Received: from eggs.gnu.org ([2001:4830:134:3::10]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkl-0003Dv-In
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-0003tc-Ln
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:31 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50184 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-0003tA-8L
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:25 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:47 +0300
Message-Id: <1484644078-21312-8-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 07/18] tcg: add vector addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg-op.h  | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-opc.h |  12 +++++
 tcg/tcg.h     |  29 ++++++++++
 3 files changed, 210 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index c469ea3..5de74d3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1153,6 +1153,8 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_add_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
 # define tcg_gen_addi_ptr(R, A, B) \
     tcg_gen_addi_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
+# define tcg_gen_movi_ptr(R, B) \
+    tcg_gen_movi_i32(TCGV_PTR_TO_NAT(R), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_mov_i32(TCGV_PTR_TO_NAT(R), (A))
 #else
@@ -1164,6 +1166,173 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_add_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
 # define tcg_gen_addi_ptr(R, A, B) \
     tcg_gen_addi_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
+# define tcg_gen_movi_ptr(R, B) \
+    tcg_gen_movi_i64(TCGV_PTR_TO_NAT(R), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_ext_i32_i64(TCGV_PTR_TO_NAT(R), (A))
 #endif /* UINTPTR_MAX == UINT32_MAX */
+
+/***************************************/
+/* 64-bit and 128-bit vector arithmetic.          */
+
+static inline void *tcg_v128_swap_slot(int n)
+{
+    return &tcg_ctx.v128_swap[n * 16];
+}
+
+/* Find a memory location for 128-bit TCG variable. */
+static inline void tcg_v128_to_ptr(TCGv_v128 tmp, TCGv_ptr base, int slot,
+                                   TCGv_ptr *real_base, intptr_t *real_offset,
+                                   int is_read)
+{
+    int idx = GET_TCGV_V128(tmp);
+    assert(idx >= 0 && idx < tcg_ctx.nb_temps);
+    if (idx < tcg_ctx.nb_globals) {
+        /* Globals use their locations within CPUArchState. */
+        int env = GET_TCGV_PTR(tcg_ctx.tcg_env);
+        TCGTemp *ts_env = &tcg_ctx.temps[env];
+        TCGTemp *ts_arg = &tcg_ctx.temps[idx];
+
+        /* Sanity checks: global's memory locations must be addressed
+           relative to ENV. */
+        assert(ts_env->val_type == TEMP_VAL_REG &&
+               ts_env == ts_arg->mem_base &&
+               ts_arg->mem_allocated);
+
+        *real_base = tcg_ctx.tcg_env;
+        *real_offset = ts_arg->mem_offset;
+    } else {
+        /* Temporaries use swap space in TCGContext. Since we already have
+           a 128-bit temporary we'll assume that the target supports 128-bit
+           loads and stores. */
+        *real_base = base;
+        *real_offset = slot * 16;
+        if (is_read) {
+            tcg_gen_st_v128(tmp, base, slot * 16);
+        }
+    }
+}
+
+/* Find a memory location for 64-bit vector TCG variable. */
+static inline void tcg_v64_to_ptr(TCGv_v64 tmp, TCGv_ptr base, int slot,
+                                  TCGv_ptr *real_base, intptr_t *real_offset,
+                                  int is_read)
+{
+    int idx = GET_TCGV_V64(tmp);
+    assert(idx >= 0 && idx < tcg_ctx.nb_temps);
+    if (idx < tcg_ctx.nb_globals) {
+        /* Globals use their locations within CPUArchState. */
+        int env = GET_TCGV_PTR(tcg_ctx.tcg_env);
+        TCGTemp *ts_env = &tcg_ctx.temps[env];
+        TCGTemp *ts_arg = &tcg_ctx.temps[idx];
+
+        /* Sanity checks: global's memory locations must be addressed
+           relative to ENV. */
+        assert(ts_env->val_type == TEMP_VAL_REG &&
+               ts_env == ts_arg->mem_base &&
+               ts_arg->mem_allocated);
+
+        *real_base = tcg_ctx.tcg_env;
+        *real_offset = ts_arg->mem_offset;
+    } else {
+        /* Temporaries use swap space in TCGContext. Since we already have
+           a 128-bit temporary we'll assume that the target supports 128-bit
+           loads and stores. */
+        *real_base = base;
+        *real_offset = slot * 16;
+        if (is_read) {
+            tcg_gen_st_v64(tmp, base, slot * 16);
+        }
+    }
+}
+
+#define GEN_VECT_WRAPPER(name, type, func)                                   \
+    static inline void glue(tcg_gen_, name)(glue(TCGv_, type) res,           \
+                                            glue(TCGv_, type) arg1,          \
+                                            glue(TCGv_, type) arg2)          \
+    {                                                                        \
+        if (glue(TCG_TARGET_HAS_, name)) {                                   \
+            glue(tcg_gen_op3_, type)(glue(INDEX_op_, name), res, arg1,       \
+                                     arg2);                                  \
+        } else {                                                             \
+            TCGv_ptr base = tcg_temp_new_ptr();                              \
+            TCGv_ptr t1 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t2 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t3 = tcg_temp_new_ptr();                                \
+            TCGv_ptr arg1p, arg2p, resp;                                     \
+            intptr_t arg1of, arg2of, resof;                                  \
+                                                                             \
+            tcg_gen_movi_ptr(base, (unsigned long)&tcg_ctx.v128_swap[0]);    \
+                                                                             \
+            glue(glue(tcg_, type), _to_ptr)(arg1, base, 1,                   \
+                                            &arg1p, &arg1of, 1);             \
+            glue(glue(tcg_, type), _to_ptr)(arg2, base, 2,                   \
+                                            &arg2p, &arg2of, 1);             \
+            glue(glue(tcg_, type), _to_ptr)(res, base, 0, &resp, &resof, 0); \
+                                                                             \
+            tcg_gen_addi_ptr(t1, resp, resof);                               \
+            tcg_gen_addi_ptr(t2, arg1p, arg1of);                             \
+            tcg_gen_addi_ptr(t3, arg2p, arg2of);                             \
+            func(t1, t2, t3);                                                \
+                                                                             \
+            if ((intptr_t)res >= tcg_ctx.nb_globals) {                       \
+                glue(tcg_gen_ld_, type)(res, base, 0);                       \
+            }                                                                \
+                                                                             \
+            tcg_temp_free_ptr(base);                                         \
+            tcg_temp_free_ptr(t1);                                           \
+            tcg_temp_free_ptr(t2);                                           \
+            tcg_temp_free_ptr(t3);                                           \
+        }                                                                    \
+    }
+
+#define TCG_INTERNAL_OP(name, N, size, ld, st, op, type)                     \
+    static inline void glue(tcg_internal_, name)(TCGv_ptr resp,              \
+                                                 TCGv_ptr arg1p,             \
+                                                 TCGv_ptr arg2p)             \
+    {                                                                        \
+        int i;                                                               \
+        glue(TCGv_, type) tmp1, tmp2;                                        \
+                                                                             \
+        tmp1 = glue(tcg_temp_new_, type)();                                  \
+        tmp2 = glue(tcg_temp_new_, type)();                                  \
+                                                                             \
+        for (i = 0; i < N; i++) {                                            \
+            glue(tcg_gen_, ld)(tmp1, arg1p, i * size);                       \
+            glue(tcg_gen_, ld)(tmp2, arg2p, i * size);                       \
+            glue(tcg_gen_, op)(tmp1, tmp1, tmp2);                            \
+            glue(tcg_gen_, st)(tmp1, resp, i * size);                        \
+        }                                                                    \
+                                                                             \
+        glue(tcg_temp_free_, type)(tmp1);                                    \
+        glue(tcg_temp_free_, type)(tmp2);                                    \
+    }
+
+#define TCG_INTERNAL_OP_8(name, N, op) \
+    TCG_INTERNAL_OP(name, N, 1, ld8u_i32, st8_i32, op, i32)
+#define TCG_INTERNAL_OP_16(name, N, op) \
+    TCG_INTERNAL_OP(name, N, 2, ld16u_i32, st16_i32, op, i32)
+#define TCG_INTERNAL_OP_32(name, N, op) \
+    TCG_INTERNAL_OP(name, N, 4, ld_i32, st_i32, op, i32)
+#define TCG_INTERNAL_OP_64(name, N, op) \
+    TCG_INTERNAL_OP(name, N, 8, ld_i64, st_i64, op, i64)
+
+TCG_INTERNAL_OP_8(add_i8x16, 16, add_i32)
+TCG_INTERNAL_OP_16(add_i16x8, 8, add_i32)
+TCG_INTERNAL_OP_32(add_i32x4, 4, add_i32)
+TCG_INTERNAL_OP_64(add_i64x2, 2, add_i64)
+
+TCG_INTERNAL_OP_8(add_i8x8, 8, add_i32)
+TCG_INTERNAL_OP_16(add_i16x4, 4, add_i32)
+TCG_INTERNAL_OP_32(add_i32x2, 2, add_i32)
+TCG_INTERNAL_OP_64(add_i64x1, 1, add_i64)
+
+GEN_VECT_WRAPPER(add_i8x16, v128, tcg_internal_add_i8x16)
+GEN_VECT_WRAPPER(add_i16x8, v128, tcg_internal_add_i16x8)
+GEN_VECT_WRAPPER(add_i32x4, v128, tcg_internal_add_i32x4)
+GEN_VECT_WRAPPER(add_i64x2, v128, tcg_internal_add_i64x2)
+
+GEN_VECT_WRAPPER(add_i8x8, v64, tcg_internal_add_i8x8)
+GEN_VECT_WRAPPER(add_i16x4, v64, tcg_internal_add_i16x4)
+GEN_VECT_WRAPPER(add_i32x2, v64, tcg_internal_add_i32x2)
+GEN_VECT_WRAPPER(add_i64x1, v64, tcg_internal_add_i64x1)
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index d622592..0022535 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -196,6 +196,18 @@ DEF(ld_v128, 1, 1, 1, IMPL128)
 DEF(st_v64, 0, 2, 1, IMPLV64)
 DEF(ld_v64, 1, 1, 1, IMPLV64)
 
+/* 128-bit vector arith */
+DEF(add_i8x16, 1, 2, 0, IMPL128 | IMPL(TCG_TARGET_HAS_add_i8x16))
+DEF(add_i16x8, 1, 2, 0, IMPL128 | IMPL(TCG_TARGET_HAS_add_i16x8))
+DEF(add_i32x4, 1, 2, 0, IMPL128 | IMPL(TCG_TARGET_HAS_add_i32x4))
+DEF(add_i64x2, 1, 2, 0, IMPL128 | IMPL(TCG_TARGET_HAS_add_i64x2))
+
+/* 64-bit vector arith */
+DEF(add_i8x8, 1, 2, 0, IMPLV64 | IMPL(TCG_TARGET_HAS_add_i8x8))
+DEF(add_i16x4, 1, 2, 0, IMPLV64 | IMPL(TCG_TARGET_HAS_add_i16x4))
+DEF(add_i32x2, 1, 2, 0, IMPLV64 | IMPL(TCG_TARGET_HAS_add_i32x2))
+DEF(add_i64x1, 1, 2, 0, IMPLV64 | IMPL(TCG_TARGET_HAS_add_i64x1))
+
 /* QEMU specific */
 DEF(insn_start, 0, 0, TLADDR_ARGS * TARGET_INSN_START_WORDS,
     TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6473228..6f4d0e7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -145,6 +145,34 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_rem_i64          0
 #endif
 
+/* 64-bit vector */
+#ifndef TCG_TARGET_HAS_add_i8x8
+#define TCG_TARGET_HAS_add_i8x8         0
+#endif
+#ifndef TCG_TARGET_HAS_add_i16x4
+#define TCG_TARGET_HAS_add_i16x4        0
+#endif
+#ifndef TCG_TARGET_HAS_add_i32x2
+#define TCG_TARGET_HAS_add_i32x2        0
+#endif
+#ifndef TCG_TARGET_HAS_add_i64x1
+#define TCG_TARGET_HAS_add_i64x1        0
+#endif
+
+/* 128-bit vector */
+#ifndef TCG_TARGET_HAS_add_i8x16
+#define TCG_TARGET_HAS_add_i8x16        0
+#endif
+#ifndef TCG_TARGET_HAS_add_i16x8
+#define TCG_TARGET_HAS_add_i16x8        0
+#endif
+#ifndef TCG_TARGET_HAS_add_i32x4
+#define TCG_TARGET_HAS_add_i32x4        0
+#endif
+#ifndef TCG_TARGET_HAS_add_i64x2
+#define TCG_TARGET_HAS_add_i64x2        0
+#endif
+
 /* For 32-bit targets, some sort of unsigned widening multiply is required.  */
 #if TCG_TARGET_REG_BITS == 32 \
     && !(defined(TCG_TARGET_HAS_mulu2_i32) \
@@ -750,6 +778,7 @@ struct TCGContext {
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
+    uint8_t v128_swap[16 * 3];
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
-- 
2.1.4
