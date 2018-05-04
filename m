Received: from eggs.gnu.org ([2001:4830:134:3::10]:45561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTU-0007Vb-Kp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTS-00017F-V7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:32 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEfTS-00016P-NQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:30 -0400
Received: by mail-pf0-x242.google.com with SMTP id a22so3971311pfn.6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 11:30:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  4 May 2018 11:30:15 -0700
Message-Id: <20180504183021.19318-5-richard.henderson@linaro.org>
In-Reply-To: <20180504183021.19318-1-richard.henderson@linaro.org>
References: <20180504183021.19318-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/10] tcg: Introduce atomic helpers for
 integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Given that this atomic operation will be used by both risc-v
and aarch64, let's not duplicate code across the two targets.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 71 +++++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h     |  8 +++++
 tcg/tcg-op.h                | 34 ++++++++++++++++++++++
 tcg/tcg.h                   |  8 +++++
 tcg/tcg-op.c                |  8 +++++
 5 files changed, 129 insertions(+)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index e022df4571..2489dd3ec1 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -25,18 +25,22 @@
 #elif DATA_SIZE == 8
 # define SUFFIX     q
 # define DATA_TYPE  uint64_t
+# define SDATA_TYPE int64_t
 # define BSWAP      bswap64
 #elif DATA_SIZE == 4
 # define SUFFIX     l
 # define DATA_TYPE  uint32_t
+# define SDATA_TYPE int32_t
 # define BSWAP      bswap32
 #elif DATA_SIZE == 2
 # define SUFFIX     w
 # define DATA_TYPE  uint16_t
+# define SDATA_TYPE int16_t
 # define BSWAP      bswap16
 #elif DATA_SIZE == 1
 # define SUFFIX     b
 # define DATA_TYPE  uint8_t
+# define SDATA_TYPE int8_t
 # define BSWAP
 #else
 # error unsupported data size
@@ -118,6 +122,39 @@ GEN_ATOMIC_HELPER(or_fetch)
 GEN_ATOMIC_HELPER(xor_fetch)
 
 #undef GEN_ATOMIC_HELPER
+
+/* These helpers are, as a whole, full barriers.  Within the helper,
+ * the leading barrier is explicit and the trailing barrier is within
+ * cmpxchg primitive.
+ */
+#define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+                        ABI_TYPE xval EXTRA_ARGS)                   \
+{                                                                   \
+    ATOMIC_MMU_DECLS;                                               \
+    XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
+    XDATA_TYPE cmp, old, new, val = xval;                           \
+    smp_mb();                                                       \
+    cmp = atomic_read__nocheck(haddr);                              \
+    do {                                                            \
+        old = cmp; new = FN(old, val);                              \
+        cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
+    } while (cmp != old);                                           \
+    ATOMIC_MMU_CLEANUP;                                             \
+    return RET;                                                     \
+}
+
+GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_umin, MIN,  DATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_umax, MAX,  DATA_TYPE, old)
+
+GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
+
+#undef GEN_ATOMIC_HELPER_FN
 #endif /* DATA SIZE >= 16 */
 
 #undef END
@@ -233,6 +270,39 @@ ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
         ldo = ldn;
     }
 }
