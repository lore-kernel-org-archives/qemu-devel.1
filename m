Received: from eggs.gnu.org ([2001:4830:134:3::10]:50951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsn0b-0001Ik-FB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsn0a-0000y7-CK
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:38:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 11:38:18 +0100
Message-Id: <20180823103818.31189-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] hw/intc/arm_gic: Document QEMU interface
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

v1->v2 changes: fixed errors in sysbus IRQ and per-cpu GICH
memory region docs pointed out by Luc.

 include/hw/intc/arm_gic.h | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 42bb535fd45..1af5051ed5d 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -18,6 +18,49 @@
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
+ *  + sysbus IRQs: (in order; number will vary depending on number of cores)
+ *    - IRQ for CPU 0
+ *    - IRQ for CPU 1
+ *      ...
+ *    - FIQ for CPU 0
+ *    - FIQ for CPU 1
+ *      ...
+ *    - VIRQ for CPU 0 (exists even if virt extensions not present)
+ *    - VIRQ for CPU 1 (exists even if virt extensions not present)
+ *      ...
+ *    - VFIQ for CPU 0 (exists even if virt extensions not present)
+ *    - VFIQ for CPU 1 (exists even if virt extensions not present)
+ *      ...
+ *    - maintenance IRQ for CPU i/f 0 (only if virt extensions present)
+ *    - maintenance IRQ for CPU i/f 1 (only if virt extensions present)
+ *  + sysbus MMIO regions: (in order; numbers will vary depending on
+ *    whether virtualization extensions are present and on number of cores)
+ *    - distributor registers (GICD*)
+ *    - CPU interface for the accessing core (GICC*)
+ *    - virtual interface control registers (GICH*) (only if virt extns present)
+ *    - virtual CPU interface for the accessing core (GICV*) (only if virt)
+ *    - CPU 0 CPU interface registers
+ *    - CPU 1 CPU interface registers
+ *      ...
+ *    - CPU 0 virtual interface control registers (only if virt extns present)
+ *    - CPU 1 virtual interface control registers (only if virt extns present)
+ *      ...
+ */
+
 #ifndef HW_ARM_GIC_H
 #define HW_ARM_GIC_H
 
-- 
2.18.0
