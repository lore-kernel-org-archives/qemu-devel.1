Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQl-000897-IC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQk-0004Lv-Qs
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:51 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:00:07 +0100
Message-Id: <1506092407-26985-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 20/20] nvic: Add missing code for writing
 SHCSR.HARDFAULTPENDED bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

When we added support for the new SHCSR bits in v8M in commit
437d59c17e9 the code to support writing to the new HARDFAULTPENDED
bit was accidentally only added for non-secure writes; the
secure banked version of the bit should also be writable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index bd1d5d3..22d5e6e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1230,6 +1230,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             s->sec_vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
             s->sec_vectors[ARMV7M_EXCP_USAGE].enabled =
                 (value & (1 << 18)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
             /* SecureFault not banked, but RAZ/WI to NS */
             s->vectors[ARMV7M_EXCP_SECURE].active = (value & (1 << 4)) != 0;
             s->vectors[ARMV7M_EXCP_SECURE].enabled = (value & (1 << 19)) != 0;
-- 
2.7.4
