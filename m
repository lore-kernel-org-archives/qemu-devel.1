Received: from eggs.gnu.org ([209.51.188.92]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN3-0002Zs-PR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN1-0008Dq-PX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:57 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBMz-00086o-RJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id u4so19163091wrp.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:22 +0000
Message-Id: <20190128181047.20781-2-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/26] target/arm: Fix validation of 32-bit
 address spaces for aa32
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

When tsz == 0, aarch32 selects the address space via exclusion,
and there are no "top_bits" remaining that require validation.

Fixes: ba97be9f4a4
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190125184913.5970-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92666e52085..e24689f7677 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10447,7 +10447,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size, top_bits;
+    target_ulong page_size;
     uint32_t attrs;
     int32_t stride;
     int addrsize, inputsize;
@@ -10487,12 +10487,19 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
      * We determined the region when collecting the parameters, but we
      * have not yet validated that the address is valid for the region.
      * Extract the top bits and verify that they all match select.
+     *
+     * For aa32, if inputsize == addrsize, then we have selected the
+     * region by exclusion in aa32_va_parameters and there is no more
+     * validation to do here.
      */
-    top_bits = sextract64(address, inputsize, addrsize - inputsize);
-    if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
-        /* In the gap between the two regions, this is a Translation fault */
-        fault_type = ARMFault_Translation;
-        goto do_fault;
+    if (inputsize < addrsize) {
+        target_ulong top_bits = sextract64(address, inputsize,
+                                           addrsize - inputsize);
+        if (-top_bits != param.select || (param.select && !ttbr1_valid)) {
+            /* The gap between the two regions is a Translation fault */
+            fault_type = ARMFault_Translation;
+            goto do_fault;
+        }
     }
 
     if (param.using64k) {
-- 
2.20.1
