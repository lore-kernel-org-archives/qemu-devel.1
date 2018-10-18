Received: from eggs.gnu.org ([2001:4830:134:3::10]:37329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDD1i-000232-EL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDD1h-00009o-H5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDD1h-00007D-8O
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:28:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id f78-v6so9506366pfe.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 11:28:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 11:27:57 -0700
Message-Id: <20181018182758.18646-3-richard.henderson@linaro.org>
In-Reply-To: <20181018182758.18646-1-richard.henderson@linaro.org>
References: <20181018182758.18646-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] target/arm: Only flush tlb if ASID changes
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

Since QEMU does not implement ASIDs, changes to the ASID must flush the
tlb.  However, if the ASID does not change there is no reason to flush.

In testing a boot of the Ubuntu installer to the first menu, this reduces
the number of flushes by 30%, or nearly 600k instances.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 24bbde4f76..ed70ac645e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2709,12 +2709,10 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    /* 64 bit accesses to the TTBRs can change the ASID and so we
-     * must flush the TLB.
-     */
-    if (cpreg_field_is_64bit(ri)) {
+    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
+    if (cpreg_field_is_64bit(ri) &&
+        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
         ARMCPU *cpu = arm_env_get_cpu(env);
-
         tlb_flush(CPU(cpu));
     }
     raw_write(env, ri, value);
-- 
2.17.2
