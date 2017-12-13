Received: from eggs.gnu.org ([2001:4830:134:3::10]:51745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWm-0004xO-Vu
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWl-0008Aa-Pq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWl-00089j-IC
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:07 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWk-0007oA-Jn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:32 +0000
Message-Id: <1513188761-20784-35-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/43] target/arm: Ignore fsr from
 get_phys_addr() in do_ats_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In do_ats_write(), rather than using the FSR value from get_phys_addr(),
construct the PAR values using the information in the ARMMMUFaultInfo
struct. This allows us to create a PAR of the correct format regardless
of what the translation table format is.

For the moment we leave the condition for "when should this be a
64 bit PAR" as it was previously; this will need to be fixed to
properly support AArch32 Hyp mode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: 1512503192-2239-11-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e611b0f..79ab277 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2160,7 +2160,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     hwaddr phys_addr;
     target_ulong page_size;
     int prot;
-    uint32_t fsr;
+    uint32_t fsr_unused;
     bool ret;
     uint64_t par64;
     MemTxAttrs attrs = {};
@@ -2168,12 +2168,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     ARMCacheAttrs cacheattrs = {};
 
     ret = get_phys_addr(env, value, access_type, mmu_idx, &phys_addr, &attrs,
-                        &prot, &page_size, &fsr, &fi, &cacheattrs);
+                        &prot, &page_size, &fsr_unused, &fi, &cacheattrs);
+    /* TODO: this is not the correct condition to use to decide whether
+     * to report a PAR in 64-bit or 32-bit format.
+     */
     if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
-        /* fsr is a DFSR/IFSR value for the long descriptor
-         * translation table format, but with WnR always clear.
-         * Convert it to a 64-bit PAR.
-         */
+        /* Create a 64-bit PAR */
         par64 = (1 << 11); /* LPAE bit always set */
         if (!ret) {
             par64 |= phys_addr & ~0xfffULL;
@@ -2183,6 +2183,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
             par64 |= (uint64_t)cacheattrs.attrs << 56; /* ATTR */
             par64 |= cacheattrs.shareability << 7; /* SH */
         } else {
+            uint32_t fsr = arm_fi_to_lfsc(&fi);
+
             par64 |= 1; /* F */
             par64 |= (fsr & 0x3f) << 1; /* FS */
             /* Note that S2WLK and FSTAGE are always zero, because we don't
@@ -2207,6 +2209,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                 par64 |= (1 << 9); /* NS */
             }
         } else {
+            uint32_t fsr = arm_fi_to_sfsc(&fi);
+
             par64 = ((fsr & (1 << 10)) >> 5) | ((fsr & (1 << 12)) >> 6) |
                     ((fsr & 0xf) << 1) | 1;
         }
-- 
2.7.4
