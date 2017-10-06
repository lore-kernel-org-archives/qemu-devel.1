Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1q-0004Ng-1a
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1l-0007qv-J9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1l-0007eF-AN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1a-0002se-0F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:29 +0100
Message-Id: <1507305585-20608-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/20] nvic: Clear the vector arrays and
 prigroup on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1506092407-26985-2-git-send-email-peter.maydell@linaro.org
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
