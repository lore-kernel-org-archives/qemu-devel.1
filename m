Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qd-0004SO-Vj
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qc-0004JC-GK
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:12 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:30 +0100
Message-Id: <20161208175030.12269-11-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 10/10] arm/arm64: gic: don't
 just use zero
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

Instead of using cpu0 and irq=0 for the IPI test, use something
a bit more interesting. To make sure we can still run the test
with the minimal number of cpus (2), we need to use sender=1. As
the irq in the test (an SGI) can only be 0 to 15 and there's really
no difference, then use irq=1. sender=1 is a bit limited for the
long term, as we may want to test IPIs across host sockets with
pinned vcpus. But we can improve on this later, possibly with the
introduction of a command line parameter.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>

---
v8:
 - remove crufy command line parsing. No need for sender or irq
   to be input right now.
v7:
 - cleanup cmdline parsing and add complain on bad args [Eric]
v6:
 - make sender/irq names more future-proof [drew]
 - sanity check inputs [drew]
 - introduce check_sender/irq and bad_sender/irq to more
   cleanly do checks [drew]
 - default sender and irq to 1, instead of still zero [drew]
v4: improve structure and make sure spurious checking is
    done even when the sender isn't cpu0
v2: actually check that the irq received was the irq sent,
    and (for gicv2) that the sender is the expected one.
---
 arm/gic.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 23 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index d0d3be0fa36e..3054d45f7387 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -19,6 +19,9 @@
 #include <asm/barrier.h>
 #include <asm/io.h>
 
+#define IPI_SENDER	1
+#define IPI_IRQ		1
+
 struct gic {
 	struct {
 		void (*send_self)(void);
@@ -28,6 +31,7 @@ struct gic {
 
 static struct gic *gic;
 static int acked[NR_CPUS], spurious[NR_CPUS];
+static int bad_sender[NR_CPUS], bad_irq[NR_CPUS];
 static cpumask_t ready;
 
 static void nr_cpu_check(int nr)
@@ -43,10 +47,23 @@ static void wait_on_ready(void)
 		cpu_relax();
 }
 
+static void stats_reset(void)
+{
+	int i;
+
+	for (i = 0; i < nr_cpus; ++i) {
+		acked[i] = 0;
+		bad_sender[i] = -1;
+		bad_irq[i] = -1;
+	}
+	smp_wmb();
+}
+
 static void check_acked(cpumask_t *mask)
 {
 	int missing = 0, extra = 0, unexpected = 0;
 	int nr_pass, cpu, i;
+	bool bad = false;
 
 	/* Wait up to 5s for all interrupts to be delivered */
 	for (i = 0; i < 50; ++i) {
@@ -56,9 +73,21 @@ static void check_acked(cpumask_t *mask)
 			smp_rmb();
 			nr_pass += cpumask_test_cpu(cpu, mask) ?
 				acked[cpu] == 1 : acked[cpu] == 0;
+
+			if (bad_sender[cpu] != -1) {
+				printf("cpu%d received IPI from wrong sender %d\n",
+					cpu, bad_sender[cpu]);
+				bad = true;
+			}
+
+			if (bad_irq[cpu] != -1) {
+				printf("cpu%d received wrong irq %d\n",
+					cpu, bad_irq[cpu]);
+				bad = true;
+			}
 		}
 		if (nr_pass == nr_cpus) {
-			report("Completed in %d ms", true, ++i * 100);
+			report("Completed in %d ms", !bad, ++i * 100);
 			return;
 		}
 	}
@@ -91,6 +120,22 @@ static void check_spurious(void)
 	}
 }
 
