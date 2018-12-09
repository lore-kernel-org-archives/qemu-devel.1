Received: from eggs.gnu.org ([2001:4830:134:3::10]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001SV-9R
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uD-0005rw-3k
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uC-0004yp-Lo
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:25 -0500
Message-Id: <20181209193749.12277-15-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 14/38] atomic_template: add inline
 trace/plugin helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

In preparation for plugin support.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/atomic_template.h | 110 ++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 8d177fefef..2f7d5ee02a 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -59,25 +59,44 @@
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
+#ifndef ATOMIC_TEMPLATE_COMMON
+#define ATOMIC_TEMPLATE_COMMON
+static inline
+void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+
+    trace_guest_mem_before_exec(cpu, addr, info);
+    trace_guest_mem_before_exec(cpu, addr, info | TRACE_MEM_ST);
+}
+
+static inline void atomic_trace_rmw_post(CPUArchState *env, target_ulong addr,
+                                         void *haddr, uint8_t info)
+{
+}
+
+static inline
+void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);
+}
+
+static inline void atomic_trace_ld_post(CPUArchState *env, target_ulong addr,
+                                        void *haddr, uint8_t info)
+{
+}
+
+static inline
+void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);
+}
+
+static inline void atomic_trace_st_post(CPUArchState *env, target_ulong addr,
+                                        void *haddr, uint8_t info)
+{
+}
+#endif /* ATOMIC_TEMPLATE_COMMON */
 
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
@@ -98,14 +117,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, cmpv, newv);
 #else
     ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return ret;
 }
 
@@ -115,10 +136,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, haddr, info);
     return val;
 }
 
@@ -127,10 +150,12 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    atomic_trace_st_pre(env, addr, info);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, haddr, info);
 }
 #endif
 #else
@@ -140,10 +165,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return ret;
 }
 
@@ -154,10 +181,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return ret;                                                     \
 }
 
@@ -186,8 +215,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -195,6 +225,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return RET;                                                     \
 }
 
@@ -232,14 +263,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
 #else
     ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return BSWAP(ret);
 }
 
@@ -249,10 +282,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, haddr, info);
     return BSWAP(val);
 }
 
@@ -261,11 +296,14 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    val = BSWAP(val);
+    atomic_trace_st_pre(env, addr, info);
     val = BSWAP(val);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, haddr, info);
 }
 #endif
 #else
@@ -275,10 +313,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return BSWAP(ret);
 }
 
@@ -289,10 +329,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return BSWAP(ret);                                              \
 }
 
@@ -319,8 +361,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -328,6 +371,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return RET;                                                     \
 }
 
@@ -355,10 +399,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
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
