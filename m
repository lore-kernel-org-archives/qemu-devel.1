Received: from eggs.gnu.org ([2001:4830:134:3::10]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAo1-0006lN-R4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnt-0003KG-SP
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:58 +0100
Message-Id: <1503414539-28762-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 19/20] target/arm: Move regime_is_secure() to
 target/arm/internals.h
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

Move the regime_is_secure() utility function to internals.h;
we are going to want to call it from translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 26 ++++++++++++++++++++++++++
 target/arm/helper.c    | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index bb06946..eb171b1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -478,4 +478,30 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
+/* Return true if this address translation regime is secure */
+static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MNegPri:
+    case ARMMMUIdx_MUser:
+        return false;
+    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSNegPri:
+    case ARMMMUIdx_MSUser:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 67b3874..b1ae73c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7060,32 +7060,6 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
-/* Return true if this address translation regime is secure */
-static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
-    case ARMMMUIdx_S1E2:
-    case ARMMMUIdx_S2NS:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MNegPri:
-    case ARMMMUIdx_MUser:
-        return false;
-    case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSNegPri:
-    case ARMMMUIdx_MSUser:
-        return true;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-- 
2.7.4
