Received: from eggs.gnu.org ([2001:4830:134:3::10]:35680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtac-0002vA-9I
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtab-0001V6-9Q
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtab-0001Uk-1n
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaa-0003yv-6y
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:17 +0000
Message-Id: <1482852077-19397-26-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/25] target-arm: Add VBAR support to ARM1176
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

ARM1176 CPUs have TrustZone support and can use the Vector Base
Address Register, but currently, qemu only adds VBAR support to ARMv7
CPUs. Fix this by adding a new feature ARM_FEATURE_VBAR which can used
for ARMv7 and ARM1176 CPUs.

The VBAR feature is always set for ARMv7 because some legacy boards
require it even if this is not architecturally correct.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1481810970-9692-1-git-send-email-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/cpu.c    |  9 +++++++++
 target/arm/helper.c | 19 +++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ca5c849..ab119e6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1125,6 +1125,7 @@ enum arm_features {
     ARM_FEATURE_V8_PMULL, /* implements PMULL part of v8 Crypto Extensions */
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
+    ARM_FEATURE_VBAR, /* has cp15 VBAR */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 98e2c68..f5cb30a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -597,6 +597,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         } else {
             set_feature(env, ARM_FEATURE_V6);
         }
+
+        /* Always define VBAR for V7 CPUs even if it doesn't exist in
+         * non-EL3 configs. This is needed by some legacy boards.
+         */
+        set_feature(env, ARM_FEATURE_VBAR);
     }
     if (arm_feature(env, ARM_FEATURE_V6K)) {
         set_feature(env, ARM_FEATURE_V6);
@@ -721,6 +726,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        set_feature(env, ARM_FEATURE_VBAR);
+    }
+
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b5b65ca..8dcabbf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1252,12 +1252,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write },
-    { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
-      .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .writefn = vbar_write,
-      .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
-                             offsetof(CPUARMState, cp15.vbar_ns) },
-      .resetvalue = 0 },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_R, .readfn = ccsidr_read, .type = ARM_CP_NO_RAW },
@@ -5094,6 +5088,19 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
 
+    if (arm_feature(env, ARM_FEATURE_VBAR)) {
+        ARMCPRegInfo vbar_cp_reginfo[] = {
+            { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
+              .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
+              .access = PL1_RW, .writefn = vbar_write,
+              .bank_fieldoffsets = { offsetof(CPUARMState, cp15.vbar_s),
+                                     offsetof(CPUARMState, cp15.vbar_ns) },
+              .resetvalue = 0 },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, vbar_cp_reginfo);
+    }
+
     /* Generic registers whose values depend on the implementation */
     {
         ARMCPRegInfo sctlr = {
-- 
2.7.4
