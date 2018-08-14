Received: from eggs.gnu.org ([2001:4830:134:3::10]:52386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdut-0004SB-Op
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtk-0006Y7-49
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtj-0006Ug-Pt
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtb-000772-9P
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:31 +0100
Message-Id: <20180814181815.23348-2-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/45] target/arm: Forbid unprivileged mode for
 M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

MSR handling is the only place where CONTROL.nPRIV is modified.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-id: 20180705222622.17139-1-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66afb08ee0f..a6d642f4ae5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10728,8 +10728,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             write_v7m_control_spsel_for_secstate(env,
                                                  val & R_V7M_CONTROL_SPSEL_MASK,
                                                  M_REG_NS);
-            env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
-            env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
+            if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+                env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
+                env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
+            }
             return;
         case 0x98: /* SP_NS */
         {
@@ -10822,8 +10824,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             !arm_v7m_is_handler_mode(env)) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
-        env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
+        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+            env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
+            env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
+        }
         break;
     default:
     bad_reg:
-- 
2.18.0
