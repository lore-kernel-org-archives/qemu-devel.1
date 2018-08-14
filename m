Received: from eggs.gnu.org ([2001:4830:134:3::10]:52785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvj-00057z-78
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduE-0006np-Rw
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduE-0006mZ-3u
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduC-0007ME-Eg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:04 +0100
Message-Id: <20180814181815.23348-35-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/45] target/arm: Honour HCR_EL2.TGE and
 MDCR_EL2.TDE in debug register access checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some debug registers can be trapped via MDCR_EL2 bits TDRA, TDOSA,
and TDA, which we implement in the functions access_tdra(),
access_tdosa() and access_tda(). If MDCR_EL2.TDE or HCR_EL2.TGE
are 1, the TDRA, TDOSA and TDA bits should behave as if they were 1.
Implement this by having the access functions check MDCR_EL2.TDE
and HCR_EL2.TGE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180724115950.17316-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 02c1c4d8404..3cd43cf7018 100644
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
2.18.0
