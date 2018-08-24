Received: from eggs.gnu.org ([2001:4830:134:3::10]:35466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8To-0007EO-GL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tn-0003hq-Kw
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tn-0003ee-Bp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tm-0006Sx-9U
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:06 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:08 +0100
Message-Id: <20180824093343.11346-18-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/52] target/arm: Clear CPSR.IL and CPSR.J on
 32-bit exception entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 32-bit exception entry, CPSR.J must always be set to 0
(see v7A Arm ARM DDI0406C.c B1.8.5). CPSR.IL must also
be cleared on 32-bit exception entry (see v8A Arm ARM
DDI0487C.a G1.10).

Clear these bits. (This fixes a bug which will never be noticed
by non-buggy guests.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-6-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 10f40b01700..b0ab18af43e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8054,6 +8054,8 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
+    /* J and IL must always be cleared for exception entry */
+    env->uncached_cpsr &= ~(CPSR_IL | CPSR_J);
     env->daif |= mask;
 
     if (new_mode == ARM_CPU_MODE_HYP) {
-- 
2.18.0
