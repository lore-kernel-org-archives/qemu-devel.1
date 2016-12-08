Received: from eggs.gnu.org ([2001:4830:134:3::10]:59974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qa-0004Go-Rd
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qU-0004Gx-8M
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:08 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:28 +0100
Message-Id: <20161208175030.12269-9-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 08/10] arm/arm64: add initial
 gicv3 support
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>

---
v8: few sysreg framework and new delay rebase changes
v7: split lib/arm/gic.c into gic-v2/3.c [Eric]
v6:
 - added comments [Alex]
 - added stride parameter to gicv3_set_redist_base [Andre]
 - redist-wait s/rwp/uwp/ and comment [Andre]
 - removed unnecessary wait-for-rwps [Andre]
v5: use modern register names [Andre]
v4:
 - only take defines from kernel we need now [Andre]
 - simplify enable by not caring if we reinit the distributor [drew]
v2:
 - configure irqs as NS GRP1
---
 arm/Makefile.common        |   2 +-
 lib/arm/asm/arch_gicv3.h   |  44 +++++++++++++++++++
 lib/arm/asm/gic-v3.h       | 105 +++++++++++++++++++++++++++++++++++++++=
++++++
 lib/arm/asm/gic.h          |   5 ++-
 lib/arm64/asm/arch_gicv3.h |  42 ++++++++++++++++++
 lib/arm64/asm/gic-v3.h     |   1 +
 lib/arm64/asm/sysreg.h     |  34 ++++++++++++++-
 lib/arm/gic-v2.c           |  27 ++++++++++++
 lib/arm/gic-v3.c           |  61 ++++++++++++++++++++++++++
 lib/arm/gic.c              |  30 +++++--------
 10 files changed, 327 insertions(+), 24 deletions(-)
 create mode 100644 lib/arm/asm/arch_gicv3.h
 create mode 100644 lib/arm/asm/gic-v3.h
 create mode 100644 lib/arm64/asm/arch_gicv3.h
 create mode 100644 lib/arm64/asm/gic-v3.h
 create mode 100644 lib/arm/gic-v2.c
 create mode 100644 lib/arm/gic-v3.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 275f8993012a..5b7d57e77aab 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -49,7 +49,7 @@ cflatobjs +=3D lib/arm/bitops.o
 cflatobjs +=3D lib/arm/psci.o
 cflatobjs +=3D lib/arm/smp.o
 cflatobjs +=3D lib/arm/delay.o
-cflatobjs +=3D lib/arm/gic.o
+cflatobjs +=3D lib/arm/gic.o lib/arm/gic-v2.o lib/arm/gic-v3.o
=20
 libeabi =3D lib/arm/libeabi.a
 eabiobjs =3D lib/arm/eabi_compat.o
