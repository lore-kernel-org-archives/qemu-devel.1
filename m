Received: from eggs.gnu.org ([2001:4830:134:3::10]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7a-0006nn-6G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7Z-0005ZQ-24
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1cEK7Y-0005Yl-PQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:40 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue,  6 Dec 2016 12:05:27 -0600
Message-Id: <1481047528-16180-5-git-send-email-wei@redhat.com>
In-Reply-To: <1481047528-16180-1-git-send-email-wei@redhat.com>
References: <1481047528-16180-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v14 4/5] arm: pmu: Check cycle
 count increases
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

From: Christopher Covington <cov@codeaurora.org>

Ensure that reads of the PMCCNTR_EL0 are monotonically increasing,
even for the smallest delta of two subsequent reads.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Wei Huang <wei@redhat.com>
---
 arm/pmu.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index bf6ac69..d9ff19d 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -18,6 +18,9 @@
 #include "asm/sysreg.h"
 #include "asm/processor.h"
 
+#define PMU_PMCR_E         (1 << 0)
+#define PMU_PMCR_C         (1 << 2)
+#define PMU_PMCR_LC        (1 << 6)
 #define PMU_PMCR_N_SHIFT   11
 #define PMU_PMCR_N_MASK    0x1f
 #define PMU_PMCR_ID_SHIFT  16
@@ -28,16 +31,47 @@
 #define ID_DFR0_PERFMON_SHIFT 24
 #define ID_DFR0_PERFMON_MASK  0xf
 
+#define PMU_CYCLE_IDX         31
+
+#define NR_SAMPLES 10
+
 static unsigned int pmu_version;
 #if defined(__arm__)
 #define PMCR         __ACCESS_CP15(c9, 0, c12, 0)
 #define ID_DFR0      __ACCESS_CP15(c0, 0, c1, 2)
+#define PMSELR       __ACCESS_CP15(c9, 0, c12, 5)
+#define PMXEVTYPER   __ACCESS_CP15(c9, 0, c13, 1)
+#define PMCNTENSET   __ACCESS_CP15(c9, 0, c12, 1)
+#define PMCCNTR32    __ACCESS_CP15(c9, 0, c13, 0)
+#define PMCCNTR64    __ACCESS_CP15_64(0, c9)
 
 static inline uint32_t get_id_dfr0(void) { return read_sysreg(ID_DFR0); }
 static inline uint32_t get_pmcr(void) { return read_sysreg(PMCR); }
+static inline void set_pmcr(uint32_t v) { write_sysreg(v, PMCR); }
+static inline void set_pmcntenset(uint32_t v) { write_sysreg(v, PMCNTENSET); }
+
+static inline uint64_t get_pmccntr(void)
+{
+	if (pmu_version == 0x3)
+		return read_sysreg(PMCCNTR64);
+	else
+		return read_sysreg(PMCCNTR32);
+}
+
+/* PMCCFILTR is an obsolete name for PMXEVTYPER31 in ARMv7 */
+static inline void set_pmccfiltr(uint32_t value)
+{
+	write_sysreg(PMU_CYCLE_IDX, PMSELR);
+	write_sysreg(value, PMXEVTYPER);
+	isb();
+}
 #elif defined(__aarch64__)
 static inline uint32_t get_id_dfr0(void) { return read_sysreg(id_dfr0_el1); }
 static inline uint32_t get_pmcr(void) { return read_sysreg(pmcr_el0); }
+static inline void set_pmcr(uint32_t v) { write_sysreg(v, pmcr_el0); }
+static inline uint64_t get_pmccntr(void) { return read_sysreg(pmccntr_el0); }
+static inline void set_pmcntenset(uint32_t v) { write_sysreg(v, pmcntenset_el0); }
+static inline void set_pmccfiltr(uint32_t v) { write_sysreg(v, pmccfiltr_el0); }
 #endif
 
 /*
@@ -63,6 +97,37 @@ static bool check_pmcr(void)
 	return ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) != 0;
 }
 
+/*
+ * Ensure that the cycle counter progresses between back-to-back reads.
+ */
+static bool check_cycles_increase(void)
+{
+	bool success = true;
+
+	/* init before event access, this test only cares about cycle count */
+	set_pmcntenset(1 << PMU_CYCLE_IDX);
+	set_pmccfiltr(0); /* count cycles in EL0, EL1, but not EL2 */
+
+	set_pmcr(get_pmcr() | PMU_PMCR_LC | PMU_PMCR_C | PMU_PMCR_E);
+
+	for (int i = 0; i < NR_SAMPLES; i++) {
+		uint64_t a, b;
+
+		a = get_pmccntr();
+		b = get_pmccntr();
+
+		if (a >= b) {
+			printf("Read %"PRId64" then %"PRId64".\n", a, b);
+			success = false;
+			break;
+		}
+	}
+
+	set_pmcr(get_pmcr() & ~PMU_PMCR_E);
+
+	return success;
+}
+
 /* Return FALSE if no PMU found, otherwise return TRUE */
 bool pmu_probe(void)
 {
@@ -88,6 +153,7 @@ int main(void)
 	report_prefix_push("pmu");
 
 	report("Control register", check_pmcr());
+	report("Monotonically increasing cycle count", check_cycles_increase());
 
 	return report_summary();
 }
-- 
1.8.3.1
