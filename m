Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rk-0000gI-TM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9re-0000in-Gv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:54:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gH9rX-0000Xh-Cx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id u1-v6so9295862wrn.0
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:53:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 29 Oct 2018 15:53:38 +0000
Message-Id: <20181029155339.15280-4-richard.henderson@linaro.org>
In-Reply-To: <20181029155339.15280-1-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/arm: Install ASIDs for short-form
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

This is less complex than the LPAE case, but still we now avoid the
flush in case it is only the PROCID field that is changing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 26d6f28793..f767467dcf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -541,17 +541,31 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-
-    if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
-        /* For VMSA (when not using the LPAE long descriptor page table
-         * format) this register includes the ASID, so do a TLB flush.
-         * For PMSA it is purely a process ID and no action is needed.
-         */
-        tlb_flush(CPU(cpu));
-    }
     raw_write(env, ri, value);
+
+    /*
+     * For VMSA (when not using the LPAE long descriptor page table format)
+     * this register includes the ASID.  For PMSA it is purely a process ID
+     * and no action is needed.
+     */
+    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
+        !extended_addresses_enabled(env)) {
+        CPUState *cs = CPU(arm_env_get_cpu(env));
+        int asid = extract32(value, 0, 8);
+        int idxmask;
+
+        switch (ri->secure) {
+        case ARM_CP_SECSTATE_S:
+            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            break;
+        case ARM_CP_SECSTATE_NS:
+            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+    }
 }
 
 /* IS variants of TLB operations must affect all cores */
-- 
2.17.2
