Received: from eggs.gnu.org ([2001:4830:134:3::10]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0002z1-J9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0006WD-8h
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:40 +1100
Message-Id: <20170112020327.24882-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/67] target-ppc: move ppc_vsr_t to common
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

The structure and corresponding defines and functions need to be used
outside of fpu_helper.c as well.

Add u8, u16, u32 and Int128 to the structure.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 37 -------------------------------------
 target/ppc/internal.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 696f537..3b867cf 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1777,43 +1777,6 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return helper_efdtsteq(env, op1, op2);
 }
 
-typedef union _ppc_vsr_t {
-    uint64_t u64[2];
-    uint32_t u32[4];
-    float32 f32[4];
-    float64 f64[2];
-} ppc_vsr_t;
-
-#if defined(HOST_WORDS_BIGENDIAN)
-#define VsrW(i) u32[i]
-#define VsrD(i) u64[i]
-#else
-#define VsrW(i) u32[3-(i)]
-#define VsrD(i) u64[1-(i)]
-#endif
-
-static void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    if (n < 32) {
-        vsr->VsrD(0) = env->fpr[n];
-        vsr->VsrD(1) = env->vsr[n];
-    } else {
-        vsr->u64[0] = env->avr[n-32].u64[0];
-        vsr->u64[1] = env->avr[n-32].u64[1];
-    }
-}
-
-static void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    if (n < 32) {
-        env->fpr[n] = vsr->VsrD(0);
-        env->vsr[n] = vsr->VsrD(1);
-    } else {
-        env->avr[n-32].u64[0] = vsr->u64[0];
-        env->avr[n-32].u64[1] = vsr->u64[1];
-    }
-}
-
 #define float64_to_float64(x, env) x
 
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index e83ea45..66cde46 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -199,4 +199,46 @@ EXTRACT_HELPER(SHW, 8, 2);
 EXTRACT_HELPER(SP, 19, 2);
 EXTRACT_HELPER(IMM8, 11, 8);
 
+typedef union _ppc_vsr_t {
+    uint8_t u8[16];
+    uint16_t u16[8];
+    uint32_t u32[4];
+    uint64_t u64[2];
+    float32 f32[4];
+    float64 f64[2];
+    Int128  s128;
+} ppc_vsr_t;
+
+#if defined(HOST_WORDS_BIGENDIAN)
+#define VsrB(i) u8[i]
+#define VsrW(i) u32[i]
+#define VsrD(i) u64[i]
+#else
+#define VsrB(i) u8[15 - (i)]
+#define VsrW(i) u32[3 - (i)]
+#define VsrD(i) u64[1 - (i)]
+#endif
+
+static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
+{
+    if (n < 32) {
+        vsr->VsrD(0) = env->fpr[n];
+        vsr->VsrD(1) = env->vsr[n];
+    } else {
+        vsr->u64[0] = env->avr[n - 32].u64[0];
+        vsr->u64[1] = env->avr[n - 32].u64[1];
+    }
+}
+
+static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
+{
+    if (n < 32) {
+        env->fpr[n] = vsr->VsrD(0);
+        env->vsr[n] = vsr->VsrD(1);
+    } else {
+        env->avr[n - 32].u64[0] = vsr->u64[0];
+        env->avr[n - 32].u64[1] = vsr->u64[1];
+    }
+}
+
 #endif /* PPC_INTERNAL_H */
-- 
2.9.3
