Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1h-000487-N1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1g-0007kE-O3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1g-0007eF-GA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1f-0002wg-9d
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:38 +0100
Message-Id: <1507305585-20608-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/20] target/arm: Update excret sanity checks
 for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In v8M, more bits are defined in the exception-return magic
values; update the code that checks these so we accept
the v8M values when the CPU permits them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-11-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c7cf24c..4aa32d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6285,8 +6285,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     uint32_t excret;
     uint32_t xpsr;
     bool ufault = false;
-    bool return_to_sp_process = false;
-    bool return_to_handler = false;
+    bool sfault = false;
+    bool return_to_sp_process;
+    bool return_to_handler;
     bool rettobase = false;
     bool exc_secure = false;
     bool return_to_secure;
@@ -6320,6 +6321,19 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                       excret);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        /* EXC_RETURN.ES validation check (R_SMFL). We must do this before
+         * we pick which FAULTMASK to clear.
+         */
+        if (!env->v7m.secure &&
+            ((excret & R_V7M_EXCRET_ES_MASK) ||
+             !(excret & R_V7M_EXCRET_DCRS_MASK))) {
+            sfault = 1;
+            /* For all other purposes, treat ES as 0 (R_HXSR) */
+            excret &= ~R_V7M_EXCRET_ES_MASK;
+        }
+    }
+
     if (env->v7m.exception != ARMV7M_EXCP_NMI) {
         /* Auto-clear FAULTMASK on return from other than NMI.
          * If the security extension is implemented then this only
@@ -6357,24 +6371,53 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         g_assert_not_reached();
     }
 
+    return_to_handler = !(excret & R_V7M_EXCRET_MODE_MASK);
+    return_to_sp_process = excret & R_V7M_EXCRET_SPSEL_MASK;
     return_to_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         (excret & R_V7M_EXCRET_S_MASK);
 
-    switch (excret & 0xf) {
-    case 1: /* Return to Handler */
-        return_to_handler = true;
-        break;
-    case 13: /* Return to Thread using Process stack */
-        return_to_sp_process = true;
-        /* fall through */
-    case 9: /* Return to Thread using Main stack */
-        if (!rettobase &&
-            !(env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_NONBASETHRDENA_MASK)) {
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        if (!arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            /* UNPREDICTABLE if S == 1 or DCRS == 0 or ES == 1 (R_XLCP);
+             * we choose to take the UsageFault.
+             */
+            if ((excret & R_V7M_EXCRET_S_MASK) ||
+                (excret & R_V7M_EXCRET_ES_MASK) ||
+                !(excret & R_V7M_EXCRET_DCRS_MASK)) {
+                ufault = true;
+            }
+        }
+        if (excret & R_V7M_EXCRET_RES0_MASK) {
             ufault = true;
         }
-        break;
-    default:
-        ufault = true;
+    } else {
+        /* For v7M we only recognize certain combinations of the low bits */
+        switch (excret & 0xf) {
+        case 1: /* Return to Handler */
+            break;
+        case 13: /* Return to Thread using Process stack */
+        case 9: /* Return to Thread using Main stack */
+            /* We only need to check NONBASETHRDENA for v7M, because in
+             * v8M this bit does not exist (it is RES1).
+             */
+            if (!rettobase &&
+                !(env->v7m.ccr[env->v7m.secure] &
+                  R_V7M_CCR_NONBASETHRDENA_MASK)) {
+                ufault = true;
+            }
+            break;
+        default:
+            ufault = true;
+        }
+    }
+
+    if (sfault) {
+        env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+        v7m_exception_taken(cpu, excret);
+        qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
+                      "stackframe: failed EXC_RETURN.ES validity check\n");
+        return;
     }
 
     if (ufault) {
-- 
2.7.4
