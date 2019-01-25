Received: from eggs.gnu.org ([209.51.188.92]:59867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn6XW-0006be-VA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn6XV-0001m3-SF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:49:18 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gn6XV-0001l0-M0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:49:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id u6so4945651plm.8
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:49:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 10:49:13 -0800
Message-Id: <20190125184913.5970-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix validation of 32-bit address
 spaces for aa32
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

When tsz == 0, aarch32 selects the address space via exclusion,
and there are no "top_bits" remaining that require validation.

Fixes: ba97be9f4a4
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92666e5208..e24689f767 100644
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
2.17.1
