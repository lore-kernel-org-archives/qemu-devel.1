Received: from eggs.gnu.org ([209.51.188.92]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJU4-00070F-Sn
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTz-0000Ye-VT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:13 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:36140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTv-0000VU-VT
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:09 -0500
Received: by mail-pl1-x636.google.com with SMTP id g9so2612842plo.3
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:43 -0800
Message-Id: <20190209033847.9014-9-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 08/12] target/arm: Split out flags setting
 from vfp compares
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

Minimize the code within a macro by splitting out a helper function.
Use deposit32 instead of manual bit manipulation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6ac81c2ca2..51be3fa16f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12752,31 +12752,40 @@ float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
     return float64_sqrt(a, &env->vfp.fp_status);
 }
 
+static void softfloat_to_vfp_compare(CPUARMState *env, int cmp)
+{
+    uint32_t flags;
+    switch (cmp) {
+    case float_relation_equal:
+        flags = 0x6;
+        break;
+    case float_relation_less:
+        flags = 0x8;
+        break;
+    case float_relation_greater:
+        flags = 0x2;
+        break;
+    case float_relation_unordered:
+        flags = 0x3;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    env->vfp.xregs[ARM_VFP_FPSCR] =
+        deposit32(env->vfp.xregs[ARM_VFP_FPSCR], 28, 4, flags);
+}
+
 /* XXX: check quiet/signaling case */
 #define DO_VFP_cmp(p, type) \
 void VFP_HELPER(cmp, p)(type a, type b, CPUARMState *env)  \
 { \
-    uint32_t flags; \
-    switch(type ## _compare_quiet(a, b, &env->vfp.fp_status)) { \
-    case 0: flags = 0x6; break; \
-    case -1: flags = 0x8; break; \
-    case 1: flags = 0x2; break; \
-    default: case 2: flags = 0x3; break; \
-    } \
-    env->vfp.xregs[ARM_VFP_FPSCR] = (flags << 28) \
-        | (env->vfp.xregs[ARM_VFP_FPSCR] & 0x0fffffff); \
+    softfloat_to_vfp_compare(env, \
+        type ## _compare_quiet(a, b, &env->vfp.fp_status)); \
 } \
 void VFP_HELPER(cmpe, p)(type a, type b, CPUARMState *env) \
 { \
-    uint32_t flags; \
-    switch(type ## _compare(a, b, &env->vfp.fp_status)) { \
-    case 0: flags = 0x6; break; \
-    case -1: flags = 0x8; break; \
-    case 1: flags = 0x2; break; \
-    default: case 2: flags = 0x3; break; \
-    } \
-    env->vfp.xregs[ARM_VFP_FPSCR] = (flags << 28) \
-        | (env->vfp.xregs[ARM_VFP_FPSCR] & 0x0fffffff); \
+    softfloat_to_vfp_compare(env, \
+        type ## _compare(a, b, &env->vfp.fp_status)); \
 }
 DO_VFP_cmp(s, float32)
 DO_VFP_cmp(d, float64)
-- 
2.17.2
