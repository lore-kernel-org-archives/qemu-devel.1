Received: from eggs.gnu.org ([2001:4830:134:3::10]:47387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0000wK-Bf
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-00058F-P9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPn-00055o-Hh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPm-0003Eo-Kn
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:10 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:50 +0000
Message-Id: <1484834995-26826-32-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 31/36] hw/intc/arm_gicv3: Implement EL2 traps
 for CPU i/f regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the architecturally required traps from NS EL1
to EL2 for the CPU interface registers. These fall into
several different groups:
 * group-0-only registers all trap if ICH_HRC_EL2.TALL0 is set
   (exactly the registers covered by gicv3_fiq_access())
 * group-1-only registers all trap if ICH_HRC_EL2.TALL1 is set
   (exactly the registers covered by gicv3_irq_access())
 * DIR traps if ICH_HCR_EL2.TC or ICH_HCR_EL2.TDIR are set
 * PMR, RPR, CTLR trap if ICH_HCR_EL2.TC is set
 * SGI0R, SGI1R, ASGI1R trap if ICH_HCR_EL2.TC is set or
   if HCR_EL2.IMO or HCR_EL2.FMO are set

We split DIR and the SGI registers out into their own access
functions, leaving the existing gicv3_irqfiq_access() just
handling PMR, RPR and CTLR.

This commit doesn't implement support for trapping on
HSTR_EL2.T12 for the 32-bit registers, as we don't implement
any of those per-coprocessor trap bits currently and
probably will want to do those in some more centralized way.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-14-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 70 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e05f6b3..a9ee7fd 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1833,9 +1833,17 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri, bool isread)
 {
     CPAccessResult r = CP_ACCESS_OK;
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int el = arm_current_el(env);
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_TC) &&
+        el == 1 && !arm_is_secure_below_el3(env)) {
+        /* Takes priority over a possible EL3 trap */
+        return CP_ACCESS_TRAP_EL2;
+    }
 
     if ((env->cp15.scr_el3 & (SCR_FIQ | SCR_IRQ)) == (SCR_FIQ | SCR_IRQ)) {
-        switch (arm_current_el(env)) {
+        switch (el) {
         case 1:
             if (arm_is_secure_below_el3(env) ||
                 ((env->cp15.hcr_el2 & (HCR_IMO | HCR_FMO)) == 0)) {
@@ -1861,13 +1869,47 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
     return r;
 }
 
+static CPAccessResult gicv3_dir_access(CPUARMState *env,
+                                       const ARMCPRegInfo *ri, bool isread)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_TDIR) &&
+        arm_current_el(env) == 1 && !arm_is_secure_below_el3(env)) {
+        /* Takes priority over a possible EL3 trap */
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return gicv3_irqfiq_access(env, ri, isread);
+}
+
+static CPAccessResult gicv3_sgi_access(CPUARMState *env,
+                                       const ARMCPRegInfo *ri, bool isread)
+{
+    if ((env->cp15.hcr_el2 & (HCR_IMO | HCR_FMO)) &&
+        arm_current_el(env) == 1 && !arm_is_secure_below_el3(env)) {
+        /* Takes priority over a possible EL3 trap */
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return gicv3_irqfiq_access(env, ri, isread);
+}
+
 static CPAccessResult gicv3_fiq_access(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
     CPAccessResult r = CP_ACCESS_OK;
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int el = arm_current_el(env);
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_TALL0) &&
+        el == 1 && !arm_is_secure_below_el3(env)) {
+        /* Takes priority over a possible EL3 trap */
+        return CP_ACCESS_TRAP_EL2;
+    }
 
     if (env->cp15.scr_el3 & SCR_FIQ) {
-        switch (arm_current_el(env)) {
+        switch (el) {
         case 1:
             if (arm_is_secure_below_el3(env) ||
                 ((env->cp15.hcr_el2 & HCR_FMO) == 0)) {
@@ -1897,9 +1939,17 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
     CPAccessResult r = CP_ACCESS_OK;
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int el = arm_current_el(env);
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_TALL1) &&
+        el == 1 && !arm_is_secure_below_el3(env)) {
+        /* Takes priority over a possible EL3 trap */
+        return CP_ACCESS_TRAP_EL2;
+    }
 
     if (env->cp15.scr_el3 & SCR_IRQ) {
-        switch (arm_current_el(env)) {
+        switch (el) {
         case 1:
             if (arm_is_secure_below_el3(env) ||
                 ((env->cp15.hcr_el2 & HCR_IMO) == 0)) {
@@ -2055,7 +2105,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
     { .name = "ICC_DIR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 11, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_dir_access,
       .writefn = icc_dir_write,
     },
     { .name = "ICC_RPR_EL1", .state = ARM_CP_STATE_BOTH,
@@ -2067,37 +2117,37 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
     { .name = "ICC_SGI1R_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 11, .opc2 = 5,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_sgi1r_write,
     },
     { .name = "ICC_SGI1R",
       .cp = 15, .opc1 = 0, .crm = 12,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_sgi1r_write,
     },
     { .name = "ICC_ASGI1R_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 11, .opc2 = 6,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_asgi1r_write,
     },
     { .name = "ICC_ASGI1R",
       .cp = 15, .opc1 = 1, .crm = 12,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_asgi1r_write,
     },
     { .name = "ICC_SGI0R_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 11, .opc2 = 7,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_sgi0r_write,
     },
     { .name = "ICC_SGI0R",
       .cp = 15, .opc1 = 2, .crm = 12,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_NO_RAW,
-      .access = PL1_W, .accessfn = gicv3_irqfiq_access,
+      .access = PL1_W, .accessfn = gicv3_sgi_access,
       .writefn = icc_sgi0r_write,
     },
     { .name = "ICC_IAR1_EL1", .state = ARM_CP_STATE_BOTH,
-- 
2.7.4
