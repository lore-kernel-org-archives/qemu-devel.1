Received: from eggs.gnu.org ([2001:4830:134:3::10]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XO-00035N-3R
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-00034p-UQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XM-0002sG-Nk
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XD-00054Y-2o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:14 +0100
Message-Id: <1506012099-13605-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/31] nvic: Make ICSR.RETTOBASE handle banked
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Update the code in nvic_rettobase() so that it checks the
sec_vectors[] array as well as the vectors[] array if needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-7-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d745f38..0df5eaf 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -84,9 +84,12 @@ static int nvic_pending_prio(NVICState *s)
 static bool nvic_rettobase(NVICState *s)
 {
     int irq, nhand = 0;
+    bool check_sec = arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY);
 
     for (irq = ARMV7M_EXCP_RESET; irq < s->num_irq; irq++) {
-        if (s->vectors[irq].active) {
+        if (s->vectors[irq].active ||
+            (check_sec && irq < NVIC_INTERNAL_VECTORS &&
+             s->sec_vectors[irq].active)) {
             nhand++;
             if (nhand == 2) {
                 return 0;
-- 
2.7.4
