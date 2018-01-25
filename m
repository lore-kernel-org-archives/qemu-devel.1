Received: from eggs.gnu.org ([2001:4830:134:3::10]:33731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoi-0003H5-Hk
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoh-0003AY-JM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoh-00038r-B5
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:47 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehof-0006wU-O9
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:24 +0000
Message-Id: <1516887809-6265-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/21] hw/intc/arm_gic: Fix group priority
 computation for group 1 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc MICHEL <luc.michel@git.antfield.fr>

When determining the group priority of a group 1 IRQ, if C_CTRL.CBPR is
0, the non-secure BPR value is used. However, this value must be
incremented by one so that it matches the secure world number of
implemented priority bits (NS world has one less priority bit compared
to the Secure world).

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
Message-id: 20180119145756.7629-5-luc.michel@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: add assert, as the gicv3 code has]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 713de30..b7989d2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -256,7 +256,8 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
     if (gic_has_groups(s) &&
         !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
         GIC_TEST_GROUP(irq, (1 << cpu))) {
-        bpr = s->abpr[cpu];
+        bpr = s->abpr[cpu] - 1;
+        assert(bpr >= 0);
     } else {
         bpr = s->bpr[cpu];
     }
-- 
2.7.4
