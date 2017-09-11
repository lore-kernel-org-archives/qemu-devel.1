Received: from eggs.gnu.org ([2001:4830:134:3::10]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP88-0001iB-Fi
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP87-0002Ew-Ij
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:52:09 +0100
Message-Id: <1505137930-13255-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] target/arm: Add and use defines for EXCRET
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The exception-return magic values get some new bits in v8M, which
makes some bit definitions for them worthwhile.

We don't use the bit definitions for the switch on the low bits
which checks the return type for v7M, because this is defined
in the v7M ARM ARM as a set of valid values rather than via
per-bit checks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 10 ++++++++++
 target/arm/helper.c    | 14 +++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a315354..18be370 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -61,6 +61,16 @@ FIELD(V7M_CONTROL, NPRIV, 0, 1)
 FIELD(V7M_CONTROL, SPSEL, 1, 1)
 FIELD(V7M_CONTROL, FPCA, 2, 1)
 
+/* Bit definitions for v7M exception return payload */
+FIELD(V7M_EXCRET, ES, 0, 1)
+FIELD(V7M_EXCRET, RES0, 1, 1)
+FIELD(V7M_EXCRET, SPSEL, 2, 1)
+FIELD(V7M_EXCRET, MODE, 3, 1)
+FIELD(V7M_EXCRET, FTYPE, 4, 1)
+FIELD(V7M_EXCRET, DCRS, 5, 1)
+FIELD(V7M_EXCRET, S, 6, 1)
+FIELD(V7M_EXCRET, RES1, 7, 25) /* including the must-be-1 prefix */
+
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
  * Note that this mapping and the AArch32 mapping defined in bank_number()
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fdd5cc6..a502e4e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6242,7 +6242,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                   " previous exception %d\n",
                   type, env->v7m.exception);
 
-    if (extract32(type, 5, 23) != extract32(-1, 5, 23)) {
+    if ((type & R_V7M_EXCRET_RES1_MASK) != R_V7M_EXCRET_RES1_MASK) {
         qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero high bits in exception "
                       "exit PC value 0x%" PRIx32 " are UNPREDICTABLE\n", type);
     }
@@ -6255,7 +6255,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          * which security state's faultmask to clear. (v8M ARM ARM R_KBNF.)
          */
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            int es = type & 1;
+            int es = type & R_V7M_EXCRET_ES_MASK;
             if (armv7m_nvic_raw_execution_priority(env->nvic) >= 0) {
                 env->v7m.faultmask[es] = 0;
             }
@@ -6491,12 +6491,16 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         return; /* Never happens.  Keep compiler happy.  */
     }
 
-    lr = 0xfffffff1;
+    lr = R_V7M_EXCRET_RES1_MASK |
+        R_V7M_EXCRET_S_MASK |
+        R_V7M_EXCRET_DCRS_MASK |
+        R_V7M_EXCRET_FTYPE_MASK |
+        R_V7M_EXCRET_ES_MASK;
     if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
-        lr |= 4;
+        lr |= R_V7M_EXCRET_SPSEL_MASK;
     }
     if (!arm_v7m_is_handler_mode(env)) {
-        lr |= 8;
+        lr |= R_V7M_EXCRET_MODE_MASK;
     }
 
     v7m_push_stack(cpu);
-- 
2.7.4
