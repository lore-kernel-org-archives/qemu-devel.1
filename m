Received: from eggs.gnu.org ([209.51.188.92]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcB-0006iZ-5Y
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRQ-0006Ic-Ns
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRO-0006Bz-N1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so16140538otm.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:11 -0800
Message-Id: <20190128223118.5255-6-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 05/12] target/arm: Cache the GP bit for a
 page in MemTxAttrs
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

Caching the bit means that we will not have to re-walk the
page tables to look up the bit during translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6efe88a157..70277222da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10457,6 +10457,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool guarded = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -10629,6 +10630,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
+        guarded |= extract64(descriptor, 50, 1);  /* GP */
         if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
@@ -10674,6 +10676,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
          */
         txattrs->secure = false;
     }
+    /* When in aarch64 mode, and BTI is enabled, remember GP in the IOTLB.  */
+    if (aarch64 && guarded && cpu_isar_feature(aa64_bti, cpu)) {
+        txattrs->target_tlb_bit0 = true;
+    }
 
     if (cacheattrs != NULL) {
         if (mmu_idx == ARMMMUIdx_S2NS) {
-- 
2.17.2
