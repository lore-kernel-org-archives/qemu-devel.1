Received: from eggs.gnu.org ([2001:4830:134:3::10]:46874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQW-0007tX-6h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQV-00042U-A3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:48 +0100
Message-Id: <1506092407-26985-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/20] nvic: Clear the vector arrays and
 prigroup on reset
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

Reset for devices does not include an automatic clear of the
device state (unlike CPU state, where most of the state
structure is cleared to zero). Add some missing initialization
of NVIC state that meant that the device was left in the wrong
state if the guest did a warm reset.

(In particular, since we were resetting the computed state like
s->exception_prio but not all the state it was computed
from like s->vectors[x].active, the NVIC wound up in an
inconsistent state that could later trigger assertion failures.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d90d8d0..bc7b66d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1782,6 +1782,11 @@ static void armv7m_nvic_reset(DeviceState *dev)
     int resetprio;
     NVICState *s = NVIC(dev);
 
+    memset(s->vectors, 0, sizeof(s->vectors));
+    memset(s->sec_vectors, 0, sizeof(s->sec_vectors));
+    s->prigroup[M_REG_NS] = 0;
+    s->prigroup[M_REG_S] = 0;
+
     s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
     /* MEM, BUS, and USAGE are enabled through
      * the System Handler Control register
-- 
2.7.4
