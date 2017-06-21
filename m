Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhS-0006dk-HJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhQ-0002Sa-Po
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:58 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhQ-0002SV-Kh
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:56 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so25676503qtg.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:30 -0700
Message-Id: <20170621024831.26019-16-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 15/16] tcg: Define separate structures for
 TCGv_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Pointers that devolve to TCGTemp will tidy things up.
At present, we continue to store indicies in TCGArg.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c |  67 +++++-------------
 tcg/tcg.h | 237 +++++++++++++++++++++++++++++++++-----------------------------
 2 files changed, 146 insertions(+), 158 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 26931a7..1ca1192 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -492,8 +492,8 @@ static inline TCGTemp *tcg_global_alloc(TCGContext *s)
     return ts;
 }
 
-static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
-                                       TCGReg reg, const char *name)
+static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
+                                            TCGReg reg, const char *name)
 {
     TCGTemp *ts;
 
@@ -509,47 +509,45 @@ static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
     ts->name = name;
     tcg_regset_set_reg(s->reserved_regs, reg);
 
-    return temp_idx(ts);
+    return ts;
 }
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
 {
-    int idx;
     s->frame_start = start;
     s->frame_end = start + size;
-    idx = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
-    s->frame_temp = &s->temps[idx];
+    s->frame_temp = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
 }
 
 TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name)
 {
     TCGContext *s = &tcg_ctx;
-    int idx;
+    TCGTemp *t;
 
     if (tcg_regset_test_reg(s->reserved_regs, reg)) {
         tcg_abort();
     }
-    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
-    return MAKE_TCGV_I32(idx);
+    t = tcg_global_reg_new_internal(s, TCG_TYPE_I32, reg, name);
+    return (TCGv_i32)t;
 }
 
 TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
 {
     TCGContext *s = &tcg_ctx;
-    int idx;
+    TCGTemp *t;
 
     if (tcg_regset_test_reg(s->reserved_regs, reg)) {
         tcg_abort();
     }
-    idx = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
-    return MAKE_TCGV_I64(idx);
+    t = tcg_global_reg_new_internal(s, TCG_TYPE_I64, reg, name);
+    return (TCGv_i64)t;
 }
 
-int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
-                                intptr_t offset, const char *name)
+TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
+                                     intptr_t offset, const char *name)
 {
     TCGContext *s = &tcg_ctx;
-    TCGTemp *base_ts = &s->temps[GET_TCGV_PTR(base)];
+    TCGTemp *base_ts = &base->impl;
     TCGTemp *ts = tcg_global_alloc(s);
     int indirect_reg = 0, bigendian = 0;
 #ifdef HOST_WORDS_BIGENDIAN
@@ -598,10 +596,10 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
         ts->mem_offset = offset;
         ts->name = name;
     }
-    return temp_idx(ts);
+    return ts;
 }
 
-static int tcg_temp_new_internal(TCGType type, int temp_local)
+TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
 {
     TCGContext *s = &tcg_ctx;
     TCGTemp *ts;
@@ -638,36 +636,18 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
             ts->temp_allocated = 1;
             ts->temp_local = temp_local;
         }
-        idx = temp_idx(ts);
     }
 
 #if defined(CONFIG_DEBUG_TCG)
     s->temps_in_use++;
 #endif
-    return idx;
-}
-
-TCGv_i32 tcg_temp_new_internal_i32(int temp_local)
-{
-    int idx;
-
-    idx = tcg_temp_new_internal(TCG_TYPE_I32, temp_local);
-    return MAKE_TCGV_I32(idx);
-}
-
-TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
-{
-    int idx;
-
-    idx = tcg_temp_new_internal(TCG_TYPE_I64, temp_local);
-    return MAKE_TCGV_I64(idx);
+    return ts;
 }
 
-static void tcg_temp_free_internal(int idx)
+void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = &tcg_ctx;
-    TCGTemp *ts;
-    int k;
+    int k, idx = temp_idx(ts);
 
 #if defined(CONFIG_DEBUG_TCG)
     s->temps_in_use--;
