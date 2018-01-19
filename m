Received: from eggs.gnu.org ([2001:4830:134:3::10]:47094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7W-0002pB-8j
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ecY7V-0003mT-EK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:58:18 -0500
From: luc.michel@greensocs.com
Date: Fri, 19 Jan 2018 15:57:51 +0100
Message-Id: <20180119145756.7629-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 0/4] arm_gic: Various fixes
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

Hi,

Here is a patch set for issues I found in the GIC. I found those by
writing unitary tests for the GIC, and compared the result against
real hardware (a Zynq UltraScale+ board with a GICv2).

The first patch prevents the GIC from signaling an IRQ that is in the
"active and pending" state. I encountered this bug in a test where I
split end of interrupt and interrupt deactivation. The GIC was
re-signaling the IRQ after priority drop if it was raised again, while
it has not been deactivated yet (and thus was in the "active and
pending" state).

The second patch returns a correct "Idle priority" value when reading
C_RPR if there is no active interrupt.

The last two patches fix issues around the Binary Point Register (the
group priority computation of group 1 IRQs when C_CTRL.CBPR is 0, and
the non-secure view of C_BPR when C_CTRL.CBPR is 1).

Luc MICHEL (4):
  hw/intc/arm_gic: Prevent the GIC from signaling an IRQ when it's
    "active and pending"
  hw/intc/arm_gic: Fix C_RPR value on idle priority
  hw/intc/arm_gic: Fix group priority computation for group 1 IRQs
  hw/intc/arm_gic: Fix the NS view of C_BPR when C_CTRL.CBPR is 1

 hw/intc/arm_gic.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.16.0
