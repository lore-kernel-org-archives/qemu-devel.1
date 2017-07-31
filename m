Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9it-0001ew-Ia
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9is-0003jA-HP
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9is-0003ax-AB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ih-0000tF-Rr
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:42 +0100
Message-Id: <1501503765-15639-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/7] target/arm: Rename cp15.c6_rgnr to
 pmsav7.rnr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Almost all of the PMSAv7 state is in the pmsav7 substruct of
the ARM CPU state structure. The exception is the region
number register, which is in cp15.c6_rgnr. This exception
is a bit odd for M profile, which otherwise generally does
not store state in the cp15 substruct.

Rename cp15.c6_rgnr to pmsav7.rnr accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1501153150-19984-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  3 +--
 hw/intc/armv7m_nvic.c | 14 +++++++-------
 target/arm/helper.c   |  6 +++---
 target/arm/machine.c  |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 102c58a..b39d64a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -305,8 +305,6 @@ typedef struct CPUARMState {
             uint64_t par_el[4];
         };
 
-        uint32_t c6_rgnr;
-
         uint32_t c9_insn; /* Cache lockdown registers.  */
         uint32_t c9_data;
         uint64_t c9_pmcr; /* performance monitor control register */
@@ -519,6 +517,7 @@ typedef struct CPUARMState {
         uint32_t *drbar;
         uint32_t *drsr;
         uint32_t *dracr;
+        uint32_t rnr;
     } pmsav7;
 
     void *nvic;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 26a4b2d..323e2d4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -536,13 +536,13 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
     case 0xd94: /* MPU_CTRL */
         return cpu->env.v7m.mpu_ctrl;
     case 0xd98: /* MPU_RNR */
-        return cpu->env.cp15.c6_rgnr;
+        return cpu->env.pmsav7.rnr;
     case 0xd9c: /* MPU_RBAR */
     case 0xda4: /* MPU_RBAR_A1 */
     case 0xdac: /* MPU_RBAR_A2 */
     case 0xdb4: /* MPU_RBAR_A3 */
     {
-        int region = cpu->env.cp15.c6_rgnr;
+        int region = cpu->env.pmsav7.rnr;
 
         if (region >= cpu->pmsav7_dregion) {
             return 0;
@@ -554,7 +554,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
     case 0xdb0: /* MPU_RASR_A2 */
     case 0xdb8: /* MPU_RASR_A3 */
     {
-        int region = cpu->env.cp15.c6_rgnr;
+        int region = cpu->env.pmsav7.rnr;
 
         if (region >= cpu->pmsav7_dregion) {
             return 0;
@@ -681,7 +681,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
                           PRIu32 "/%" PRIu32 "\n",
                           value, cpu->pmsav7_dregion);
         } else {
-            cpu->env.cp15.c6_rgnr = value;
+            cpu->env.pmsav7.rnr = value;
         }
         break;
     case 0xd9c: /* MPU_RBAR */
@@ -702,9 +702,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
                               region, cpu->pmsav7_dregion);
                 return;
             }
-            cpu->env.cp15.c6_rgnr = region;
+            cpu->env.pmsav7.rnr = region;
         } else {
-            region = cpu->env.cp15.c6_rgnr;
+            region = cpu->env.pmsav7.rnr;
         }
 
         if (region >= cpu->pmsav7_dregion) {
@@ -720,7 +720,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
     case 0xdb0: /* MPU_RASR_A2 */
     case 0xdb8: /* MPU_RASR_A3 */
     {
-        int region = cpu->env.cp15.c6_rgnr;
+        int region = cpu->env.pmsav7.rnr;
 
         if (region >= cpu->pmsav7_dregion) {
             return;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0299c5..0f79b25 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2385,7 +2385,7 @@ static uint64_t pmsav7_read(CPUARMState *env, const ARMCPRegInfo *ri)
         return 0;
     }
 
-    u32p += env->cp15.c6_rgnr;
+    u32p += env->pmsav7.rnr;
     return *u32p;
 }
 
@@ -2399,7 +2399,7 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    u32p += env->cp15.c6_rgnr;
+    u32p += env->pmsav7.rnr;
     tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
     *u32p = value;
 }
@@ -2447,7 +2447,7 @@ static const ARMCPRegInfo pmsav7_cp_reginfo[] = {
       .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn = pmsav7_reset },
     { .name = "RGNR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 2, .opc2 = 0,
       .access = PL1_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c6_rgnr),
+      .fieldoffset = offsetof(CPUARMState, pmsav7.rnr),
       .writefn = pmsav7_rgnr_write },
     REGINFO_SENTINEL
 };
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 1a40469..93c1a78 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -151,7 +151,7 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu->env.cp15.c6_rgnr < cpu->pmsav7_dregion;
+    return cpu->env.pmsav7.rnr < cpu->pmsav7_dregion;
 }
 
 static const VMStateDescription vmstate_pmsav7 = {
-- 
2.7.4
