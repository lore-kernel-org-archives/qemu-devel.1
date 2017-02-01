Received: from eggs.gnu.org ([2001:4830:134:3::10]:53146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsA-00060L-VG
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts5-0005bq-Tl
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:50 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46056 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts5-0005bO-IA
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:45 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:03 +0300
Message-Id: <1485951502-28774-2-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 01/20] tcg: add support for 128bit vector
 type
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

Introduce TCG_TYPE_V128 and corresponding TCGv_v128 for TCG temps. Add helper
functions that work with temps of this new type.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg-op.h | 24 ++++++++++++++++++++++++
 tcg/tcg.c    | 13 +++++++++++++
 tcg/tcg.h    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index c68e300..5abf8b2 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -248,6 +248,23 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 GET_TCGV_I64(a3), GET_TCGV_I64(a4), a5, a6);
 }
 
+static inline void tcg_gen_op1_v128(TCGOpcode opc, TCGv_v128 a1)
+{
+    tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_V128(a1));
+}
+
+static inline void tcg_gen_op2_v128(TCGOpcode opc, TCGv_v128 a1,
+                                    TCGv_v128 a2)
+{
+    tcg_gen_op2(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_V128(a2));
+}
+
+static inline void tcg_gen_op3_v128(TCGOpcode opc, TCGv_v128 a1,
+                                    TCGv_v128 a2, TCGv_v128 a3)
+{
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_V128(a2),
+                GET_TCGV_V128(a3));
+}
 
 /* Generic ops.  */
 
@@ -454,6 +471,13 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/* Vector ops */
+
+static inline void tcg_gen_discard_v128(TCGv_v128 arg)
+{
+    tcg_gen_op1_v128(INDEX_op_discard, arg);
+}
+
 /* 64 bit ops */
 
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cb898f1..2a5e83b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -641,6 +641,14 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
     return MAKE_TCGV_I64(idx);
 }
 
+TCGv_v128 tcg_temp_new_internal_v128(int temp_local)
+{
+    int idx;
+
+    idx = tcg_temp_new_internal(TCG_TYPE_V128, temp_local);
+    return MAKE_TCGV_V128(idx);
+}
+
 static void tcg_temp_free_internal(int idx)
 {
     TCGContext *s = &tcg_ctx;
@@ -673,6 +681,11 @@ void tcg_temp_free_i64(TCGv_i64 arg)
     tcg_temp_free_internal(GET_TCGV_I64(arg));
 }
 
+void tcg_temp_free_v128(TCGv_v128 arg)
+{
+    tcg_temp_free_internal(GET_TCGV_V128(arg));
+}
+
 TCGv_i32 tcg_const_i32(int32_t val)
 {
     TCGv_i32 t0;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 631c6f6..56484e7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -246,6 +246,7 @@ typedef struct TCGPool {
 typedef enum TCGType {
     TCG_TYPE_I32,
     TCG_TYPE_I64,
+    TCG_TYPE_V128,
     TCG_TYPE_COUNT, /* number of different types */
 
     /* An alias for the size of the host register.  */
@@ -421,6 +422,7 @@ typedef tcg_target_ulong TCGArg;
 typedef struct TCGv_i32_d *TCGv_i32;
 typedef struct TCGv_i64_d *TCGv_i64;
 typedef struct TCGv_ptr_d *TCGv_ptr;
+typedef struct TCGv_v128_d *TCGv_v128;
 typedef TCGv_ptr TCGv_env;
 #if TARGET_LONG_BITS == 32
 #define TCGv TCGv_i32
@@ -445,6 +447,11 @@ static inline TCGv_ptr QEMU_ARTIFICIAL MAKE_TCGV_PTR(intptr_t i)
     return (TCGv_ptr)i;
 }
 
+static inline TCGv_v128 QEMU_ARTIFICIAL MAKE_TCGV_V128(intptr_t i)
+{
+    return (TCGv_v128)i;
+}
+
 static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_I32(TCGv_i32 t)
 {
     return (intptr_t)t;
@@ -460,6 +467,11 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
     return (intptr_t)t;
 }
 
+static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_V128(TCGv_v128 t)
+{
+    return (intptr_t)t;
+}
+
 #if TCG_TARGET_REG_BITS == 32
 #define TCGV_LOW(t) MAKE_TCGV_I32(GET_TCGV_I64(t))
 #define TCGV_HIGH(t) MAKE_TCGV_I32(GET_TCGV_I64(t) + 1)
@@ -467,15 +479,18 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 
 #define TCGV_EQUAL_I32(a, b) (GET_TCGV_I32(a) == GET_TCGV_I32(b))
 #define TCGV_EQUAL_I64(a, b) (GET_TCGV_I64(a) == GET_TCGV_I64(b))
+#define TCGV_EQUAL_V128(a, b) (GET_TCGV_V128(a) == GET_TCGV_V128(b))
 #define TCGV_EQUAL_PTR(a, b) (GET_TCGV_PTR(a) == GET_TCGV_PTR(b))
 
 /* Dummy definition to avoid compiler warnings.  */
 #define TCGV_UNUSED_I32(x) x = MAKE_TCGV_I32(-1)
 #define TCGV_UNUSED_I64(x) x = MAKE_TCGV_I64(-1)
+#define TCGV_UNUSED_V128(x) x = MAKE_TCGV_V128(-1)
 #define TCGV_UNUSED_PTR(x) x = MAKE_TCGV_PTR(-1)
 
 #define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == -1)
 #define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == -1)
+#define TCGV_IS_UNUSED_V128(x) (GET_TCGV_V128(x) == -1)
 #define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == -1)
 
 /* call flags */
@@ -798,9 +813,11 @@ TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
 
 TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
 TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
+TCGv_v128 tcg_temp_new_internal_v128(int temp_local);
 
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
+void tcg_temp_free_v128(TCGv_v128 arg);
 
 static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
                                               const char *name)
@@ -836,6 +853,23 @@ static inline TCGv_i64 tcg_temp_local_new_i64(void)
     return tcg_temp_new_internal_i64(1);
 }
 
+static inline TCGv_v128 tcg_global_mem_new_v128(TCGv_ptr reg, intptr_t offset,
+                                                const char *name)
+{
+    int idx = tcg_global_mem_new_internal(TCG_TYPE_V128, reg, offset, name);
+    return MAKE_TCGV_V128(idx);
+}
+
+static inline TCGv_v128 tcg_temp_new_v128(void)
+{
+    return tcg_temp_new_internal_v128(0);
+}
+
+static inline TCGv_v128 tcg_temp_local_new_v128(void)
+{
+    return tcg_temp_new_internal_v128(1);
+}
+
 #if defined(CONFIG_DEBUG_TCG)
 /* If you call tcg_clear_temp_count() at the start of a section of
  * code which is not supposed to leak any TCG temporaries, then
-- 
2.1.4