@@ -677,7 +657,6 @@ static void tcg_temp_free_internal(int idx)
 #endif
 
     tcg_debug_assert(idx >= s->nb_globals && idx < s->nb_temps);
-    ts = &s->temps[idx];
     tcg_debug_assert(ts->temp_allocated != 0);
     ts->temp_allocated = 0;
 
@@ -685,16 +664,6 @@ static void tcg_temp_free_internal(int idx)
     set_bit(idx, s->free_temps[k].l);
 }
 
-void tcg_temp_free_i32(TCGv_i32 arg)
-{
-    tcg_temp_free_internal(GET_TCGV_I32(arg));
-}
-
-void tcg_temp_free_i64(TCGv_i64 arg)
-{
-    tcg_temp_free_internal(GET_TCGV_I64(arg));
-}
-
 TCGv_i32 tcg_const_i32(int32_t val)
 {
     TCGv_i32 t0;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 018c01c..a5a0412 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -395,6 +395,44 @@ static inline unsigned get_alignment_bits(TCGMemOp memop)
 
 typedef tcg_target_ulong TCGArg;
 
+typedef enum TCGTempVal {
+    TEMP_VAL_DEAD,
+    TEMP_VAL_REG,
+    TEMP_VAL_MEM,
+    TEMP_VAL_CONST,
+} TCGTempVal;
+
+typedef struct TCGTemp {
+    TCGReg reg:8;
+    TCGTempVal val_type:8;
+    TCGType base_type:8;
+    TCGType type:8;
+    unsigned int fixed_reg:1;
+    unsigned int indirect_reg:1;
+    unsigned int indirect_base:1;
+    unsigned int mem_coherent:1;
+    unsigned int mem_allocated:1;
+    /* If true, the temp is saved across both basic blocks and
+       translation blocks.  */
+    unsigned int temp_global:1;
+    /* If true, the temp is saved across basic blocks but dead
+       at the end of translation blocks.  If false, the temp is
+       dead at the end of basic blocks.  */
+    unsigned int temp_local:1;
+    unsigned int temp_allocated:1;
+
+    tcg_target_long val;
+    struct TCGTemp *mem_base;
+    intptr_t mem_offset;
+    const char *name;
+
+    /* Pass-specific information that can be stored for a temporary.
+       One word worth of integer data, and one pointer to data
+       allocated separately.  */
+    uintptr_t state;
+    void *state_ptr;
+} TCGTemp;
+
 /* Define type and accessor macros for TCG variables.
 
    TCG variables are the inputs and outputs of TCG ops, as described
@@ -411,25 +449,34 @@ typedef tcg_target_ulong TCGArg;
 
    Users of tcg_gen_* don't need to know about any of the internal
    details of these, and should treat them as opaque types.
-   You won't be able to look inside them in a debugger either.
 
    Internal implementation details follow:
 
-   Note that there is no definition of the structs TCGv_i32_d etc anywhere.
-   This is deliberate, because the values we store in variables of type
-   TCGv_i32 are not really pointers-to-structures. They're just small
-   integers, but keeping them in pointer types like this means that the
-   compiler will complain if you accidentally pass a TCGv_i32 to a
-   function which takes a TCGv_i64, and so on. Only the internals of
-   TCG need to care about the actual contents of the types, and they always
-   box and unbox via the MAKE_TCGV_* and GET_TCGV_* functions.
-   Converting to and from intptr_t rather than int reduces the number
-   of sign-extension instructions that get implied on 64-bit hosts.  */
-
-typedef struct TCGv_i32_d *TCGv_i32;
-typedef struct TCGv_i64_d *TCGv_i64;
-typedef struct TCGv_ptr_d *TCGv_ptr;
+   There is an array of TCGTemp structures which describe each variable.
+   For type checking purposes, we want to distinguish one TCGTemp pointer
+   from another.  We do this by creating different structure types
+   (TCGv_i32_d, TCGv_i64_d, TCGv_ptr_d) that wrap TCGTemp or a pair of them.
+   We unwrap these within tcg-op.c when generating opcodes.  After that
+   point we only have unpaired TCGTemp structures.  */
+
+typedef struct TCGv_i32_d {
+    TCGTemp impl;
+} *TCGv_i32;
+
+typedef struct TCGv_i64_d {
+#if TCG_TARGET_REG_BITS == 32
+    struct TCGv_i32_d lo, hi;
+#else
+    TCGTemp impl;
+#endif
+} *TCGv_i64;
+
+typedef struct TCGv_ptr_d {
+    TCGTemp impl;
+} *TCGv_ptr;
+
 typedef TCGv_ptr TCGv_env;
+
 #if TARGET_LONG_BITS == 32
 #define TCGv TCGv_i32
 #elif TARGET_LONG_BITS == 64
@@ -438,53 +485,23 @@ typedef TCGv_ptr TCGv_env;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
-static inline TCGv_i32 QEMU_ARTIFICIAL MAKE_TCGV_I32(intptr_t i)
-{
-    return (TCGv_i32)i;
-}
-
-static inline TCGv_i64 QEMU_ARTIFICIAL MAKE_TCGV_I64(intptr_t i)
-{
-    return (TCGv_i64)i;
-}
-
-static inline TCGv_ptr QEMU_ARTIFICIAL MAKE_TCGV_PTR(intptr_t i)
-{
-    return (TCGv_ptr)i;
-}
-
-static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_I32(TCGv_i32 t)
-{
-    return (intptr_t)t;
-}
-
-static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_I64(TCGv_i64 t)
-{
-    return (intptr_t)t;
-}
-
-static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
-{
-    return (intptr_t)t;
-}
-
 #if TCG_TARGET_REG_BITS == 32
-#define TCGV_LOW(t) MAKE_TCGV_I32(GET_TCGV_I64(t))
-#define TCGV_HIGH(t) MAKE_TCGV_I32(GET_TCGV_I64(t) + 1)
+#define TCGV_LOW(t)  (&(t)->lo)
+#define TCGV_HIGH(t) (&(t)->hi)
 #endif
 
-#define TCGV_EQUAL_I32(a, b) (GET_TCGV_I32(a) == GET_TCGV_I32(b))
-#define TCGV_EQUAL_I64(a, b) (GET_TCGV_I64(a) == GET_TCGV_I64(b))
-#define TCGV_EQUAL_PTR(a, b) (GET_TCGV_PTR(a) == GET_TCGV_PTR(b))
+#define TCGV_EQUAL_I32(a, b)  ((a) == (b))
+#define TCGV_EQUAL_I64(a, b)  ((a) == (b))
+#define TCGV_EQUAL_PTR(a, b)  ((a) == (b))
 
 /* Dummy definition to avoid compiler warnings.  */
-#define TCGV_UNUSED_I32(x) x = MAKE_TCGV_I32(-1)
-#define TCGV_UNUSED_I64(x) x = MAKE_TCGV_I64(-1)
-#define TCGV_UNUSED_PTR(x) x = MAKE_TCGV_PTR(-1)
+#define TCGV_UNUSED_I32(x)    ((x) = NULL)
+#define TCGV_UNUSED_I64(x)    ((x) = NULL)
+#define TCGV_UNUSED_PTR(x)    ((x) = NULL)
 
-#define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == -1)
-#define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == -1)
-#define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == -1)
+#define TCGV_IS_UNUSED_I32(x) ((x) == NULL)
+#define TCGV_IS_UNUSED_I64(x) ((x) == NULL)
+#define TCGV_IS_UNUSED_PTR(x) ((x) == NULL)
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
@@ -568,44 +585,6 @@ static inline TCGCond tcg_high_cond(TCGCond c)
     }
 }
 
