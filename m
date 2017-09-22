Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQc-00080z-7f
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQb-0004Ax-8U
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:56 +0100
Message-Id: <1506092407-26985-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/20] target/arm: Add new-in-v8M SFSR and SFAR
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

Add the new M profile Secure Fault Status Register
and Secure Fault Address Register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 12 ++++++++++++
 hw/intc/armv7m_nvic.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/machine.c  |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ad6eff4..9e3a16d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -443,8 +443,10 @@ typedef struct CPUARMState {
         uint32_t cfsr[M_REG_NUM_BANKS]; /* Configurable Fault Status */
         uint32_t hfsr; /* HardFault Status */
         uint32_t dfsr; /* Debug Fault Status Register */
+        uint32_t sfsr; /* Secure Fault Status Register */
         uint32_t mmfar[M_REG_NUM_BANKS]; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
+        uint32_t sfar; /* Secure Fault Address Register */
         unsigned mpu_ctrl[M_REG_NUM_BANKS]; /* MPU_CTRL */
         int exception;
         uint32_t primask[M_REG_NUM_BANKS];
@@ -1260,6 +1262,16 @@ FIELD(V7M_DFSR, DWTTRAP, 2, 1)
 FIELD(V7M_DFSR, VCATCH, 3, 1)
 FIELD(V7M_DFSR, EXTERNAL, 4, 1)
 
+/* V7M SFSR bits */
+FIELD(V7M_SFSR, INVEP, 0, 1)
+FIELD(V7M_SFSR, INVIS, 1, 1)
+FIELD(V7M_SFSR, INVER, 2, 1)
+FIELD(V7M_SFSR, AUVIOL, 3, 1)
+FIELD(V7M_SFSR, INVTRAN, 4, 1)
+FIELD(V7M_SFSR, LSPERR, 5, 1)
+FIELD(V7M_SFSR, SFARVALID, 6, 1)
+FIELD(V7M_SFSR, LSERR, 7, 1)
+
 /* v7M MPU_CTRL bits */
 FIELD(V7M_MPU_CTRL, ENABLE, 0, 1)
 FIELD(V7M_MPU_CTRL, HFNMIENA, 1, 1)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a1041c2..deea637 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1017,6 +1017,22 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             goto bad_offset;
         }
         return cpu->env.pmsav8.mair1[attrs.secure];
+    case 0xde4: /* SFSR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        return cpu->env.v7m.sfsr;
+    case 0xde8: /* SFAR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return 0;
+        }
+        return cpu->env.v7m.sfar;
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
@@ -1368,6 +1384,24 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
          * only affect cacheability, and we don't implement caching.
          */
         break;
+    case 0xde4: /* SFSR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        cpu->env.v7m.sfsr &= ~value; /* W1C */
+        break;
+    case 0xde8: /* SFAR */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+            goto bad_offset;
+        }
+        if (!attrs.secure) {
+            return;
+        }
+        cpu->env.v7m.sfsr = value;
+        break;
     case 0xf00: /* Software Triggered Interrupt Register */
     {
         int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e5fe083..d4b3baf 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -276,6 +276,8 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.cfsr[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.sfsr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.sfar, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
