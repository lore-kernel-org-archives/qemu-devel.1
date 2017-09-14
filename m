Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJc-00088Z-GZ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJb-00083Z-Do
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJb-0007x0-5h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJN-0005nI-TW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:37 +0100
Message-Id: <1505411573-27848-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/18] target/arm: Clear exclusive monitor on
 v7M reset, exception entry/exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M profile we must clear the exclusive monitor on reset, exception
entry and exception exit.  We weren't doing any of these things; fix
this bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505137930-13255-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/internals.h | 10 ++++++++++
 target/arm/cpu.c       |  6 ++++++
 target/arm/helper.c    |  2 ++
 target/arm/op_helper.c |  2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5d7f24c..a315354 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -444,6 +444,16 @@ void arm_handle_psci_call(ARMCPU *cpu);
 #endif
 
 /**
+ * arm_clear_exclusive: clear the exclusive monitor
+ * @env: CPU env
+ * Clear the CPU's exclusive monitor, like the guest CLREX instruction.
+ */
+static inline void arm_clear_exclusive(CPUARMState *env)
+{
+    env->exclusive_addr = -1;
+}
+
+/**
  * ARMMMUFaultInfo: Information describing an ARM MMU Fault
  * @s2addr: Address that caused a fault at stage 2
  * @stage2: True if we faulted at stage 2
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a1acce3..412e94c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -235,6 +235,12 @@ static void arm_cpu_reset(CPUState *s)
         env->regs[15] = 0xFFFF0000;
     }
 
+    /* M profile requires that reset clears the exclusive monitor;
+     * A profile does not, but clearing it makes more sense than having it
+     * set with an exclusive access on address zero.
+     */
+    arm_clear_exclusive(env);
+
     env->vfp.xregs[ARM_VFP_FPEXC] = 0;
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 329e517..668e367 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6175,6 +6175,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr)
 
     armv7m_nvic_acknowledge_irq(env->nvic);
     switch_v7m_sp(env, 0);
+    arm_clear_exclusive(env);
     /* Clear IT bits */
     env->condexec_bits = 0;
     env->regs[14] = lr;
@@ -6354,6 +6355,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
 
     /* Otherwise, we have a successful exception exit. */
+    arm_clear_exclusive(env);
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index d1bca46..6a60464 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1022,7 +1022,7 @@ void HELPER(exception_return)(CPUARMState *env)
 
     aarch64_save_sp(env, cur_el);
 
-    env->exclusive_addr = -1;
+    arm_clear_exclusive(env);
 
     /* We must squash the PSTATE.SS bit to zero unless both of the
      * following hold:
-- 
2.7.4
