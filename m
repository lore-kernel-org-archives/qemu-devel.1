Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph2-0003Qz-13
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph0-0006RF-SQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:51 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:48 +0100
Message-Id: <1505240046-11454-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/19] target/arm: Implement MSR/MRS access to
 NS banked registers
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

In v8M the MSR and MRS instructions have extra register value
encodings to allow secure code to access the non-secure banked
version of various special registers.

(We don't implement the MSPLIM_NS or PSPLIM_NS aliases, because
we don't currently implement the stack limit registers at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f41841..f4f2a87 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8892,12 +8892,68 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         break;
     case 20: /* CONTROL */
         return env->v7m.control[env->v7m.secure];
+    case 0x94: /* CONTROL_NS */
+        /* We have to handle this here because unprivileged Secure code
+         * can read the NS CONTROL register.
+         */
+        if (!env->v7m.secure) {
+            return 0;
+        }
+        return env->v7m.control[M_REG_NS];
     }
 
     if (el == 0) {
         return 0; /* unprivileged reads others as zero */
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        switch (reg) {
+        case 0x88: /* MSP_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.other_ss_msp;
+        case 0x89: /* PSP_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.other_ss_psp;
+        case 0x90: /* PRIMASK_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.primask[M_REG_NS];
+        case 0x91: /* BASEPRI_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.basepri[M_REG_NS];
+        case 0x93: /* FAULTMASK_NS */
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            return env->v7m.faultmask[M_REG_NS];
+        case 0x98: /* SP_NS */
+        {
+            /* This gives the non-secure SP selected based on whether we're
+             * currently in handler mode or not, using the NS CONTROL.SPSEL.
+             */
+            bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
+
+            if (!env->v7m.secure) {
+                return 0;
+            }
+            if (!arm_v7m_is_handler_mode(env) && spsel) {
+                return env->v7m.other_ss_psp;
+            } else {
+                return env->v7m.other_ss_msp;
+            }
+        }
+        default:
+            break;
+        }
+    }
+
     switch (reg) {
     case 8: /* MSP */
         return (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) ?
@@ -8936,6 +8992,60 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         return;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        switch (reg) {
+        case 0x88: /* MSP_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.other_ss_msp = val;
+            return;
+        case 0x89: /* PSP_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.other_ss_psp = val;
+            return;
+        case 0x90: /* PRIMASK_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.primask[M_REG_NS] = val & 1;
+            return;
+        case 0x91: /* BASEPRI_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.basepri[M_REG_NS] = val & 0xff;
+            return;
+        case 0x93: /* FAULTMASK_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            env->v7m.faultmask[M_REG_NS] = val & 1;
+            return;
+        case 0x98: /* SP_NS */
+        {
+            /* This gives the non-secure SP selected based on whether we're
+             * currently in handler mode or not, using the NS CONTROL.SPSEL.
+             */
+            bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
+
+            if (!env->v7m.secure) {
+                return;
+            }
+            if (!arm_v7m_is_handler_mode(env) && spsel) {
+                env->v7m.other_ss_psp = val;
+            } else {
+                env->v7m.other_ss_msp = val;
+            }
+            return;
+        }
+        default:
+            break;
+        }
+    }
+
     switch (reg) {
     case 0 ... 7: /* xPSR sub-fields */
         /* only APSR is actually writable */
-- 
2.7.4
