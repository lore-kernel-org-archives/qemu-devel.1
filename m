Received: from eggs.gnu.org ([2001:4830:134:3::10]:47460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7V-0006ke-Ur
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7U-0005Vw-II
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1cEK7U-0005Ve-4y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:36 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue,  6 Dec 2016 12:05:25 -0600
Message-Id: <1481047528-16180-3-git-send-email-wei@redhat.com>
In-Reply-To: <1481047528-16180-1-git-send-email-wei@redhat.com>
References: <1481047528-16180-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v14 2/5] arm: Add support for
 read_sysreg() and write_sysreg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cov@codeaurora.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, shannon.zhao@linaro.org, alistair.francis@xilinx.com, croberts@codeaurora.org, alindsay@codeaurora.org, drjones@redhat.com, andre.przywara@arm.com

This patch adds two new macros to support read/write operations of ARMv7
and ARMv8 system registers. As part of the change, xstr() is revised to
support variable arguments. With it, ARMv7 system register can be defined
with __ACCESS_CP15() or __ACCESS_CP15_64() depending if it is 32-bit or
64-bit. get_mpidr() is re-written with new macros.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Wei Huang <wei@redhat.com>
---
 lib/arm/asm/processor.h   |  6 +++---
 lib/arm/asm/sysreg.h      | 19 +++++++++++++++++++
 lib/arm64/asm/processor.h | 11 ++++-------
 lib/arm64/asm/sysreg.h    | 26 ++++++++++++++++++++++++++
 lib/libcflat.h            |  4 ++--
 5 files changed, 54 insertions(+), 12 deletions(-)
 create mode 100644 lib/arm64/asm/sysreg.h

diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
index f25e7ee..c831749 100644
--- a/lib/arm/asm/processor.h
+++ b/lib/arm/asm/processor.h
@@ -6,6 +6,7 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 
 enum vector {
 	EXCPTN_RST,
@@ -33,11 +34,10 @@ static inline unsigned long current_cpsr(void)
 
 #define current_mode() (current_cpsr() & MODE_MASK)
 
+#define MPIDR __ACCESS_CP15(c0, 0, c0, 5)
 static inline unsigned int get_mpidr(void)
 {
-	unsigned int mpidr;
-	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
-	return mpidr;
+	return read_sysreg(MPIDR);
 }
 
 /* Only support Aff0 for now, up to 4 cpus */
diff --git a/lib/arm/asm/sysreg.h b/lib/arm/asm/sysreg.h
index 3e1ad3a..02dbe3d 100644
--- a/lib/arm/asm/sysreg.h
+++ b/lib/arm/asm/sysreg.h
@@ -34,4 +34,23 @@
 #define CR_AFE	(1 << 29)	/* Access flag enable			*/
 #define CR_TE	(1 << 30)	/* Thumb exception enable		*/
 
+#ifndef __ASSEMBLY__
+#include <libcflat.h>
+
+#define __ACCESS_CP15(CRn, Op1, CRm, Op2)			\
+	"mrc", "mcr", xstr(p15, Op1, %0, CRn, CRm, Op2), u32
+#define __ACCESS_CP15_64(Op1, CRm)					\
+	"mrrc", "mcrr", xstr(p15, Op1, %Q0, %R0, CRm), u64
+
+#define __read_sysreg(r, w, c, t) ({				\
+			t __val;				\
+			asm volatile(r " " c : "=r" (__val));	\
+			__val;					\
+		})
+#define read_sysreg(...)                 __read_sysreg(__VA_ARGS__)
+
+#define __write_sysreg(v, r, w, c, t)   asm volatile(w " " c : : "r" ((t)(v)))
+#define write_sysreg(v, ...)            __write_sysreg(v, __VA_ARGS__)
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _ASMARM_SYSREG_H_ */
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index 84d5c7c..ed59ad2 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -19,6 +19,7 @@
 #ifndef __ASSEMBLY__
 #include <asm/ptrace.h>
 #include <asm/esr.h>
+#include <asm/sysreg.h>
 
 enum vector {
 	EL1T_SYNC,
@@ -66,14 +67,10 @@ static inline unsigned long current_level(void)
 	return el & 0xc;
 }
 
-#define DEFINE_GET_SYSREG32(reg)				\
-static inline unsigned int get_##reg(void)			\
-{								\
-	unsigned int reg;					\
-	asm volatile("mrs %0, " #reg "_el1" : "=r" (reg));	\
-	return reg;						\
+static inline unsigned int get_mpidr(void)
+{
+	return read_sysreg(mpidr_el1);
 }
-DEFINE_GET_SYSREG32(mpidr)
 
 /* Only support Aff0 for now, gicv2 only */
 #define mpidr_to_cpu(mpidr) ((int)((mpidr) & 0xff))
diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
new file mode 100644
index 0000000..05b9fcb
--- /dev/null
+++ b/lib/arm64/asm/sysreg.h
@@ -0,0 +1,26 @@
+/*
+ * Ripped off from arch/arm64/include/asm/sysreg.h
+ *
+ * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#ifndef _ASMARM64_SYSREG_H_
+#define _ASMARM64_SYSREG_H_
+
+#ifndef __ASSEMBLY__
+#include <libcflat.h>
+
+#define read_sysreg(r) ({					\
+	u64 __val;						\
+	asm volatile("mrs %0, " xstr(r) : "=r" (__val));	\
+	__val;							\
+})
+
+#define write_sysreg(v, r) do {					\
+	u64 __val = (u64)v;					\
+	asm volatile("msr " xstr(r) ", %x0" : : "rZ" (__val));	\
+} while (0)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASMARM64_SYSREG_H_ */
diff --git a/lib/libcflat.h b/lib/libcflat.h
index c622198..c3fa4f2 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -27,8 +27,8 @@
 
 #define __unused __attribute__((__unused__))
 
-#define xstr(s) xxstr(s)
-#define xxstr(s) #s
+#define xstr(s...) xxstr(s)
+#define xxstr(s...) #s
 
 #define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
-- 
1.8.3.1
