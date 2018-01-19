Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7W-0002pE-9v
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7V-0003mf-Fq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:18 -0500
From: luc.michel@greensocs.com
Date: Fri, 19 Jan 2018 15:57:55 +0100
Message-Id: <20180119145756.7629-5-luc.michel@greensocs.com>
In-Reply-To: <20180119145756.7629-1-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 3/4] hw/intc/arm_gic: Fix group priority
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
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

From: Luc MICHEL <luc.michel@git.antfield.fr>

When determining the group priority of a group 1 IRQ, if C_CTRL.CBPR is
0, the non-secure BPR value is used. However, this value must be
incremented by one so that it matches the secure world number of
implemented priority bits (NS world has one less priority bit compared
to the Secure world).

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
---
 hw/intc/arm_gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 713de3084f..d0a41a89ae 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -256,7 +256,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
     if (gic_has_groups(s) &&
         !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
         GIC_TEST_GROUP(irq, (1 << cpu))) {
-        bpr = s->abpr[cpu];
+        bpr = s->abpr[cpu] - 1;
     } else {
         bpr = s->bpr[cpu];
     }
-- 
2.16.0