diff --git a/lib/arm/asm/arch_gicv3.h b/lib/arm/asm/arch_gicv3.h
new file mode 100644
index 000000000000..f4388d057975
--- /dev/null
+++ b/lib/arm/asm/arch_gicv3.h
@@ -0,0 +1,44 @@
+/*
+ * All ripped off from arch/arm/include/asm/arch_gicv3.h
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#ifndef _ASMARM_ARCH_GICV3_H_
+#define _ASMARM_ARCH_GICV3_H_
+
+#ifndef __ASSEMBLY__
+#include <libcflat.h>
+#include <asm/sysreg.h>
+#include <asm/barrier.h>
+#include <asm/io.h>
+
+#define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
+#define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
+
+static inline void gicv3_write_pmr(u32 val)
+{
+	write_sysreg(val, ICC_PMR);
+}
+
+static inline void gicv3_write_grpen1(u32 val)
+{
+	write_sysreg(val, ICC_IGRPEN1);
+	isb();
+}
+
+/*
+ * We may access GICR_TYPER and GITS_TYPER by reading both the TYPER
+ * offset and the following offset (+ 4) and then combining them to
+ * form a 64-bit address.
+ */
+static inline u64 gicv3_read_typer(const volatile void __iomem *addr)
+{
+	u64 val =3D readl(addr);
+	val |=3D (u64)readl(addr + 4) << 32;
+	return val;
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASMARM_ARCH_GICV3_H_ */
diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
new file mode 100644
index 000000000000..65f148b8a265
--- /dev/null
+++ b/lib/arm/asm/gic-v3.h
@@ -0,0 +1,105 @@
+/*
+ * All GIC* defines are lifted from include/linux/irqchip/arm-gic-v3.h
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#ifndef _ASMARM_GIC_V3_H_
+#define _ASMARM_GIC_V3_H_
+
+#ifndef _ASMARM_GIC_H_
+#error Do not directly include <asm/gic-v3.h>. Include <asm/gic.h>
+#endif
+
+/*
+ * Distributor registers
+ *
+ * We expect to be run in Non-secure mode, thus we define the
+ * group1 enable bits with respect to that view.
+ */
+#define GICD_CTLR_RWP			(1U << 31)
+#define GICD_CTLR_ARE_NS		(1U << 4)
+#define GICD_CTLR_ENABLE_G1A		(1U << 1)
+#define GICD_CTLR_ENABLE_G1		(1U << 0)
+
+/* Re-Distributor registers, offsets from RD_base */
+#define GICR_TYPER			0x0008
+
+#define GICR_TYPER_LAST			(1U << 4)
+
+/* Re-Distributor registers, offsets from SGI_base */
+#define GICR_IGROUPR0			GICD_IGROUPR
+#define GICR_ISENABLER0			GICD_ISENABLER
+#define GICR_IPRIORITYR0		GICD_IPRIORITYR
+
+#include <asm/arch_gicv3.h>
+
+#ifndef __ASSEMBLY__
+#include <asm/setup.h>
+#include <asm/processor.h>
+#include <asm/delay.h>
+#include <asm/smp.h>
+#include <asm/io.h>
+
+struct gicv3_data {
+	void *dist_base;
+	void *redist_base[NR_CPUS];
+	unsigned int irq_nr;
+};
+extern struct gicv3_data gicv3_data;
+
+#define gicv3_dist_base()		(gicv3_data.dist_base)
+#define gicv3_redist_base()		(gicv3_data.redist_base[smp_processor_id()]=
)
+#define gicv3_sgi_base()		(gicv3_data.redist_base[smp_processor_id()] + =
SZ_64K)
+
+extern int gicv3_init(void);
+extern void gicv3_enable_defaults(void);
+extern void gicv3_set_redist_base(size_t stride);
+
+static inline void gicv3_do_wait_for_rwp(void *base)
+{
+	int count =3D 100000;	/* 1s */
+
+	while (readl(base + GICD_CTLR) & GICD_CTLR_RWP) {
+		if (!--count) {
+			printf("GICv3: RWP timeout!\n");
+			abort();
+		}
+		cpu_relax();
+		udelay(10);
+	};
+}
+
+static inline void gicv3_dist_wait_for_rwp(void)
+{
+	gicv3_do_wait_for_rwp(gicv3_dist_base());
+}
+
+static inline void gicv3_redist_wait_for_uwp(void)
+{
+	/*
+	 * We can build on gic_do_wait_for_rwp, which uses GICD_ registers
+	 * because GICD_CTLR =3D=3D GICR_CTLR and GICD_CTLR_RWP =3D=3D GICR_CTL=
R_UWP
+	 */
+	gicv3_do_wait_for_rwp(gicv3_redist_base());
+}
+
+static inline u32 mpidr_compress(u64 mpidr)
+{
+	u64 compressed =3D mpidr & MPIDR_HWID_BITMASK;
+
+	compressed =3D (((compressed >> 32) & 0xff) << 24) | compressed;
+	return compressed;
+}
+
+static inline u64 mpidr_uncompress(u32 compressed)
+{
+	u64 mpidr =3D ((u64)compressed >> 24) << 32;
+
+	mpidr |=3D compressed & MPIDR_HWID_BITMASK;
+	return mpidr;
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASMARM_GIC_V3_H_ */
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index d816b96e46b4..21511997f2a9 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -6,11 +6,11 @@
 #ifndef _ASMARM_GIC_H_
 #define _ASMARM_GIC_H_
=20
-#include <asm/gic-v2.h>
=20
 /* Distributor registers */
 #define GICD_CTLR			0x0000
 #define GICD_TYPER			0x0004
+#define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_IPRIORITYR			0x0400
 #define GICD_SGIR			0x0f00
@@ -28,6 +28,9 @@
 #define GICC_INT_PRI_THRESHOLD		0xf0
 #define GICC_INT_SPURIOUS		0x3ff
=20
+#include <asm/gic-v2.h>
+#include <asm/gic-v3.h>
+
 #ifndef __ASSEMBLY__
=20
 /*
diff --git a/lib/arm64/asm/arch_gicv3.h b/lib/arm64/asm/arch_gicv3.h
new file mode 100644
index 000000000000..a6c153103547
--- /dev/null
+++ b/lib/arm64/asm/arch_gicv3.h
@@ -0,0 +1,42 @@
+/*
+ * All ripped off from arch/arm64/include/asm/arch_gicv3.h
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#ifndef _ASMARM64_ARCH_GICV3_H_
+#define _ASMARM64_ARCH_GICV3_H_
+
+#include <asm/sysreg.h>
+
+#define ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
+#define ICC_GRPEN1_EL1			sys_reg(3, 0, 12, 12, 7)
+
+#ifndef __ASSEMBLY__
+
+#include <libcflat.h>
+#include <asm/barrier.h>
+
+/*
+ * Low-level accessors
+ *
+ * These system registers are 32 bits, but we make sure that the compile=
r
+ * sets the GP register's most significant bits to 0 with an explicit ca=
st.
+ */
+
+static inline void gicv3_write_pmr(u32 val)
+{
+	asm volatile("msr_s " xstr(ICC_PMR_EL1) ", %0" : : "r" ((u64)val));
+}
+
+static inline void gicv3_write_grpen1(u32 val)
+{
+	asm volatile("msr_s " xstr(ICC_GRPEN1_EL1) ", %0" : : "r" ((u64)val));
+	isb();
+}
+
+#define gicv3_read_typer(c) readq(c)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASMARM64_ARCH_GICV3_H_ */
diff --git a/lib/arm64/asm/gic-v3.h b/lib/arm64/asm/gic-v3.h
new file mode 100644
index 000000000000..8ee5d4d9c181
--- /dev/null
+++ b/lib/arm64/asm/gic-v3.h
@@ -0,0 +1 @@
+#include "../../arm/asm/gic-v3.h"
diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index 05b9fcb1bbf7..a03830bceb8f 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -8,7 +8,23 @@
 #ifndef _ASMARM64_SYSREG_H_
 #define _ASMARM64_SYSREG_H_
=20
-#ifndef __ASSEMBLY__
+#define sys_reg(op0, op1, crn, crm, op2) \
+	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
+
+#ifdef __ASSEMBLY__
+	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,=
24,25,26,27,28,29,30
+	.equ	.L__reg_num_x\num, \num
+	.endr
+	.equ	.L__reg_num_xzr, 31
+
+	.macro	mrs_s, rt, sreg
+	.inst	0xd5200000|(\sreg)|(.L__reg_num_\rt)
+	.endm
+
+	.macro	msr_s, sreg, rt
+	.inst	0xd5000000|(\sreg)|(.L__reg_num_\rt)
+	.endm
+#else
 #include <libcflat.h>
=20
 #define read_sysreg(r) ({					\
@@ -22,5 +38,19 @@
 	asm volatile("msr " xstr(r) ", %x0" : : "rZ" (__val));	\
 } while (0)
