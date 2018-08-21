Received: from eggs.gnu.org ([2001:4830:134:3::10]:60576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6i8-00064x-Hi
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6i7-0003vv-Nw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 14:28:03 +0100
Message-Id: <20180821132811.17675-2-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-1-peter.maydell@linaro.org>
References: <20180821132811.17675-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/9] hw/intc/arm_gic: Document QEMU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>

The GICv2's QEMU interface (sysbus MMIO regions, IRQs,
etc) is now quite complicated with the addition of the
virtualization extensions. Add a comment in the header
file which documents it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I needed to write this out to figure out what I was
connecting to what in the a15mpcore object :-)
---
 include/hw/intc/arm_gic.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 42bb535fd45..989bc837606 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -18,6 +18,41 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/*
+ * QEMU interface:
+ *  + QOM property "num-cpu": number of CPUs to support
+ *  + QOM property "num-irq": number of IRQs (including both SPIs and PPIs)
+ *  + QOM property "revision": GIC version (1 or 2), or 0 for the 11MPCore GIC
+ *  + QOM property "has-security-extensions": set true if the GIC should
+ *    implement the security extensions
+ *  + QOM property "has-virtualization-extensions": set true if the GIC should
+ *    implement the virtualization extensions
+ *  + unnamed GPIO inputs: (where P is number of PPIs, i.e. num-irq - 32)
+ *    [0..P-1]  SPIs
+ *    [P..P+31] PPIs for CPU 0
+ *    [P+32..P+63] PPIs for CPU 1
+ *    ...
+ *  + sysbus IRQ 0 : IRQ
+ *  + sysbus IRQ 1 : FIQ
+ *  + sysbus IRQ 2 : VIRQ (exists even if virt extensions not present)
+ *  + sysbus IRQ 3 : VFIQ (exists even if virt extensions not present)
+ *  + sysbus IRQ 4 : maintenance IRQ for CPU i/f 0 (only if virt extns present)
+ *  + sysbus IRQ 5 : maintenance IRQ for CPU i/f 1 (only if virt extns present)
+ *    ...
+ *  + sysbus MMIO regions: (in order; numbers will vary depending on
+ *    whether virtualization extensions are present and on number of cores)
+ *    - distributor registers (GICD*)
+ *    - CPU interface for the accessing core (GICC*)
+ *    - virtual interface control registers (GICH*) (only if virt extns present)
+ *    - virtual CPU interface for the accessing core (GICV*) (only if virt)
+ *    - CPU 0 CPU interface registers
+ *    - CPU 1 CPU interface registers
+ *      ...
+ *    - CPU 0 VCPU interface registers (only if virt extns present)
+ *    - CPU 1 VCPU interface registers (only if virt extns present)
+ *      ...
+ */
+
 #ifndef HW_ARM_GIC_H
 #define HW_ARM_GIC_H
 
-- 
2.18.0
