Received: from eggs.gnu.org ([209.51.188.92]:36713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtcf1-0005eK-M1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtcey-0005IQ-Ta
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:19:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtcey-0004cI-Co
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:19:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id x10so4063967wmg.2
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:19:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 18:19:17 +0000
Message-Id: <20190212181917.8322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/intc/armv7m_nvic: Allow byte accesses to
 SHPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Julia Suvorova <jusual@mail.ru>

The code for handling the NVIC SHPR1 register intends to permit
byte and halfword accesses (as the architecture requires). However
the 'case' line for it only lists the base address of the
register, so attempts to access bytes other than the first one
end up in the "bad write" default logic. This bug was added
accidentally when we split out the SHPR1 logic from SHPR2 and
SHPR3 to support v6M.

Fixes: 7c9140afd594 ("nvic: Handle ARMv6-M SCS reserved registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The Zephyr RTOS happens to access SHPR1 byte at a time,
which is how I spotted this.
---
 hw/intc/armv7m_nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 790a3d95849..2fd40f9dc4c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1956,7 +1956,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         }
         nvic_irq_update(s);
         return MEMTX_OK;
-    case 0xd18: /* System Handler Priority (SHPR1) */
+    case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             return MEMTX_OK;
         }
-- 
2.20.1
