Received: from eggs.gnu.org ([2001:4830:134:3::10]:41208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0I-00042w-Jv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0H-0007x2-4D
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:26 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:58:10 +0000
Message-Id: <20180209165810.6668-12-peter.maydell@linaro.org>
In-Reply-To: <20180209165810.6668-1-peter.maydell@linaro.org>
References: <20180209165810.6668-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 11/11] target/arm: Implement v8M MSPLIM and
 PSPLIM registers
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

The v8M architecture includes hardware support for enforcing
stack pointer limits. We don't implement this behaviour yet,
but provide the MSPLIM and PSPLIM stack pointer limit registers
as reads-as-written, so that when we do implement the checks
in future this won't break guest migration.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/helper.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/machine.c | 21 +++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfa92c477b..3ef523ddbd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -498,6 +498,8 @@ typedef struct CPUARMState {
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
         uint32_t csselr[M_REG_NUM_BANKS];
         uint32_t scr[M_REG_NUM_BANKS];
+        uint32_t msplim[M_REG_NUM_BANKS];
+        uint32_t psplim[M_REG_NUM_BANKS];
     } v7m;
 
     /* Information associated with an exception about to be taken:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7c1dcb0330..03b1a3fd92 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10415,6 +10415,16 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
                 return 0;
             }
             return env->v7m.other_ss_psp;
+        case 0x8a: /* MSPLIM_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.msplim[M_REG_NS];
+        case 0x8b: /* PSPLIM_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.psplim[M_REG_NS];
         case 0x90: /* PRIMASK_NS */
             if (!env->v7m.secure) {
                 return 0;
@@ -10456,6 +10466,16 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return v7m_using_psp(env) ? env->v7m.other_sp : env->regs[13];
     case 9: /* PSP */
         return v7m_using_psp(env) ? env->regs[13] : env->v7m.other_sp;
+    case 10: /* MSPLIM */
+        if (!arm_feature(env, ARM_FEATURE_V8)) {
+            goto bad_reg;
+        }
+        return env->v7m.msplim[env->v7m.secure];
+    case 11: /* PSPLIM */
+        if (!arm_feature(env, ARM_FEATURE_V8)) {
+            goto bad_reg;
+        }
+        return env->v7m.psplim[env->v7m.secure];
     case 16: /* PRIMASK */
         return env->v7m.primask[env->v7m.secure];
     case 17: /* BASEPRI */
@@ -10464,6 +10484,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
     case 19: /* FAULTMASK */
         return env->v7m.faultmask[env->v7m.secure];
     default:
+    bad_reg:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
                                        " register %d\n", reg);
         return 0;
@@ -10501,6 +10522,18 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             }
             env->v7m.other_ss_psp = val;
             return;
+        case 0x8a: /* MSPLIM_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.msplim[M_REG_NS] = val & ~7;
+            return;
+        case 0x8b: /* PSPLIM_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.psplim[M_REG_NS] = val & ~7;
+            return;
         case 0x90: /* PRIMASK_NS */
             if (!env->v7m.secure) {
                 return;
@@ -10580,6 +10613,18 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             env->v7m.other_sp = val;
         }
         break;
+    case 10: /* MSPLIM */
+        if (!arm_feature(env, ARM_FEATURE_V8)) {
+            goto bad_reg;
+        }
+        env->v7m.msplim[env->v7m.secure] = val & ~7;
+        break;
+    case 11: /* PSPLIM */
+        if (!arm_feature(env, ARM_FEATURE_V8)) {
+            goto bad_reg;
+        }
+        env->v7m.psplim[env->v7m.secure] = val & ~7;
+        break;
     case 16: /* PRIMASK */
         env->v7m.primask[env->v7m.secure] = val & 1;
         break;
@@ -10612,6 +10657,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         break;
     default:
+    bad_reg:
         qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
                                        " register %d\n", reg);
         return;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 1a20d6c36c..2e28d086bd 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -246,6 +246,26 @@ static const VMStateDescription vmstate_m_other_sp = {
     }
 };
 
+static bool m_v8m_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_M) && arm_feature(env, ARM_FEATURE_V8);
+}
+
+static const VMStateDescription vmstate_m_v8m = {
+    .name = "cpu/m/v8m",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = m_v8m_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(env.v7m.msplim, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_UINT32_ARRAY(env.v7m.psplim, ARMCPU, M_REG_NUM_BANKS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -270,6 +290,7 @@ static const VMStateDescription vmstate_m = {
         &vmstate_m_csselr,
         &vmstate_m_scr,
         &vmstate_m_other_sp,
+        &vmstate_m_v8m,
         NULL
     }
 };
-- 
2.16.1
