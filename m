Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevm-0007LI-G1
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevi-0004ee-Mc
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:58 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevi-0004d4-Bn
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:54 -0500
Received: by mail-pg0-x242.google.com with SMTP id q12so2711410pgt.7
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:13:54 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.13.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:13:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:25 -0800
Message-Id: <20180106031346.6650-3-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 02/23] tcg: Add types and basic operations
 for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Nothing uses or enables them yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target  |   4 +-
 tcg/tcg-op.h     |  30 +++++
 tcg/tcg-opc.h    |  26 ++++
 tcg/tcg.h        |  56 +++++++++
 tcg/tcg-op-vec.c | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c        | 100 ++++++++++++++-
 tcg/README       |  58 +++++++++
 7 files changed, 630 insertions(+), 6 deletions(-)
 create mode 100644 tcg/tcg-op-vec.c

diff --git a/Makefile.target b/Makefile.target
index f9a9da7e7c..7f30a1e725 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -93,8 +93,8 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
-obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG) += tcg/tcg-common.o
+obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o
+obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index ca07b32b65..9b0560e4d3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -35,6 +35,10 @@ void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
+void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
+void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
+void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+
 static inline void tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
     tcg_gen_op1(opc, tcgv_i32_arg(a1));
@@ -903,6 +907,30 @@ void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 
+void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
+void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
+void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
+void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
+void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
+void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
+void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
+void tcg_gen_movi_v64(TCGv_vec, uint64_t);
+void tcg_gen_movi_v128(TCGv_vec, uint64_t, uint64_t);
+void tcg_gen_movi_v256(TCGv_vec, uint64_t, uint64_t, uint64_t, uint64_t);
+void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+
+void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
+
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
@@ -1001,6 +1029,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i64
 #define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i64
 #define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i64
+#define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
 #define tcg_gen_mov_tl tcg_gen_mov_i32
@@ -1098,6 +1127,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i32
 #define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i32
 #define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i32
+#define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #endif
 
 #if UINTPTR_MAX == UINT32_MAX
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 956fb1e9f3..4e62eda14b 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -204,8 +204,34 @@ DEF(qemu_ld_i64, DATA64_ARGS, TLADDR_ARGS, 1,
 DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 
+/* Host vector support.  */
+
+#define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
+
+DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
+DEF(movi_vec, 1, 0, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT) /* vecl defines const args */
+DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
+
+DEF(dup_vec, 1, 1, 0, IMPLVEC)
+DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS == 32))
+
+DEF(ld_vec, 1, 1, 1, IMPLVEC)
+DEF(st_vec, 0, 2, 1, IMPLVEC)
+
+DEF(add_vec, 1, 2, 0, IMPLVEC)
+DEF(sub_vec, 1, 2, 0, IMPLVEC)
+DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
+
+DEF(and_vec, 1, 2, 0, IMPLVEC)
+DEF(or_vec, 1, 2, 0, IMPLVEC)
+DEF(xor_vec, 1, 2, 0, IMPLVEC)
+DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
+DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
+DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
+
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
 #undef IMPL
 #undef IMPL64
+#undef IMPLVEC
 #undef DEF
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2ce497cebf..dce483b0ee 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -170,6 +170,27 @@ typedef uint64_t TCGRegSet;
 # error "Missing unsigned widening multiply"
 #endif
 
+#if !defined(TCG_TARGET_HAS_v64) \
+    && !defined(TCG_TARGET_HAS_v128) \
+    && !defined(TCG_TARGET_HAS_v256)
+#define TCG_TARGET_MAYBE_vec            0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#else
+#define TCG_TARGET_MAYBE_vec            1
+#endif
+#ifndef TCG_TARGET_HAS_v64
+#define TCG_TARGET_HAS_v64              0
+#endif
+#ifndef TCG_TARGET_HAS_v128
+#define TCG_TARGET_HAS_v128             0
+#endif
+#ifndef TCG_TARGET_HAS_v256
+#define TCG_TARGET_HAS_v256             0
+#endif
+
 #ifndef TARGET_INSN_START_EXTRA_WORDS
 # define TARGET_INSN_START_WORDS 1
 #else
