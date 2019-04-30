Received: from eggs.gnu.org ([209.51.188.92]:44524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSar-00010e-0H
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSap-0002Aw-Vu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSap-0002AJ-Pa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so3791786wmc.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 14:14:36 +0100
Message-Id: <20190430131439.25251-2-peter.maydell@linaro.org>
In-Reply-To: <20190430131439.25251-1-peter.maydell@linaro.org>
References: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] hw/arm/armv7m_nvic: Check subpriority in
 nvic_recompute_state_secure()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Rule R_CQRV says that if two pending interrupts have the same
group priority then ties are broken by looking at the subpriority.
We had a comment describing this but had forgotten to actually
implement the subpriority comparison. Correct the omission.

(The further tie break rules of "lowest exception number" and
"secure before non-secure" are handled implicitly by the order
in which we iterate through the exceptions in the loops.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index fff6e694e60..131b5938b9a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -213,6 +213,7 @@ static void nvic_recompute_state_secure(NVICState *s)
     int active_prio = NVIC_NOEXC_PRIO;
     int pend_irq = 0;
     bool pending_is_s_banked = false;
+    int pend_subprio = 0;
 
     /* R_CQRV: precedence is by:
      *  - lowest group priority; if both the same then
@@ -226,7 +227,7 @@ static void nvic_recompute_state_secure(NVICState *s)
     for (i = 1; i < s->num_irq; i++) {
         for (bank = M_REG_S; bank >= M_REG_NS; bank--) {
             VecInfo *vec;
-            int prio;
+            int prio, subprio;
             bool targets_secure;
 
             if (bank == M_REG_S) {
@@ -241,8 +242,12 @@ static void nvic_recompute_state_secure(NVICState *s)
             }
 
             prio = exc_group_prio(s, vec->prio, targets_secure);
-            if (vec->enabled && vec->pending && prio < pend_prio) {
+            subprio = vec->prio & ~nvic_gprio_mask(s, targets_secure);
+            if (vec->enabled && vec->pending &&
+                ((prio < pend_prio) ||
+                 (prio == pend_prio && prio >= 0 && subprio < pend_subprio))) {
                 pend_prio = prio;
+                pend_subprio = subprio;
                 pend_irq = i;
                 pending_is_s_banked = (bank == M_REG_S);
             }
-- 
2.20.1
