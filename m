Received: from eggs.gnu.org ([209.51.188.92]:34377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004rg-Hk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kd-Gr
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006NL-1h
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p21so186402wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.45
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:59 +0100
Message-Id: <20190429170030.11323-12-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/42] target/arm: Handle SFPA and FPCA bits in
 reads and writes of CONTROL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M-profile CONTROL register has two bits -- SFPA and FPCA --
which relate to floating-point support, and should be RES0 otherwise.
Handle them correctly in the MSR/MRS register access code.
Neither is banked between security states, so they are stored
in v7m.control[M_REG_S] regardless of current security state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-9-peter.maydell@linaro.org
---
 target/arm/helper.c | 57 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 45a9d92e505..e801744673f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12027,7 +12027,14 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return xpsr_read(env) & mask;
         break;
     case 20: /* CONTROL */
-        return env->v7m.control[env->v7m.secure];
+    {
+        uint32_t value = env->v7m.control[env->v7m.secure];
+        if (!env->v7m.secure) {
+            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S bank */
+            value |= env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK;
+        }
+        return value;
+    }
     case 0x94: /* CONTROL_NS */
         /* We have to handle this here because unprivileged Secure code
          * can read the NS CONTROL register.
@@ -12035,7 +12042,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         if (!env->v7m.secure) {
             return 0;
         }
-        return env->v7m.control[M_REG_NS];
+        return env->v7m.control[M_REG_NS] |
+            (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK);
     }
 
     if (el == 0) {
@@ -12141,9 +12149,13 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
      */
     uint32_t mask = extract32(maskreg, 8, 4);
     uint32_t reg = extract32(maskreg, 0, 8);
+    int cur_el = arm_current_el(env);
 
-    if (arm_current_el(env) == 0 && reg > 7) {
-        /* only xPSR sub-fields may be written by unprivileged */
+    if (cur_el == 0 && reg > 7 && reg != 20) {
+        /*
+         * only xPSR sub-fields and CONTROL.SFPA may be written by
+         * unprivileged code
+         */
         return;
     }
 
@@ -12202,6 +12214,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                 env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
                 env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
             }
+            /*
+             * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
+             * RES0 if the FPU is not present, and is stored in the S bank
+             */
+            if (arm_feature(env, ARM_FEATURE_VFP) &&
+                extract32(env->v7m.nsacr, 10, 1)) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
             return;
         case 0x98: /* SP_NS */
         {
@@ -12304,21 +12325,41 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         env->v7m.faultmask[env->v7m.secure] = val & 1;
         break;
     case 20: /* CONTROL */
-        /* Writing to the SPSEL bit only has an effect if we are in
+        /*
+         * Writing to the SPSEL bit only has an effect if we are in
          * thread mode; other bits can be updated by any privileged code.
          * write_v7m_control_spsel() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
          * For v7M, we must just ignore explicit writes to SPSEL in handler
          * mode; for v8M the write is permitted but will have no effect.
+         * All these bits are writes-ignored from non-privileged code,
+         * except for SFPA.
          */
-        if (arm_feature(env, ARM_FEATURE_V8) ||
-            !arm_v7m_is_handler_mode(env)) {
+        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_V8) ||
+                           !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            /*
+             * SFPA is RAZ/WI from NS or if no FPU.
+             * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
+             * Both are stored in the S bank.
+             */
+            if (env->v7m.secure) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_SFPA_MASK;
+            }
+            if (cur_el > 0 &&
+                (env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_SECURITY) ||
+                 extract32(env->v7m.nsacr, 10, 1))) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
+        }
         break;
     default:
     bad_reg:
-- 
2.20.1