@@ -246,6 +267,11 @@ typedef struct TCGPool {
 typedef enum TCGType {
     TCG_TYPE_I32,
     TCG_TYPE_I64,
+
+    TCG_TYPE_V64,
+    TCG_TYPE_V128,
+    TCG_TYPE_V256,
+
     TCG_TYPE_COUNT, /* number of different types */
 
     /* An alias for the size of the host register.  */
@@ -396,6 +422,8 @@ typedef tcg_target_ulong TCGArg;
     * TCGv_i32 : 32 bit integer type
     * TCGv_i64 : 64 bit integer type
     * TCGv_ptr : a host pointer type
+    * TCGv_vec : a host vector type; the exact size is not exposed
+                 to the CPU front-end code.
     * TCGv : an integer type the same size as target_ulong
              (an alias for either TCGv_i32 or TCGv_i64)
    The compiler's type checking will complain if you mix them
@@ -418,6 +446,7 @@ typedef tcg_target_ulong TCGArg;
 typedef struct TCGv_i32_d *TCGv_i32;
 typedef struct TCGv_i64_d *TCGv_i64;
 typedef struct TCGv_ptr_d *TCGv_ptr;
+typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
 #if TARGET_LONG_BITS == 32
 #define TCGv TCGv_i32
@@ -589,6 +618,9 @@ typedef struct TCGOp {
 #define TCGOP_CALLI(X)    (X)->param1
 #define TCGOP_CALLO(X)    (X)->param2
 
+#define TCGOP_VECL(X)     (X)->param1
+#define TCGOP_VECE(X)     (X)->param2
+
 /* Make sure operands fit in the bitfields above.  */
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 
@@ -726,6 +758,11 @@ static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)
+{
+    return tcgv_i32_temp((TCGv_i32)v);
+}
+
 static inline TCGArg tcgv_i32_arg(TCGv_i32 v)
 {
     return temp_arg(tcgv_i32_temp(v));
@@ -741,6 +778,11 @@ static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
     return temp_arg(tcgv_ptr_temp(v));
 }
 
+static inline TCGArg tcgv_vec_arg(TCGv_vec v)
+{
+    return temp_arg(tcgv_vec_temp(v));
+}
+
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
     (void)temp_idx(t); /* trigger embedded assert */
@@ -757,6 +799,11 @@ static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
     return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
+static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
+{
+    return (TCGv_vec)temp_tcgv_i32(t);
+}
+
 #if TCG_TARGET_REG_BITS == 32
 static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)
 {
@@ -832,9 +879,12 @@ TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
 
 TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
 TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
+TCGv_vec tcg_temp_new_vec(TCGType type);
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
 
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
+void tcg_temp_free_vec(TCGv_vec arg);
 
 static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
@@ -916,6 +966,8 @@ enum {
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemened by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x10,
+    /* Instruction operands are vectors.  */
+    TCG_OPF_VECTOR       = 0x20,
 };
 
 typedef struct TCGOpDef {
@@ -981,6 +1033,10 @@ TCGv_i32 tcg_const_i32(int32_t val);
 TCGv_i64 tcg_const_i64(int64_t val);
 TCGv_i32 tcg_const_local_i32(int32_t val);
 TCGv_i64 tcg_const_local_i64(int64_t val);
+TCGv_vec tcg_const_zeros_vec(TCGType);
+TCGv_vec tcg_const_ones_vec(TCGType);
+TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec);
+TCGv_vec tcg_const_ones_vec_matching(TCGv_vec);
 
 TCGLabel *gen_new_label(void);
 
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
new file mode 100644
index 0000000000..dc04c11860
--- /dev/null
+++ b/tcg/tcg-op-vec.c
@@ -0,0 +1,362 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "tcg.h"
+#include "tcg-op.h"
+#include "tcg-mo.h"
+
+/* Reduce the number of ifdefs below.  This assumes that all uses of
+   TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
+   the compiler can eliminate.  */
+#if TCG_TARGET_REG_BITS == 64
+extern TCGv_i32 TCGV_LOW_link_error(TCGv_i64);
+extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
+#define TCGV_LOW  TCGV_LOW_link_error
+#define TCGV_HIGH TCGV_HIGH_link_error
+#endif
+
+void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
+{
+    TCGOp *op = tcg_emit_op(opc);
+    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_VECE(op) = vece;
+    op->args[0] = r;
+    op->args[1] = a;
+}
+
+void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
+               TCGArg r, TCGArg a, TCGArg b)
+{
+    TCGOp *op = tcg_emit_op(opc);
+    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_VECE(op) = vece;
+    op->args[0] = r;
+    op->args[1] = a;
+    op->args[2] = b;
+}
+
+void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
+               TCGArg r, TCGArg a, TCGArg b, TCGArg c)
+{
+    TCGOp *op = tcg_emit_op(opc);
+    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_VECE(op) = vece;
+    op->args[0] = r;
+    op->args[1] = a;
+    op->args[2] = b;
+    op->args[3] = c;
+}
+
+static void vec_gen_op2(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGType type = rt->base_type;
+
+    tcg_debug_assert(at->base_type == type);
+    vec_gen_2(opc, type, vece, temp_arg(rt), temp_arg(at));
+}
+
+static void vec_gen_op3(TCGOpcode opc, unsigned vece,
+                        TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGType type = rt->base_type;
+
+    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(bt->base_type == type);
+    vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
+}
+
+void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
+{
+    if (r != a) {
+        vec_gen_op2(INDEX_op_mov_vec, 0, r, a);
+    }
+}
+
+#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
+
+static void tcg_gen_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
+}
+
+TCGv_vec tcg_const_zeros_vec(TCGType type)
+{
+    TCGv_vec ret = tcg_temp_new_vec(type);
+    tcg_gen_dupi_vec(ret, MO_REG, 0);
+    return ret;
+}
+
+TCGv_vec tcg_const_ones_vec(TCGType type)
+{
+    TCGv_vec ret = tcg_temp_new_vec(type);
+    tcg_gen_dupi_vec(ret, MO_REG, -1);
+    return ret;
+}
+
+TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec m)
+{
+    TCGTemp *t = tcgv_vec_temp(m);
+    return tcg_const_zeros_vec(t->base_type);
+}
+
+TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
+{
+    TCGTemp *t = tcgv_vec_temp(m);
+    return tcg_const_ones_vec(t->base_type);
+}
+
+void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
+{
+    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
+        tcg_gen_dupi_vec(r, MO_32, a);
+    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
+        tcg_gen_dupi_vec(r, MO_64, a);
+    } else {
+        TCGv_i64 c = tcg_const_i64(a);
+        tcg_gen_dup_i64_vec(MO_64, r, c);
+        tcg_temp_free_i64(c);
+    }
+}
+
+void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
+{
+    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffffffffu) * a);
+}
+
+void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
+{
+    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffff) * (a & 0xffff));
+}
+
+void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
+{
+    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xff) * (a & 0xff));
+}
+
+void tcg_gen_movi_v64(TCGv_vec r, uint64_t a)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGArg ri = temp_arg(rt);
+
+    tcg_debug_assert(rt->base_type == TCG_TYPE_V64);
+    if (TCG_TARGET_REG_BITS == 64) {
+        vec_gen_2(INDEX_op_movi_vec, TCG_TYPE_V64, 0, ri, a);
+    } else {
+        vec_gen_3(INDEX_op_movi_vec, TCG_TYPE_V64, 0, ri, a, a >> 32);
+    }
+}
+
+void tcg_gen_movi_v128(TCGv_vec r, uint64_t a, uint64_t b)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGArg ri = temp_arg(rt);
+
+    tcg_debug_assert(rt->base_type == TCG_TYPE_V128);
+    if (a == b) {
+        tcg_gen_dup64i_vec(r, a);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        vec_gen_3(INDEX_op_movi_vec, TCG_TYPE_V128, 0, ri, a, b);
+    } else {
+        TCGOp *op = tcg_emit_op(INDEX_op_movi_vec);
+        TCGOP_VECL(op) = TCG_TYPE_V128 - TCG_TYPE_V64;
+        op->args[0] = ri;
+        op->args[1] = a;
+        op->args[2] = a >> 32;
+        op->args[3] = b;
+        op->args[4] = b >> 32;
+    }
+}
+
+void tcg_gen_movi_v256(TCGv_vec r, uint64_t a, uint64_t b,
+                       uint64_t c, uint64_t d)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGTemp *rt = arg_temp(ri);
+
+    tcg_debug_assert(rt->base_type == TCG_TYPE_V256);
+    if (a == b && a == c && a == d) {
+        tcg_gen_dup64i_vec(r, a);
+    } else {
+        TCGOp *op = tcg_emit_op(INDEX_op_movi_vec);
+        TCGOP_VECL(op) = TCG_TYPE_V256 - TCG_TYPE_V64;
+        op->args[0] = ri;
+        if (TCG_TARGET_REG_BITS == 64) {
+            op->args[1] = a;
+            op->args[2] = b;
+            op->args[3] = c;
+            op->args[4] = d;
+        } else {
+            op->args[1] = a;
+            op->args[2] = a >> 32;
+            op->args[3] = b;
+            op->args[4] = b >> 32;
+            op->args[5] = c;
+            op->args[6] = c >> 32;
+            op->args[7] = d;
+            op->args[8] = d >> 32;
+        }
+    }
+}
+
+void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGTemp *rt = arg_temp(ri);
+    TCGType type = rt->base_type;
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        TCGArg ai = tcgv_i64_arg(a);
+        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
+    } else if (vece == MO_64) {
+        TCGArg al = tcgv_i32_arg(TCGV_LOW(a));
+        TCGArg ah = tcgv_i32_arg(TCGV_HIGH(a));
+        vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
+    } else {
+        TCGArg ai = tcgv_i32_arg(TCGV_LOW(a));
+        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
+    }
+}
+
+void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec r, TCGv_i32 a)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGArg ai = tcgv_i32_arg(a);
+    TCGTemp *rt = arg_temp(ri);
+    TCGType type = rt->base_type;
+
+    vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
+}
+
+static void vec_gen_ldst(TCGOpcode opc, TCGv_vec r, TCGv_ptr b, TCGArg o)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGArg bi = tcgv_ptr_arg(b);
+    TCGTemp *rt = arg_temp(ri);
+    TCGType type = rt->base_type;
+
+    vec_gen_3(opc, type, 0, ri, bi, o);
+}
+
+void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr b, TCGArg o)
+{
+    vec_gen_ldst(INDEX_op_ld_vec, r, b, o);
+}
+
+void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr b, TCGArg o)
+{
+    vec_gen_ldst(INDEX_op_st_vec, r, b, o);
+}
+
+void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType low_type)
+{
+    TCGArg ri = tcgv_vec_arg(r);
+    TCGArg bi = tcgv_ptr_arg(b);
+    TCGTemp *rt = arg_temp(ri);
+    TCGType type = rt->base_type;
+
+    tcg_debug_assert(low_type >= TCG_TYPE_V64);
+    tcg_debug_assert(low_type <= type);
+    vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
+}
+
+void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    vec_gen_op3(INDEX_op_add_vec, vece, r, a, b);
+}
+
+void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    vec_gen_op3(INDEX_op_sub_vec, vece, r, a, b);
+}
+
+void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    vec_gen_op3(INDEX_op_and_vec, 0, r, a, b);
+}
+
+void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    vec_gen_op3(INDEX_op_or_vec, 0, r, a, b);
+}
+
+void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    vec_gen_op3(INDEX_op_xor_vec, 0, r, a, b);
+}
+
+void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    if (TCG_TARGET_HAS_andc_vec) {
+        vec_gen_op3(INDEX_op_andc_vec, 0, r, a, b);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec_matching(r);
+        tcg_gen_not_vec(0, t, b);
+        tcg_gen_and_vec(0, r, a, t);
+        tcg_temp_free_vec(t);
+    }
+}
+
+void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    if (TCG_TARGET_HAS_orc_vec) {
+        vec_gen_op3(INDEX_op_orc_vec, 0, r, a, b);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec_matching(r);
+        tcg_gen_not_vec(0, t, b);
+        tcg_gen_or_vec(0, r, a, t);
+        tcg_temp_free_vec(t);
+    }
+}
+
+void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    if (TCG_TARGET_HAS_not_vec) {
+        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
+    } else {
+        TCGv_vec t = tcg_const_ones_vec_matching(r);
+        tcg_gen_xor_vec(0, r, a, t);
+        tcg_temp_free_vec(t);
+    }
+}
+
+void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    if (TCG_TARGET_HAS_neg_vec) {
+        vec_gen_op2(INDEX_op_neg_vec, vece, r, a);
+    } else {
+        TCGv_vec t = tcg_const_zeros_vec_matching(r);
+        tcg_gen_sub_vec(vece, r, t, a);
+        tcg_temp_free_vec(t);
+    }
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 93caa0be93..16b8faf66f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -106,6 +106,18 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
                        const int *const_args);