+
+/* These helpers are, as a whole, full barriers.  Within the helper,
+ * the leading barrier is explicit and the trailing barrier is within
+ * cmpxchg primitive.
+ */
+#define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
+ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
+                        ABI_TYPE xval EXTRA_ARGS)                   \
+{                                                                   \
+    ATOMIC_MMU_DECLS;                                               \
+    XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
+    XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    smp_mb();                                                       \
+    ldn = atomic_read__nocheck(haddr);                              \
+    do {                                                            \
+        ldo = ldn; old = BSWAP(ldo); new = FN(old, val);            \
+        ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
+    } while (ldo != ldn);                                           \
+    ATOMIC_MMU_CLEANUP;                                             \
+    return RET;                                                     \
+}
+
+GEN_ATOMIC_HELPER_FN(fetch_smin, MIN, SDATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_umin, MIN,  DATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_smax, MAX, SDATA_TYPE, old)
+GEN_ATOMIC_HELPER_FN(fetch_umax, MAX,  DATA_TYPE, old)
+
+GEN_ATOMIC_HELPER_FN(smin_fetch, MIN, SDATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(umin_fetch, MIN,  DATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(smax_fetch, MAX, SDATA_TYPE, new)
+GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
+
+#undef GEN_ATOMIC_HELPER_FN
 #endif /* DATA_SIZE >= 16 */
 
 #undef END
@@ -241,5 +311,6 @@ ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
 #undef BSWAP
 #undef ABI_TYPE
 #undef DATA_TYPE
+#undef SDATA_TYPE
 #undef SUFFIX
 #undef DATA_SIZE
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 2536959a18..1bd39d136d 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -125,11 +125,19 @@ GEN_ATOMIC_HELPERS(fetch_add)
 GEN_ATOMIC_HELPERS(fetch_and)
 GEN_ATOMIC_HELPERS(fetch_or)
 GEN_ATOMIC_HELPERS(fetch_xor)
+GEN_ATOMIC_HELPERS(fetch_smin)
+GEN_ATOMIC_HELPERS(fetch_umin)
+GEN_ATOMIC_HELPERS(fetch_smax)
+GEN_ATOMIC_HELPERS(fetch_umax)
 
 GEN_ATOMIC_HELPERS(add_fetch)
 GEN_ATOMIC_HELPERS(and_fetch)
 GEN_ATOMIC_HELPERS(or_fetch)
 GEN_ATOMIC_HELPERS(xor_fetch)
+GEN_ATOMIC_HELPERS(smin_fetch)
+GEN_ATOMIC_HELPERS(umin_fetch)
+GEN_ATOMIC_HELPERS(smax_fetch)
+GEN_ATOMIC_HELPERS(umax_fetch)
 
 GEN_ATOMIC_HELPERS(xchg)
 
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 0451e2752e..04eb3e9e17 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -898,6 +898,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGv_i64,
 
 void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+
 void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
@@ -906,6 +907,15 @@ void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+
 void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
@@ -914,6 +924,14 @@ void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
 void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
+void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
+void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
@@ -1043,10 +1061,18 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_atomic_fetch_and_tl tcg_gen_atomic_fetch_and_i64
 #define tcg_gen_atomic_fetch_or_tl tcg_gen_atomic_fetch_or_i64
 #define tcg_gen_atomic_fetch_xor_tl tcg_gen_atomic_fetch_xor_i64
+#define tcg_gen_atomic_fetch_smin_tl tcg_gen_atomic_fetch_smin_i64
+#define tcg_gen_atomic_fetch_umin_tl tcg_gen_atomic_fetch_umin_i64
+#define tcg_gen_atomic_fetch_smax_tl tcg_gen_atomic_fetch_smax_i64
+#define tcg_gen_atomic_fetch_umax_tl tcg_gen_atomic_fetch_umax_i64
 #define tcg_gen_atomic_add_fetch_tl tcg_gen_atomic_add_fetch_i64
 #define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i64
 #define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i64
 #define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i64
+#define tcg_gen_atomic_smin_fetch_tl tcg_gen_atomic_smin_fetch_i64
+#define tcg_gen_atomic_umin_fetch_tl tcg_gen_atomic_umin_fetch_i64
+#define tcg_gen_atomic_smax_fetch_tl tcg_gen_atomic_smax_fetch_i64
+#define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
@@ -1145,10 +1171,18 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_atomic_fetch_and_tl tcg_gen_atomic_fetch_and_i32
 #define tcg_gen_atomic_fetch_or_tl tcg_gen_atomic_fetch_or_i32
 #define tcg_gen_atomic_fetch_xor_tl tcg_gen_atomic_fetch_xor_i32
+#define tcg_gen_atomic_fetch_smin_tl tcg_gen_atomic_fetch_smin_i32
+#define tcg_gen_atomic_fetch_umin_tl tcg_gen_atomic_fetch_umin_i32
+#define tcg_gen_atomic_fetch_smax_tl tcg_gen_atomic_fetch_smax_i32
+#define tcg_gen_atomic_fetch_umax_tl tcg_gen_atomic_fetch_umax_i32
 #define tcg_gen_atomic_add_fetch_tl tcg_gen_atomic_add_fetch_i32
 #define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i32
 #define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i32
 #define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i32
+#define tcg_gen_atomic_smin_fetch_tl tcg_gen_atomic_smin_fetch_i32
+#define tcg_gen_atomic_umin_fetch_tl tcg_gen_atomic_umin_fetch_i32
+#define tcg_gen_atomic_smax_fetch_tl tcg_gen_atomic_smax_fetch_i32
+#define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #endif
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 75fbad128b..1ca985479b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1415,12 +1415,20 @@ GEN_ATOMIC_HELPER_ALL(fetch_sub)
 GEN_ATOMIC_HELPER_ALL(fetch_and)
 GEN_ATOMIC_HELPER_ALL(fetch_or)
 GEN_ATOMIC_HELPER_ALL(fetch_xor)
+GEN_ATOMIC_HELPER_ALL(fetch_smin)
+GEN_ATOMIC_HELPER_ALL(fetch_umin)
+GEN_ATOMIC_HELPER_ALL(fetch_smax)
+GEN_ATOMIC_HELPER_ALL(fetch_umax)
 
 GEN_ATOMIC_HELPER_ALL(add_fetch)
 GEN_ATOMIC_HELPER_ALL(sub_fetch)
 GEN_ATOMIC_HELPER_ALL(and_fetch)
 GEN_ATOMIC_HELPER_ALL(or_fetch)
 GEN_ATOMIC_HELPER_ALL(xor_fetch)
+GEN_ATOMIC_HELPER_ALL(smin_fetch)
+GEN_ATOMIC_HELPER_ALL(umin_fetch)
+GEN_ATOMIC_HELPER_ALL(smax_fetch)
+GEN_ATOMIC_HELPER_ALL(umax_fetch)
 
 GEN_ATOMIC_HELPER_ALL(xchg)
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5b82c3be8d..6a914654f5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3051,11 +3051,19 @@ GEN_ATOMIC_HELPER(fetch_add, add, 0)
 GEN_ATOMIC_HELPER(fetch_and, and, 0)
 GEN_ATOMIC_HELPER(fetch_or, or, 0)
 GEN_ATOMIC_HELPER(fetch_xor, xor, 0)
+GEN_ATOMIC_HELPER(fetch_smin, smin, 0)
+GEN_ATOMIC_HELPER(fetch_umin, umin, 0)
+GEN_ATOMIC_HELPER(fetch_smax, smax, 0)
+GEN_ATOMIC_HELPER(fetch_umax, umax, 0)
 
 GEN_ATOMIC_HELPER(add_fetch, add, 1)
 GEN_ATOMIC_HELPER(and_fetch, and, 1)
 GEN_ATOMIC_HELPER(or_fetch, or, 1)
 GEN_ATOMIC_HELPER(xor_fetch, xor, 1)
+GEN_ATOMIC_HELPER(smin_fetch, smin, 1)
+GEN_ATOMIC_HELPER(umin_fetch, umin, 1)
+GEN_ATOMIC_HELPER(smax_fetch, smax, 1)
+GEN_ATOMIC_HELPER(umax_fetch, umax, 1)
 
 static void tcg_gen_mov2_i32(TCGv_i32 r, TCGv_i32 a, TCGv_i32 b)
 {
-- 
2.14.3
