Received: from eggs.gnu.org ([2001:4830:134:3::10]:47149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rg-0000cg-BW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rX-0000cy-E1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gH9rT-0000WP-Tr
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id x12-v6so9251049wrw.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:53:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 29 Oct 2018 15:53:37 +0000
Message-Id: <20181029155339.15280-3-richard.henderson@linaro.org>
In-Reply-To: <20181029155339.15280-1-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] target/arm: Install ASIDs for long-form
 from EL1
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

In addition to providing the core with the current ASID, this minimizes
both the number of flushes due to non-changing ASID as well as the set
of mmu_idx that are affected by each flush.

In particular, updates to the secure mode registers flushes only the
relevant secure mode mmu_idx's, and similarly non-secure updates only
affect non-secure mmu_idx's.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 73 +++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ea95b0815..26d6f28793 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2685,6 +2685,36 @@ static const ARMCPRegInfo pmsav5_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Called after a change to any of TTBR*_EL1 or TTBCR_EL1.  */
+static void update_lpae_el1_asid(CPUARMState *env, int secure)
+{
+    CPUState *cs = CPU(arm_env_get_cpu(env));
+    uint64_t ttbr0, ttbr1, ttcr;
+    int asid, idxmask;
+
+    switch (secure) {
+    case ARM_CP_SECSTATE_S:
+        ttbr0 = env->cp15.ttbr0_s;
+        ttbr1 = env->cp15.ttbr1_s;
+        ttcr = env->cp15.tcr_el[3].raw_tcr;
+        /* Note that cp15.ttbr0_s == cp15.ttbr0_el[3], so S1E3 is affected.  */
+        /* ??? Secure EL3 really using the ASID field?  Doesn't make sense.  */
+        idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 | ARMMMUIdxBit_S1E3;
+        break;
+    case ARM_CP_SECSTATE_NS:
+        ttbr0 = env->cp15.ttbr0_ns;
+        ttbr1 = env->cp15.ttbr1_ns;
+        ttcr = env->cp15.tcr_el[1].raw_tcr;
+        idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    asid = extract64(ttcr & TTBCR_A1 ? ttbr1 : ttbr0, 48, 16);
+
+    tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+}
+
 static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -2721,15 +2751,11 @@ static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    if (arm_feature(env, ARM_FEATURE_LPAE)) {
-        /* With LPAE the TTBCR could result in a change of ASID
-         * via the TTBCR.A1 bit, so do a TLB flush.
-         */
-        tlb_flush(CPU(cpu));
-    }
     vmsa_ttbcr_raw_write(env, ri, value);
+    if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        /* The A1 bit controls which ASID is active.  */
+        update_lpae_el1_asid(env, ri->secure);
+    }
 }
 
 static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -2747,24 +2773,19 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    TCR *tcr = raw_ptr(env, ri);
-
-    /* For AArch64 the A1 bit could result in a change of ASID, so TLB flush. */
-    tlb_flush(CPU(cpu));
-    tcr->raw_tcr = value;
+    raw_write(env, ri, value);
+    /* The A1 bit controls which ASID is active.  */
+    update_lpae_el1_asid(env, ri->secure);
 }
 
-static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
+static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
 {
-    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
-    if (cpreg_field_is_64bit(ri) &&
-        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
-        ARMCPU *cpu = arm_env_get_cpu(env);
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+    if (cpreg_field_is_64bit(ri)) {
+        /* The LPAE format (64-bit write) contains an ASID field.  */
+        update_lpae_el1_asid(env, ri->secure);
+    }
 }
 
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2810,12 +2831,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr_el1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .writefn = vmsa_ttbr_el1_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
@@ -3067,12 +3088,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_el1_write, },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
       .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
-      .writefn = vmsa_ttbr_write, },
+      .writefn = vmsa_ttbr_el1_write, },
     REGINFO_SENTINEL
 };
 
-- 
2.17.2