+#if TCG_TARGET_MAYBE_vec
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
+                           unsigned vece, const TCGArg *args,
+                           const int *const_args);
+#else
+static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
+                                  unsigned vece, const TCGArg *args,
+                                  const int *const_args)
+{
+    g_assert_not_reached();
+}
+#endif
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -146,8 +158,7 @@ struct tcg_region_state {
 };
 
 static struct tcg_region_state region;
-
-static TCGRegSet tcg_target_available_regs[2];
+static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
 static TCGRegSet tcg_target_call_clobber_regs;
 
 #if TCG_TARGET_INSN_UNIT_SIZE == 1
@@ -1026,6 +1037,41 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
     return temp_tcgv_i64(t);
 }
 
+TCGv_vec tcg_temp_new_vec(TCGType type)
+{
+    TCGTemp *t;
+
+#ifdef CONFIG_DEBUG_TCG
+    switch (type) {
+    case TCG_TYPE_V64:
+        assert(TCG_TARGET_HAS_v64);
+        break;
+    case TCG_TYPE_V128:
+        assert(TCG_TARGET_HAS_v128);
+        break;
+    case TCG_TYPE_V256:
+        assert(TCG_TARGET_HAS_v256);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+
+    t = tcg_temp_new_internal(type, 0);
+    return temp_tcgv_vec(t);
+}
+
+/* Create a new temp of the same type as an existing temp.  */
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match)
+{
+    TCGTemp *t = tcgv_vec_temp(match);
+
+    tcg_debug_assert(t->temp_allocated != 0);
+
+    t = tcg_temp_new_internal(t->base_type, 0);
+    return temp_tcgv_vec(t);
+}
+
 static void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
