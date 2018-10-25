Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006ht-D1
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKJ-00008D-5V
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKH-0008Q9-90
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:21 -0400
Message-Id: <20181025172057.20414-13-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 12/48] atomic_template: define pre/post macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

In preparation for plugin support.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/atomic_template.h | 92 +++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 8d177fefef..b13318c1ce 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -59,25 +59,26 @@
 # define ABI_TYPE  uint32_t
 #endif
 
-#define ATOMIC_TRACE_RMW do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
-                                                                        \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr,             \
-                                    info | TRACE_MEM_ST);               \
-    } while (0)
-
-#define ATOMIC_TRACE_LD do {                                            \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
-                                                                        \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
-    } while (0)
-
-# define ATOMIC_TRACE_ST do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
-                                                                        \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
-    } while (0)
+/* these don't depend on MEND/SHIFT, so we just define them once */
+#ifndef ATOMIC_TRACE_RMW_PRE
+# define ATOMIC_TRACE_RMW_PRE do {                                            \
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);                \
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info | TRACE_MEM_ST); \
+} while (0)
+
+# define ATOMIC_TRACE_RMW_POST                                          \
+
+# define ATOMIC_TRACE_LD_PRE                                    \
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
+
+# define ATOMIC_TRACE_LD_POST                                           \
+
+# define ATOMIC_TRACE_ST_PRE                                    \
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info)
+
+# define ATOMIC_TRACE_ST_POST                                           \
+
+#endif /* ATOMIC_TRACE_RMW_PRE */
 
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
@@ -98,14 +99,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    ATOMIC_TRACE_RMW_PRE;
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, cmpv, newv);
 #else
     ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_RMW_POST;
     return ret;
 }
 
@@ -115,10 +118,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    ATOMIC_TRACE_LD_PRE;
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_LD_POST;
     return val;
 }
 
@@ -127,10 +132,12 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    ATOMIC_TRACE_ST_PRE;
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_ST_POST;
 }
 #endif
 #else
@@ -140,10 +147,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    ATOMIC_TRACE_RMW_PRE;
     ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_RMW_POST;
     return ret;
 }
 
@@ -154,10 +163,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    ATOMIC_TRACE_RMW_PRE;                                           \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
+    ATOMIC_TRACE_RMW_POST;                                          \
     return ret;                                                     \
 }
 
@@ -186,8 +197,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    ATOMIC_TRACE_RMW_PRE;                                           \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -195,6 +207,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    ATOMIC_TRACE_RMW_POST;                                          \
     return RET;                                                     \
 }
 
@@ -232,14 +245,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    ATOMIC_TRACE_RMW_PRE;
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
 #else
     ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_RMW_POST;
     return BSWAP(ret);
 }
 
@@ -249,10 +264,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    ATOMIC_TRACE_LD_PRE;
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_LD_POST;
     return BSWAP(val);
 }
 
@@ -261,11 +278,14 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    val = BSWAP(val);
+    ATOMIC_TRACE_ST_PRE;
     val = BSWAP(val);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_ST_POST;
 }
 #endif
 #else
@@ -275,10 +295,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    ATOMIC_TRACE_RMW_PRE;
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
+    ATOMIC_TRACE_RMW_POST;
     return BSWAP(ret);
 }
 
@@ -289,10 +311,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    ATOMIC_TRACE_RMW_PRE;                                           \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
+    ATOMIC_TRACE_RMW_POST;                                          \
     return BSWAP(ret);                                              \
 }
 
@@ -319,8 +343,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    ATOMIC_TRACE_RMW_PRE;                                           \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -328,6 +353,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    ATOMIC_TRACE_RMW_POST;                                          \
     return RET;                                                     \
 }
 
@@ -355,10 +381,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef MEND
 #endif /* DATA_SIZE > 1 */
 
-#undef ATOMIC_TRACE_ST
-#undef ATOMIC_TRACE_LD
-#undef ATOMIC_TRACE_RMW
-
 #undef BSWAP
 #undef ABI_TYPE
 #undef DATA_TYPE
-- 
2.17.1
