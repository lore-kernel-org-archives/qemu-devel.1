Received: from eggs.gnu.org ([2001:4830:134:3::10]:52383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSI-0004tp-50
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS7-0004he-4m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS6-0004ej-Tm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS5-0005Ts-RL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:42 +0100
Message-Id: <1504527967-29248-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/36] target/arm: Make arm_cpu_dump_state()
 handle the M-profile XPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the arm_cpu_dump_state() debug logging handle the M-profile XPSR
rather than assuming it's an A-profile CPSR.  On M profile the PSR
line of a register dump will now look like this:

XPSR=41000000 -Z-- T priv-thread

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-12-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 58 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3c14cb0..e52a6d7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12215,8 +12215,6 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     int i;
-    uint32_t psr;
-    const char *ns_status;
 
     if (is_a64(env)) {
         aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
@@ -12230,24 +12228,48 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         else
             cpu_fprintf(f, " ");
     }
-    psr = cpsr_read(env);
 
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        (psr & CPSR_M) != ARM_CPU_MODE_MON) {
-        ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        uint32_t xpsr = xpsr_read(env);
+        const char *mode;
+
+        if (xpsr & XPSR_EXCP) {
+            mode = "handler";
+        } else {
+            if (env->v7m.control & R_V7M_CONTROL_NPRIV_MASK) {
+                mode = "unpriv-thread";
+            } else {
+                mode = "priv-thread";
+            }
+        }
+
+        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s\n",
+                    xpsr,
+                    xpsr & XPSR_N ? 'N' : '-',
+                    xpsr & XPSR_Z ? 'Z' : '-',
+                    xpsr & XPSR_C ? 'C' : '-',
+                    xpsr & XPSR_V ? 'V' : '-',
+                    xpsr & XPSR_T ? 'T' : 'A',
+                    mode);
     } else {
-        ns_status = "";
-    }
-
-    cpu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
-                psr,
-                psr & (1 << 31) ? 'N' : '-',
-                psr & (1 << 30) ? 'Z' : '-',
-                psr & (1 << 29) ? 'C' : '-',
-                psr & (1 << 28) ? 'V' : '-',
-                psr & CPSR_T ? 'T' : 'A',
-                ns_status,
-                cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
+        uint32_t psr = cpsr_read(env);
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_EL3) &&
+            (psr & CPSR_M) != ARM_CPU_MODE_MON) {
+            ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+        }
+
+        cpu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
+                    psr,
+                    psr & CPSR_N ? 'N' : '-',
+                    psr & CPSR_Z ? 'Z' : '-',
+                    psr & CPSR_C ? 'C' : '-',
+                    psr & CPSR_V ? 'V' : '-',
+                    psr & CPSR_T ? 'T' : 'A',
+                    ns_status,
+                    cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
+    }
 
     if (flags & CPU_DUMP_FPU) {
         int numvfpregs = 0;
-- 
2.7.4