@@ -1057,6 +1103,11 @@ void tcg_temp_free_i64(TCGv_i64 arg)
     tcg_temp_free_internal(tcgv_i64_temp(arg));
 }
 
+void tcg_temp_free_vec(TCGv_vec arg)
+{
+    tcg_temp_free_internal(tcgv_vec_temp(arg));
+}
+
 TCGv_i32 tcg_const_i32(int32_t val)
 {
     TCGv_i32 t0;
@@ -1114,6 +1165,9 @@ int tcg_check_temp_count(void)
    Test the runtime variable that controls each opcode.  */
 bool tcg_op_supported(TCGOpcode op)
 {
+    const bool have_vec
+        = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
+
     switch (op) {
     case INDEX_op_discard:
     case INDEX_op_set_label:
@@ -1327,6 +1381,29 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_mulsh_i64:
         return TCG_TARGET_HAS_mulsh_i64;
 
+    case INDEX_op_mov_vec:
+    case INDEX_op_movi_vec:
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupi_vec:
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return have_vec;
+    case INDEX_op_dup2_vec:
+        return have_vec && TCG_TARGET_REG_BITS == 32;
+    case INDEX_op_not_vec:
+        return have_vec && TCG_TARGET_HAS_not_vec;
+    case INDEX_op_neg_vec:
+        return have_vec && TCG_TARGET_HAS_neg_vec;
+    case INDEX_op_andc_vec:
+        return have_vec && TCG_TARGET_HAS_andc_vec;
+    case INDEX_op_orc_vec:
+        return have_vec && TCG_TARGET_HAS_orc_vec;
+
     case NB_OPS:
         break;
     }
@@ -1661,6 +1738,14 @@ void tcg_dump_ops(TCGContext *s)
             nb_iargs = def->nb_iargs;
             nb_cargs = def->nb_cargs;
 
+            if (c == INDEX_op_movi_vec) {
+                nb_cargs = (64 / TCG_TARGET_REG_BITS) << TCGOP_VECL(op);
+            }
+            if (def->flags & TCG_OPF_VECTOR) {
+                col += qemu_log("v%d,e%d,", 64 << TCGOP_VECL(op),
+                                8 << TCGOP_VECE(op));
+            }
+
             k = 0;
             for (i = 0; i < nb_oargs; i++) {
                 if (k != 0) {
@@ -2890,8 +2975,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 
     /* emit instruction */
-    tcg_out_op(s, op->opc, new_args, const_args);
-    
+    if (def->flags & TCG_OPF_VECTOR) {
+        tcg_out_vec_op(s, op->opc, TCGOP_VECL(op), TCGOP_VECE(op),
+                       new_args, const_args);
+    } else {
+        tcg_out_op(s, op->opc, new_args, const_args);
+    }
+
     /* move the outputs in the correct register if needed */
     for(i = 0; i < nb_oargs; i++) {
         ts = arg_temp(op->args[i]);
@@ -3239,10 +3329,12 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
+        case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
         case INDEX_op_movi_i32:
         case INDEX_op_movi_i64:
+        case INDEX_op_dupi_vec:
             tcg_reg_alloc_movi(s, op);
             break;
         case INDEX_op_insn_start:
diff --git a/tcg/README b/tcg/README
index 03bfb6acd4..e14990fb9b 100644
--- a/tcg/README
+++ b/tcg/README
@@ -503,6 +503,64 @@ of the memory access.
 For a 32-bit host, qemu_ld/st_i64 is guaranteed to only be used with a
 64-bit memory access specified in flags.
 
+********* Host vector operations
+
+All of the vector ops have two parameters, TCGOP_VECL & TCGOP_VECE.
+The former specifies the length of the vector in log2 64-bit units; the
+later specifies the length of the element (if applicable) in log2 8-bit units.
+E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
+
+* mov_vec   v0, v1
+* ld_vec    v0, t1
+* st_vec    v0, t1
+
+  Move, load and store.
+
+* movi_vec  v0, a, b, ...
+
+  Move with constant data.  There are arguments to hold the entire
+  vector value, stored little-endian.  Note that the way MAX_OPC_PARAM
+  is sized for 64- and 32-bit hosts, there are enough slots for v256,
+  but not a future v512.
+
+  Prefer dupi_vec when possible.
+
+* dup_vec  v0, r1
+
+  Duplicate the low N bits of R1 into VECL/VECE copies across V0.
+
+* dupi_vec v0, c
+
+  Similarly, for a constant.
+  Smaller values will be replicated to host register size by the expanders.
+
+* dup2_vec v0, r1, r2
+
+  Duplicate r2:r1 into VECL/64 copies across V0.  This opcode is
+  only present for 32-bit hosts.
+
+* add_vec   v0, v1, v2
+
+  v0 = v1 + v2, in elements across the vector.
+
+* sub_vec   v0, v1, v2
+
+  Similarly, v0 = v1 - v2.
+
+* neg_vec   v0, v1
+
+  Similarly, v0 = -v1.
+
+* and_vec   v0, v1, v2
+* or_vec    v0, v1, v2
+* xor_vec   v0, v1, v2
+* andc_vec  v0, v1, v2
+* orc_vec   v0, v1, v2
+* not_vec   v0, v1
+
+  Similarly, logical operations with and without compliment.
+  Note that VECE is unused.
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.14.3
