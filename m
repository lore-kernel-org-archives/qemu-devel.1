Received: from eggs.gnu.org ([2001:4830:134:3::10]:45624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6Z-0008Ja-Fp
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6U-00089L-TO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:48718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6U-00088I-KO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id p75so609955wmg.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:02 +0200
Message-Id: <20171025093535.10175-19-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 18/51] tcg: Remove GET_TCGV_* and MAKE_TCGV_*
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

The GET and MAKE functions weren't really specific enough.
We now have a full complement of functions that convert exactly
between temporaries, arguments, tcgv pointers, and indices.

The target/sparc change is also a bug fix, which would have affected
a host that defines TCG_TARGET_HAS_extr[lh]_i64_i32, i.e. MIPS64.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h |  4 ---
 tcg/tcg.h                  | 78 ++++++++++++++++------------------------------
 target/sparc/translate.c   | 15 +++------
 tcg/tcg-op.c               |  4 +--
 tcg/tcg.c                  |  2 +-
 5 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 13286018fd..639eefdbc0 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -20,10 +20,6 @@
 
 #define HELPER(name) glue(helper_, name)
 
-#define GET_TCGV_i32 GET_TCGV_I32
-#define GET_TCGV_i64 GET_TCGV_I64
-#define GET_TCGV_ptr GET_TCGV_PTR
-
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
 #define dh_alias_s32 i32
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9432962d7b..b7fac0db8a 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -414,10 +414,7 @@ typedef tcg_target_ulong TCGArg;
    integers, but keeping them in pointer types like this means that the
    compiler will complain if you accidentally pass a TCGv_i32 to a
    function which takes a TCGv_i64, and so on. Only the internals of
-   TCG need to care about the actual contents of the types, and they always
-   box and unbox via the MAKE_TCGV_* and GET_TCGV_* functions.
-   Converting to and from intptr_t rather than int reduces the number
-   of sign-extension instructions that get implied on 64-bit hosts.  */
+   TCG need to care about the actual contents of the types.  */
 
 typedef struct TCGv_i32_d *TCGv_i32;
 typedef struct TCGv_i64_d *TCGv_i64;
@@ -431,53 +428,18 @@ typedef TCGv_ptr TCGv_env;
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
-#if TCG_TARGET_REG_BITS == 32
-#define TCGV_LOW(t) MAKE_TCGV_I32(GET_TCGV_I64(t))
-#define TCGV_HIGH(t) MAKE_TCGV_I32(GET_TCGV_I64(t) + 1)
-#endif
-
-#define TCGV_EQUAL_I32(a, b) (GET_TCGV_I32(a) == GET_TCGV_I32(b))
-#define TCGV_EQUAL_I64(a, b) (GET_TCGV_I64(a) == GET_TCGV_I64(b))
-#define TCGV_EQUAL_PTR(a, b) (GET_TCGV_PTR(a) == GET_TCGV_PTR(b))
+#define TCGV_EQUAL_I32(a, b) ((a) == (b))
+#define TCGV_EQUAL_I64(a, b) ((a) == (b))
+#define TCGV_EQUAL_PTR(a, b) ((a) == (b))
 
 /* Dummy definition to avoid compiler warnings.  */
-#define TCGV_UNUSED_I32(x) x = MAKE_TCGV_I32(-1)
-#define TCGV_UNUSED_I64(x) x = MAKE_TCGV_I64(-1)
-#define TCGV_UNUSED_PTR(x) x = MAKE_TCGV_PTR(-1)
+#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)-1)
+#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)-1)
+#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)-1)
 
-#define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == -1)
-#define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == -1)
-#define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == -1)
+#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)-1)
+#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)-1)
+#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)-1)
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
@@ -801,6 +763,18 @@ static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
     return (TCGv_ptr)temp_idx(t);
 }
 
+#if TCG_TARGET_REG_BITS == 32
+static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)
+{
+    return temp_tcgv_i32(tcgv_i64_temp(t));
+}
+
+static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
+{
+    return temp_tcgv_i32(tcgv_i64_temp(t) + 1);
+}
+#endif
+
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
     tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
@@ -972,8 +946,8 @@ do {\
 } while (0)
 
 #if UINTPTR_MAX == UINT32_MAX
