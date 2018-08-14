Received: from eggs.gnu.org ([2001:4830:134:3::10]:43857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfJ-0005XT-Go
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfI-0002L9-84
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:52 +0100
Message-Id: <20180814124254.5229-9-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/10] target/arm: Permit accesses to ELR_Hyp
 from Hyp mode via MSR/MRS (banked)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

The MSR (banked) and MRS (banked) instructions allow accesses to ELR_Hyp
from either Monitor or Hyp mode. Our translate time check
was overly strict and only permitted access from Monitor mode.

The runtime check wo do in msr_mrs_banked_exc_checks() had the
correct code in it, but never got there because of the earlier
"currmode == tgtmode" check. Special case ELR_Hyp.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 22 +++++++++++-----------
 target/arm/translate.c | 10 +++++++---
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index d550978b5b9..952b8d122b7 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -611,6 +611,14 @@ static void msr_mrs_banked_exc_checks(CPUARMState *env, uint32_t tgtmode,
      */
     int curmode = env->uncached_cpsr & CPSR_M;
 
+    if (regno == 17) {
+        /* ELR_Hyp: a special case because access from tgtmode is OK */
+        if (curmode != ARM_CPU_MODE_HYP && curmode != ARM_CPU_MODE_MON) {
+            goto undef;
+        }
+        return;
+    }
+
     if (curmode == tgtmode) {
         goto undef;
     }
@@ -638,17 +646,9 @@ static void msr_mrs_banked_exc_checks(CPUARMState *env, uint32_t tgtmode,
     }
 
     if (tgtmode == ARM_CPU_MODE_HYP) {
-        switch (regno) {
-        case 17: /* ELR_Hyp */
-            if (curmode != ARM_CPU_MODE_HYP && curmode != ARM_CPU_MODE_MON) {
-                goto undef;
-            }
-            break;
-        default:
-            if (curmode != ARM_CPU_MODE_MON) {
-                goto undef;
-            }
-            break;
+        /* SPSR_Hyp, r13_hyp: accessible from Monitor mode only */
+        if (curmode != ARM_CPU_MODE_MON) {
+            goto undef;
         }
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f845da7c638..3f5751d4826 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4506,10 +4506,14 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
         }
         break;
     case ARM_CPU_MODE_HYP:
-        /* Note that we can forbid accesses from EL2 here because they
-         * must be from Hyp mode itself
+        /*
+         * SPSR_hyp and r13_hyp can only be accessed from Monitor mode
+         * (and so we can forbid accesses from EL2 or below). elr_hyp
+         * can be accessed also from Hyp mode, so forbid accesses from
+         * EL0 or EL1.
          */
-        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 3) {
+        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 2 ||
+            (s->current_el < 3 && *regno != 17)) {
             goto undef;
         }
         break;
-- 
2.18.0
