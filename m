Received: from eggs.gnu.org ([2001:4830:134:3::10]:51743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs2-0005WT-5z
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs0-0004CN-Ji
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:50 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvs0-0004C5-Au
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:48 -0400
Received: by mail-pf0-x242.google.com with SMTP id j11so12399224pff.10
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:48:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:48:41 -0700
Message-Id: <20180502174842.16253-3-richard.henderson@linaro.org>
In-Reply-To: <20180502174842.16253-1-richard.henderson@linaro.org>
References: <20180502174842.16253-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 4/5] tcg: Improve TCGv_ptr support
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

Drop TCGV_PTR_TO_NAT and TCGV_NAT_TO_PTR internal macros.

Add tcg_temp_local_new_ptr, tcg_gen_brcondi_ptr, tcg_gen_ext_i32_ptr,
tcg_gen_trunc_i64_ptr, tcg_gen_extu_ptr_i64, tcg_gen_trunc_ptr_i32.

Use inlines instead of macros where possible.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h            | 91 +++++++++++++++++++++++++++++++++++++------------
 tcg/tcg.h               | 86 ++++++++++++++++++++++++++++++----------------
 target/hppa/translate.c | 16 ++-------
 tcg/tcg.c               | 31 ++---------------
 4 files changed, 130 insertions(+), 94 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 75bb55aeac..5d2c91a1b6 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1137,25 +1137,74 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #endif
 
 #if UINTPTR_MAX == UINT32_MAX
-# define tcg_gen_ld_ptr(R, A, O) \
-    tcg_gen_ld_i32(TCGV_PTR_TO_NAT(R), (A), (O))
-# define tcg_gen_discard_ptr(A) \
-    tcg_gen_discard_i32(TCGV_PTR_TO_NAT(A))
-# define tcg_gen_add_ptr(R, A, B) \
-    tcg_gen_add_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
-# define tcg_gen_addi_ptr(R, A, B) \
-    tcg_gen_addi_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
-# define tcg_gen_ext_i32_ptr(R, A) \
-    tcg_gen_mov_i32(TCGV_PTR_TO_NAT(R), (A))
+# define PTR  i32
+# define NAT  TCGv_i32
 #else
-# define tcg_gen_ld_ptr(R, A, O) \
-    tcg_gen_ld_i64(TCGV_PTR_TO_NAT(R), (A), (O))
-# define tcg_gen_discard_ptr(A) \
-    tcg_gen_discard_i64(TCGV_PTR_TO_NAT(A))
-# define tcg_gen_add_ptr(R, A, B) \
-    tcg_gen_add_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), TCGV_PTR_TO_NAT(B))
-# define tcg_gen_addi_ptr(R, A, B) \
-    tcg_gen_addi_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
-# define tcg_gen_ext_i32_ptr(R, A) \
-    tcg_gen_ext_i32_i64(TCGV_PTR_TO_NAT(R), (A))
-#endif /* UINTPTR_MAX == UINT32_MAX */
+# define PTR  i64
+# define NAT  TCGv_i64
+#endif
+
+static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
+}
+
+static inline void tcg_gen_discard_ptr(TCGv_ptr a)
+{
+    glue(tcg_gen_discard_,PTR)((NAT)a);
+}
+
+static inline void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
+{
+    glue(tcg_gen_add_,PTR)((NAT)r, (NAT)a, (NAT)b);
+}
+
+static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
+{
+    glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
+}
+
+static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                       intptr_t b, TCGLabel *label)
+{
+    glue(tcg_gen_brcondi_,PTR)(cond, (NAT)a, b, label);
+}
+
+static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
+{
+#if UINTPTR_MAX == UINT32_MAX
+    tcg_gen_mov_i32((NAT)r, a);
+#else
+    tcg_gen_ext_i32_i64((NAT)r, a);
+#endif
+}
+
+static inline void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
+{
+#if UINTPTR_MAX == UINT32_MAX
+    tcg_gen_extrl_i64_i32((NAT)r, a);
+#else
+    tcg_gen_mov_i64((NAT)r, a);
+#endif
+}
+
+static inline void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a)
+{
+#if UINTPTR_MAX == UINT32_MAX
+    tcg_gen_extu_i32_i64(r, (NAT)a);
+#else
+    tcg_gen_mov_i64(r, (NAT)a);
+#endif
+}
+
+static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
+{
+#if UINTPTR_MAX == UINT32_MAX
+    tcg_gen_mov_i32(r, (NAT)a);
+#else
+    tcg_gen_extrl_i64_i32(r, (NAT)a);
+#endif
+}
+
+#undef PTR
+#undef NAT
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 30896ca304..eb0d4f6ca7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -890,15 +890,30 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
 TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
                                      intptr_t, const char *);
