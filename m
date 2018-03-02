Received: from eggs.gnu.org ([2001:4830:134:3::10]:56400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjK2-0001oC-Kw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1erjJy-0001zk-P9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:58 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1erjJy-0001xt-Dd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:57:54 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri,  2 Mar 2018 12:57:43 +0100
Message-Id: <20180302115743.3409-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
References: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 4/4] tricore: renamed masking of PIE
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
Message-Id: <20180301155619.8640-5-david.brenken@efs-auto.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
[BK: Added why we made this change to the commit message]
---
 target/tricore/cpu.h       |  3 ++-
 target/tricore/op_helper.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 6d89f625d0..07b8b59f58 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -229,7 +229,8 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
 
 
 #define MASK_PCXI_PCPN 0xff000000
-#define MASK_PCXI_PIE  0x00800000
+#define MASK_PCXI_PIE_1_3  0x00800000
+#define MASK_PCXI_PIE_1_6  0x00200000
 #define MASK_PCXI_UL   0x00400000
 #define MASK_PCXI_PCXS 0x000f0000
 #define MASK_PCXI_PCXO 0x0000ffff
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 475b6ce081..16955f273e 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -84,7 +84,7 @@ raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
       ICR.IE and ICR.CCPN are saved */
 
     /* PCXI.PIE = ICR.IE */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
+    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.PCPN = ICR.CCPN */
     env->PCXI = (env->PCXI & 0xffffff) +
@@ -2464,7 +2464,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     env->PCXI = (env->PCXI & 0xffffff) +
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
+    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 1; */
     env->PCXI |= MASK_PCXI_UL;
@@ -2562,7 +2562,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     env->PCXI = (env->PCXI & 0xffffff) +
                  ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE  = ICR.IE */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
+    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
                  ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 0 */
     env->PCXI &= ~(MASK_PCXI_UL);
@@ -2604,7 +2604,7 @@ void helper_rfe(CPUTriCoreState *env)
     env->PC = env->gpr_a[11] & ~0x1;
     /* ICR.IE = PCXI.PIE; */
     env->ICR = (env->ICR & ~MASK_ICR_IE_1_3)
-            + ((env->PCXI & MASK_PCXI_PIE) >> 15);
+            + ((env->PCXI & MASK_PCXI_PIE_1_3) >> 15);
     /* ICR.CCPN = PCXI.PCPN; */
     env->ICR = (env->ICR & ~MASK_ICR_CCPN) +
                ((env->PCXI & MASK_PCXI_PCPN) >> 24);
@@ -2628,8 +2628,8 @@ void helper_rfm(CPUTriCoreState *env)
 {
     env->PC = (env->gpr_a[11] & ~0x1);
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3) |
-               ((env->PCXI & MASK_PCXI_PIE) >> 15);
+    env->ICR = (env->ICR & ~MASK_ICR_IE_1_3)
+            | ((env->PCXI & MASK_PCXI_PIE_1_3) >> 15);
     /* ICR.CCPN = PCXI.PCPN; */
     env->ICR = (env->ICR & ~MASK_ICR_CCPN) |
                ((env->PCXI & MASK_PCXI_PCPN) >> 24);
@@ -2694,7 +2694,7 @@ void helper_svlcx(CPUTriCoreState *env)
     env->PCXI = (env->PCXI & 0xffffff) +
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
+    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 0; */
     env->PCXI &= ~MASK_PCXI_UL;
@@ -2737,7 +2737,7 @@ void helper_svucx(CPUTriCoreState *env)
     env->PCXI = (env->PCXI & 0xffffff) +
                 ((env->ICR & MASK_ICR_CCPN) << 24);
     /* PCXI.PIE = ICR.IE; */
-    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE) +
+    env->PCXI = ((env->PCXI & ~MASK_PCXI_PIE_1_3) +
                 ((env->ICR & MASK_ICR_IE_1_3) << 15));
     /* PCXI.UL = 1; */
     env->PCXI |= MASK_PCXI_UL;
-- 
2.16.2
