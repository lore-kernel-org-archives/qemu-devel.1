Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyx-0008Cw-Qe
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyw-00039O-Vx
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:59:50 +0100
Message-Id: <20180724115950.17316-6-peter.maydell@linaro.org>
In-Reply-To: <20180724115950.17316-1-peter.maydell@linaro.org>
References: <20180724115950.17316-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] target/arm: Treat SCTLR_EL1.M as if it
 were zero when HCR_EL2.TGE is set
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

One of the required effects of setting HCR_EL2.TGE is that when
SCR_EL3.NS is 1 then SCTLR_EL1.M must behave as if it is zero for
all purposes except direct reads. That is, it effectively disables
the MMU for the NS EL0/EL1 translation regime.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 699189ebd7b..efd258fdb59 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8402,6 +8402,14 @@ static inline bool regime_translation_disabled(CPUARMState *env,
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
2.17.1
