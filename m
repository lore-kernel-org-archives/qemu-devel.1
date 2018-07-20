Received: from eggs.gnu.org ([2001:4830:134:3::10]:57621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVd-0007PX-Qp
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVc-0008I6-N3
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:57 -0400
Received: from foss.arm.com ([217.140.101.70]:46160)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVc-0008HA-FK
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:56 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 20 Jul 2018 16:39:40 +0100
Message-Id: <20180720153942.26821-3-andre.przywara@arm.com>
In-Reply-To: <20180720153942.26821-1-andre.przywara@arm.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 2/4] arm/arm64: GIC: basic
 GICv2 MMIO tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

This adds an MMIO subtest to the GIC test.
It accesses some generic GICv2 registers and does some sanity tests,
like checking for some of them being read-only.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c         | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg | 18 +++++++++++
 lib/arm/asm/gic.h |  4 +++
 3 files changed, 113 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 5dd958e..23cb9a4 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -3,6 +3,7 @@
  *
  * GICv2
  *   + test sending/receiving IPIs
+ *   + MMIO access tests
  * GICv3
  *   + test sending/receiving IPIs
  *
@@ -303,6 +304,92 @@ static void run_active_clear_test(void)
 	report_prefix_pop();
 }
 
+static bool test_ro_pattern_32(void *address, u32 pattern, u32 orig)
+{
+	u32 reg;
+
+	writel(pattern, address);
+	reg = readl(address);
+
+	if (reg != orig)
+		writel(orig, address);
+
+	return reg == orig;
+}
+
+static bool test_readonly_32(void *address, bool razwi)
+{
+	u32 orig, pattern;
+
+	orig = readl(address);
+	if (razwi && orig)
+		return false;
+
+	pattern = 0xffffffff;
+	if (orig != pattern) {
+		if (!test_ro_pattern_32(address, pattern, orig))
+			return false;
+	}
+
+	pattern = 0xa5a55a5a;
+	if (orig != pattern) {
+		if (!test_ro_pattern_32(address, pattern, orig))
+			return false;
+	}
+
+	pattern = 0;
+	if (orig != pattern) {
+		if (!test_ro_pattern_32(address, pattern, orig))
+			return false;
+	}
+
+	return true;
+}
+
+static void test_typer_v2(uint32_t reg)
+{
+	int nr_gic_cpus = ((reg >> 5) & 0x7) + 1;
+
+	report("all %d CPUs have interrupts", nr_cpus == nr_gic_cpus,
+	       nr_gic_cpus);
+}
+
+static void gic_test_mmio(void)
+{
+	u32 reg;
+	int nr_irqs;
+	void *gic_dist_base, *idreg;
+
+	switch(gic_version()) {
+	case 0x2:
+		gic_dist_base = gicv2_dist_base();
+		idreg = gic_dist_base + GICD_ICPIDR2;
+		break;
+	case 0x3:
+		report_abort("GICv3 MMIO tests NYI");
+	default:
+		report_abort("GIC version %d not supported", gic_version());
+	}
+
+	reg = readl(gic_dist_base + GICD_TYPER);
+	nr_irqs = GICD_TYPER_IRQS(reg);
+	report_info("number of implemented SPIs: %d", nr_irqs - GIC_FIRST_SPI);
+
+	test_typer_v2(reg);
+
+	report_info("IIDR: 0x%08x", readl(gic_dist_base + GICD_IIDR));
+
+	report("GICD_TYPER is read-only",
+	       test_readonly_32(gic_dist_base + GICD_TYPER, false));
+	report("GICD_IIDR is read-only",
+	       test_readonly_32(gic_dist_base + GICD_IIDR, false));
+
+	reg = readl(idreg);
+	report("ICPIDR2 is read-only (0x%08x)",
+	       test_readonly_32(idreg, false),
+	       reg);
+}
+
 int main(int argc, char **argv)
 {
 	if (!gic_init()) {
@@ -330,6 +417,10 @@ int main(int argc, char **argv)
 		on_cpus(ipi_test, NULL);
 	} else if (strcmp(argv[1], "active") == 0) {
 		run_active_clear_test();
+	} else if (strcmp(argv[1], "mmio") == 0) {
+		report_prefix_push(argv[1]);
+		gic_test_mmio();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown subtest '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 44b98cf..7f3a321 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -86,6 +86,24 @@ smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
 extra_params = -machine gic-version=2 -append 'ipi'
 groups = gic
 
+[gicv2-mmio]
+file = gic.flat
+smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
+extra_params = -machine gic-version=2 -append 'mmio'
+groups = gic
+
+[gicv2-mmio-up]
+file = gic.flat
+smp = 1
+extra_params = -machine gic-version=2 -append 'mmio'
+groups = gic
+
+[gicv2-mmio-3p]
+file = gic.flat
+smp = $((($MAX_SMP < 3)?$MAX_SMP:3))
+extra_params = -machine gic-version=2 -append 'mmio'
+groups = gic
+
 [gicv3-ipi]
 file = gic.flat
 smp = $MAX_SMP
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 2eb4af8..a469645 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -6,10 +6,13 @@
 #ifndef _ASMARM_GIC_H_
 #define _ASMARM_GIC_H_
 
+#define GIC_NR_PRIVATE_IRQS		32
+#define GIC_FIRST_SPI			GIC_NR_PRIVATE_IRQS
 
 /* Distributor registers */
 #define GICD_CTLR			0x0000
 #define GICD_TYPER			0x0004
+#define GICD_IIDR			0x0008
 #define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_ISPENDR			0x0200
@@ -18,6 +21,7 @@
 #define GICD_ICACTIVER			0x0380
 #define GICD_IPRIORITYR			0x0400
 #define GICD_SGIR			0x0f00
+#define GICD_ICPIDR2			0x0fe8
 
 #define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
 #define GICD_INT_EN_SET_SGI		0x0000ffff
-- 
2.14.4
