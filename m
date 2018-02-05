Received: from eggs.gnu.org ([2001:4830:134:3::10]:40007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSv-00064Y-3M
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSu-0007E1-6E
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:37 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Feb 2018 10:57:18 +0000
Message-Id: <20180205105720.14620-7-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-1-peter.maydell@linaro.org>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/8] hw/intc/armv7m_nvic: Implement SCR
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

We were previously making the system control register (SCR)
just RAZ/WI. Although we don't implement the functionality
this register controls, we should at least provide the state,
including the banked state for v8M.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  7 +++++++
 hw/intc/armv7m_nvic.c | 12 ++++++++----
 target/arm/machine.c  | 12 ++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 99c7cb996f..46dae607e8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -454,6 +454,7 @@ typedef struct CPUARMState {
         uint32_t aircr; /* only holds r/w state if security extn implemented */
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
         uint32_t csselr[M_REG_NUM_BANKS];
+        uint32_t scr[M_REG_NUM_BANKS];
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -1220,6 +1221,12 @@ FIELD(V7M_CCR, STKALIGN, 9, 1)
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
index cc83c9e553..8726be796e 100644
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
@@ -1282,8 +1281,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
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
index 968ec30b4a..a5feaa9604 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -143,6 +143,16 @@ static const VMStateDescription vmstate_m_csselr = {
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
@@ -165,6 +175,7 @@ static const VMStateDescription vmstate_m = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_m_faultmask_primask,
         &vmstate_m_csselr,
+        &vmstate_m_scr,
         NULL
     }
 };
@@ -328,6 +339,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.sau.rnr, ARMCPU),
         VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
         VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
+        VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.16.1
