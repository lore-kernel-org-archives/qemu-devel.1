Received: from eggs.gnu.org ([2001:4830:134:3::10]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6a0-0000fd-LU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zz-0000dX-7r
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:13 +0000
Message-Id: <1485285380-10565-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/10] armv7m: add state for v7M CCR, CFSR, HFSR,
 DFSR, MMFAR, BFAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

Add the structure fields, VMState fields, reset code and macros for
the v7M system control registers CCR, CFSR, HFSR, DFSR, MMFAR and
BFAR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c     |  7 +++++++
 target/arm/machine.c | 10 ++++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2cc329..4b062d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -21,6 +21,7 @@
 #define ARM_CPU_H
 
 #include "kvm-consts.h"
+#include "hw/registerfields.h"
 
 #if defined(TARGET_AARCH64)
   /* AArch64 definitions */
@@ -405,6 +406,12 @@ typedef struct CPUARMState {
         uint32_t vecbase;
         uint32_t basepri;
         uint32_t control;
+        uint32_t ccr; /* Configuration and Control */
+        uint32_t cfsr; /* Configurable Fault Status */
+        uint32_t hfsr; /* HardFault Status */
+        uint32_t dfsr; /* Debug Fault Status Register */
+        uint32_t mmfar; /* MemManage Fault Address */
+        uint32_t bfar; /* BusFault Address */
         int exception;
     } v7m;
 
@@ -1086,6 +1093,53 @@ enum arm_cpu_mode {
 #define ARM_IWMMXT_wCGR2	10
 #define ARM_IWMMXT_wCGR3	11
 
+/* V7M CCR bits */
+FIELD(V7M_CCR, NONBASETHRDENA, 0, 1)
+FIELD(V7M_CCR, USERSETMPEND, 1, 1)
+FIELD(V7M_CCR, UNALIGN_TRP, 3, 1)
+FIELD(V7M_CCR, DIV_0_TRP, 4, 1)
+FIELD(V7M_CCR, BFHFNMIGN, 8, 1)
+FIELD(V7M_CCR, STKALIGN, 9, 1)
+FIELD(V7M_CCR, DC, 16, 1)
+FIELD(V7M_CCR, IC, 17, 1)
+
+/* V7M CFSR bits for MMFSR */
+FIELD(V7M_CFSR, IACCVIOL, 0, 1)
+FIELD(V7M_CFSR, DACCVIOL, 1, 1)
+FIELD(V7M_CFSR, MUNSTKERR, 3, 1)
+FIELD(V7M_CFSR, MSTKERR, 4, 1)
+FIELD(V7M_CFSR, MLSPERR, 5, 1)
+FIELD(V7M_CFSR, MMARVALID, 7, 1)
+
+/* V7M CFSR bits for BFSR */
+FIELD(V7M_CFSR, IBUSERR, 8 + 0, 1)
+FIELD(V7M_CFSR, PRECISERR, 8 + 1, 1)
+FIELD(V7M_CFSR, IMPRECISERR, 8 + 2, 1)
+FIELD(V7M_CFSR, UNSTKERR, 8 + 3, 1)
+FIELD(V7M_CFSR, STKERR, 8 + 4, 1)
+FIELD(V7M_CFSR, LSPERR, 8 + 5, 1)
+FIELD(V7M_CFSR, BFARVALID, 8 + 7, 1)
+
+/* V7M CFSR bits for UFSR */
+FIELD(V7M_CFSR, UNDEFINSTR, 16 + 0, 1)
+FIELD(V7M_CFSR, INVSTATE, 16 + 1, 1)
+FIELD(V7M_CFSR, INVPC, 16 + 2, 1)
+FIELD(V7M_CFSR, NOCP, 16 + 3, 1)
+FIELD(V7M_CFSR, UNALIGNED, 16 + 8, 1)
+FIELD(V7M_CFSR, DIVBYZERO, 16 + 9, 1)
+
+/* V7M HFSR bits */
+FIELD(V7M_HFSR, VECTTBL, 1, 1)
+FIELD(V7M_HFSR, FORCED, 30, 1)
+FIELD(V7M_HFSR, DEBUGEVT, 31, 1)
+
+/* V7M DFSR bits */
+FIELD(V7M_DFSR, HALTED, 0, 1)
+FIELD(V7M_DFSR, BKPT, 1, 1)
+FIELD(V7M_DFSR, DWTTRAP, 2, 1)
+FIELD(V7M_DFSR, VCATCH, 3, 1)
+FIELD(V7M_DFSR, EXTERNAL, 4, 1)
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6395d5a..c804f59 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -188,6 +188,13 @@ static void arm_cpu_reset(CPUState *s)
         uint8_t *rom;
 
         env->daif &= ~PSTATE_I;
+
+        /* The reset value of this bit is IMPDEF, but ARM recommends
+         * that it resets to 1, so QEMU always does that rather than making
+         * it dependent on CPU model.
+         */
+        env->v7m.ccr = R_V7M_CCR_STKALIGN_MASK;
+
         rom = rom_ptr(0);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8ed24bf..49e09a8 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -96,13 +96,19 @@ static bool m_needed(void *opaque)
 
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = m_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri, ARMCPU),
         VMSTATE_UINT32(env.v7m.control, ARMCPU),
+        VMSTATE_UINT32(env.v7m.ccr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.hfsr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.mmfar, ARMCPU),
+        VMSTATE_UINT32(env.v7m.bfar, ARMCPU),
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
-- 
2.7.4