-#define TCGV_NAT_TO_PTR(n) MAKE_TCGV_PTR(GET_TCGV_I32(n))
-#define TCGV_PTR_TO_NAT(n) MAKE_TCGV_I32(GET_TCGV_PTR(n))
+static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i32 n) { return (TCGv_ptr)n; }
+static inline TCGv_i32 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i32)n; }
 
 #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i32((intptr_t)(V)))
 #define tcg_global_reg_new_ptr(R, N) \
@@ -983,8 +957,8 @@ do {\
 #define tcg_temp_new_ptr() TCGV_NAT_TO_PTR(tcg_temp_new_i32())
 #define tcg_temp_free_ptr(T) tcg_temp_free_i32(TCGV_PTR_TO_NAT(T))
 #else
-#define TCGV_NAT_TO_PTR(n) MAKE_TCGV_PTR(GET_TCGV_I64(n))
-#define TCGV_PTR_TO_NAT(n) MAKE_TCGV_I64(GET_TCGV_PTR(n))
+static inline TCGv_ptr TCGV_NAT_TO_PTR(TCGv_i64 n) { return (TCGv_ptr)n; }
+static inline TCGv_i64 TCGV_PTR_TO_NAT(TCGv_ptr n) { return (TCGv_i64)n; }
 
 #define tcg_const_ptr(V) TCGV_NAT_TO_PTR(tcg_const_i64((intptr_t)(V)))
 #define tcg_global_reg_new_ptr(R, N) \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6290705b11..83a7d8e3ee 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -171,18 +171,13 @@ static TCGv_i32 gen_load_fpr_F(DisasContext *dc, unsigned int src)
         return TCGV_HIGH(cpu_fpr[src / 2]);
     }
 #else
+    TCGv_i32 ret = get_temp_i32(dc);
     if (src & 1) {
-        return MAKE_TCGV_I32(GET_TCGV_I64(cpu_fpr[src / 2]));
+        tcg_gen_extrl_i64_i32(ret, cpu_fpr[src / 2]);
     } else {
-        TCGv_i32 ret = get_temp_i32(dc);
-        TCGv_i64 t = tcg_temp_new_i64();
-
-        tcg_gen_shri_i64(t, cpu_fpr[src / 2], 32);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-
-        return ret;
+        tcg_gen_extrh_i64_i32(ret, cpu_fpr[src / 2]);
     }
+    return ret;
 #endif
 }
 
@@ -195,7 +190,7 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
         tcg_gen_mov_i32(TCGV_HIGH(cpu_fpr[dst / 2]), v);
     }
 #else
-    TCGv_i64 t = MAKE_TCGV_I64(GET_TCGV_I32(v));
+    TCGv_i64 t = (TCGv_i64)v;
     tcg_gen_deposit_i64(cpu_fpr[dst / 2], cpu_fpr[dst / 2], t,
                         (dst & 1 ? 0 : 32), 32);
 #endif
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index be4b623e82..9561510d9c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2460,7 +2460,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
         tcg_gen_op2(INDEX_op_extrl_i64_i32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
-        tcg_gen_mov_i32(ret, MAKE_TCGV_I32(GET_TCGV_I64(arg)));
+        tcg_gen_mov_i32(ret, (TCGv_i32)arg);
     }
 }
 
@@ -2474,7 +2474,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_shri_i64(t, arg, 32);
-        tcg_gen_mov_i32(ret, MAKE_TCGV_I32(GET_TCGV_I64(t)));
+        tcg_gen_mov_i32(ret, (TCGv_i32)t);
         tcg_temp_free_i64(t);
     }
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0a9bfa4236..3a73912827 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -548,7 +548,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
                                      intptr_t offset, const char *name)
 {
     TCGContext *s = &tcg_ctx;
-    TCGTemp *base_ts = &s->temps[GET_TCGV_PTR(base)];
+    TCGTemp *base_ts = tcgv_ptr_temp(base);
     TCGTemp *ts = tcg_global_alloc(s);
     int indirect_reg = 0, bigendian = 0;
 #ifdef HOST_WORDS_BIGENDIAN
-- 
2.13.6
