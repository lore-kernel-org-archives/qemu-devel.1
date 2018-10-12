Received: from eggs.gnu.org ([2001:4830:134:3::10]:55418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeT-00086I-Re
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeS-000364-U1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:34 +0100
Message-Id: <20181012144235.19646-10-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/10] target/arm: Get IL bit correct for v7
 syndrome values
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

For the v7 version of the Arm architecture, the IL bit in
syndrome register values where the field is not valid was
defined to be UNK/SBZP. In v8 this is RES1, which is what
QEMU currently implements. Handle the desired v7 behaviour
by squashing the IL bit for the affected cases:
 * EC == EC_UNCATEGORIZED
 * prefetch aborts
 * data aborts where ISV is 0

(The fourth case listed in the v8 Arm ARM DDI 0487C.a in
section G7.2.70, "illegal state exception", can't happen
on a v7 CPU.)

This deals with a corner case noted in a comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  7 ++-----
 target/arm/helper.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 516f9454e9b..cd8bc1ec3d4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -286,11 +286,8 @@ static inline uint32_t syn_get_ec(uint32_t syn)
 /* Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
  * few cases the value in HSR for exceptions taken to AArch32 Hyp
- * mode differs slightly, so if we ever implemented Hyp mode then the
- * syndrome value would need some massaging on exception entry.
- * (One example of this is that AArch64 defaults to IL bit set for
- * exceptions which don't specifically indicate information about the
- * trapping instruction, whereas AArch32 defaults to IL bit clear.)
+ * mode differs slightly, and we fix this up when populating HSR in
+ * arm_cpu_do_interrupt_aarch32_hyp().
  */
 static inline uint32_t syn_uncategorized(void)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b89804961b..0b659171b07 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8299,6 +8299,20 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
     }
 
     if (cs->exception_index != EXCP_IRQ && cs->exception_index != EXCP_FIQ) {
+
+        if (!arm_feature(env, ARM_FEATURE_V8)) {
+            /*
+             * QEMU syndrome values are v8-style. v7 has the IL bit
+             * UNK/SBZP for "field not valid" cases, where v8 uses RES1.
+             * If this is a v7 CPU, squash the IL bit in those cases.
+             */
+            if (cs->exception_index == EXCP_PREFETCH_ABORT ||
+                (cs->exception_index == EXCP_DATA_ABORT &&
+                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
+                env->exception.syndrome &= ~ARM_EL_IL;
+            }
+        }
         env->cp15.esr_el[2] = env->exception.syndrome;
     }
 
-- 
2.19.0
