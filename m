Received: from eggs.gnu.org ([2001:4830:134:3::10]:56547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr8-00013B-Bz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr1-0007gM-4M
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwr0-0007fH-TH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqz-0001gk-Id
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:19 +0100
Message-Id: <1504790904-17018-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/31] target/arm: Move regime_is_secure() to
 target/arm/internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the regime_is_secure() utility function to internals.h;
we are going to want to call it from translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-20-git-send-email-peter.maydell@linaro.org
---
 target/arm/internals.h | 26 ++++++++++++++++++++++++++
 target/arm/helper.c    | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 461f558..4afebd9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -480,4 +480,30 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
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
index 1c47f71..00807b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7055,32 +7055,6 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
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
