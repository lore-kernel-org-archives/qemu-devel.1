Received: from eggs.gnu.org ([2001:4830:134:3::10]:48920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8C-0003cG-Hi
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8B-0005FL-CW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY8B-0002bn-45
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY60-0006jV-JR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:08 +0100
Message-Id: <20181019165735.22511-19-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/45] target/arm: New utility function to
 extract EC from syndrome
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create and use a utility function to extract the EC field
from a syndrome, rather than open-coding the shift.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-9-peter.maydell@linaro.org
---
 target/arm/internals.h | 5 +++++
 target/arm/helper.c    | 4 ++--
 target/arm/kvm64.c     | 2 +-
 target/arm/op_helper.c | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6b204fad51e..bf7bd1fbfe1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -278,6 +278,11 @@ enum arm_exception_class {
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
 
+static inline uint32_t syn_get_ec(uint32_t syn)
+{
+    return syn >> ARM_EL_EC_SHIFT;
+}
+
 /* Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
  * few cases the value in HSR for exceptions taken to AArch32 Hyp
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1928d3fadd9..26872edef75 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8336,7 +8336,7 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     uint32_t moe;
 
     /* If this is a debug exception we must update the DBGDSCR.MOE bits */
-    switch (env->exception.syndrome >> ARM_EL_EC_SHIFT) {
+    switch (syn_get_ec(env->exception.syndrome)) {
     case EC_BREAKPOINT:
     case EC_BREAKPOINT_SAME_EL:
         moe = 1;
@@ -8676,7 +8676,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
         qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
-                      env->exception.syndrome >> ARM_EL_EC_SHIFT,
+                      syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5411486491a..5de8ff0ac57 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -933,7 +933,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 {
-    int hsr_ec = debug_exit->hsr >> ARM_EL_EC_SHIFT;
+    int hsr_ec = syn_get_ec(debug_exit->hsr);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index d9155797126..90741f6331d 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -42,7 +42,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
          * (see DDI0478C.a D1.10.4)
          */
         target_el = 2;
-        if (syndrome >> ARM_EL_EC_SHIFT == EC_ADVSIMDFPACCESSTRAP) {
+        if (syn_get_ec(syndrome) == EC_ADVSIMDFPACCESSTRAP) {
             syndrome = syn_uncategorized();
         }
     }
-- 
2.19.1
