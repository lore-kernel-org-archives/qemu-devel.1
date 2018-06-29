Received: from eggs.gnu.org ([2001:4830:134:3::10]:36423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO6-0008J1-4F
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO5-0002Go-69
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:26 -0400
Received: from foss.arm.com ([217.140.101.70]:39280)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fYrO4-0002GL-VN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:16:25 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Fri, 29 Jun 2018 12:15:24 +0100
Message-Id: <1530270944-11351-5-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Subject: [Qemu-devel] [PATCH v3 04/20] kvm: arm64: Clean up VTCR_EL2
 initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Suzuki K Poulose <suzuki.poulose@arm.com>

Use the new helper for converting the parange to the physical shift.
Also, add the missing definitions for the VTCR_EL2 register fields
and use them instead of hard coding numbers.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2
 - Part 2 of the split from original patch.
 - Also add missing VTCR field helpers and use them.
---
 arch/arm64/include/asm/kvm_arm.h |  3 +++
 arch/arm64/kvm/hyp/s2-setup.c    | 30 ++++++------------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6dd285e..3dffd38 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -106,6 +106,7 @@
 #define VTCR_EL2_RES1		(1 << 31)
 #define VTCR_EL2_HD		(1 << 22)
 #define VTCR_EL2_HA		(1 << 21)
+#define VTCR_EL2_PS_SHIFT	TCR_EL2_PS_SHIFT
 #define VTCR_EL2_PS_MASK	TCR_EL2_PS_MASK
 #define VTCR_EL2_TG0_MASK	TCR_TG0_MASK
 #define VTCR_EL2_TG0_4K		TCR_TG0_4K
@@ -126,6 +127,8 @@
 #define VTCR_EL2_VS_8BIT	(0 << VTCR_EL2_VS_SHIFT)
 #define VTCR_EL2_VS_16BIT	(1 << VTCR_EL2_VS_SHIFT)
 
+#define VTCR_EL2_T0SZ(x)	TCR_T0SZ(x)
+
 /*
  * We configure the Stage-2 page tables to always restrict the IPA space to be
  * 40 bits wide (T0SZ = 24).  Systems with a PARange smaller than 40 bits are
diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
index 603e1ee..81094f1 100644
--- a/arch/arm64/kvm/hyp/s2-setup.c
+++ b/arch/arm64/kvm/hyp/s2-setup.c
@@ -19,11 +19,13 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
+#include <asm/cpufeature.h>
 
 u32 __hyp_text __init_stage2_translation(void)
 {
 	u64 val = VTCR_EL2_FLAGS;
 	u64 parange;
+	u32 phys_shift;
 	u64 tmp;
 
 	/*
@@ -34,30 +36,10 @@ u32 __hyp_text __init_stage2_translation(void)
 	parange = read_sysreg(id_aa64mmfr0_el1) & 7;
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
-	val |= parange << 16;
+	val |= parange << VTCR_EL2_PS_SHIFT;
 
 	/* Compute the actual PARange... */
-	switch (parange) {
-	case 0:
-		parange = 32;
-		break;
-	case 1:
-		parange = 36;
-		break;
-	case 2:
-		parange = 40;
-		break;
-	case 3:
-		parange = 42;
-		break;
-	case 4:
-		parange = 44;
-		break;
-	case 5:
-	default:
-		parange = 48;
-		break;
-	}
+	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
 
 	/*
 	 * ... and clamp it to 40 bits, unless we have some braindead
@@ -65,7 +47,7 @@ u32 __hyp_text __init_stage2_translation(void)
 	 * return that value for the rest of the kernel to decide what
 	 * to do.
 	 */
-	val |= 64 - (parange > 40 ? 40 : parange);
+	val |= VTCR_EL2_T0SZ(phys_shift > 40 ? 40 : phys_shift);
 
 	/*
 	 * Check the availability of Hardware Access Flag / Dirty Bit
@@ -86,5 +68,5 @@ u32 __hyp_text __init_stage2_translation(void)
 
 	write_sysreg(val, vtcr_el2);
 
-	return parange;
+	return phys_shift;
 }
-- 
2.7.4
