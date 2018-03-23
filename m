Received: from eggs.gnu.org ([2001:4830:134:3::10]:49178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlR-00019N-C7
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlO-0004Gn-HZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlO-0004FG-9u
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlM-0007gs-Va
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:56 +0000
Message-Id: <20180323184958.14252-9-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/10] target/arm: Factor out code to calculate
 FSR for debug exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When a debug exception is taken to AArch32, it appears as a Prefetch
Abort, and the Instruction Fault Status Register (IFSR) must be set.
The IFSR has two possible formats, depending on whether LPAE is in
use. Factor out the code in arm_debug_excp_handler() which picks
an FSR value into its own utility function, update it to use
arm_fi_to_lfsc() and arm_fi_to_sfsc() rather than hard-coded constants,
and use the correct condition to select long or short format.

In particular this fixes a bug where we could select the short
format because we're at EL0 and the EL1 translation regime is
not using LPAE, but then route the debug exception to EL2 because
of MDCR_EL2.TDE and hand EL2 the wrong format FSR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180320134114.30418-3-peter.maydell@linaro.org
---
 target/arm/internals.h | 25 +++++++++++++++++++++++++
 target/arm/op_helper.c | 12 ++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 47cc224a46..8ce944b7a0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -763,4 +763,29 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the FSR value for a debug exception (watchpoint, hardware
+ * breakpoint or BKPT insn) targeting the specified exception level.
+ */
+static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
+{
+    ARMMMUFaultInfo fi = { .type = ARMFault_Debug };
+    int target_el = arm_debug_target_el(env);
+    bool using_lpae = false;
+
+    if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
+        using_lpae = true;
+    } else {
+        if (arm_feature(env, ARM_FEATURE_LPAE) &&
+            (env->cp15.tcr_el[target_el].raw_tcr & TTBCR_EAE)) {
+            using_lpae = true;
+        }
+    }
+
+    if (using_lpae) {
+        return arm_fi_to_lfsc(&fi);
+    } else {
+        return arm_fi_to_sfsc(&fi);
+    }
+}
+
 #endif
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 4b123d2bd6..75efff9edf 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1330,11 +1330,7 @@ void arm_debug_excp_handler(CPUState *cs)
 
             cs->watchpoint_hit = NULL;
 
-            if (extended_addresses_enabled(env)) {
-                env->exception.fsr = (1 << 9) | 0x22;
-            } else {
-                env->exception.fsr = 0x2;
-            }
+            env->exception.fsr = arm_debug_exception_fsr(env);
             env->exception.vaddress = wp_hit->hitaddr;
             raise_exception(env, EXCP_DATA_ABORT,
                     syn_watchpoint(same_el, 0, wnr),
@@ -1354,11 +1350,7 @@ void arm_debug_excp_handler(CPUState *cs)
             return;
         }
 
-        if (extended_addresses_enabled(env)) {
-            env->exception.fsr = (1 << 9) | 0x22;
-        } else {
-            env->exception.fsr = 0x2;
-        }
+        env->exception.fsr = arm_debug_exception_fsr(env);
         /* FAR is UNKNOWN, so doesn't need setting */
         raise_exception(env, EXCP_PREFETCH_ABORT,
                         syn_breakpoint(same_el),
-- 
2.16.2