-
-TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
-TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
+TCGTemp *tcg_temp_new_internal(TCGType, bool);
+void tcg_temp_free_internal(TCGTemp *);
 TCGv_vec tcg_temp_new_vec(TCGType type);
 TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
 
-void tcg_temp_free_i32(TCGv_i32 arg);
-void tcg_temp_free_i64(TCGv_i64 arg);
-void tcg_temp_free_vec(TCGv_vec arg);
+static inline void tcg_temp_free_i32(TCGv_i32 arg)
+{
+    tcg_temp_free_internal(tcgv_i32_temp(arg));
+}
+
+static inline void tcg_temp_free_i64(TCGv_i64 arg)
+{
+    tcg_temp_free_internal(tcgv_i64_temp(arg));
+}
+
+static inline void tcg_temp_free_ptr(TCGv_ptr arg)
+{
+    tcg_temp_free_internal(tcgv_ptr_temp(arg));
+}
+
+static inline void tcg_temp_free_vec(TCGv_vec arg)
+{
+    tcg_temp_free_internal(tcgv_vec_temp(arg));
+}
 
 static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
@@ -909,12 +924,14 @@ static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
 
 static inline TCGv_i32 tcg_temp_new_i32(void)
 {
-    return tcg_temp_new_internal_i32(0);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, false);
+    return temp_tcgv_i32(t);
 }
 
 static inline TCGv_i32 tcg_temp_local_new_i32(void)
 {
-    return tcg_temp_new_internal_i32(1);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, true);
+    return temp_tcgv_i32(t);
 }
 
 static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
@@ -926,12 +943,33 @@ static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
 
 static inline TCGv_i64 tcg_temp_new_i64(void)
 {
-    return tcg_temp_new_internal_i64(0);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, false);
+    return temp_tcgv_i64(t);
 }
 
 static inline TCGv_i64 tcg_temp_local_new_i64(void)
 {
-    return tcg_temp_new_internal_i64(1);
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, true);
+    return temp_tcgv_i64(t);
+}
+
+static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t offset,
+                                              const char *name)
+{
+    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, name);
+    return temp_tcgv_ptr(t);
+}
+
+static inline TCGv_ptr tcg_temp_new_ptr(void)
+{
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, false);
+    return temp_tcgv_ptr(t);
+}
+
+static inline TCGv_ptr tcg_temp_local_new_ptr(void)
+{
+    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, true);
+    return temp_tcgv_ptr(t);
 }
 
 #if defined(CONFIG_DEBUG_TCG)
@@ -1009,26 +1047,6 @@ do {\
     abort();\
 } while (0)
 
-#if UINTPTR_MAX == UINT32_MAX
-static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i32 n) { return (TCGv_ptr)n; }
-static inline TCGv_i32 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i32)n; }
-
-#define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i32((intptr_t)(V)))
-#define tcg_global_mem_new_ptr(R, O, N) \
-    TCGV_NAT_TO_PTR(tcg_global_mem_new_i32((R), (O), (N)))
-#define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i32())
-#define tcg_temp_free_ptr(T) tcg_temp_free_i32(TCGV_PTR_TO_NAT(T))
-#else
-static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i64 n) { return (TCGv_ptr)n; }
-static inline TCGv_i64 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i64)n; }
-
-#define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i64((intptr_t)(V)))
-#define tcg_global_mem_new_ptr(R, O, N) \
-    TCGV_NAT_TO_PTR(tcg_global_mem_new_i64((R), (O), (N)))
-#define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i64())
-#define tcg_temp_free_ptr(T) tcg_temp_free_i64(TCGV_PTR_TO_NAT(T))
-#endif
-
 bool tcg_op_supported(TCGOpcode op);
 
 void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
