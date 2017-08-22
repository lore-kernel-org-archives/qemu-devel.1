Received: from eggs.gnu.org ([2001:4830:134:3::10]:53555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnw-0006dP-6K
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAns-0003JR-La
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:20 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:56 +0100
Message-Id: <1503414539-28762-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 17/20] target/arm: Make MMFAR banked for v8M
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

Make the MMFAR register banked if v8M security extensions are
enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 2 +-
 hw/intc/armv7m_nvic.c | 4 ++--
 target/arm/helper.c   | 4 ++--
 target/arm/machine.c  | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 25ebf9e..21c68d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -427,7 +427,7 @@ typedef struct CPUARMState {
         uint32_t cfsr; /* Configurable Fault Status */
         uint32_t hfsr; /* HardFault Status */
         uint32_t dfsr; /* Debug Fault Status Register */
-        uint32_t mmfar; /* MemManage Fault Address */
+        uint32_t mmfar[2]; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
         unsigned mpu_ctrl[2]; /* MPU_CTRL */
         int exception;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index f071649..99b62ac 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -506,7 +506,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd30: /* Debug Fault Status.  */
         return cpu->env.v7m.dfsr;
     case 0xd34: /* MMFAR MemManage Fault Address */
-        return cpu->env.v7m.mmfar;
+        return cpu->env.v7m.mmfar[attrs.secure];
     case 0xd38: /* Bus Fault Address.  */
         return cpu->env.v7m.bfar;
     case 0xd3c: /* Aux Fault Status.  */
@@ -723,7 +723,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         cpu->env.v7m.dfsr &= ~value; /* W1C */
         break;
     case 0xd34: /* Mem Manage Address.  */
-        cpu->env.v7m.mmfar = value;
+        cpu->env.v7m.mmfar[attrs.secure] = value;
         return;
     case 0xd38: /* Bus Fault Address.  */
         cpu->env.v7m.bfar = value;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 28b3d6c..e587e85 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6380,10 +6380,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             case EXCP_DATA_ABORT:
                 env->v7m.cfsr |=
                     (R_V7M_CFSR_DACCVIOL_MASK | R_V7M_CFSR_MMARVALID_MASK);
-                env->v7m.mmfar = env->exception.vaddress;
+                env->v7m.mmfar[env->v7m.secure] = env->exception.vaddress;
                 qemu_log_mask(CPU_LOG_INT,
                               "...with CFSR.DACCVIOL and MMFAR 0x%x\n",
-                              env->v7m.mmfar);
+                              env->v7m.mmfar[env->v7m.secure]);
                 break;
             }
             armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 4457ec6..5122e58 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -121,7 +121,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.hfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
-        VMSTATE_UINT32(env.v7m.mmfar, ARMCPU),
+        VMSTATE_UINT32(env.v7m.mmfar[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.bfar, ARMCPU),
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_NS], ARMCPU),
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
@@ -272,6 +272,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
