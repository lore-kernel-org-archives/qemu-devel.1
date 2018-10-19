Received: from eggs.gnu.org ([2001:4830:134:3::10]:47779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6d-000265-FF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6c-0002w0-KO
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY6c-00020Y-9m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:58:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6Q-0006pt-ON
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:35 +0100
Message-Id: <20181019165735.22511-46-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 45/45] target/arm: Only flush tlb if ASID changes
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

Since QEMU does not implement ASIDs, changes to the ASID must flush the
tlb.  However, if the ASID does not change there is no reason to flush.

In testing a boot of the Ubuntu installer to the first menu, this reduces
the number of flushes by 30%, or nearly 600k instances.

Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181019015617.22583-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20114bf574d..bea4d5350d1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2758,12 +2758,10 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
2.19.1
