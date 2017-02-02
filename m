Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU4-0005No-Nb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITx-0005Pn-Kt
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:36 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39804 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITw-0005Ow-Uc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:29 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:46 +0300
Message-Id: <1486046099-17726-9-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 08/21] tcg: add vector addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---

Support for representing a v128 addition as two v64 additions have been added.
As a result GEN_VECT_WRAPPER_HALVES macro was added. It is larger and more
complicated than original GEN_VECT_WRAPPER (which is still used for v64 additions
because they do not have half operations (v32 additions)).

GEN_VECT_WRAPPER_HALVES seems to grow fast (in size and complexity) for each
supported representation. Calling tcg_gen_add_<smaller_size> may not be desirable
because last resort fallback code is better be generated for the whole vector as
it will require less additional operations.

Some additional performance optimization can be done by creating hand written
tcg_gen_internal_<operation> for some cases (for example, add_i8x16). This function
will still operate on memory locations but will use 64 bit scalar additions with some
bit masking as Richard suggested in v1 discussion. This series is focused on
infrastructure (not on optimization of particular instructions), so I have not
included this optimization yet.

---
 tcg/tcg-op.c  |  64 ++++++++++++++++++++++
 tcg/tcg-op.h  | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-opc.h |  12 +++++
 tcg/tcg.c     |  12 +++++
 tcg/tcg.h     |  43 +++++++++++++++
 5 files changed, 298 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 95a39b7..8a19eee 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3038,3 +3038,67 @@ static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
 GEN_ATOMIC_HELPER(xchg, mov2, 0)
 
 #undef GEN_ATOMIC_HELPER
+
+/* Find a memory location for 128-bit TCG variable. */
+void tcg_v128_to_ptr(TCGv_v128 tmp, TCGv_ptr base, int slot,
+                     TCGv_ptr *real_base, intptr_t *real_offset, int is_read)
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
+void tcg_v64_to_ptr(TCGv_v64 tmp, TCGv_ptr base, int slot,
+                    TCGv_ptr *real_base, intptr_t *real_offset, int is_read)
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
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 250493b..3727be7 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1195,6 +1195,10 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_add_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
 # define tcg_gen_addi_ptr(R, A, B) \
     tcg_gen_addi_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
