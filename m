Received: from eggs.gnu.org ([2001:4830:134:3::10]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSj-0003oi-ED
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSg-0006Ks-Q0
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:05 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:07 +0200
Message-Id: <20180727095421.386-7-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 06/20] intc/arm_gic: Add virtual interface
 register definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Add the register definitions for the virtual interface of the GICv2.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gic_internal.h | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index c85427c8e3..1aa888a576 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -19,10 +19,11 @@
  */
 
 #ifndef QEMU_ARM_GIC_INTERNAL_H
 #define QEMU_ARM_GIC_INTERNAL_H
 
+#include "hw/registerfields.h"
 #include "hw/intc/arm_gic.h"
 
 #define ALL_CPU_MASK ((unsigned)(((1 << GIC_NCPU) - 1)))
 
 #define GIC_BASE_IRQ 0
@@ -62,10 +63,74 @@
 #define GICC_CTLR_FIQ_EN     (1U << 3)
 #define GICC_CTLR_CBPR       (1U << 4) /* GICv1: SBPR */
 #define GICC_CTLR_EOIMODE    (1U << 9)
 #define GICC_CTLR_EOIMODE_NS (1U << 10)
 
+REG32(GICH_HCR, 0x0)
+    FIELD(GICH_HCR, EN, 0, 1)
+    FIELD(GICH_HCR, UIE, 1, 1)
+    FIELD(GICH_HCR, LRENPIE, 2, 1)
+    FIELD(GICH_HCR, NPIE, 3, 1)
+    FIELD(GICH_HCR, VGRP0EIE, 4, 1)
+    FIELD(GICH_HCR, VGRP0DIE, 5, 1)
+    FIELD(GICH_HCR, VGRP1EIE, 6, 1)
+    FIELD(GICH_HCR, VGRP1DIE, 7, 1)
+    FIELD(GICH_HCR, EOICount, 27, 5)
+
+#define GICH_HCR_MASK \
+    (R_GICH_HCR_EN_MASK | R_GICH_HCR_UIE_MASK | \
+     R_GICH_HCR_LRENPIE_MASK | R_GICH_HCR_NPIE_MASK | \
+     R_GICH_HCR_VGRP0EIE_MASK | R_GICH_HCR_VGRP0DIE_MASK | \
+     R_GICH_HCR_VGRP1EIE_MASK | R_GICH_HCR_VGRP1DIE_MASK | \
+     R_GICH_HCR_EOICount_MASK)
+
+REG32(GICH_VTR, 0x4)
+    FIELD(GICH_VTR, ListRegs, 0, 6)
+    FIELD(GICH_VTR, PREbits, 26, 3)
+    FIELD(GICH_VTR, PRIbits, 29, 3)
+
+REG32(GICH_VMCR, 0x8)
+    FIELD(GICH_VMCR, VMCCtlr, 0, 10)
+    FIELD(GICH_VMCR, VMABP, 18, 3)
+    FIELD(GICH_VMCR, VMBP, 21, 3)
+    FIELD(GICH_VMCR, VMPriMask, 27, 5)
+
+REG32(GICH_MISR, 0x10)
+    FIELD(GICH_MISR, EOI, 0, 1)
+    FIELD(GICH_MISR, U, 1, 1)
+    FIELD(GICH_MISR, LRENP, 2, 1)
+    FIELD(GICH_MISR, NP, 3, 1)
+    FIELD(GICH_MISR, VGrp0E, 4, 1)
+    FIELD(GICH_MISR, VGrp0D, 5, 1)
+    FIELD(GICH_MISR, VGrp1E, 6, 1)
+    FIELD(GICH_MISR, VGrp1D, 7, 1)
+
+REG32(GICH_EISR0, 0x20)
+REG32(GICH_EISR1, 0x24)
+REG32(GICH_ELRSR0, 0x30)
+REG32(GICH_ELRSR1, 0x34)
+REG32(GICH_APR, 0xf0)
+
+REG32(GICH_LR0, 0x100)
+    FIELD(GICH_LR0, VirtualID, 0, 10)
+    FIELD(GICH_LR0, PhysicalID, 10, 10)
+    FIELD(GICH_LR0, CPUID, 10, 3)
+    FIELD(GICH_LR0, EOI, 19, 1)
+    FIELD(GICH_LR0, Priority, 23, 5)
+    FIELD(GICH_LR0, State, 28, 2)
+    FIELD(GICH_LR0, Grp1, 30, 1)
+    FIELD(GICH_LR0, HW, 31, 1)
+
+/* Last LR register */
+REG32(GICH_LR63, 0x1fc)
+
+#define GICH_LR_MASK \
+    (R_GICH_LR0_VirtualID_MASK | R_GICH_LR0_PhysicalID_MASK | \
+     R_GICH_LR0_CPUID_MASK | R_GICH_LR0_EOI_MASK | \
+     R_GICH_LR0_Priority_MASK | R_GICH_LR0_State_MASK | \
+     R_GICH_LR0_Grp1_MASK | R_GICH_LR0_HW_MASK)
+
 /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
  * GICv2 and GICv2 with security extensions:
  */
 #define GICC_CTLR_V1_MASK    0x1
 #define GICC_CTLR_V1_S_MASK  0x1f
-- 
2.18.0
