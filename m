Received: from eggs.gnu.org ([209.51.188.92]:58769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wRx-0006EB-0z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wRp-0004Kl-MI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:51 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wRp-0004Iu-40
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:45 -0500
Received: by mail-pg1-x542.google.com with SMTP id j3so11726498pgm.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:04:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:18 -0800
Message-Id: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 00/22] target/arm: Implement ARMv8.5-MemTag,
 system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Major changes since v3:

  * User mode support dropped.  There's nothing baked about the
    userland abi yet.

  * Introduce a new softmmu TLB to avoid duplicating the
    address space -> flatview -> memory region -> ram offset
    craziness that the TLB already manages.

  * Tested with a truly hack-full kernel patch and test case below.
    Real kernel support for MTE will require support for paging.
    I ignore that and pin some pages, which is good enough for the
    test case to run.


r~


Richard Henderson (22):
  target/arm: Add MTE_ACTIVE to tb_flags
  target/arm: Extract TCMA with ARMVAParameters
  target/arm: Add MTE system registers
  target/arm: Add helper_mte_check{1,2}
  target/arm: Suppress tag check for sp+offset
  target/arm: Implement the IRG instruction
  target/arm: Implement ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for CONFIG_USER_ONLY
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Implement the LDGM and STGM instructions
  target/arm: Implement the access tag cache flushes
  target/arm: Clean address for DC ZVA
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Create a TLB entry for tag physical address space
  target/arm: Add allocation tag storage for system mode
  target/arm: Enable MTE

 target/arm/cpu.h           |  68 ++++-
 target/arm/helper-a64.h    |  16 ++
 target/arm/internals.h     |  29 ++
 target/arm/translate.h     |   2 +
 hw/arm/virt.c              |  33 +++
 target/arm/cpu.c           |  21 +-
 target/arm/cpu64.c         |   1 +
 target/arm/helper.c        | 241 ++++++++++++++--
 target/arm/mte_helper.c    | 559 +++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c     |  33 ++-
 target/arm/translate-a64.c | 338 +++++++++++++++++++---
 target/arm/Makefile.objs   |   2 +-
 12 files changed, 1244 insertions(+), 99 deletions(-)
 create mode 100644 target/arm/mte_helper.c

--- kernel patch

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 82e9099834ae..b7aa17d9a044 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -60,7 +60,8 @@
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF         39
 #define ARM64_HAS_GENERIC_AUTH_ARCH            40
 #define ARM64_HAS_GENERIC_AUTH_IMP_DEF         41
+#define ARM64_HAS_MTE                          42
 
-#define ARM64_NCAPS                            42
+#define ARM64_NCAPS                            43
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 72dc4c011014..996ab091ae99 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -451,6 +451,7 @@
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_DSSBS        (_BITUL(44))
+#define SCTLR_ELx_ATA          (_BITUL(43))
 #define SCTLR_ELx_ENIA (_BITUL(31))
 #define SCTLR_ELx_ENIB (_BITUL(30))
 #define SCTLR_ELx_ENDA (_BITUL(27))
@@ -496,6 +497,7 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_ATA0         (_BITUL(42))
 #define SCTLR_EL1_UCI          (_BITUL(26))
 #define SCTLR_EL1_E0E          (_BITUL(24))
 #define SCTLR_EL1_SPAN         (_BITUL(23))
@@ -596,6 +598,7 @@
 
 /* id_aa64pfr1 */
 #define ID_AA64PFR1_SSBS_SHIFT         4
+#define ID_AA64PFR1_MTE_SHIFT          8
 
 #define ID_AA64PFR1_SSBS_PSTATE_NI     0
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY   1
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6d84e2c92fe..f54c1e7f40aa 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -178,6 +178,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
        ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
+       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, 0),
        ARM64_FTR_END,
 };
 
@@ -1203,6 +1204,11 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
+static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
+{
+       sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
        {
                .desc = "GIC system register CPU interface",
@@ -1480,6 +1486,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
                .matches = has_cpuid_feature,
        },
 #endif /* CONFIG_ARM64_PTR_AUTH */
+       {
+               .desc = "Memory Tagging",
+               .capability = ARM64_HAS_MTE,
+               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
+               .matches = has_cpuid_feature,
+               .sys_reg = SYS_ID_AA64PFR1_EL1,
+               .field_pos = ID_AA64PFR1_MTE_SHIFT,
+               .sign = FTR_UNSIGNED,
+               .min_field_value = 1,
+               .cpu_enable = cpu_enable_mte,
        {
                .desc = "GIC system register CPU interface",
@@ -1480,6 +1486,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
                .matches = has_cpuid_feature,
        },
 #endif /* CONFIG_ARM64_PTR_AUTH */
+       {
+               .desc = "Memory Tagging",
+               .capability = ARM64_HAS_MTE,
+               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
+               .matches = has_cpuid_feature,
+               .sys_reg = SYS_ID_AA64PFR1_EL1,
+               .field_pos = ID_AA64PFR1_MTE_SHIFT,
+               .sign = FTR_UNSIGNED,
+               .min_field_value = 1,
+               .cpu_enable = cpu_enable_mte,
+       },
        {},
 };
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5f1f30..20ebf4a222e8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -435,14 +435,14 @@ ENTRY(__cpu_setup)
         *   DEVICE_nGnRE       001     00000100
         *   DEVICE_GRE         010     00001100
         *   NORMAL_NC          011     01000100
-        *   NORMAL             100     11111111
+        *   NORMAL             100     11110000 (Tag)
         *   NORMAL_WT          101     10111011
         */
        ldr     x5, =MAIR(0x00, MT_DEVICE_nGnRnE) | \
                     MAIR(0x04, MT_DEVICE_nGnRE) | \
                     MAIR(0x0c, MT_DEVICE_GRE) | \
                     MAIR(0x44, MT_NORMAL_NC) | \
-                    MAIR(0xff, MT_NORMAL) | \
+                    MAIR(0xf0, MT_NORMAL) | \
                     MAIR(0xbb, MT_NORMAL_WT)
        msr     mair_el1, x5
        /*

--- test case
/*
 * Memory tagging, basic pass cases.
 */

#include <stdio.h>
#include <assert.h>
#include <sys/mman.h>

asm(".arch armv8.5-a+memtag");

int data[16 / sizeof(int)] __attribute__((aligned(16)));

int main(int ac, char **av)
{
    int *p0 = data;
    int *p1, *p2;
    long c;

    if (mlock(data, sizeof(data)) < 0) {
        perror("mlock");
        return 1;
    }

    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
    assert(p1 != p0);
    asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
    assert(c == 0);

    asm("stg %0, [%0]" : : "r"(p1));
    asm("ldg %0, [%1]" : "=r"(p2) : "r"(p0), "0"(p0));
    assert(p1 == p2);

    return 0;
}
