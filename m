Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rk-0000gH-TO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rb-0000gK-Ga
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gH9rV-0000Yg-QH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id l6-v6so9278733wrt.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:53:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 29 Oct 2018 15:53:39 +0000
Message-Id: <20181029155339.15280-5-richard.henderson@linaro.org>
In-Reply-To: <20181029155339.15280-1-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Install ASIDs for EL2
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

The VMID is the ASID for the 2nd stage page lookup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f767467dcf..4b14f2c05b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2805,17 +2805,23 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = CPU(arm_env_get_cpu(env));
+    int vmid;
 
-    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
-    if (raw_read(env, ri) != value) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
-                            ARMMMUIdxBit_S2NS);
-        raw_write(env, ri, value);
-    }
+    raw_write(env, ri, value);
+
+    /*
+     * TODO: with ARMv8.1-VMID16, aarch64 must examine VTCR.VS
+     * (re-evaluating with changes to VTCR) then use bits [63:48].
+     */
+    vmid = extract64(value, 48, 8);
+
+    /*
+     * A change in VMID to the stage2 page table (S2NS) invalidates
+     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
+     */
+    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
+                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
-- 
2.17.2
