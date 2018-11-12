Received: from eggs.gnu.org ([2001:4830:134:3::10]:60566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhq-00041G-9k
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhp-0000ew-8E
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFho-0008MG-Sl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhP-0005t7-2b
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:11 +0000
Message-Id: <20181112170816.500-12-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/16] arm: fix aa64_generate_debug_exceptions
 to work with EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

The test was incomplete and incorrectly caused debug exceptions to be
generated when returning to EL2 after a failed attempt to single-step
an EL1 instruction. Fix this while cleaning up the function a little.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181109152119.9242-8-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1efff21a18d..814ff69bc22 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2764,23 +2764,35 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
     return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
 }
 
+/* See AArch64.GenerateDebugExceptionsFrom() in ARM ARM pseudocode */
 static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
 {
-    if (arm_is_secure(env)) {
-        /* MDCR_EL3.SDD disables debug events from Secure state */
-        if (extract32(env->cp15.mdcr_el3, 16, 1) != 0
-            || arm_current_el(env) == 3) {
-            return false;
-        }
+    int cur_el = arm_current_el(env);
+    int debug_el;
+
+    if (cur_el == 3) {
+        return false;
     }
 
-    if (arm_current_el(env) == arm_debug_target_el(env)) {
-        if ((extract32(env->cp15.mdscr_el1, 13, 1) == 0)
-            || (env->daif & PSTATE_D)) {
-            return false;
-        }
+    /* MDCR_EL3.SDD disables debug events from Secure state */
+    if (arm_is_secure_below_el3(env)
+        && extract32(env->cp15.mdcr_el3, 16, 1)) {
+        return false;
     }
-    return true;
+
+    /*
+     * Same EL to same EL debug exceptions need MDSCR_KDE enabled
+     * while not masking the (D)ebug bit in DAIF.
+     */
+    debug_el = arm_debug_target_el(env);
+
+    if (cur_el == debug_el) {
+        return extract32(env->cp15.mdscr_el1, 13, 1)
+            && !(env->daif & PSTATE_D);
+    }
+
+    /* Otherwise the debug target needs to be a higher EL */
+    return debug_el > cur_el;
 }
 
 static inline bool aa32_generate_debug_exceptions(CPUARMState *env)
@@ -2833,9 +2845,6 @@ static inline bool aa32_generate_debug_exceptions(CPUARMState *env)
  * since the pseudocode has it at all callsites except for the one in
  * CheckSoftwareStep(), where it is elided because both branches would
  * always return the same value.
- *
- * Parts of the pseudocode relating to EL2 and EL3 are omitted because we
- * don't yet implement those exception levels or their associated trap bits.
  */
 static inline bool arm_generate_debug_exceptions(CPUARMState *env)
 {
-- 
2.19.1
