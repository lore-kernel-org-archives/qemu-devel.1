Received: from eggs.gnu.org ([2001:4830:134:3::10]:52748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2H-00084l-UZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2G-00052W-Vm
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2G-0004xW-OH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2F-0001oN-Fi
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:15 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:57 +0000
Message-Id: <20180215135702.1340-17-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/21] hw/intc/armv7m_nvic: Implement SCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We were previously making the system control register (SCR)
just RAZ/WI. Although we don't implement the functionality
this register controls, we should at least provide the state,
including the banked state for v8M.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-7-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  7 +++++++
 hw/intc/armv7m_nvic.c | 12 ++++++++----
 target/arm/machine.c  | 12 ++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8938a7c953..bc0638d3fa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -497,6 +497,7 @@ typedef struct CPUARMState {
         uint32_t aircr; /* only holds r/w state if security extn implemented */
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
         uint32_t csselr[M_REG_NUM_BANKS];
+        uint32_t scr[M_REG_NUM_BANKS];
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -1258,6 +1259,12 @@ FIELD(V7M_CCR, STKALIGN, 9, 1)
 FIELD(V7M_CCR, DC, 16, 1)
 FIELD(V7M_CCR, IC, 17, 1)
 
+/* V7M SCR bits */
+FIELD(V7M_SCR, SLEEPONEXIT, 1, 1)
+FIELD(V7M_SCR, SLEEPDEEP, 2, 1)
+FIELD(V7M_SCR, SLEEPDEEPS, 3, 1)
+FIELD(V7M_SCR, SEVONPEND, 4, 1)
+
 /* V7M AIRCR bits */
 FIELD(V7M_AIRCR, VECTRESET, 0, 1)
 FIELD(V7M_AIRCR, VECTCLRACTIVE, 1, 1)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 040f3380ec..ea3b7cce14 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -863,8 +863,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd10: /* System Control.  */
-        /* TODO: Implement SLEEPONEXIT.  */
-        return 0;
+        return cpu->env.v7m.scr[attrs.secure];
     case 0xd14: /* Configuration Control.  */
         /* The BFHFNMIGN bit is the only non-banked bit; we
          * keep it in the non-secure copy of the register.
@@ -1285,8 +1284,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xd10: /* System Control.  */
-        /* TODO: Implement control registers.  */
-        qemu_log_mask(LOG_UNIMP, "NVIC: SCR unimplemented\n");
+        /* We don't implement deep-sleep so these bits are RAZ/WI.
+         * The other bits in the register are banked.
+         * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
+         * is architecturally permitted.
+         */
+        value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
+        cpu->env.v7m.scr[attrs.secure] = value;
         break;
     case 0xd14: /* Configuration Control.  */
         /* Enforce RAZ/WI on reserved and must-RAZ/WI bits */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index cae63c2f98..30fb1454a6 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -226,6 +226,16 @@ static const VMStateDescription vmstate_m_csselr = {
     }
 };
 
+static const VMStateDescription vmstate_m_scr = {
+    .name = "cpu/m/scr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.v7m.scr[M_REG_NS], ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -248,6 +258,7 @@ static const VMStateDescription vmstate_m = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_m_faultmask_primask,
         &vmstate_m_csselr,
+        &vmstate_m_scr,
         NULL
     }
 };
@@ -411,6 +422,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.sau.rnr, ARMCPU),
         VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
         VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
+        VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.16.1
