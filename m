Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8A-0003Yq-Cz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY89-0005Bb-6y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY88-00020Y-Sy
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY61-0006jj-Ew
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:09 +0100
Message-Id: <20181019165735.22511-20-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/45] target/arm: Get IL bit correct for v7
 syndrome values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-10-peter.maydell@linaro.org
---
 target/arm/internals.h |  7 ++-----
 target/arm/helper.c    | 13 +++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index bf7bd1fbfe1..6b9387ba97e 100644
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
index 26872edef75..5db76df758b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8302,6 +8302,19 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
     }
 
     if (cs->exception_index != EXCP_IRQ && cs->exception_index != EXCP_FIQ) {
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
2.19.1
