Received: from eggs.gnu.org ([209.51.188.92]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSat-00011F-22
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSas-0002Ci-4n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSar-0002C6-Uz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id k16so20992206wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 14:14:38 +0100
Message-Id: <20190430131439.25251-4-peter.maydell@linaro.org>
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] hw/intc/armv7m_nvic: Don't enable
 ARMV7M_EXCP_DEBUG from reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

The M-profile architecture specifies that the DebugMonitor exception
should be initially disabled, not enabled. It should be controlled
by the DEMCR register's MON_EN bit, but we don't implement that
register yet (like most of the debug architecture for M-profile).

Note that BKPT instructions will still work, because they
will be escalated to HardFault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 15cba63c964..3a346a682a3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2491,10 +2491,12 @@ static void armv7m_nvic_reset(DeviceState *dev)
      * the System Handler Control register
      */
     s->vectors[ARMV7M_EXCP_SVC].enabled = 1;
-    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 1;
     s->vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
     s->vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
 
+    /* DebugMonitor is enabled via DEMCR.MON_EN */
+    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 0;
+
     resetprio = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? -4 : -3;
     s->vectors[ARMV7M_EXCP_RESET].prio = resetprio;
     s->vectors[ARMV7M_EXCP_NMI].prio = -2;
-- 
2.20.1