-typedef enum TCGTempVal {
-    TEMP_VAL_DEAD,
-    TEMP_VAL_REG,
-    TEMP_VAL_MEM,
-    TEMP_VAL_CONST,
-} TCGTempVal;
-
-typedef struct TCGTemp {
-    TCGReg reg:8;
-    TCGTempVal val_type:8;
-    TCGType base_type:8;
-    TCGType type:8;
-    unsigned int fixed_reg:1;
-    unsigned int indirect_reg:1;
-    unsigned int indirect_base:1;
-    unsigned int mem_coherent:1;
-    unsigned int mem_allocated:1;
-    /* If true, the temp is saved across both basic blocks and
-       translation blocks.  */
-    unsigned int temp_global:1;
-    /* If true, the temp is saved across basic blocks but dead
-       at the end of translation blocks.  If false, the temp is
-       dead at the end of basic blocks.  */
-    unsigned int temp_local:1;
-    unsigned int temp_allocated:1;
-
-    tcg_target_long val;
-    struct TCGTemp *mem_base;
-    intptr_t mem_offset;
-    const char *name;
-
-    /* Pass-specific information that can be stored for a temporary.
-       One word worth of integer data, and one pointer to data
-       allocated separately.  */
-    uintptr_t state;
-    void *state_ptr;
-} TCGTemp;
-
 typedef struct TCGContext TCGContext;
 
 typedef struct TCGTempSet {
@@ -755,6 +734,36 @@ static inline size_t arg_index(TCGArg a)
     return a;
 }
 
