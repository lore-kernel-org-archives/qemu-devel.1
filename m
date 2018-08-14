Received: from eggs.gnu.org ([2001:4830:134:3::10]:52840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvp-0005Ce-AJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduI-0006qd-R1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduI-0006nb-Ba
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduF-0007NX-A2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:07 +0100
Message-Id: <20180814181815.23348-38-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 37/45] target/arm: Treat SCTLR_EL1.M as if it
 were zero when HCR_EL2.TGE is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

One of the required effects of setting HCR_EL2.TGE is that when
SCR_EL3.NS is 1 then SCTLR_EL1.M must behave as if it is zero for
all purposes except direct reads. That is, it effectively disables
the MMU for the NS EL0/EL1 translation regime.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180724115950.17316-6-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7b438e43a90..62f63e4e5b9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8396,6 +8396,14 @@ static inline bool regime_translation_disabled(CPUARMState *env,
     if (mmu_idx == ARMMMUIdx_S2NS) {
         return (env->cp15.hcr_el2 & HCR_VM) == 0;
     }
+
+    if (env->cp15.hcr_el2 & HCR_TGE) {
+        /* TGE means that NS EL0/1 act as if SCTLR_EL1.M is zero */
+        if (!regime_is_secure(env, mmu_idx) && regime_el(env, mmu_idx) == 1) {
+            return true;
+        }
+    }
+
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
 }
 
-- 
2.18.0
