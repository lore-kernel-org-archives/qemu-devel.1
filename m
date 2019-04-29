Received: from eggs.gnu.org ([209.51.188.92]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DU-OT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Pz-D2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-0006Ab-1N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so17083544wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:53 +0100
Message-Id: <20190429170030.11323-6-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/42] hw/intc/armv7m_nvic: Allow reading of
 M-profile MVFR* registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M-profile the MVFR* ID registers are memory mapped, in the
range we implement via the NVIC. Allow them to be read.
(If the CPU has no FPU, these registers are defined to be RAZ.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-3-peter.maydell@linaro.org
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
