Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeT-00086A-Nb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeS-00035o-Ov
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:33 +0100
Message-Id: <20181012144235.19646-9-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/10] target/arm: New utility function to
 extract EC from syndrome
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

Create and use a utility function to extract the EC field
from a syndrome, rather than open-coding the shift.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 5 +++++
 target/arm/helper.c    | 4 ++--
 target/arm/kvm64.c     | 2 +-
 target/arm/op_helper.c | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d4b1973efa1..516f9454e9b 100644
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
index b5752d52dd1..0b89804961b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8333,7 +8333,7 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     uint32_t moe;
 
     /* If this is a debug exception we must update the DBGDSCR.MOE bits */
-    switch (env->exception.syndrome >> ARM_EL_EC_SHIFT) {
+    switch (syn_get_ec(env->exception.syndrome)) {
     case EC_BREAKPOINT:
     case EC_BREAKPOINT_SAME_EL:
         moe = 1;
@@ -8669,7 +8669,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
         qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
-                      env->exception.syndrome >> ARM_EL_EC_SHIFT,
+                      syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e0b82462838..ce33cbc65a6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -920,7 +920,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 {
-    int hsr_ec = debug_exit->hsr >> ARM_EL_EC_SHIFT;
+    int hsr_ec = syn_get_ec(debug_exit->hsr);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index fb15a13e6c9..b1e65f43d38 100644
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
2.19.0
