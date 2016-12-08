Received: from eggs.gnu.org ([2001:4830:134:3::10]:59972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qa-0004GL-MD
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qX-0004I2-Io
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:08 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:29 +0100
Message-Id: <20161208175030.12269-10-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 09/10] arm/arm64: gicv3: add
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

Signed-off-by: Andrew Jones <drjones@redhat.com>

---
v8:
 - keep the gic_common_ops concept completely local to
   lib/arm/gic.c by instead exposing the more useful
   concept of gic-specific functions
 - sysreg rebase changes
 - ordered ICC registers in spec-order (OCD kicked in...)
v7:
 - add common ipi_send_single/mask (replacing ipi_send).
   Note, the arg order irq,cpu got swapped. [Eric]
 - comment rewording [Eric]
 - make enable_defaults a common op [Eric]
 - gic_enable_defaults() will now invoke gic_init if
   necessary [drew]
 - split lib/arm/gic.c into gic-v2/3.c [Eric]
v6: move most gicv2/gicv3 wrappers to common code [Alex]
v5:
 - fix copy+paste error in gicv3_write_eoir [drew]
 - use modern register names [Andre]
v4:
 - heavily comment gicv3_ipi_send_tlist() [Eric]
 - changes needed for gicv2 iar/irqstat fix to other patch
v2:
 - use IRM for gicv3 broadcast
---
 arm/unittests.cfg          |  6 ++++
 lib/arm/asm/arch_gicv3.h   | 21 ++++++++++++
 lib/arm/asm/gic-v2.h       |  6 ++++
 lib/arm/asm/gic-v3.h       | 12 +++++++
 lib/arm/asm/gic.h          | 19 +++++++++++
 lib/arm64/asm/arch_gicv3.h | 22 ++++++++++++
 arm/gic.c                  | 81 +++++++++++++++++++++++++++++++++++--------
 lib/arm/gic-v2.c           | 30 ++++++++++++++++
 lib/arm/gic-v3.c           | 84 +++++++++++++++++++++++++++++++++++++++++++++
 lib/arm/gic.c              | 85 ++++++++++++++++++++++++++++++++++++++++++++--
 10 files changed, 350 insertions(+), 16 deletions(-)

diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index f61e30b8526d..8cf94729d86e 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -85,3 +85,9 @@ file = gic.flat
 smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
 extra_params = -machine gic-version=2 -append 'ipi'
 groups = gic
+
+[gicv3-ipi]
+file = gic.flat
+smp = $MAX_SMP
+extra_params = -machine gic-version=3 -append 'ipi'
+groups = gic
diff --git a/lib/arm/asm/arch_gicv3.h b/lib/arm/asm/arch_gicv3.h
index f4388d057975..45b609684460 100644
--- a/lib/arm/asm/arch_gicv3.h
+++ b/lib/arm/asm/arch_gicv3.h
@@ -15,6 +15,9 @@
 #include <asm/io.h>
 
 #define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
+#define ICC_SGI1R			__ACCESS_CP15_64(0, c12)
+#define ICC_IAR1			__ACCESS_CP15(c12, 0, c12, 0)
+#define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 
 static inline void gicv3_write_pmr(u32 val)
@@ -22,6 +25,24 @@ static inline void gicv3_write_pmr(u32 val)
 	write_sysreg(val, ICC_PMR);
 }
 
