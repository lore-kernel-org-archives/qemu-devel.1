Received: from eggs.gnu.org ([209.51.188.92]:53984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLI-00080r-1n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLF-0004r7-S2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLD-0004pD-Tn
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id q1so7705326wrp.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:58 +0000
Message-Id: <20190214190603.25030-23-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/27] target/arm: Split out flags setting from
 vfp compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Minimize the code within a macro by splitting out a helper function.
Use deposit32 instead of manual bit manipulation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-9-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8eedce113c1..28e45f0f0ba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12871,31 +12871,40 @@ float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
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
2.20.1
