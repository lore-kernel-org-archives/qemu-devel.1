Received: from eggs.gnu.org ([2001:4830:134:3::10]:43607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFkB-0003Ij-TK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFk7-00072W-6Z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fLFk7-00071t-3V
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 May 2018 18:26:52 -0400
Message-Id: <1527028012-21888-6-git-send-email-cota@braap.org>
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 5/5] trace: enable tracing of TCG atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

We do not trace guest atomic accesses. Fix it.

Tested with a modified atomic_add-bench so that it executes
a deterministic number of instructions, i.e. fixed seeding,
no threading and fixed number of loop iterations instead
of running for a certain time.

Before:
- With parallel_cpus = false (no clone syscall so it is never set to true):
  220070 memory accesses
- With parallel_cpus = true (hard-coded):
  212105 memory accesses <-- we're not tracing the atomics!

After:
  220070 memory accesses regardless of parallel_cpus.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/atomic_template.h | 87 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 3f41ef2..d751bcb 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,30 +18,37 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "trace/mem.h"
+
 #if DATA_SIZE == 16
 # define SUFFIX     o
 # define DATA_TYPE  Int128
 # define BSWAP      bswap128
+# define SHIFT      4
 #elif DATA_SIZE == 8
 # define SUFFIX     q
 # define DATA_TYPE  uint64_t
 # define SDATA_TYPE int64_t
 # define BSWAP      bswap64
+# define SHIFT      3
 #elif DATA_SIZE == 4
 # define SUFFIX     l
 # define DATA_TYPE  uint32_t
 # define SDATA_TYPE int32_t
 # define BSWAP      bswap32
+# define SHIFT      2
 #elif DATA_SIZE == 2
 # define SUFFIX     w
 # define DATA_TYPE  uint16_t
 # define SDATA_TYPE int16_t
 # define BSWAP      bswap16
+# define SHIFT      1
 #elif DATA_SIZE == 1
 # define SUFFIX     b
 # define DATA_TYPE  uint8_t
 # define SDATA_TYPE int8_t
 # define BSWAP
+# define SHIFT      0
 #else
 # error unsupported data size
 #endif
@@ -52,14 +59,37 @@
 # define ABI_TYPE  uint32_t
 #endif
 
+#define ATOMIC_TRACE_RMW do {                                           \
+        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+                                                                        \
+        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
+        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr,             \
+                                    info | TRACE_MEM_ST);               \
+    } while (0)
+
+#define ATOMIC_TRACE_LD do {                                            \
+        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+                                                                        \
+        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
+    } while (0)
+
+# define ATOMIC_TRACE_ST do {                                           \
+        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
+                                                                        \
+        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
+    } while (0)
+
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
 #if DATA_SIZE == 1
 # define END
+# define MEND _be /* either le or be would be fine */
 #elif defined(HOST_WORDS_BIGENDIAN)
 # define END  _be
+# define MEND _be
 #else
 # define END  _le
+# define MEND _le
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -67,7 +97,10 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+    DATA_TYPE ret;
+
+    ATOMIC_TRACE_RMW;
+    ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
     ATOMIC_MMU_CLEANUP;
     return ret;
 }
@@ -77,6 +110,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+
+    ATOMIC_TRACE_LD;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
     return val;
@@ -87,6 +122,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+
+    ATOMIC_TRACE_ST;
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
 }
@@ -96,7 +133,10 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    DATA_TYPE ret = atomic_xchg__nocheck(haddr, val);
+    DATA_TYPE ret;
+
+    ATOMIC_TRACE_RMW;
+    ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
     return ret;
 }
@@ -107,7 +147,10 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
 {                                                                   \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-    DATA_TYPE ret = atomic_##X(haddr, val);                         \
+    DATA_TYPE ret;                                                  \
+                                                                    \
+    ATOMIC_TRACE_RMW;                                               \
+    ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
     return ret;                                                     \
 }
@@ -126,6 +169,9 @@ GEN_ATOMIC_HELPER(xor_fetch)
 /* These helpers are, as a whole, full barriers.  Within the helper,
  * the leading barrier is explicit and the trailing barrier is within
  * cmpxchg primitive.
+ *
+ * Trace this load + RMW loop as a single RMW op. This way, regardless
+ * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
@@ -134,6 +180,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
+                                                                    \
+    ATOMIC_TRACE_RMW;                                               \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -158,6 +206,7 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 #endif /* DATA SIZE >= 16 */
 
 #undef END
+#undef MEND
 
 #if DATA_SIZE > 1
 
@@ -165,8 +214,10 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
    within the ATOMIC_NAME macro.  */
 #ifdef HOST_WORDS_BIGENDIAN
 # define END  _le
+# define MEND _le
 #else
 # define END  _be
+# define MEND _be
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -174,7 +225,10 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
+    DATA_TYPE ret;
+
+    ATOMIC_TRACE_RMW;
+    ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
     ATOMIC_MMU_CLEANUP;
     return BSWAP(ret);
 }
@@ -184,6 +238,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+
+    ATOMIC_TRACE_LD;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
     return BSWAP(val);
@@ -194,6 +250,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+
+    ATOMIC_TRACE_ST;
     val = BSWAP(val);
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
@@ -204,7 +262,10 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    ABI_TYPE ret = atomic_xchg__nocheck(haddr, BSWAP(val));
+    ABI_TYPE ret;
+
+    ATOMIC_TRACE_RMW;
+    ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
     return BSWAP(ret);
 }
@@ -215,7 +276,10 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
 {                                                                   \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-    DATA_TYPE ret = atomic_##X(haddr, BSWAP(val));                  \
+    DATA_TYPE ret;                                                  \
+                                                                    \
+    ATOMIC_TRACE_RMW;                                               \
+    ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
     return BSWAP(ret);                                              \
 }
@@ -232,6 +296,9 @@ GEN_ATOMIC_HELPER(xor_fetch)
 /* These helpers are, as a whole, full barriers.  Within the helper,
  * the leading barrier is explicit and the trailing barrier is within
  * cmpxchg primitive.
+ *
+ * Trace this load + RMW loop as a single RMW op. This way, regardless
+ * of CF_PARALLEL's value, we'll trace just a read and a write.
  */
 #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
@@ -240,6 +307,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+                                                                    \
+    ATOMIC_TRACE_RMW;                                               \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -271,11 +340,17 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #endif /* DATA_SIZE >= 16 */
 
 #undef END
+#undef MEND
 #endif /* DATA_SIZE > 1 */
 
+#undef ATOMIC_TRACE_ST
+#undef ATOMIC_TRACE_LD
+#undef ATOMIC_TRACE_RMW
+
 #undef BSWAP
 #undef ABI_TYPE
 #undef DATA_TYPE
 #undef SDATA_TYPE
 #undef SUFFIX
 #undef DATA_SIZE
+#undef SHIFT
-- 
2.7.4
