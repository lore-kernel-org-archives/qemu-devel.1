Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgy-0003Nb-8m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgx-0006OM-3M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:48 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:53 +0100
Message-Id: <1505240046-11454-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/19] nvic: Make ICSR.RETTOBASE handle banked
 exceptions
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

Update the code in nvic_rettobase() so that it checks the
sec_vectors[] array as well as the vectors[] array if needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 585b1a7..edaf60c 100644
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
