Received: from eggs.gnu.org ([2001:4830:134:3::10]:56399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr1-0000zk-HW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqv-0007bk-3e
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqu-0007a4-RD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqt-0001cQ-Qq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:11 +0100
Message-Id: <1504790904-17018-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/31] target/arm: Make VTOR register banked for
 v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the VTOR register banked if v8M security extensions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-12-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  2 +-
 hw/intc/armv7m_nvic.c | 13 +++++++------
 target/arm/helper.c   |  2 +-
 target/arm/machine.c  |  3 ++-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1d9eb36..cf2331d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -420,7 +420,7 @@ typedef struct CPUARMState {
 
     struct {
         uint32_t other_sp;
-        uint32_t vecbase;
+        uint32_t vecbase[2];
         uint32_t basepri[2];
         uint32_t control[2];
         uint32_t ccr; /* Configuration and Control */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 2b0b328..3a1f02d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -403,7 +403,7 @@ static void set_irq_level(void *opaque, int n, int level)
     }
 }
 
-static uint32_t nvic_readl(NVICState *s, uint32_t offset)
+static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
 {
     ARMCPU *cpu = s->cpu;
     uint32_t val;
@@ -441,7 +441,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
         /* ISRPREEMPT not implemented */
         return val;
     case 0xd08: /* Vector Table Offset.  */
-        return cpu->env.v7m.vecbase;
+        return cpu->env.v7m.vecbase[attrs.secure];
     case 0xd0c: /* Application Interrupt/Reset Control.  */
         return 0xfa050000 | (s->prigroup << 8);
     case 0xd10: /* System Control.  */
@@ -617,7 +617,8 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
     }
 }
 
-static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
+static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
+                        MemTxAttrs attrs)
 {
     ARMCPU *cpu = s->cpu;
 
@@ -638,7 +639,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
         }
         break;
     case 0xd08: /* Vector Table Offset.  */
-        cpu->env.v7m.vecbase = value & 0xffffff80;
+        cpu->env.v7m.vecbase[attrs.secure] = value & 0xffffff80;
         break;
     case 0xd0c: /* Application Interrupt/Reset Control.  */
         if ((value >> 16) == 0x05fa) {
@@ -944,7 +945,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         break;
     default:
         if (size == 4) {
-            val = nvic_readl(s, offset);
+            val = nvic_readl(s, offset, attrs);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "NVIC: Bad read of size %d at offset 0x%x\n",
@@ -1025,7 +1026,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         return MEMTX_OK;
     }
     if (size == 4) {
-        nvic_writel(s, offset, value);
+        nvic_writel(s, offset, value, attrs);
         return MEMTX_OK;
     }
     qemu_log_mask(LOG_GUEST_ERROR,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index aa64596..4685d50 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6067,7 +6067,7 @@ static uint32_t arm_v7m_load_vector(ARMCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
     MemTxResult result;
-    hwaddr vec = env->v7m.vecbase + env->v7m.exception * 4;
+    hwaddr vec = env->v7m.vecbase[env->v7m.secure] + env->v7m.exception * 4;
     uint32_t addr;
 
     addr = address_space_ldl(cs->as, vec,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 5e379ed..923f259 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -114,7 +114,7 @@ static const VMStateDescription vmstate_m = {
     .minimum_version_id = 4,
     .needed = m_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
+        VMSTATE_UINT32(env.v7m.vecbase[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr, ARMCPU),
@@ -254,6 +254,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.primask[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.faultmask[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.vecbase[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
