Received: from eggs.gnu.org ([2001:4830:134:3::10]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVh-0007Qs-Af
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVg-0008Nk-EY
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:40:01 -0400
Received: from foss.arm.com ([217.140.101.70]:46194)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVg-0008Mf-8Y
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:40:00 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 20 Jul 2018 16:39:42 +0100
Message-Id: <20180720153942.26821-5-andre.przywara@arm.com>
In-Reply-To: <20180720153942.26821-1-andre.przywara@arm.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 4/4] arm/arm64: GICv2: add
 GICD_ITARGETSR testing
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

Some tests for the ITARGETS registers.
Bits corresponding to non-existent CPUs must be RAZ/WI.
These registers must be byte-accessible, also check that accesses beyond
the implemented IRQ limit are actually read-as-zero/write-ignore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 lib/arm/asm/gic.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 57a2995..ed5642e 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -431,6 +431,46 @@ static void test_priorities(int nr_irqs, void *priptr)
 	writel(orig_prio, first_spi);
 }
 
+/* GICD_ITARGETSR is only used by GICv2. */
+static void test_targets(int nr_irqs)
+{
+	void *targetsptr = gicv2_dist_base() + GICD_ITARGETSR;
+	u32 orig_targets;
+	u32 cpu_mask;
+	u32 pattern, reg;
+
+	orig_targets = readl(targetsptr + GIC_FIRST_SPI);
+	report_prefix_push("ITARGETSR");
+
+	cpu_mask = (1 << nr_cpus) - 1;
+	cpu_mask |= cpu_mask << 8;
+	cpu_mask |= cpu_mask << 16;
+
+	/* Check that bits for non implemented CPUs are RAZ/WI. */
+	if (nr_cpus < 8) {
+		writel(0xffffffff, targetsptr + GIC_FIRST_SPI);
+		report("bits for %d non-existent CPUs masked",
+		       !(readl(targetsptr + GIC_FIRST_SPI) & ~cpu_mask),
+		       8 - nr_cpus);
+	} else {
+		report_skip("CPU masking (all CPUs implemented)");
+	}
+
+	report("accesses beyond limit RAZ/WI",
+	       test_readonly_32(targetsptr + nr_irqs, true));
+
+	pattern = 0x0103020f;
+	writel(pattern, targetsptr + GIC_FIRST_SPI);
+	reg = readl(targetsptr + GIC_FIRST_SPI);
+	report("register content preserved (%08x => %08x)",
+	       reg == (pattern & cpu_mask), pattern & cpu_mask, reg);
+
+	/* The TARGETS registers are byte accessible. */
+	test_byte_access(targetsptr + GIC_FIRST_SPI, pattern, cpu_mask);
+
+	writel(orig_targets, targetsptr + GIC_FIRST_SPI);
+}
+
 static void gic_test_mmio(void)
 {
 	u32 reg;
@@ -467,6 +507,9 @@ static void gic_test_mmio(void)
 	       reg);
 
 	test_priorities(nr_irqs, gic_dist_base + GICD_IPRIORITYR);
+
+	if (gic_version() == 2)
+		test_targets(nr_irqs);
 }
 
 int main(int argc, char **argv)
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index a469645..f6dfb90 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -20,6 +20,7 @@
 #define GICD_ISACTIVER			0x0300
 #define GICD_ICACTIVER			0x0380
 #define GICD_IPRIORITYR			0x0400
+#define GICD_ITARGETSR			0x0800
 #define GICD_SGIR			0x0f00
 #define GICD_ICPIDR2			0x0fe8
 
-- 
2.14.4
