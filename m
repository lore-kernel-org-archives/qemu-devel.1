Received: from eggs.gnu.org ([2001:4830:134:3::10]:59905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qS-0003o0-Sj
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qR-0004Fm-Fd
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:00 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:26 +0100
Message-Id: <20161208175030.12269-7-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 06/10] arm/arm64: gicv2: add
 an IPI test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
v8:
  - fix check_spurious print arguments and change the printf
    to a report_info
  - remove the self-ipi test issued when no subtest is given,
    i.e. require a subtest to be given
  - use report_summary for no supported gic present instead
    of report_abort, this will output nice SKIP message
v6: move the spurious check to its own check_ function [drew]
v5: use modern registers [Andre]
v4: properly mask irqnr in ipi_handler
v2: add more details in the output if a test fails,
    report spurious interrupts if we get them
---
 arm/Makefile.common  |  10 +--
 arm/unittests.cfg    |   8 +++
 lib/arm/asm/gic-v2.h |   2 +
 lib/arm/asm/gic.h    |   4 ++
 arm/gic.c            | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 214 insertions(+), 5 deletions(-)
 create mode 100644 arm/gic.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 0ccd6743a8fe..275f8993012a 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -9,11 +9,11 @@ ifeq ($(LOADADDR),)
 	LOADADDR = 0x40000000
 endif
 
-tests-common = \
-	$(TEST_DIR)/selftest.flat \
-	$(TEST_DIR)/spinlock-test.flat \
-	$(TEST_DIR)/pci-test.flat \
-	$(TEST_DIR)/pmu.flat
+tests-common  = $(TEST_DIR)/selftest.flat
+tests-common += $(TEST_DIR)/spinlock-test.flat
+tests-common += $(TEST_DIR)/pci-test.flat
+tests-common += $(TEST_DIR)/pmu.flat
+tests-common += $(TEST_DIR)/gic.flat
 
 all: test_cases
 
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 65f9c4c0b9eb..f61e30b8526d 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -55,6 +55,7 @@ smp = $MAX_SMP
 extra_params = -append 'smp'
 groups = selftest
 
+# Test PCI emulation
 [pci-test]
 file = pci-test.flat
 groups = pci
@@ -77,3 +78,10 @@ groups = pmu
 #extra_params = -icount 8 -append '256'
 #groups = pmu
 #accel = tcg
+
+# Test GIC emulation
+[gicv2-ipi]
+file = gic.flat
+smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
+extra_params = -machine gic-version=2 -append 'ipi'
+groups = gic
diff --git a/lib/arm/asm/gic-v2.h b/lib/arm/asm/gic-v2.h
index c2d5fecd4886..8b3f7ed6790c 100644
--- a/lib/arm/asm/gic-v2.h
+++ b/lib/arm/asm/gic-v2.h
@@ -13,7 +13,9 @@
 #endif
 
 #define GICD_ENABLE			0x1
+
 #define GICC_ENABLE			0x1
+#define GICC_IAR_INT_ID_MASK		0x3ff
 
 #ifndef __ASSEMBLY__
 
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index e3580bd1d42d..d816b96e46b4 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -13,6 +13,7 @@
 #define GICD_TYPER			0x0004
 #define GICD_ISENABLER			0x0100
 #define GICD_IPRIORITYR			0x0400
+#define GICD_SGIR			0x0f00
 
 #define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
 #define GICD_INT_EN_SET_SGI		0x0000ffff
@@ -21,8 +22,11 @@
 /* CPU interface registers */
 #define GICC_CTLR			0x0000
 #define GICC_PMR			0x0004
+#define GICC_IAR			0x000c
+#define GICC_EOIR			0x0010
 
 #define GICC_INT_PRI_THRESHOLD		0xf0
+#define GICC_INT_SPURIOUS		0x3ff
 
 #ifndef __ASSEMBLY__
 
