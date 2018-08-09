Received: from eggs.gnu.org ([2001:4830:134:3::10]:53988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSn-0000jl-Nz
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSm-0007BU-S5
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSm-0007AK-ML
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id k21-v6so2183463pff.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:51 -0700
Message-Id: <20180809042206.15726-6-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/20] target/arm: Fix
 arm_cpu_data_is_big_endian for aa64 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Unlike aa32, endianness cannot be adjusted by userland in aa64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9526ed27cb..2d6d7d03aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2709,8 +2709,6 @@ static inline bool arm_sctlr_b(CPUARMState *env)
 /* Return true if the processor is in big-endian mode. */
 static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 {
-    int cur_el;
-
     /* In 32bit endianness is determined by looking at CPSR's E bit */
     if (!is_a64(env)) {
         return
@@ -2729,15 +2727,24 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
             arm_sctlr_b(env) ||
 #endif
                 ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
+    } else {
+#ifdef CONFIG_USER_ONLY
+        /* AArch64 does not have a SETEND instruction; endianness
+         * for usermode is fixed at compile-time.
+         */
+# ifdef TARGET_WORDS_BIGENDIAN
+        return true;
+# else
+        return false;
+# endif
+#else
+        int cur_el = arm_current_el(env);
+        if (cur_el == 0) {
+            return (env->cp15.sctlr_el[1] & SCTLR_E0E) != 0;
+        }
+        return (env->cp15.sctlr_el[cur_el] & SCTLR_EE) != 0;
+#endif
     }
-
-    cur_el = arm_current_el(env);
-
-    if (cur_el == 0) {
-        return (env->cp15.sctlr_el[1] & SCTLR_E0E) != 0;
-    }
-
-    return (env->cp15.sctlr_el[cur_el] & SCTLR_EE) != 0;
 }
 
 #include "exec/cpu-all.h"
-- 
2.17.1
