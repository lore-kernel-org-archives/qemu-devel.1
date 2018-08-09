Received: from eggs.gnu.org ([2001:4830:134:3::10]:53976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSm-0000im-Im
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSl-00079t-Id
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSl-00079K-BP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:15 -0400
Received: by mail-pf1-x42f.google.com with SMTP id a26-v6so2199430pfo.4
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:50 -0700
Message-Id: <20180809042206.15726-5-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/20] target/arm: Adjust sve_exception_el
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

Check for EL3 before testing CPTR_EL3.EZ.  Return 0 when the exception
should be routed via AdvSIMDFPAccessTrap.  Mirror the structure of
CheckSVEEnabled more closely.

Fixes: 5be5e8eda78
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 96 ++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 61a79e4c44..26e9098c5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4338,67 +4338,63 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
-/* Return the exception level to which SVE-disabled exceptions should
- * be taken, or 0 if SVE is enabled.
+/* Return the exception level to which exceptions should be taken
+ * via SVEAccessTrap.  If an exception should be routed through
+ * AArch64.AdvSIMDFPAccessTrap, return 0; fp_exception_el should
+ * take care of raising that exception.
+ * C.f. the ARM pseudocode function CheckSVEEnabled.
  */
 static int sve_exception_el(CPUARMState *env)
 {
 #ifndef CONFIG_USER_ONLY
     unsigned current_el = arm_current_el(env);
 
-    /* The CPACR.ZEN controls traps to EL1:
-     * 0, 2 : trap EL0 and EL1 accesses
-     * 1    : trap only EL0 accesses
-     * 3    : trap no accesses
+    if (current_el <= 1) {
+        bool disabled = false;
+
+        /* The CPACR.ZEN controls traps to EL1:
+         * 0, 2 : trap EL0 and EL1 accesses
+         * 1    : trap only EL0 accesses
+         * 3    : trap no accesses
+         */
+        if (!extract32(env->cp15.cpacr_el1, 16, 1)) {
+            disabled = true;
+        } else if (!extract32(env->cp15.cpacr_el1, 17, 1)) {
+            disabled = current_el == 0;
+        }
+        if (disabled) {
+            /* route_to_el2 */
+            return (arm_feature(env, ARM_FEATURE_EL2)
+                    && !arm_is_secure(env)
+                    && (env->cp15.hcr_el2 & HCR_TGE) ? 2 : 1);
+        }
+
+        /* Check CPACR.FPEN.  */
+        if (!extract32(env->cp15.cpacr_el1, 20, 1)) {
+            disabled = true;
+        } else if (!extract32(env->cp15.cpacr_el1, 21, 1)) {
+            disabled = current_el == 0;
+        }
+        if (disabled) {
+            return 0;
+        }
+    }
+
+    /* CPTR_EL2.  Since TZ and TFP are positive,
+     * they will be zero when EL2 is not present.
      */
-    switch (extract32(env->cp15.cpacr_el1, 16, 2)) {
-    default:
-        if (current_el <= 1) {
-            /* Trap to PL1, which might be EL1 or EL3 */
-            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
-                return 3;
-            }
-            return 1;
+    if (current_el <= 2 && !arm_is_secure_below_el3(env)) {
+        if (env->cp15.cptr_el[2] & CPTR_TZ) {
+            return 2;
         }
-        break;
-    case 1:
-        if (current_el == 0) {
-            return 1;
+        if (env->cp15.cptr_el[2] & CPTR_TFP) {
+            return 0;
         }
-        break;
-    case 3:
-        break;
     }
 
-    /* Similarly for CPACR.FPEN, after having checked ZEN.  */
-    switch (extract32(env->cp15.cpacr_el1, 20, 2)) {
-    default:
-        if (current_el <= 1) {
-            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
-                return 3;
-            }
-            return 1;
-        }
-        break;
-    case 1:
-        if (current_el == 0) {
-            return 1;
-        }
-        break;
-    case 3:
-        break;
-    }
-
-    /* CPTR_EL2.  Check both TZ and TFP.  */
-    if (current_el <= 2
-        && (env->cp15.cptr_el[2] & (CPTR_TFP | CPTR_TZ))
-        && !arm_is_secure_below_el3(env)) {
-        return 2;
-    }
-
-    /* CPTR_EL3.  Check both EZ and TFP.  */
-    if (!(env->cp15.cptr_el[3] & CPTR_EZ)
-        || (env->cp15.cptr_el[3] & CPTR_TFP)) {
+    /* CPTR_EL3.  Since EZ is negative we must check for EL3.  */
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.cptr_el[3] & CPTR_EZ)) {
         return 3;
     }
 #endif
-- 
2.17.1
