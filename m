Received: from eggs.gnu.org ([209.51.188.92]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AT-0001ua-TH
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0000Yp-Bd
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:53 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000KW-32
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so4402816wrt.13
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:53 +0000
Message-Id: <20190205170510.21984-6-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/22] target/arm: Cache the GP bit for a page
 in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Caching the bit means that we will not have to re-walk the
page tables to look up the bit during translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190128223118.5255-6-richard.henderson@linaro.org
[PMM: no need to OR in guarded bit status]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 45ba678a7df..be0ec7de2a4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10577,6 +10577,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool guarded = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -10756,6 +10757,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
+        guarded = extract64(descriptor, 50, 1);  /* GP */
         if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
@@ -10801,6 +10803,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
2.20.1
