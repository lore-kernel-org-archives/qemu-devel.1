Received: from eggs.gnu.org ([209.51.188.92]:55959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHY-0004Wi-6w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHX-0007bR-Fs
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:56 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHX-0007al-AE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:55 -0500
Received: by mail-pl1-x644.google.com with SMTP id g9so5121865plo.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:17:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:29 +1100
Message-Id: <20190110121736.23448-5-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/11] target/arm: Record the GP bit for a page
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
Cc: peter.maydell@linaro.org

This isn't really a transaction attribute, but that's the most
convenient place to hold a random bit of information within the
softmmu tlb.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h | 2 ++
 target/arm/helper.c     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a1642098..39d61188e1 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -35,6 +35,8 @@ typedef struct MemTxAttrs {
     unsigned int secure:1;
     /* Memory access is usermode (unprivileged) */
     unsigned int user:1;
+    /* Page is marked as "guarded" */
+    unsigned int guarded:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
 } MemTxAttrs;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 138d9d5565..4e9ea2ed39 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9927,6 +9927,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool ttbr1_valid;
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
+    bool guarded = false;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -10098,6 +10099,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
+        guarded |= extract64(descriptor, 50, 1);  /* GP */
         if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
@@ -10143,6 +10145,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
          */
         txattrs->secure = false;
     }
+    /* When in aarch64 mode, and BTI is enabled, remember GP in the IOTLB.  */
+    if (aarch64 && guarded && cpu_isar_feature(aa64_bti, cpu)) {
+        txattrs->guarded = true;
+    }
 
     if (cacheattrs != NULL) {
         if (mmu_idx == ARMMMUIdx_S2NS) {
-- 
2.17.2
