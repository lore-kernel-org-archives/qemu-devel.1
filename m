Received: from eggs.gnu.org ([2001:4830:134:3::10]:50647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwEQ-0006DL-Rd
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwEP-0007dx-G4
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:45:10 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 30 Jun 2017 15:45:02 +0200
Message-Id: <1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Extend PAR format determination to handle more cases.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/helper.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fd1027e..6a1fffe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2345,12 +2345,40 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     uint32_t fsr;
     bool ret;
     uint64_t par64;
+    bool format64 = false;
     MemTxAttrs attrs = {};
     ARMMMUFaultInfo fi = {};
 
     ret = get_phys_addr(env, value, access_type, mmu_idx,
                         &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
-    if (extended_addresses_enabled(env)) {
+
+    if (is_a64(env)) {
+        format64 = true;
+    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
+        /*
+         * ATS1Cxx:
+         * * TTBCR.EAE determines whether the result is returned using the
+         *   32-bit or the 64-bit PAR format
+         * * Instructions executed in Hyp mode always use the 64bit format
+         *
+         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
+         * * The Non-secure TTBCR.EAE bit is set to 1
+         * * The implementation includes EL2, and the value of HCR.VM is 1
+         *
+         * ATS1Hx always uses the 64bit format (not supported yet).
+         */
+        format64 = regime_using_lpae_format(env, mmu_idx);
+
+        if (arm_feature(env, ARM_FEATURE_EL2)) {
+            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+                format64 |= env->cp15.hcr_el2 & HCR_VM;
+            } else {
+                format64 |= arm_current_el(env) == 2;
+            }
+        }
+    }
+
+    if (format64) {
         /* fsr is a DFSR/IFSR value for the long descriptor
          * translation table format, but with WnR always clear.
          * Convert it to a 64-bit PAR.
-- 
2.7.4