+static inline TCGv_i32 QEMU_ARTIFICIAL MAKE_TCGV_I32(TCGArg i)
+{
+    return (TCGv_i32)arg_temp(i);
+}
+
+static inline TCGv_i64 QEMU_ARTIFICIAL MAKE_TCGV_I64(TCGArg i)
+{
+    return (TCGv_i64)arg_temp(i);
+}
+
+static inline TCGv_ptr QEMU_ARTIFICIAL MAKE_TCGV_PTR(TCGArg i)
+{
+    return (TCGv_ptr)arg_temp(i);
+}
+
+static inline TCGArg QEMU_ARTIFICIAL GET_TCGV_I32(TCGv_i32 t)
+{
+    return temp_arg((TCGTemp *)t);
+}
+
+static inline TCGArg QEMU_ARTIFICIAL GET_TCGV_I64(TCGv_i64 t)
+{
+    return temp_arg((TCGTemp *)t);
+}
+
+static inline TCGArg QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
+{
+    return temp_arg((TCGTemp *)t);
+}
+
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
     tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
@@ -807,49 +816,59 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
-int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
+TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
+TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local);
+void tcg_temp_free_internal(TCGTemp *ts);
 
 TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
 TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
 
-TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
-TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
-
-void tcg_temp_free_i32(TCGv_i32 arg);
-void tcg_temp_free_i64(TCGv_i64 arg);
-
 static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
 {
-    int idx = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
-    return MAKE_TCGV_I32(idx);
+    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
+    return (TCGv_i32)t;
 }
 
 static inline TCGv_i32 tcg_temp_new_i32(void)
 {
-    return tcg_temp_new_internal_i32(0);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, false);
+    return (TCGv_i32)t;
 }
 
 static inline TCGv_i32 tcg_temp_local_new_i32(void)
 {
-    return tcg_temp_new_internal_i32(1);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, true);
+    return (TCGv_i32)t;
 }
 
 static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
 {
-    int idx = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
-    return MAKE_TCGV_I64(idx);
+    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
+    return (TCGv_i64)t;
 }
 
 static inline TCGv_i64 tcg_temp_new_i64(void)
 {
-    return tcg_temp_new_internal_i64(0);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, false);
+    return (TCGv_i64)t;
 }
 
 static inline TCGv_i64 tcg_temp_local_new_i64(void)
 {
-    return tcg_temp_new_internal_i64(1);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, true);
+    return (TCGv_i64)t;
+}
+
+static inline void tcg_temp_free_i32(TCGv_i32 arg)
+{
+    tcg_temp_free_internal((TCGTemp *)arg);
+}
+
+static inline void tcg_temp_free_i64(TCGv_i64 arg)
+{
+    tcg_temp_free_internal((TCGTemp *)arg);
 }
 
 #if defined(CONFIG_DEBUG_TCG)
-- 
2.9.4
