Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbChz-0001j8-7A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbChv-0001fa-Sh
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:26:39 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:54132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fbChv-0001ax-KX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:26:35 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  6 Jul 2018 01:26:22 +0300
Message-Id: <20180705222622.17139-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2] target/arm: Forbid unprivileged mode for M
 Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

MSR handling is the only place where CONTROL.nPRIV is modified.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
v2:
    * Add the check in the CONTROL_NS case

 target/arm/helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5ee229eb35..2343aa5069 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10686,8 +10686,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
@@ -10781,8 +10783,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
2.17.1