+static void check_ipi_sender(u32 irqstat)
+{
+	if (gic_version() == 2) {
+		int src = (irqstat >> 10) & 7;
+
+		if (src != IPI_SENDER)
+			bad_sender[smp_processor_id()] = src;
+	}
+}
+
+static void check_irqnr(u32 irqnr)
+{
+	if (irqnr != IPI_IRQ)
+		bad_irq[smp_processor_id()] = irqnr;
+}
+
 static void ipi_handler(struct pt_regs *regs __unused)
 {
 	u32 irqstat = gic_read_iar();
@@ -98,8 +143,10 @@ static void ipi_handler(struct pt_regs *regs __unused)
 
 	if (irqnr != GICC_INT_SPURIOUS) {
 		gic_write_eoir(irqstat);
-		smp_rmb(); /* pairs with wmb in ipi_test functions */
+		smp_rmb(); /* pairs with wmb in stats_reset */
 		++acked[smp_processor_id()];
+		check_ipi_sender(irqstat);
+		check_irqnr(irqnr);
 		smp_wmb(); /* pairs with rmb in check_acked */
 	} else {
 		++spurious[smp_processor_id()];
@@ -109,22 +156,22 @@ static void ipi_handler(struct pt_regs *regs __unused)
 
 static void gicv2_ipi_send_self(void)
 {
-	writel(2 << 24, gicv2_dist_base() + GICD_SGIR);
+	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
 }
 
 static void gicv2_ipi_send_broadcast(void)
 {
-	writel(1 << 24, gicv2_dist_base() + GICD_SGIR);
+	writel(1 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
 }
 
 static void gicv3_ipi_send_self(void)
 {
-	gic_ipi_send_single(0, smp_processor_id());
+	gic_ipi_send_single(IPI_IRQ, smp_processor_id());
 }
 
 static void gicv3_ipi_send_broadcast(void)
 {
-	gicv3_write_sgi1r(1ULL << 40);
+	gicv3_write_sgi1r(1ULL << 40 | IPI_IRQ << 24);
 	isb();
 }
 
@@ -133,10 +180,9 @@ static void ipi_test_self(void)
 	cpumask_t mask;
 
 	report_prefix_push("self");
-	memset(acked, 0, sizeof(acked));
-	smp_wmb();
+	stats_reset();
 	cpumask_clear(&mask);
-	cpumask_set_cpu(0, &mask);
+	cpumask_set_cpu(smp_processor_id(), &mask);
 	gic->ipi.send_self();
 	check_acked(&mask);
 	report_prefix_pop();
@@ -148,20 +194,18 @@ static void ipi_test_smp(void)
 	int i;
 
 	report_prefix_push("target-list");
-	memset(acked, 0, sizeof(acked));
-	smp_wmb();
+	stats_reset();
 	cpumask_copy(&mask, &cpu_present_mask);
-	for (i = 0; i < nr_cpus; i += 2)
+	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
 		cpumask_clear_cpu(i, &mask);
-	gic_ipi_send_mask(0, &mask);
+	gic_ipi_send_mask(IPI_IRQ, &mask);
 	check_acked(&mask);
 	report_prefix_pop();
 
 	report_prefix_push("broadcast");
-	memset(acked, 0, sizeof(acked));
-	smp_wmb();
+	stats_reset();
 	cpumask_copy(&mask, &cpu_present_mask);
-	cpumask_clear_cpu(0, &mask);
+	cpumask_clear_cpu(smp_processor_id(), &mask);
 	gic->ipi.send_broadcast();
 	check_acked(&mask);
 	report_prefix_pop();
@@ -178,6 +222,16 @@ static void ipi_enable(void)
 	local_irq_enable();
 }
 
+static void ipi_send(void)
+{
+	ipi_enable();
+	wait_on_ready();
+	ipi_test_self();
+	ipi_test_smp();
+	check_spurious();
+	exit(report_summary());
+}
+
 static void ipi_recv(void)
 {
 	ipi_enable();
@@ -232,14 +286,10 @@ int main(int argc, char **argv)
 		for_each_present_cpu(cpu) {
 			if (cpu == 0)
 				continue;
-			smp_boot_secondary(cpu, ipi_recv);
+			smp_boot_secondary(cpu,
+				cpu == IPI_SENDER ? ipi_send : ipi_recv);
 		}
-		ipi_enable();
-		wait_on_ready();
-		ipi_test_self();
-		ipi_test_smp();
-		check_spurious();
-		report_prefix_pop();
+		ipi_recv();
 	} else {
 		report_abort("Unknown subtest '%s'", argv[1]);
 	}
-- 
2.9.3
