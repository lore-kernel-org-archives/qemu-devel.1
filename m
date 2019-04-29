Received: from eggs.gnu.org ([209.51.188.92]:34170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eS-0004Sl-Br
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eM-0006We-7d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eI-0006Qc-FT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id h18so189194wml.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.50
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:03 +0100
Message-Id: <20190429170030.11323-16-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/42] target/arm: Clear CONTROL.SFPA in BXNS
 and BLXNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For v8M floating point support, transitions from Secure
to Non-secure state via BLNS and BLXNS must clear the
CONTROL.SFPA bit. (This corresponds to the pseudocode
BranchToNS() function.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-13-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 547898581a2..088852ceb96 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7819,6 +7819,9 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     /* translate.c should have made BXNS UNDEF unless we're secure */
     assert(env->v7m.secure);
 
+    if (!(dest & 1)) {
+        env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+    }
     switch_v7m_security_state(env, dest & 1);
     env->thumb = 1;
     env->regs[15] = dest & ~1;
@@ -7876,6 +7879,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
          */
         write_v7m_exception(env, 1);
     }
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, 0);
     env->thumb = 1;
     env->regs[15] = dest;
-- 
2.20.1
