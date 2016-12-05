Received: from eggs.gnu.org ([2001:4830:134:3::10]:35521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE17L-000797-5P
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE17K-0002SP-9M
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:11 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:46 +0100
Message-Id: <1480974406-29345-16-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 15/15] arm/arm64: ITS test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

This patch implements an example ITS test which
- allocates a device
- allocates a collection
- maps the device to an ITT
- maps the collection to a redistributor
- creates an ITT entry for the device
- requests an LPI for this entry

the test checks the LPI hits the right CPU and triggers
the right lpi id.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/gic.c                | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/arm/asm/gic-v3-its.h | 10 ++++++
 2 files changed, 97 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index cbaab3f..89f34b6 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -31,6 +31,7 @@ static int acked[NR_CPUS], spurious[NR_CPUS];
 static int bad_sender[NR_CPUS], bad_irq[NR_CPUS];
 static int cmdl_sender = 1, cmdl_irq = 1;
 static cpumask_t ready;
+static struct its_stats lpi_stats;
 
 static void nr_cpu_check(int nr)
 {
@@ -154,6 +155,42 @@ static void ipi_handler(struct pt_regs *regs __unused)
 	}
 }
 
+static void lpi_handler(struct pt_regs *regs __unused)
+{
+	u32 irqstat = gic_read_iar();
+	int irqnr = gic_iar_irqnr(irqstat);
+
+	gic_write_eoir(irqstat);
+	smp_rmb(); /* pairs with wmb in lpi_stats_reset */
+	lpi_stats.observed.cpu_id = smp_processor_id();
+	lpi_stats.observed.lpi_id = irqnr;
+	smp_wmb(); /* pairs with rmb in check_lpi_stats */
+}
+
+static void lpi_stats_reset(int exp_cpu_id, int exp_lpi_id)
+{
+	lpi_stats.expected.cpu_id = exp_cpu_id;
+	lpi_stats.expected.lpi_id = exp_lpi_id;
+	lpi_stats.observed.cpu_id = -1;
+	lpi_stats.observed.lpi_id = -1;
+	smp_wmb(); /* pairs with rmb in handler */
+}
+
+static void check_lpi_stats(void)
+{
+	mdelay(100);
+	smp_rmb(); /* pairs with wmb in lpi_handler */
+	if ((lpi_stats.observed.cpu_id != lpi_stats.expected.cpu_id) ||
+	    (lpi_stats.observed.lpi_id != lpi_stats.expected.lpi_id))
+		report("Unexpected LPI (cpuid=%d, lpidid=%d)\n", false,
+			lpi_stats.observed.cpu_id,
+			lpi_stats.observed.lpi_id);
+	else
+		report("LPI %d on CPU %d\n", true,
+			lpi_stats.observed.lpi_id,
+			lpi_stats.observed.cpu_id);
+}
+
 static void gicv2_ipi_send_self(void)
 {
 	writel(2 << 24 | cmdl_irq, gicv2_dist_base() + GICD_SGIR);
@@ -288,6 +325,51 @@ static void cmdl_ipi_get_inputs(int argc, char **argv)
 	}
 }
 
+static void secondary_lpi_test(void)
+{
+	setup_irq(lpi_handler);
+	cpumask_set_cpu(smp_processor_id(), &ready);
+	while (1)
+		wfi();
+}
+
+static int gic_test_its(void)
+{
+	struct its_device *dev0;
+	struct its_collection *col0;
+	int cpu;
+
+	stats_reset();
+
+	setup_irq(lpi_handler);
+	for_each_present_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		smp_boot_secondary(cpu, secondary_lpi_test);
+	}
+	wait_on_ready();
+
+	its_enable_defaults();
+
+	report_prefix_push("Test 1");
+
+	dev0 = its_create_device(2 /* dev id */, 8 /* nvecs */);
+	col0 = its_create_collection(3 /* col id */, 3/* target PE */);
+
+	lpi_stats_reset(3, 8195);
+
+	its_send_mapd(dev0, true);
+	its_send_mapc(col0, true);
+	its_send_mapti(dev0, 8195 /* lpi id */,
+		       8200 /* event id */, col0);
+	its_send_int(dev0, 8200);
+
+	check_lpi_stats();
+
+	return 0;
+
+}
+
 static struct gic gicv2 = {
 	.ipi = {
 		.send_self = gicv2_ipi_send_self,
@@ -342,7 +424,12 @@ int main(int argc, char **argv)
 			smp_boot_secondary(cpu, ipi_test);
 		}
 		ipi_test();
+	} else if (!strcmp(argv[1], "its")) {
+		report_prefix_push(argv[1]);
 
+		gic_test_its();
+
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown subtest '%s'", argv[1]);
 	}
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 6130605..10c6a09 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -198,6 +198,16 @@ struct its_data {
 	u64 flags;
 };
 
+struct its_event {
+	int cpu_id;
+	int lpi_id;
+};
+
+struct its_stats {
+	struct its_event expected;
+	struct its_event observed;
+};
+
 extern struct its_data its_data;
 
 #define gicv3_its_base()		(its_data.base)
-- 
2.5.5
