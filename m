Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDD1k-00023p-9F
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDD1i-0000EJ-WD
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDD1i-0000C5-LS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id f8-v6so14709715plb.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 11:28:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 11:27:58 -0700
Message-Id: <20181018182758.18646-4-richard.henderson@linaro.org>
In-Reply-To: <20181018182758.18646-1-richard.henderson@linaro.org>
References: <20181018182758.18646-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] target/arm: Flush only the TLBs affected
 by TTBR*_EL1
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

Only the EL0 and EL1 TLBs are affected by the EL1 register,
so flush only 2 of the 8 TLBs.

In testing a boot of the Ubuntu installer to the first menu, this
accounts for nearly all of the full tlb flushes: all but 11k of
the 1.2M instances without the patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ed70ac645e..a943e91666 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2706,14 +2706,16 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tcr->raw_tcr = value;
 }
 
-static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
+static void vmsa_ttbr1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
 {
     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
     if (cpreg_field_is_64bit(ri) &&
         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
         ARMCPU *cpu = arm_env_get_cpu(env);
-        tlb_flush(CPU(cpu));
+        tlb_flush_by_mmuidx(CPU(cpu),
+                            ARMMMUIdxBit_S12NSE1 |
+                            ARMMMUIdxBit_S12NSE0);
     }
     raw_write(env, ri, value);
 }
@@ -2761,12 +2763,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
@@ -3018,12 +3020,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr1_write, },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr1_write, },
     REGINFO_SENTINEL
 };
 
-- 
2.17.2
