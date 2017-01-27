Received: from eggs.gnu.org ([2001:4830:134:3::10]:59745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vw-00018G-LJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vv-0005Ah-Fs
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vv-000541-7G
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vh-0003N0-D5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:01 +0000
Message-Id: <1485531137-2362-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/22] armv7m: Fix reads of CONTROL register bit
 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

The v7m CONTROL register bit 1 is SPSEL, which indicates
the stack being used. We were storing this information
not in v7m.control but in the separate v7m.other_sp
structure field. Unfortunately, the code handling reads
of the CONTROL register didn't take account of this, and
so if SPSEL was updated by an exception entry or exit then
a subsequent guest read of CONTROL would get the wrong value.

Using a separate structure field doesn't really gain us
anything in efficiency, so drop this unnecessary complexity
in favour of simply storing all the bits in v7m.control.

This is a migration compatibility break for M profile
CPUs only.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1484937883-1068-6-git-send-email-peter.maydell@linaro.org
[PMM: rewrote commit message;
 use deposit32(); use FIELD to define constants for
 masking and shifting of CONTROL register fields
]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  1 -
 target/arm/internals.h |  7 +++++++
 target/arm/helper.c    | 35 +++++++++++++++++++++++------------
 target/arm/machine.c   |  6 ++----
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 151a5d7..521c11b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -405,7 +405,6 @@ typedef struct CPUARMState {
         uint32_t vecbase;
         uint32_t basepri;
         uint32_t control;
-        int current_sp;
         int exception;
     } v7m;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3cae5ff..2e65bc1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -25,6 +25,8 @@
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
+#include "hw/registerfields.h"
+
 /* register banks for CPU modes */
 #define BANK_USRSYS 0
 #define BANK_SVC    1
@@ -75,6 +77,11 @@ static const char * const excnames[] = {
  */
 #define GTIMER_SCALE 16
 
+/* Bit definitions for the v7M CONTROL register */
+FIELD(V7M_CONTROL, NPRIV, 0, 1)
+FIELD(V7M_CONTROL, SPSEL, 1, 1)
+FIELD(V7M_CONTROL, FPCA, 2, 1)
+
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
  * Note that this mapping and the AArch32 mapping defined in bank_number()
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8edb08c..dc383d1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5947,14 +5947,19 @@ static uint32_t v7m_pop(CPUARMState *env)
 }
 
 /* Switch to V7M main or process stack pointer.  */
-static void switch_v7m_sp(CPUARMState *env, int process)
+static void switch_v7m_sp(CPUARMState *env, bool new_spsel)
 {
     uint32_t tmp;
-    if (env->v7m.current_sp != process) {
+    bool old_spsel = env->v7m.control & R_V7M_CONTROL_SPSEL_MASK;
+
+    if (old_spsel != new_spsel) {
         tmp = env->v7m.other_sp;
         env->v7m.other_sp = env->regs[13];
         env->regs[13] = tmp;
-        env->v7m.current_sp = process;
+
+        env->v7m.control = deposit32(env->v7m.control,
+                                     R_V7M_CONTROL_SPSEL_SHIFT,
+                                     R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
     }
 }
 
@@ -6049,8 +6054,9 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     arm_log_exception(cs->exception_index);
 
     lr = 0xfffffff1;
-    if (env->v7m.current_sp)
+    if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
         lr |= 4;
+    }
     if (env->v7m.exception == 0)
         lr |= 8;
 
@@ -8294,9 +8300,11 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 
     switch (reg) {
     case 8: /* MSP */
-        return env->v7m.current_sp ? env->v7m.other_sp : env->regs[13];
+        return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
+            env->v7m.other_sp : env->regs[13];
     case 9: /* PSP */
-        return env->v7m.current_sp ? env->regs[13] : env->v7m.other_sp;
+        return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
+            env->regs[13] : env->v7m.other_sp;
     case 16: /* PRIMASK */
         return (env->daif & PSTATE_I) != 0;
     case 17: /* BASEPRI */
@@ -8326,16 +8334,18 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
         }
         break;
     case 8: /* MSP */
-        if (env->v7m.current_sp)
+        if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
             env->v7m.other_sp = val;
-        else
+        } else {
             env->regs[13] = val;
+        }
         break;
     case 9: /* PSP */
-        if (env->v7m.current_sp)
+        if (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) {
             env->regs[13] = val;
-        else
+        } else {
             env->v7m.other_sp = val;
+        }
         break;
     case 16: /* PRIMASK */
         if (val & 1) {
@@ -8360,8 +8370,9 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
         }
         break;
     case 20: /* CONTROL */
-        env->v7m.control = val & 3;
-        switch_v7m_sp(env, (val & 2) != 0);
+        switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
+        env->v7m.control = val & (R_V7M_CONTROL_SPSEL_MASK |
+                                  R_V7M_CONTROL_NPRIV_MASK);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 487320d..8d93571 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -99,15 +99,13 @@ static bool m_needed(void *opaque)
 
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = m_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(env.v7m.other_sp, ARMCPU),
         VMSTATE_UINT32(env.v7m.vecbase, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri, ARMCPU),
         VMSTATE_UINT32(env.v7m.control, ARMCPU),
-        VMSTATE_INT32(env.v7m.current_sp, ARMCPU),
         VMSTATE_INT32(env.v7m.exception, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
-- 
2.7.4
