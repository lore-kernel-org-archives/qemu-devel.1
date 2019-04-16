Received: from eggs.gnu.org ([209.51.188.92]:34341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf0-0004TX-Jp
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNex-00014z-7X
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNet-00010w-Cw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id z24so25490158wmi.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:20 +0100
Message-Id: <20190416125744.27770-3-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/26] hw/intc/armv7m_nvic: Allow reading of
 M-profile MVFR* registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

For M-profile the MVFR* ID registers are memory mapped, in the
range we implement via the NVIC. Allow them to be read.
(If the CPU has no FPU, these registers are defined to be RAZ.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index ab822f42514..45d72f86bdf 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1222,6 +1222,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return 0;
         }
         return cpu->env.v7m.sfar;
+    case 0xf40: /* MVFR0 */
+        return cpu->isar.mvfr0;
+    case 0xf44: /* MVFR1 */
+        return cpu->isar.mvfr1;
+    case 0xf48: /* MVFR2 */
+        return cpu->isar.mvfr2;
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
-- 
2.20.1
