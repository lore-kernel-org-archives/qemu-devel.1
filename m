Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9AR7-0002XL-Pm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9AR1-0002AX-Rp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:21:21 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 15:21:06 +0100
Message-Id: <20180419142106.9694-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Use v7m_stack_read() for reading
 the frame signature
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

In commit 95695effe8caa552b8f2 we changed the v7M/v8M stack
pop code to use a new v7m_stack_read() function that checks
whether the read should fail due to an MPU or bus abort.
We missed one call though, the one which reads the signature
word for the callee-saved register part of the frame.

Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b14fdab140..2ebd086ef2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6913,7 +6913,6 @@ static bool v7m_push_stack(ARMCPU *cpu)
 static void do_v7m_exception_exit(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
     uint32_t excret;
     uint32_t xpsr;
     bool ufault = false;
@@ -7112,9 +7111,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             ((excret & R_V7M_EXCRET_ES_MASK) == 0 ||
              (excret & R_V7M_EXCRET_DCRS_MASK) == 0)) {
             uint32_t expected_sig = 0xfefa125b;
-            uint32_t actual_sig = ldl_phys(cs->as, frameptr);
+            uint32_t actual_sig;
 
-            if (expected_sig != actual_sig) {
+            pop_ok = v7m_stack_read(cpu, &actual_sig, frameptr, mmu_idx);
+
+            if (pop_ok && expected_sig != actual_sig) {
                 /* Take a SecureFault on the current stack */
                 env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
@@ -7125,7 +7126,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 return;
             }
 
-            pop_ok =
+            pop_ok = pop_ok &&
                 v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
                 v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
                 v7m_stack_read(cpu, &env->regs[5], frameptr + 0xc, mmu_idx) &&
-- 
2.17.0
