Received: from eggs.gnu.org ([2001:4830:134:3::10]:36891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1faoWF-00066a-0s
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1faoWB-0001Ca-SJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:36:55 -0400
Received: from smtp1.mail.ru ([94.100.179.111]:41454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1faoWB-0001Bp-Gq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:36:51 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed,  4 Jul 2018 23:36:39 +0300
Message-Id: <20180704203639.29553-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] target/arm: Forbid unprivileged mode for M
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
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5ee229eb35..83cca554ad 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10781,8 +10781,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