@@ -1052,6 +1070,14 @@ TCGv_vec tcg_const_ones_vec(TCGType);
 TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec);
 TCGv_vec tcg_const_ones_vec_matching(TCGv_vec);
 
+#if UINTPTR_MAX == UINT32_MAX
+# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i32((intptr_t)(x)))
+# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i32((intptr_t)(x)))
+#else
+# define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i64((intptr_t)(x)))
+# define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i64((intptr_t)(x)))
+#endif
+
 TCGLabel *gen_new_label(void);
 
 /**
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c532889b1f..cdc397308b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -151,13 +151,7 @@
 #define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i64
 #define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i64
-#if UINTPTR_MAX == UINT32_MAX
-# define tcg_gen_trunc_reg_ptr(p, r) \
-    tcg_gen_trunc_i64_i32(TCGV_PTR_TO_NAT(p), r)
-#else
-# define tcg_gen_trunc_reg_ptr(p, r) \
-    tcg_gen_mov_i64(TCGV_PTR_TO_NAT(p), r)
-#endif
+#define tcg_gen_trunc_reg_ptr   tcg_gen_trunc_i64_ptr
 #else
 #define TCGv_reg             TCGv_i32
 #define tcg_temp_new         tcg_temp_new_i32
@@ -251,13 +245,7 @@
 #define tcg_gen_qemu_ld_reg  tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_reg  tcg_gen_qemu_st_i32
 #define tcg_gen_atomic_xchg_reg tcg_gen_atomic_xchg_i32
-#if UINTPTR_MAX == UINT32_MAX
-# define tcg_gen_trunc_reg_ptr(p, r) \
-    tcg_gen_mov_i32(TCGV_PTR_TO_NAT(p), r)
-#else
-# define tcg_gen_trunc_reg_ptr(p, r) \
-    tcg_gen_extu_i32_i64(TCGV_PTR_TO_NAT(p), r)
-#endif
+#define tcg_gen_trunc_reg_ptr   tcg_gen_ext_i32_ptr
 #endif /* TARGET_REGISTER_BITS */
 
 typedef struct DisasCond {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb24526c93..b5e706bc49 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -980,7 +980,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
     return ts;
 }
 
-static TCGTemp *tcg_temp_new_internal(TCGType type, int temp_local)
+TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *ts;
@@ -1025,18 +1025,6 @@ static TCGTemp *tcg_temp_new_internal(TCGType type, int temp_local)
     return ts;
 }
 
-TCGv_i32 tcg_temp_new_internal_i32(int temp_local)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, temp_local);
-    return temp_tcgv_i32(t);
-}
-
-TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, temp_local);
-    return temp_tcgv_i64(t);
-}
-
 TCGv_vec tcg_temp_new_vec(TCGType type)
 {
     TCGTemp *t;
@@ -1072,7 +1060,7 @@ TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match)
     return temp_tcgv_vec(t);
 }
 
-static void tcg_temp_free_internal(TCGTemp *ts)
+void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
     int k, idx;
@@ -1093,21 +1081,6 @@ static void tcg_temp_free_internal(TCGTemp *ts)
     set_bit(idx, s->free_temps[k].l);
 }
 
-void tcg_temp_free_i32(TCGv_i32 arg)
-{
-    tcg_temp_free_internal(tcgv_i32_temp(arg));
-}
-
-void tcg_temp_free_i64(TCGv_i64 arg)
-{
-    tcg_temp_free_internal(tcgv_i64_temp(arg));
-}
-
-void tcg_temp_free_vec(TCGv_vec arg)
-{
-    tcg_temp_free_internal(tcgv_vec_temp(arg));
-}
-
 TCGv_i32 tcg_const_i32(int32_t val)
 {
     TCGv_i32 t0;
-- 
2.14.3