+static inline void gicv3_write_sgi1r(u64 val)
+{
+	write_sysreg(val, ICC_SGI1R);
+}
+
+static inline u32 gicv3_read_iar(void)
+{
+	u32 irqstat = read_sysreg(ICC_IAR1);
+	dsb(sy);
+	return irqstat;
+}
+
+static inline void gicv3_write_eoir(u32 irq)
+{
+	write_sysreg(irq, ICC_EOIR1);
+	isb();
+}
+
 static inline void gicv3_write_grpen1(u32 val)
 {
 	write_sysreg(val, ICC_IGRPEN1);
diff --git a/lib/arm/asm/gic-v2.h b/lib/arm/asm/gic-v2.h
index 8b3f7ed6790c..1fcfd43c8075 100644
--- a/lib/arm/asm/gic-v2.h
+++ b/lib/arm/asm/gic-v2.h
@@ -18,6 +18,7 @@
 #define GICC_IAR_INT_ID_MASK		0x3ff
 
 #ifndef __ASSEMBLY__
+#include <asm/cpumask.h>
 
 struct gicv2_data {
 	void *dist_base;
@@ -31,6 +32,11 @@ extern struct gicv2_data gicv2_data;
 
 extern int gicv2_init(void);
 extern void gicv2_enable_defaults(void);
+extern u32 gicv2_read_iar(void);
+extern u32 gicv2_iar_irqnr(u32 iar);
+extern void gicv2_write_eoir(u32 irqstat);
+extern void gicv2_ipi_send_single(int irq, int cpu);
+extern void gicv2_ipi_send_mask(int irq, const cpumask_t *dest);
 
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V2_H_ */
diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index 65f148b8a265..1dceb9541f62 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -33,12 +33,19 @@
 #define GICR_ISENABLER0			GICD_ISENABLER
 #define GICR_IPRIORITYR0		GICD_IPRIORITYR
 
+#define ICC_SGI1R_AFFINITY_1_SHIFT	16
+#define ICC_SGI1R_AFFINITY_2_SHIFT	32
+#define ICC_SGI1R_AFFINITY_3_SHIFT	48
+#define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
+	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
+
 #include <asm/arch_gicv3.h>
 
 #ifndef __ASSEMBLY__
 #include <asm/setup.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
+#include <asm/cpumask.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 
@@ -55,6 +62,11 @@ extern struct gicv3_data gicv3_data;
 
 extern int gicv3_init(void);
 extern void gicv3_enable_defaults(void);
+extern u32 gicv3_read_iar(void);
+extern u32 gicv3_iar_irqnr(u32 iar);
+extern void gicv3_write_eoir(u32 irqstat);
+extern void gicv3_ipi_send_single(int irq, int cpu);
+extern void gicv3_ipi_send_mask(int irq, const cpumask_t *dest);
 extern void gicv3_set_redist_base(size_t stride);
 
 static inline void gicv3_do_wait_for_rwp(void *base)
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 21511997f2a9..c8186f25aa6b 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -32,6 +32,7 @@
 #include <asm/gic-v3.h>
 
 #ifndef __ASSEMBLY__
+#include <asm/cpumask.h>
 
 /*
  * gic_init will try to find all known gics, and then
@@ -42,5 +43,23 @@
  */
 extern int gic_init(void);
 
+/*
+ * gic_enable_defaults enables the gic with basic but useful
+ * settings. gic_enable_defaults will call gic_init if it has
+ * not yet been invoked.
+ */
+extern void gic_enable_defaults(void);
+
+/*
+ * After enabling the gic with gic_enable_defaults the functions
+ * below will work with any supported gic version.
+ */
+extern int gic_version(void);
+extern u32 gic_read_iar(void);
+extern u32 gic_iar_irqnr(u32 iar);
+extern void gic_write_eoir(u32 irqstat);
+extern void gic_ipi_send_single(int irq, int cpu);
+extern void gic_ipi_send_mask(int irq, const cpumask_t *dest);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm64/asm/arch_gicv3.h b/lib/arm64/asm/arch_gicv3.h
index a6c153103547..a7994ec2fbbe 100644
--- a/lib/arm64/asm/arch_gicv3.h
+++ b/lib/arm64/asm/arch_gicv3.h
@@ -11,6 +11,9 @@
 #include <asm/sysreg.h>
 
 #define ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
+#define ICC_SGI1R_EL1			sys_reg(3, 0, 12, 11, 5)
+#define ICC_IAR1_EL1			sys_reg(3, 0, 12, 12, 0)
+#define ICC_EOIR1_EL1			sys_reg(3, 0, 12, 12, 1)
 #define ICC_GRPEN1_EL1			sys_reg(3, 0, 12, 12, 7)
 
 #ifndef __ASSEMBLY__
@@ -30,6 +33,25 @@ static inline void gicv3_write_pmr(u32 val)
 	asm volatile("msr_s " xstr(ICC_PMR_EL1) ", %0" : : "r" ((u64)val));
 }
 
+static inline void gicv3_write_sgi1r(u64 val)
+{
+	asm volatile("msr_s " xstr(ICC_SGI1R_EL1) ", %0" : : "r" (val));
+}
+
+static inline u32 gicv3_read_iar(void)
+{
+	u64 irqstat;
+	asm volatile("mrs_s %0, " xstr(ICC_IAR1_EL1) : "=r" (irqstat));
+	dsb(sy);
+	return (u64)irqstat;
+}
+
+static inline void gicv3_write_eoir(u32 irq)
+{
+	asm volatile("msr_s " xstr(ICC_EOIR1_EL1) ", %0" : : "r" ((u64)irq));
+	isb();
+}
+
 static inline void gicv3_write_grpen1(u32 val)
 {
 	asm volatile("msr_s " xstr(ICC_GRPEN1_EL1) ", %0" : : "r" ((u64)val));
diff --git a/arm/gic.c b/arm/gic.c
index 744e227426bf..d0d3be0fa36e 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -3,6 +3,8 @@
  *
  * GICv2
  *   + test sending/receiving IPIs
+ * GICv3
+ *   + test sending/receiving IPIs
  *
  * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
  *
@@ -17,7 +19,14 @@
 #include <asm/barrier.h>
 #include <asm/io.h>
 
-static int gic_version;
+struct gic {
+	struct {
+		void (*send_self)(void);
+		void (*send_broadcast)(void);
+	} ipi;
+};
+
+static struct gic *gic;
 static int acked[NR_CPUS], spurious[NR_CPUS];
 static cpumask_t ready;
 
@@ -84,11 +93,11 @@ static void check_spurious(void)
 
 static void ipi_handler(struct pt_regs *regs __unused)
 {
-	u32 irqstat = readl(gicv2_cpu_base() + GICC_IAR);
-	u32 irqnr = irqstat & GICC_IAR_INT_ID_MASK;
+	u32 irqstat = gic_read_iar();
+	u32 irqnr = gic_iar_irqnr(irqstat);
 
 	if (irqnr != GICC_INT_SPURIOUS) {
-		writel(irqstat, gicv2_cpu_base() + GICC_EOIR);
+		gic_write_eoir(irqstat);
 		smp_rmb(); /* pairs with wmb in ipi_test functions */
 		++acked[smp_processor_id()];
 		smp_wmb(); /* pairs with rmb in check_acked */
@@ -98,6 +107,27 @@ static void ipi_handler(struct pt_regs *regs __unused)
 	}
 }
 
+static void gicv2_ipi_send_self(void)
+{
+	writel(2 << 24, gicv2_dist_base() + GICD_SGIR);
+}
+
+static void gicv2_ipi_send_broadcast(void)
+{
+	writel(1 << 24, gicv2_dist_base() + GICD_SGIR);
+}
+
+static void gicv3_ipi_send_self(void)
+{
+	gic_ipi_send_single(0, smp_processor_id());
+}
+
+static void gicv3_ipi_send_broadcast(void)
+{
+	gicv3_write_sgi1r(1ULL << 40);
+	isb();
+}
+
 static void ipi_test_self(void)
 {
 	cpumask_t mask;
@@ -107,7 +137,7 @@ static void ipi_test_self(void)
 	smp_wmb();
 	cpumask_clear(&mask);
 	cpumask_set_cpu(0, &mask);
-	writel(2 << 24, gicv2_dist_base() + GICD_SGIR);
+	gic->ipi.send_self();
 	check_acked(&mask);
 	report_prefix_pop();
 }
@@ -115,14 +145,15 @@ static void ipi_test_self(void)
 static void ipi_test_smp(void)
 {
 	cpumask_t mask;
-	unsigned long tlist;
+	int i;
 
 	report_prefix_push("target-list");
 	memset(acked, 0, sizeof(acked));
 	smp_wmb();
-	tlist = cpumask_bits(&cpu_present_mask)[0] & 0xaa;
-	cpumask_bits(&mask)[0] = tlist;
-	writel((u8)tlist << 16, gicv2_dist_base() + GICD_SGIR);
+	cpumask_copy(&mask, &cpu_present_mask);
+	for (i = 0; i < nr_cpus; i += 2)
+		cpumask_clear_cpu(i, &mask);
+	gic_ipi_send_mask(0, &mask);
 	check_acked(&mask);
 	report_prefix_pop();
 
@@ -131,14 +162,14 @@ static void ipi_test_smp(void)
 	smp_wmb();
 	cpumask_copy(&mask, &cpu_present_mask);
 	cpumask_clear_cpu(0, &mask);
-	writel(1 << 24, gicv2_dist_base() + GICD_SGIR);
+	gic->ipi.send_broadcast();
 	check_acked(&mask);
 	report_prefix_pop();
 }
 
 static void ipi_enable(void)
 {
-	gicv2_enable_defaults();
+	gic_enable_defaults();
 #ifdef __arm__
 	install_exception_handler(EXCPTN_IRQ, ipi_handler);
 #else
@@ -155,20 +186,42 @@ static void ipi_recv(void)
 		wfi();
 }
 
+static struct gic gicv2 = {
+	.ipi = {
+		.send_self = gicv2_ipi_send_self,
+		.send_broadcast = gicv2_ipi_send_broadcast,
+	},
+};
+
+static struct gic gicv3 = {
+	.ipi = {
+		.send_self = gicv3_ipi_send_self,
+		.send_broadcast = gicv3_ipi_send_broadcast,
+	},
+};
+
 int main(int argc, char **argv)
 {
 	char pfx[8];
 	int cpu;
 
-	gic_version = gic_init();
-	if (!gic_version) {
+	if (!gic_init()) {
 		printf("No supported gic present, skipping tests...\n");
 		return report_summary();
 	}
 
-	snprintf(pfx, sizeof(pfx), "gicv%d", gic_version);
+	snprintf(pfx, sizeof(pfx), "gicv%d", gic_version());
 	report_prefix_push(pfx);
 
+	switch (gic_version()) {
+	case 2:
+		gic = &gicv2;
+		break;
+	case 3:
+		gic = &gicv3;
+		break;
+	}
+
 	if (argc < 2)
 		report_abort("no test specified");
 
diff --git a/lib/arm/gic-v2.c b/lib/arm/gic-v2.c
index e80eb8f29488..dc6a97c600ec 100644
--- a/lib/arm/gic-v2.c
+++ b/lib/arm/gic-v2.c
@@ -25,3 +25,33 @@ void gicv2_enable_defaults(void)
 	writel(GICC_INT_PRI_THRESHOLD, cpu_base + GICC_PMR);
 	writel(GICC_ENABLE, cpu_base + GICC_CTLR);
 }
+
+u32 gicv2_read_iar(void)
+{
+	return readl(gicv2_cpu_base() + GICC_IAR);
+}
+
+u32 gicv2_iar_irqnr(u32 iar)
+{
+	return iar & GICC_IAR_INT_ID_MASK;
+}
+
+void gicv2_write_eoir(u32 irqstat)
+{
+	writel(irqstat, gicv2_cpu_base() + GICC_EOIR);
+}
+
+void gicv2_ipi_send_single(int irq, int cpu)
+{
+	assert(cpu < 8);
+	assert(irq < 16);
+	writel(1 << (cpu + 16) | irq, gicv2_dist_base() + GICD_SGIR);
+}
+
+void gicv2_ipi_send_mask(int irq, const cpumask_t *dest)
+{
+	u8 tlist = (u8)cpumask_bits(dest)[0];
+
+	assert(irq < 16);
+	writel(tlist << 16 | irq, gicv2_dist_base() + GICD_SGIR);
+}
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
index c46d16e11782..9682fc96b631 100644
--- a/lib/arm/gic-v3.c
+++ b/lib/arm/gic-v3.c
@@ -59,3 +59,87 @@ void gicv3_enable_defaults(void)
 	gicv3_write_pmr(GICC_INT_PRI_THRESHOLD);
 	gicv3_write_grpen1(1);
 }
+
+u32 gicv3_iar_irqnr(u32 iar)
+{
+	return iar;
+}
+
+void gicv3_ipi_send_mask(int irq, const cpumask_t *dest)
+{
+	u16 tlist;
+	int cpu;
+
+	assert(irq < 16);
+
+	/*
+	 * For each cpu in the mask collect its peers, which are also in
+	 * the mask, in order to form target lists.
+	 */
+	for_each_cpu(cpu, dest) {
+		u64 mpidr = cpus[cpu], sgi1r;
+		u64 cluster_id;
+
+		/*
+		 * GICv3 can send IPIs to up 16 peer cpus with a single
+		 * write to ICC_SGI1R_EL1 (using the target list). Peers
+		 * are cpus that have nearly identical MPIDRs, the only
+		 * difference being Aff0. The matching upper affinity
+		 * levels form the cluster ID.
+		 */
+		cluster_id = mpidr & ~0xffUL;
+		tlist = 0;
+
+		/*
+		 * Sort of open code for_each_cpu in order to have a
+		 * nested for_each_cpu loop.
+		 */
+		while (cpu < nr_cpus) {
+			if ((mpidr & 0xff) >= 16) {
+				printf("cpu%d MPIDR:aff0 is %d (>= 16)!\n",
+					cpu, (int)(mpidr & 0xff));
+				break;
+			}
+
+			tlist |= 1 << (mpidr & 0xf);
+
+			cpu = cpumask_next(cpu, dest);
+			if (cpu >= nr_cpus)
+				break;
+
+			mpidr = cpus[cpu];
+
+			if (cluster_id != (mpidr & ~0xffUL)) {
+				/*
+				 * The next cpu isn't in our cluster. Roll
+				 * back the cpu index allowing the outer
+				 * for_each_cpu to find it again with
+				 * cpumask_next
+				 */
+				--cpu;
+				break;
+			}
+		}
+
+		/* Send the IPIs for the target list of this cluster */
+		sgi1r = (MPIDR_TO_SGI_AFFINITY(cluster_id, 3)	|
+			 MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
+			 irq << 24				|
+			 MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
+			 tlist);
+
+		gicv3_write_sgi1r(sgi1r);
+	}
+
+	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
+	isb();
+}
+
+void gicv3_ipi_send_single(int irq, int cpu)
+{
+	cpumask_t dest;
+
+	cpumask_clear(&dest);
+	cpumask_set_cpu(cpu, &dest);
+	gicv3_ipi_send_mask(irq, &dest);
+}
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 4d3ddd9722b1..3ed539727f8c 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -10,6 +10,38 @@
 struct gicv2_data gicv2_data;
 struct gicv3_data gicv3_data;
 
+struct gic_common_ops {
+	int gic_version;
+	void (*enable_defaults)(void);
+	u32 (*read_iar)(void);
+	u32 (*iar_irqnr)(u32 iar);
+	void (*write_eoir)(u32 irqstat);
+	void (*ipi_send_single)(int irq, int cpu);
+	void (*ipi_send_mask)(int irq, const cpumask_t *dest);
+};
+
+static const struct gic_common_ops *gic_common_ops;
+
+static const struct gic_common_ops gicv2_common_ops = {
+	.gic_version = 2,
+	.enable_defaults = gicv2_enable_defaults,
+	.read_iar = gicv2_read_iar,
+	.iar_irqnr = gicv2_iar_irqnr,
+	.write_eoir = gicv2_write_eoir,
+	.ipi_send_single = gicv2_ipi_send_single,
+	.ipi_send_mask = gicv2_ipi_send_mask,
+};
+
+static const struct gic_common_ops gicv3_common_ops = {
+	.gic_version = 3,
+	.enable_defaults = gicv3_enable_defaults,
+	.read_iar = gicv3_read_iar,
+	.iar_irqnr = gicv3_iar_irqnr,
+	.write_eoir = gicv3_write_eoir,
+	.ipi_send_single = gicv3_ipi_send_single,
+	.ipi_send_mask = gicv3_ipi_send_mask,
+};
+
 /*
  * Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
  * Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -58,9 +90,58 @@ int gicv3_init(void)
 
 int gic_init(void)
 {
-	if (gicv2_init())
+	if (gicv2_init()) {
+		gic_common_ops = &gicv2_common_ops;
 		return 2;
-	else if (gicv3_init())
+	} else if (gicv3_init()) {
+		gic_common_ops = &gicv3_common_ops;
 		return 3;
+	}
 	return 0;
 }
+
+void gic_enable_defaults(void)
+{
+	if (!gic_common_ops) {
+		int ret = gic_init();
+		assert(ret != 0);
+	} else
+		assert(gic_common_ops->enable_defaults);
+	gic_common_ops->enable_defaults();
+}
+
+int gic_version(void)
+{
+	assert(gic_common_ops);
+	return gic_common_ops->gic_version;
+}
+
+u32 gic_read_iar(void)
+{
+	assert(gic_common_ops && gic_common_ops->read_iar);
+	return gic_common_ops->read_iar();
+}
+
+u32 gic_iar_irqnr(u32 iar)
+{
+	assert(gic_common_ops && gic_common_ops->iar_irqnr);
+	return gic_common_ops->iar_irqnr(iar);
+}
+
+void gic_write_eoir(u32 irqstat)
+{
+	assert(gic_common_ops && gic_common_ops->write_eoir);
+	gic_common_ops->write_eoir(irqstat);
+}
+
+void gic_ipi_send_single(int irq, int cpu)
+{
+	assert(gic_common_ops && gic_common_ops->ipi_send_single);
+	gic_common_ops->ipi_send_single(irq, cpu);
+}
+
+void gic_ipi_send_mask(int irq, const cpumask_t *dest)
+{
+	assert(gic_common_ops && gic_common_ops->ipi_send_mask);
+	gic_common_ops->ipi_send_mask(irq, dest);
+}
-- 
2.9.3