=20
-#endif /* !__ASSEMBLY__ */
+asm(
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23=
,24,25,26,27,28,29,30\n"
+"	.equ	.L__reg_num_x\\num, \\num\n"
+"	.endr\n"
+"	.equ	.L__reg_num_xzr, 31\n"
+"\n"
+"	.macro	mrs_s, rt, sreg\n"
+"	.inst	0xd5200000|(\\sreg)|(.L__reg_num_\\rt)\n"
+"	.endm\n"
+"\n"
+"	.macro	msr_s, sreg, rt\n"
+"	.inst	0xd5000000|(\\sreg)|(.L__reg_num_\\rt)\n"
+"	.endm\n"
+);
+#endif /* __ASSEMBLY__ */
 #endif /* _ASMARM64_SYSREG_H_ */
diff --git a/lib/arm/gic-v2.c b/lib/arm/gic-v2.c
new file mode 100644
index 000000000000..e80eb8f29488
--- /dev/null
+++ b/lib/arm/gic-v2.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <asm/gic.h>
+#include <asm/io.h>
+
+void gicv2_enable_defaults(void)
+{
+	void *dist =3D gicv2_dist_base();
+	void *cpu_base =3D gicv2_cpu_base();
+	unsigned int i;
+
+	gicv2_data.irq_nr =3D GICD_TYPER_IRQS(readl(dist + GICD_TYPER));
+	if (gicv2_data.irq_nr > 1020)
+		gicv2_data.irq_nr =3D 1020;
+
+	for (i =3D 0; i < gicv2_data.irq_nr; i +=3D 4)
+		writel(GICD_INT_DEF_PRI_X4, dist + GICD_IPRIORITYR + i);
+
+	writel(GICD_INT_EN_SET_SGI, dist + GICD_ISENABLER + 0);
+	writel(GICD_ENABLE, dist + GICD_CTLR);
+
+	writel(GICC_INT_PRI_THRESHOLD, cpu_base + GICC_PMR);
+	writel(GICC_ENABLE, cpu_base + GICC_CTLR);
+}
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
new file mode 100644
index 000000000000..c46d16e11782
--- /dev/null
+++ b/lib/arm/gic-v3.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <asm/gic.h>
+#include <asm/io.h>
+
+void gicv3_set_redist_base(size_t stride)
+{
+	u32 aff =3D mpidr_compress(get_mpidr());
+	void *ptr =3D gicv3_data.redist_base[0];
+	u64 typer;
+
+	do {
+		typer =3D gicv3_read_typer(ptr + GICR_TYPER);
+		if ((typer >> 32) =3D=3D aff) {
+			gicv3_redist_base() =3D ptr;
+			return;
+		}
+		ptr +=3D stride; /* skip RD_base, SGI_base, etc. */
+	} while (!(typer & GICR_TYPER_LAST));
+
+	/* should never reach here */
+	assert(0);
+}
+
+void gicv3_enable_defaults(void)
+{
+	void *dist =3D gicv3_dist_base();
+	void *sgi_base;
+	unsigned int i;
+
+	gicv3_data.irq_nr =3D GICD_TYPER_IRQS(readl(dist + GICD_TYPER));
+	if (gicv3_data.irq_nr > 1020)
+		gicv3_data.irq_nr =3D 1020;
+
+	writel(0, dist + GICD_CTLR);
+	gicv3_dist_wait_for_rwp();
+
+	writel(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
+	       dist + GICD_CTLR);
+	gicv3_dist_wait_for_rwp();
+
+	for (i =3D 0; i < gicv3_data.irq_nr; i +=3D 4)
+		writel(~0, dist + GICD_IGROUPR + i);
+
+	if (!gicv3_redist_base())
+		gicv3_set_redist_base(SZ_64K * 2);
+	sgi_base =3D gicv3_sgi_base();
+
+	writel(~0, sgi_base + GICR_IGROUPR0);
+
+	for (i =3D 0; i < 16; i +=3D 4)
+		writel(GICD_INT_DEF_PRI_X4, sgi_base + GICR_IPRIORITYR0 + i);
+
+	writel(GICD_INT_EN_SET_SGI, sgi_base + GICR_ISENABLER0);
+
+	gicv3_write_pmr(GICC_INT_PRI_THRESHOLD);
+	gicv3_write_grpen1(1);
+}
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index d655105e058b..4d3ddd9722b1 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -8,9 +8,11 @@
 #include <asm/io.h>