+# define tcg_gen_mov_ptr(R, B) \
+    tcg_gen_mov_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(B))
+# define tcg_gen_movi_ptr(R, B) \
+    tcg_gen_movi_i32(TCGV_PTR_TO_NAT(R), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_mov_i32(TCGV_PTR_TO_NAT(R), (A))
 #else
@@ -1206,6 +1210,169 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_add_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
 # define tcg_gen_addi_ptr(R, A, B) \
     tcg_gen_addi_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
+# define tcg_gen_mov_ptr(R, B) \
+    tcg_gen_mov_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(B))
+# define tcg_gen_movi_ptr(R, B) \
+    tcg_gen_movi_i64(TCGV_PTR_TO_NAT(R), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_ext_i32_i64(TCGV_PTR_TO_NAT(R), (A))
 #endif /* UINTPTR_MAX == UINT32_MAX */
+
+/***************************************/
+/* 64-bit and 128-bit vector arithmetic.          */
+
+/* Find a memory location for 128-bit TCG variable. */
+void tcg_v128_to_ptr(TCGv_v128 tmp, TCGv_ptr base, int slot,
+                     TCGv_ptr *real_base, intptr_t *real_offset, int is_read);
+/* Find a memory location for 64-bit vector TCG variable. */
+void tcg_v64_to_ptr(TCGv_v64 tmp, TCGv_ptr base, int slot,
+                    TCGv_ptr *real_base, intptr_t *real_offset, int is_read);
+
+#define VTYPE(width) glue(TCG_TYPE_V, width)
+#define TEMP_TYPE(arg, temp_type) \
+            tcg_ctx.temps[glue(GET_TCGV_, temp_type)(arg)].type
+
+#define GEN_VECT_WRAPPER_HALVES(op, width, half_op, half_width, func)        \
+    static inline void glue(tcg_gen_, op)(glue(TCGv_v, width) res,           \
+                                            glue(TCGv_v, width) arg1,        \
+                                            glue(TCGv_v, width) arg2)        \
+    {                                                                        \
+        if (glue(TCG_TARGET_HAS_, op)) {                                     \
+            glue(tcg_gen_op3_v, width)(glue(INDEX_op_, op), res, arg1,       \
+                                       arg2);                                \
+        } else if (TEMP_TYPE(res, glue(V, width)) == VTYPE(half_width) &&    \
+                   glue(TCG_TARGET_HAS_, half_op)) {                         \
+            glue(TCGv_v, half_width) res_lo, res_hi, arg1_lo, arg1_hi,       \
+                                     arg2_lo, arg2_hi;                       \
+            res_lo = glue(tcg_temp_low_half_v, width)(res);                  \
+            res_hi = glue(tcg_temp_high_half_v, width)(res);                 \
+            arg1_lo = glue(tcg_temp_low_half_v, width)(arg1);                \
+            arg1_hi = glue(tcg_temp_high_half_v, width)(arg1);               \
+            arg2_lo = glue(tcg_temp_low_half_v, width)(arg2);                \
+            arg2_hi = glue(tcg_temp_high_half_v, width)(arg2);               \
+            glue(tcg_gen_op3_v, half_width)(glue(INDEX_op_, half_op),        \
+                                            res_lo, arg1_lo, arg2_lo);       \
+            glue(tcg_gen_op3_v, half_width)(glue(INDEX_op_, half_op),        \
+                                            res_hi, arg1_hi, arg2_hi);       \
+        } else {                                                             \
+            TCGv_ptr base =                                                  \
+                        MAKE_TCGV_PTR(tcg_ctx.frame_temp - tcg_ctx.temps);   \
+            TCGv_ptr t1 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t2 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t3 = tcg_temp_new_ptr();                                \
+            TCGv_ptr arg1p, arg2p, resp;                                     \
+            intptr_t arg1of, arg2of, resof;                                  \
+                                                                             \
+            glue(glue(tcg_v, width), _to_ptr)(arg1, base, 1,                 \
+                                            &arg1p, &arg1of, 1);             \
+            glue(glue(tcg_v, width), _to_ptr)(arg2, base, 2,                 \
+                                            &arg2p, &arg2of, 1);             \
+            glue(glue(tcg_v, width), _to_ptr)(res, base, 0, &resp, &resof,   \
+                                              0);                            \
+                                                                             \
+            tcg_gen_addi_ptr(t1, resp, resof);                               \
+            tcg_gen_addi_ptr(t2, arg1p, arg1of);                             \
+            tcg_gen_addi_ptr(t3, arg2p, arg2of);                             \
+            func(t1, t2, t3);                                                \
+                                                                             \
+            if ((intptr_t)res >= tcg_ctx.nb_globals) {                       \
+                glue(tcg_gen_ld_v, width)(res, base, 0);                     \
+            }                                                                \
+                                                                             \
+            tcg_temp_free_ptr(t1);                                           \
+            tcg_temp_free_ptr(t2);                                           \
+            tcg_temp_free_ptr(t3);                                           \
+        }                                                                    \
+    }
+
+#define GEN_VECT_WRAPPER(op, width, func)                                    \
+    static inline void glue(tcg_gen_, op)(glue(TCGv_v, width) res,           \
+                                            glue(TCGv_v, width) arg1,        \
+                                            glue(TCGv_v, width) arg2)        \
+    {                                                                        \
+        if (glue(TCG_TARGET_HAS_, op)) {                                     \
+            glue(tcg_gen_op3_v, width)(glue(INDEX_op_, op), res, arg1,       \
+                                       arg2);                                \
+        } else {                                                             \
+            TCGv_ptr base =                                                  \
+                        MAKE_TCGV_PTR(tcg_ctx.frame_temp - tcg_ctx.temps);   \
+            TCGv_ptr t1 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t2 = tcg_temp_new_ptr();                                \
+            TCGv_ptr t3 = tcg_temp_new_ptr();                                \
+            TCGv_ptr arg1p, arg2p, resp;                                     \
+            intptr_t arg1of, arg2of, resof;                                  \
+                                                                             \
+            glue(glue(tcg_v, width), _to_ptr)(arg1, base, 1,                 \
+                                            &arg1p, &arg1of, 1);             \
+            glue(glue(tcg_v, width), _to_ptr)(arg2, base, 2,                 \
+                                            &arg2p, &arg2of, 1);             \
+            glue(glue(tcg_v, width), _to_ptr)(res, base, 0, &resp, &resof,   \
+                                              0);                            \
+                                                                             \
+            tcg_gen_addi_ptr(t1, resp, resof);                               \
+            tcg_gen_addi_ptr(t2, arg1p, arg1of);                             \
+            tcg_gen_addi_ptr(t3, arg2p, arg2of);                             \
+            func(t1, t2, t3);                                                \
+                                                                             \
+            if ((intptr_t)res >= tcg_ctx.nb_globals) {                       \
+                glue(tcg_gen_ld_v, width)(res, base, 0);                     \
+            }                                                                \
+                                                                             \
+            tcg_temp_free_ptr(t1);                                           \
+            tcg_temp_free_ptr(t2);                                           \
+            tcg_temp_free_ptr(t3);                                           \
+        }                                                                    \
+    }
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
+GEN_VECT_WRAPPER_HALVES(add_i8x16, 128, add_i8x8, 64, tcg_internal_add_i8x16)
+GEN_VECT_WRAPPER_HALVES(add_i16x8, 128, add_i16x4, 64, tcg_internal_add_i16x8)
+GEN_VECT_WRAPPER_HALVES(add_i32x4, 128, add_i32x2, 64, tcg_internal_add_i32x4)
+GEN_VECT_WRAPPER_HALVES(add_i64x2, 128, add_i64x1, 64, tcg_internal_add_i64x2)
+
+GEN_VECT_WRAPPER(add_i8x8, 64, tcg_internal_add_i8x8)
+GEN_VECT_WRAPPER(add_i16x4, 64, tcg_internal_add_i16x4)
+GEN_VECT_WRAPPER(add_i32x2, 64, tcg_internal_add_i32x2)
+GEN_VECT_WRAPPER(add_i64x1, 64, tcg_internal_add_i64x1)
+
+#undef VTYPE
+#undef BASE_TYPE
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 2365c97..4c8f195 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -206,6 +206,18 @@ DEF(ld_v128, 1, 1, 1, IMPL128)
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a8df040..a23f739 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -712,6 +712,18 @@ TCGv_v128 tcg_temp_new_internal_v128(int temp_local)
     return MAKE_TCGV_V128(idx);
 }
 
