Received: from eggs.gnu.org ([2001:4830:134:3::10]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjK2-0001oD-Kw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjJy-0001zT-P3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1erjJy-0001xw-Dt
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  2 Mar 2018 12:57:42 +0100
Message-Id: <20180302115743.3409-4-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
References: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 3/4] tricore: renamed masking of IE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

between 1.3 ISA and 1.6 ISA the IE mask has changed. We reflect this by add an
ISA suffix to the existing mask and add the corresponding mask for 1.6.

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Message-Id: <20180301155619.8640-4-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
[BK: Add why we did this change to the commit message]
---
 target/tricore/cpu.h       |  3 ++-
 target/tricore/op_helper.c | 17 +++++++++--------
 target/tricore/translate.c |  4 ++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 045126181a..6d89f625d0 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -256,7 +256,8 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
 #define MASK_CPUID_REV     0x000000ff
 
 #define MASK_ICR_PIPN 0x00ff0000
-#define MASK_ICR_IE   0x00000100
+#define MASK_ICR_IE_1_3   0x00000100
+#define MASK_ICR_IE_1_6   0x00008000
 #define MASK_ICR_CCPN 0x000000ff
 
 #define MASK_FCX_FCXS 0x000f0000
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 098f217c2a..475b6ce081 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -85,7 +85,7 @@ raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
 
     /* PCXI.PIE = ICR.IE */
     env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
-                ((env->ICR & MASK_ICR_IE) << 15));
+                ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.PCPN = ICR.CCPN */
     env->PCXI = (env->PCXI & 0xffffff) +
                 ((env->ICR & MASK_ICR_CCPN) << 24);
@@ -2465,7 +2465,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
     env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
-                ((env->ICR & MASK_ICR_IE) << 15));
+                ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 1; */
     env->PCXI |= MASK_PCXI_UL;
 
@@ -2563,7 +2563,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
                  ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE  = ICR.IE */
     env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
-                 ((env->ICR & MASK_ICR_IE) << 15));
+                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 0 */
     env->PCXI &= ~(MASK_PCXI_UL);
     /* PCXI[19: 0] = FCX[19: 0] */
@@ -2571,7 +2571,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     /* FXC[19: 0] = new_FCX[19: 0] */
     env->FCX = (env->FCX & 0xfff00000) + (new_FCX & 0xfffff);
     /* ICR.IE = 1 */
-    env->ICR |= MASK_ICR_IE;
+    env->ICR |= MASK_ICR_IE_1_3;
 
     env->ICR |= const9; /* ICR.CCPN = const9[7: 0];*/
 
@@ -2603,7 +2603,8 @@ void helper_rfe(CPUTriCoreState *env)
     }
     env->PC = env->gpr_a[11] & ~0x1;
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE) + ((env->PCXI & MASK_PCXI_PIE) >> 15);
+    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3)
+            + ((env->PCXI & MASK_PCXI_PIE) >> 15);
     /* ICR.CCPN = PCXI.PCPN; */
     env->ICR = (env->ICR & ~MASK_ICR_CCPN) +
                ((env->PCXI & MASK_PCXI_PCPN) >> 24);
@@ -2627,7 +2628,7 @@ void helper_rfm(CPUTriCoreState *env)
 {
     env->PC = (env->gpr_a[11] & ~0x1);
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE) |
+    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3) |
                ((env->PCXI & MASK_PCXI_PIE) >> 15);
     /* ICR.CCPN = PCXI.PCPN; */
     env->ICR = (env->ICR & ~MASK_ICR_CCPN) |
@@ -2694,7 +2695,7 @@ void helper_svlcx(CPUTriCoreState *env)
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
     env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
-                ((env->ICR & MASK_ICR_IE) << 15));
+                ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 0; */
     env->PCXI &= ~MASK_PCXI_UL;
 
@@ -2737,7 +2738,7 @@ void helper_svucx(CPUTriCoreState *env)
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
     env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
-                ((env->ICR & MASK_ICR_IE) << 15));
+                ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 1; */
     env->PCXI |= MASK_PCXI_UL;
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 54de0dd346..aef0d9cf06 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8379,12 +8379,12 @@ static void decode_sys_interrupts(CPUTriCoreState *env, DisasContext *ctx)
         /* raise EXCP_DEBUG */
         break;
     case OPC2_32_SYS_DISABLE:
-        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE);
+        tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);
         break;
     case OPC2_32_SYS_DSYNC:
         break;
     case OPC2_32_SYS_ENABLE:
-        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, MASK_ICR_IE);
+        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, MASK_ICR_IE_1_3);
         break;
     case OPC2_32_SYS_ISYNC:
         break;
-- 
2.16.2
