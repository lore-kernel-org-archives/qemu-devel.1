Received: from eggs.gnu.org ([209.51.188.92]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLJ-00082q-US
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLH-0004so-Ua
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLH-0004kk-Et
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id a62so7506563wmh.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:49 +0000
Message-Id: <20190214190603.25030-14-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/27] hw/intc/armv7m_nvic: Allow byte accesses
 to SHPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The code for handling the NVIC SHPR1 register intends to permit
byte and halfword accesses (as the architecture requires). However
the 'case' line for it only lists the base address of the
register, so attempts to access bytes other than the first one
end up in the "bad write" default logic. This bug was added
accidentally when we split out the SHPR1 logic from SHPR2 and
SHPR3 to support v6M.

Fixes: 7c9140afd594 ("nvic: Handle ARMv6-M SCS reserved registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
The Zephyr RTOS happens to access SHPR1 byte at a time,
which is how I spotted this.
---
 hw/intc/armv7m_nvic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 790a3d95849..ab822f42514 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1841,7 +1841,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0xd18: /* System Handler Priority (SHPR1) */
+    case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             val = 0;
             break;
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