=20
 struct gicv2_data gicv2_data;
+struct gicv3_data gicv3_data;
=20
 /*
  * Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+ * Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
  */
 static bool
 gic_get_dt_bases(const char *compatible, void **base1, void **base2)
@@ -48,29 +50,17 @@ int gicv2_init(void)
 			&gicv2_data.dist_base, &gicv2_data.cpu_base);
 }
=20
+int gicv3_init(void)
+{
+	return gic_get_dt_bases("arm,gic-v3", &gicv3_data.dist_base,
+			&gicv3_data.redist_base[0]);
+}
+
 int gic_init(void)
 {
 	if (gicv2_init())
 		return 2;
+	else if (gicv3_init())
+		return 3;
 	return 0;
 }
-
-void gicv2_enable_defaults(void)
-{
-	void *dist =3D gicv2_dist_base();
-	void *cpu_base =3D gicv2_cpu_base();
-	unsigned int i;
-
-	gicv2_data.irq_nr =3D GICD_TYPER_IRQS(readl(dist + GICD_TYPER));
-	if (gicv2_data.irq_nr > 1020)
-		gicv2_data.irq_nr =3D 1020;
-
-	for (i =3D 0; i < gicv2_data.irq_nr; i +=3D 4)
-		writel(GICD_INT_DEF_PRI_X4, dist + GICD_IPRIORITYR + i);
-
-	writel(GICD_INT_EN_SET_SGI, dist + GICD_ISENABLER + 0);
-	writel(GICD_ENABLE, dist + GICD_CTLR);
-
-	writel(GICC_INT_PRI_THRESHOLD, cpu_base + GICC_PMR);
-	writel(GICC_ENABLE, cpu_base + GICC_CTLR);
-}
--=20
2.9.3