+int tcg_temp_half_internal(int arg, TCGType type, int is_high)
+{
+    const TCGTemp *ts = &tcg_ctx.temps[arg];
+    tcg_debug_assert(ts->type != ts->base_type);
+    tcg_debug_assert(tcg_type_size(type) > tcg_type_size(ts->type));
+    tcg_debug_assert(tcg_type_size(type) <= tcg_type_size(ts->base_type));
+    if (is_high) {
+        arg += tcg_type_size(type) / tcg_type_size(ts->type) / 2;
+    }
+    return arg;
+}
+
 static void tcg_temp_free_internal(int idx)
 {
     TCGContext *s = &tcg_ctx;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 01299cc..fd43f15 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -156,6 +156,34 @@ typedef uint64_t TCGRegSet;
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
@@ -761,6 +789,7 @@ struct TCGContext {
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
     void *code_gen_ptr;
+    uint8_t v128_swap[16 * 3];
 
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
@@ -938,6 +967,20 @@ static inline TCGv_v128 tcg_temp_local_new_v128(void)
     return tcg_temp_new_internal_v128(1);
 }
 
+int tcg_temp_half_internal(int arg, TCGType type, int is_high);
+
+static inline TCGv_v64 tcg_temp_low_half_v128(TCGv_v128 arg)
+{
+    int idx = tcg_temp_half_internal(GET_TCGV_V128(arg), TCG_TYPE_V128, 0);
+    return MAKE_TCGV_V64(idx);
+}
+
+static inline TCGv_v64 tcg_temp_high_half_v128(TCGv_v128 arg)
+{
+    int idx = tcg_temp_half_internal(GET_TCGV_V128(arg), TCG_TYPE_V128, 1);
+    return MAKE_TCGV_V64(idx);
+}
+
 #if defined(CONFIG_DEBUG_TCG)
 /* If you call tcg_clear_temp_count() at the start of a section of
  * code which is not supposed to leak any TCG temporaries, then
-- 
2.1.4
