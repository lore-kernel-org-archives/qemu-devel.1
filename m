Received: from eggs.gnu.org ([2001:4830:134:3::10]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr7-00011x-3u
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqv-0007cE-Ov
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqv-0007bf-Gv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqu-0001cw-Hw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:12 +0100
Message-Id: <1504790904-17018-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/31] target/arm: Make MPU_MAIR0,
 MPU_MAIR1 registers banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the MPU registers MPU_MAIR0 and MPU_MAIR1 banked if v8M security
extensions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-13-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 4 ++--
 hw/intc/armv7m_nvic.c | 8 ++++----
 target/arm/cpu.c      | 6 ++++--
 target/arm/machine.c  | 6 ++++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf2331d..42a6cb2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -545,8 +545,8 @@ typedef struct CPUARMState {
          */
         uint32_t *rbar;
         uint32_t *rlar;
-        uint32_t mair0;
-        uint32_t mair1;
+        uint32_t mair0[2];
+        uint32_t mair1[2];
     } pmsav8;
 
     void *nvic;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3a1f02d..e98eb95 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -604,12 +604,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             goto bad_offset;
         }
-        return cpu->env.pmsav8.mair0;
+        return cpu->env.pmsav8.mair0[attrs.secure];
     case 0xdc4: /* MPU_MAIR1 */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             goto bad_offset;
         }
-        return cpu->env.pmsav8.mair1;
+        return cpu->env.pmsav8.mair1[attrs.secure];
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
@@ -826,7 +826,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         if (cpu->pmsav7_dregion) {
             /* Register is RES0 if no MPU regions are implemented */
-            cpu->env.pmsav8.mair0 = value;
+            cpu->env.pmsav8.mair0[attrs.secure] = value;
         }
         /* We don't need to do anything else because memory attributes
          * only affect cacheability, and we don't implement caching.
@@ -838,7 +838,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         if (cpu->pmsav7_dregion) {
             /* Register is RES0 if no MPU regions are implemented */
-            cpu->env.pmsav8.mair1 = value;
+            cpu->env.pmsav8.mair1[attrs.secure] = value;
         }
         /* We don't need to do anything else because memory attributes
          * only affect cacheability, and we don't implement caching.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ae866be..7b4acc0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -249,8 +249,10 @@ static void arm_cpu_reset(CPUState *s)
             }
         }
         env->pmsav7.rnr = 0;
-        env->pmsav8.mair0 = 0;
-        env->pmsav8.mair1 = 0;
+        env->pmsav8.mair0[M_REG_NS] = 0;
+        env->pmsav8.mair0[M_REG_S] = 0;
+        env->pmsav8.mair1[M_REG_NS] = 0;
+        env->pmsav8.mair1[M_REG_S] = 0;
     }
 
     set_flush_to_zero(1, &env->vfp.standard_fp_status);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 923f259..80942d6 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -229,8 +229,8 @@ static const VMStateDescription vmstate_pmsav8 = {
                               vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav8.rlar, ARMCPU, pmsav7_dregion, 0,
                               vmstate_info_uint32, uint32_t),
-        VMSTATE_UINT32(env.pmsav8.mair0, ARMCPU),
-        VMSTATE_UINT32(env.pmsav8.mair1, ARMCPU),
+        VMSTATE_UINT32(env.pmsav8.mair0[M_REG_NS], ARMCPU),
+        VMSTATE_UINT32(env.pmsav8.mair1[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -255,6 +255,8 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.faultmask[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.vecbase[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.pmsav8.mair0[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.pmsav8.mair1[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
