Received: from eggs.gnu.org ([209.51.188.92]:34453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf7-0004bS-GD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf6-0001B8-F8
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf3-00015u-2K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id w15so25304725wmc.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:25 +0100
Message-Id: <20190416125744.27770-8-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/26] target/arm: Clear CONTROL_S.SFPA in SG
 insn if FPU present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

If the floating point extension is present, then the SG instruction
must clear the CONTROL_S.SFPA bit. Implement this.

(On a no-FPU system the bit will always be zero, so we don't need
to make the clearing of the bit conditional on ARM_FEATURE_VFP.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27e5f98bc73..b4f1609a1c6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8809,6 +8809,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PRIx32
                   ", executing it\n", env->regs[15]);
     env->regs[14] &= ~1;
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
     switch_v7m_security_state(env, true);
     xpsr_write(env, 0, XPSR_IT);
     env->regs[15] += 4;
-- 
2.20.1
