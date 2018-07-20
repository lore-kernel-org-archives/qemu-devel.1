Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVf-0007PY-H2
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVe-0008KV-Gi
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:59 -0400
Received: from foss.arm.com ([217.140.101.70]:46176)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVe-0008JP-Ap
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:58 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 20 Jul 2018 16:39:41 +0100
Message-Id: <20180720153942.26821-4-andre.przywara@arm.com>
In-Reply-To: <20180720153942.26821-1-andre.przywara@arm.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 3/4] arm/arm64: GICv2: add
 GICD_IPRIORITYR testing
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

Some tests for the IPRIORITY registers. The significant number of bits
is IMPLEMENTATION DEFINED, but should be the same for every IRQ.
Also these registers must be byte-accessible.
Check that accesses beyond the implemented IRQ limit are actually
read-as-zero/write-ignore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 23cb9a4..57a2995 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -354,6 +354,83 @@ static void test_typer_v2(uint32_t reg)
 	       nr_gic_cpus);
 }
 
+#define BYTE(reg32, byte) (((reg32) >> ((byte) * 8)) & 0xff)
+#define REPLACE_BYTE(reg32, byte, new) (((reg32) & ~(0xff << ((byte) * 8))) |\
+					((new) << ((byte) * 8)))
+
+/*
+ * Some registers are byte accessible, do a byte-wide read and write of known
+ * content to check for this.
+ * Apply a @mask to cater for special register properties.
+ * @pattern contains the value already in the register.
+ */
+static void test_byte_access(void *base_addr, u32 pattern, u32 mask)
+{
+	u32 reg = readb(base_addr + 1);
+
+	report("byte reads successful (0x%08x => 0x%02x)",
+	       reg == (BYTE(pattern, 1) & (mask >> 8)),
+	       pattern & mask, reg);
+
+	pattern = REPLACE_BYTE(pattern, 2, 0x1f);
+	writeb(BYTE(pattern, 2), base_addr + 2);
+	reg = readl(base_addr);
+	report("byte writes successful (0x%02x => 0x%08x)",
+	       reg == (pattern & mask), BYTE(pattern, 2), reg);
+}
+
+static void test_priorities(int nr_irqs, void *priptr)
+{
+	u32 orig_prio, reg, pri_bits;
+	u32 pri_mask, pattern;
+	void *first_spi = priptr + GIC_FIRST_SPI;
+
+	orig_prio = readl(first_spi);
+	report_prefix_push("IPRIORITYR");
+
+	/*
+	 * Determine implemented number of priority bits by writing all 1's
+	 * and checking the number of cleared bits in the value read back.
+	 */
+	writel(0xffffffff, first_spi);
+	pri_mask = readl(first_spi);
+
+	reg = ~pri_mask;
+	report("consistent priority masking (0x%08x)",
+	       (((reg >> 16) == (reg & 0xffff)) &&
+	        ((reg & 0xff) == ((reg >> 8) & 0xff))), pri_mask);
+
+	reg = reg & 0xff;
+	for (pri_bits = 8; reg & 1; reg >>= 1, pri_bits--)
+		;
+	report("implements at least 4 priority bits (%d)",
+	       pri_bits >= 4, pri_bits);
+
+	pattern = 0;
+	writel(pattern, first_spi);
+	report("clearing priorities", readl(first_spi) == pattern);
+
+	/* setting all priorities to their max valus was tested above */
+
+	report("accesses beyond limit RAZ/WI",
+	       test_readonly_32(priptr + nr_irqs, true));
+
+	writel(pattern, priptr + nr_irqs - 4);
+	report("accessing last SPIs",
+	       readl(priptr + nr_irqs - 4) == (pattern & pri_mask));
+
+	pattern = 0xff7fbf3f;
+	writel(pattern, first_spi);
+	report("priorities are preserved",
+	       readl(first_spi) == (pattern & pri_mask));
+
+	/* The PRIORITY registers are byte accessible. */
+	test_byte_access(first_spi, pattern, pri_mask);
+
+	report_prefix_pop();
+	writel(orig_prio, first_spi);
+}
+
 static void gic_test_mmio(void)
 {
 	u32 reg;
@@ -388,6 +465,8 @@ static void gic_test_mmio(void)
 	report("ICPIDR2 is read-only (0x%08x)",
 	       test_readonly_32(idreg, false),
 	       reg);
+
+	test_priorities(nr_irqs, gic_dist_base + GICD_IPRIORITYR);
 }
 
 int main(int argc, char **argv)
-- 
2.14.4