diff --git a/arm/gic.c b/arm/gic.c
new file mode 100644
index 000000000000..744e227426bf
--- /dev/null
+++ b/arm/gic.c
@@ -0,0 +1,195 @@
+/*
+ * GIC tests
+ *
+ * GICv2
+ *   + test sending/receiving IPIs
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <libcflat.h>
+#include <asm/setup.h>
+#include <asm/processor.h>
+#include <asm/delay.h>
+#include <asm/gic.h>
+#include <asm/smp.h>
+#include <asm/barrier.h>
+#include <asm/io.h>
+
+static int gic_version;
+static int acked[NR_CPUS], spurious[NR_CPUS];
+static cpumask_t ready;
+
+static void nr_cpu_check(int nr)
+{
+	if (nr_cpus < nr)
+		report_abort("At least %d cpus required", nr);
+}
+
+static void wait_on_ready(void)
+{
+	cpumask_set_cpu(smp_processor_id(), &ready);
+	while (!cpumask_full(&ready))
+		cpu_relax();
+}
+
+static void check_acked(cpumask_t *mask)
+{
+	int missing = 0, extra = 0, unexpected = 0;
+	int nr_pass, cpu, i;
+
+	/* Wait up to 5s for all interrupts to be delivered */
+	for (i = 0; i < 50; ++i) {
+		mdelay(100);
+		nr_pass = 0;
+		for_each_present_cpu(cpu) {
+			smp_rmb();
+			nr_pass += cpumask_test_cpu(cpu, mask) ?
+				acked[cpu] == 1 : acked[cpu] == 0;
+		}
+		if (nr_pass == nr_cpus) {
+			report("Completed in %d ms", true, ++i * 100);
+			return;
+		}
+	}
+
+	for_each_present_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, mask)) {
+			if (!acked[cpu])
+				++missing;
+			else if (acked[cpu] > 1)
+				++extra;
+		} else {
+			if (acked[cpu])
+				++unexpected;
+		}
+	}
+
+	report("Timed-out (5s). ACKS: missing=%d extra=%d unexpected=%d",
+	       false, missing, extra, unexpected);
+}
+
+static void check_spurious(void)
+{
+	int cpu;
+
+	smp_rmb();
+	for_each_present_cpu(cpu) {
+		if (spurious[cpu])
+			report_info("WARN: cpu%d got %d spurious interrupts",
+				cpu, spurious[cpu]);
+	}
+}
+
+static void ipi_handler(struct pt_regs *regs __unused)
+{
+	u32 irqstat = readl(gicv2_cpu_base() + GICC_IAR);
+	u32 irqnr = irqstat & GICC_IAR_INT_ID_MASK;
+
+	if (irqnr != GICC_INT_SPURIOUS) {
+		writel(irqstat, gicv2_cpu_base() + GICC_EOIR);
+		smp_rmb(); /* pairs with wmb in ipi_test functions */
+		++acked[smp_processor_id()];
+		smp_wmb(); /* pairs with rmb in check_acked */
+	} else {
+		++spurious[smp_processor_id()];
+		smp_wmb();
+	}
+}
+
+static void ipi_test_self(void)
+{
+	cpumask_t mask;
+
+	report_prefix_push("self");
+	memset(acked, 0, sizeof(acked));
+	smp_wmb();
+	cpumask_clear(&mask);
+	cpumask_set_cpu(0, &mask);
+	writel(2 << 24, gicv2_dist_base() + GICD_SGIR);
+	check_acked(&mask);
+	report_prefix_pop();
+}
+
+static void ipi_test_smp(void)
+{
+	cpumask_t mask;
+	unsigned long tlist;
+
+	report_prefix_push("target-list");
+	memset(acked, 0, sizeof(acked));
+	smp_wmb();
+	tlist = cpumask_bits(&cpu_present_mask)[0] & 0xaa;
+	cpumask_bits(&mask)[0] = tlist;
+	writel((u8)tlist << 16, gicv2_dist_base() + GICD_SGIR);
+	check_acked(&mask);
+	report_prefix_pop();
+
+	report_prefix_push("broadcast");
+	memset(acked, 0, sizeof(acked));
+	smp_wmb();
+	cpumask_copy(&mask, &cpu_present_mask);
+	cpumask_clear_cpu(0, &mask);
+	writel(1 << 24, gicv2_dist_base() + GICD_SGIR);
+	check_acked(&mask);
+	report_prefix_pop();
+}
+
+static void ipi_enable(void)
+{
+	gicv2_enable_defaults();
+#ifdef __arm__
+	install_exception_handler(EXCPTN_IRQ, ipi_handler);
+#else
+	install_irq_handler(EL1H_IRQ, ipi_handler);
+#endif
+	local_irq_enable();
+}
+
+static void ipi_recv(void)
+{
+	ipi_enable();
+	cpumask_set_cpu(smp_processor_id(), &ready);
+	while (1)
+		wfi();
+}
+
+int main(int argc, char **argv)
+{
+	char pfx[8];
+	int cpu;
+
+	gic_version = gic_init();
+	if (!gic_version) {
+		printf("No supported gic present, skipping tests...\n");
+		return report_summary();
+	}
+
+	snprintf(pfx, sizeof(pfx), "gicv%d", gic_version);
+	report_prefix_push(pfx);
+
+	if (argc < 2)
+		report_abort("no test specified");
+
+	if (strcmp(argv[1], "ipi") == 0) {
+		report_prefix_push(argv[1]);
+		nr_cpu_check(2);
+
+		for_each_present_cpu(cpu) {
+			if (cpu == 0)
+				continue;
+			smp_boot_secondary(cpu, ipi_recv);
+		}
+		ipi_enable();
+		wait_on_ready();
+		ipi_test_self();
+		ipi_test_smp();
+		check_spurious();
+		report_prefix_pop();
+	} else {
+		report_abort("Unknown subtest '%s'", argv[1]);
+	}
+
+	return report_summary();
+}
-- 
2.9.3
