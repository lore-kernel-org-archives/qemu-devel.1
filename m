Received: from eggs.gnu.org ([2001:4830:134:3::10]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnx-0006f9-5q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnt-0003K6-Ic
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:21 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:42 +0100
Message-Id: <1503414539-28762-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/20] target/arm: Add state field,
 feature bit and migration for v8M secure state
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

As the first step in implementing ARM v8M's security extension:
 * add a new feature bit ARM_FEATURE_M_SECURITY
 * add the CPU state field that indicates whether the CPU is
   currently in the secure state
 * add a migration subsection for this new state
   (we will add the Secure copies of banked register state
   to this subsection in later patches)
 * add a #define for the one new-in-v8M exception type
 * make the CPU debug log print S/NS status

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  3 +++
 target/arm/cpu.c       |  4 ++++
 target/arm/machine.c   | 20 ++++++++++++++++++++
 target/arm/translate.c |  8 +++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b6bb78a..24666baa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -66,6 +66,7 @@
 #define ARMV7M_EXCP_MEM     4
 #define ARMV7M_EXCP_BUS     5
 #define ARMV7M_EXCP_USAGE   6
+#define ARMV7M_EXCP_SECURE  7
 #define ARMV7M_EXCP_SVC     11
 #define ARMV7M_EXCP_DEBUG   12
 #define ARMV7M_EXCP_PENDSV  14
@@ -420,6 +421,7 @@ typedef struct CPUARMState {
         int exception;
         uint32_t primask;
         uint32_t faultmask;
+        uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
     } v7m;
 
     /* Information associated with an exception about to be taken:
@@ -1264,6 +1266,7 @@ enum arm_features {
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
+    ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8b610de..f32317e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -185,6 +185,10 @@ static void arm_cpu_reset(CPUState *s)
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
 
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            env->v7m.secure = true;
+        }
+
         /* The reset value of this bit is IMPDEF, but ARM recommends
          * that it resets to 1, so QEMU always does that rather than making
          * it dependent on CPU model.
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 05e2909..745adae 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -235,6 +235,25 @@ static const VMStateDescription vmstate_pmsav8 = {
     }
 };
 
+static bool m_security_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_M_SECURITY);
+}
+
+static const VMStateDescription vmstate_m_security = {
+    .name = "cpu/m-security",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = m_security_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.v7m.secure, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
                     VMStateField *field)
 {
@@ -484,6 +503,7 @@ const VMStateDescription vmstate_arm_cpu = {
          */
         &vmstate_pmsav7_rnr,
         &vmstate_pmsav7,
+        &vmstate_m_security,
         NULL
     }
 };
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e52a6d7..dea0a6f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12232,6 +12232,11 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     if (arm_feature(env, ARM_FEATURE_M)) {
         uint32_t xpsr = xpsr_read(env);
         const char *mode;
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            ns_status = env->v7m.secure ? "S " : "NS ";
+        }
 
         if (xpsr & XPSR_EXCP) {
             mode = "handler";
@@ -12243,13 +12248,14 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
             }
         }
 
-        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s\n",
+        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
                     xpsr,
                     xpsr & XPSR_N ? 'N' : '-',
                     xpsr & XPSR_Z ? 'Z' : '-',
                     xpsr & XPSR_C ? 'C' : '-',
                     xpsr & XPSR_V ? 'V' : '-',
                     xpsr & XPSR_T ? 'T' : 'A',
+                    ns_status,
                     mode);
     } else {
         uint32_t psr = cpsr_read(env);
-- 
2.7.4
