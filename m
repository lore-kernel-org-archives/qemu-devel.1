Received: from eggs.gnu.org ([209.51.188.92]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfH-0004p0-Ox
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfF-0001KM-Re
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfE-0001Gi-0u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id a184so25245569wma.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:30 +0100
Message-Id: <20190416125744.27770-13-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/26] target/arm: Clear CONTROL.SFPA in BXNS
 and BLXNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

For v8M floating point support, transitions from Secure
to Non-secure state via BLNS and BLXNS must clear the
CONTROL.SFPA bit. (This corresponds to the pseudocode
BranchToNS() function.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7298f9de735..8e72e1097ce 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7824,6 +7824,9 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     /* translate.c should have made BXNS UNDEF unless we're secure */
     assert(env->v7m.secure);
 
+    if (!(dest & 1)) {
+        env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+    }
     switch_v7m_security_state(env, dest & 1);
     env->thumb = 1;
     env->regs[15] = dest & ~1;
@@ -7881,6 +7884,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
          */
         write_v7m_exception(env, 1);
     }
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, 0);
     env->thumb = 1;
     env->regs[15] = dest;
-- 
2.20.1
