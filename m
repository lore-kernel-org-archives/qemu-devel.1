Received: from eggs.gnu.org ([2001:4830:134:3::10]:52167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyx-0008CF-G4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyw-000394-PZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:59:47 +0100
Message-Id: <20180724115950.17316-3-peter.maydell@linaro.org>
In-Reply-To: <20180724115950.17316-1-peter.maydell@linaro.org>
References: <20180724115950.17316-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] target/arm: Honour HCR_EL2.TGE and
 MDCR_EL2.TDE in debug register access checks
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

Some debug registers can be trapped via MDCR_EL2 bits TDRA, TDOSA,
and TDA, which we implement in the functions access_tdra(),
access_tdosa() and access_tda(). If MDCR_EL2.TDE or HCR_EL2.TGE
are 1, the TDRA, TDOSA and TDA bits should behave as if they were 1.
Implement this by having the access functions check MDCR_EL2.TDE
and HCR_EL2.TGE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22d812240af..e2930e99388 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -444,9 +444,11 @@ static CPAccessResult access_tdosa(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
     int el = arm_current_el(env);
+    bool mdcr_el2_tdosa = (env->cp15.mdcr_el2 & MDCR_TDOSA) ||
+        (env->cp15.mdcr_el2 & MDCR_TDE) ||
+        (env->cp15.hcr_el2 & HCR_TGE);
 
-    if (el < 2 && (env->cp15.mdcr_el2 & MDCR_TDOSA)
-        && !arm_is_secure_below_el3(env)) {
+    if (el < 2 && mdcr_el2_tdosa && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
     }
     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TDOSA)) {
@@ -462,9 +464,11 @@ static CPAccessResult access_tdra(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
     int el = arm_current_el(env);
+    bool mdcr_el2_tdra = (env->cp15.mdcr_el2 & MDCR_TDRA) ||
+        (env->cp15.mdcr_el2 & MDCR_TDE) ||
+        (env->cp15.hcr_el2 & HCR_TGE);
 
-    if (el < 2 && (env->cp15.mdcr_el2 & MDCR_TDRA)
-        && !arm_is_secure_below_el3(env)) {
+    if (el < 2 && mdcr_el2_tdra && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
     }
     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TDA)) {
@@ -480,9 +484,11 @@ static CPAccessResult access_tda(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
     int el = arm_current_el(env);
+    bool mdcr_el2_tda = (env->cp15.mdcr_el2 & MDCR_TDA) ||
+        (env->cp15.mdcr_el2 & MDCR_TDE) ||
+        (env->cp15.hcr_el2 & HCR_TGE);
 
-    if (el < 2 && (env->cp15.mdcr_el2 & MDCR_TDA)
-        && !arm_is_secure_below_el3(env)) {
+    if (el < 2 && mdcr_el2_tda && !arm_is_secure_below_el3(env)) {
         return CP_ACCESS_TRAP_EL2;
     }
     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TDA)) {
-- 
2.17.1
