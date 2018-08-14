Received: from eggs.gnu.org ([2001:4830:134:3::10]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvj-000581-ID
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduF-0006o9-CY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduF-0006nb-2C
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduD-0007Me-Ch
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:05 +0100
Message-Id: <20180814181815.23348-36-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 35/45] target/arm: Honour HCR_EL2.TGE when
 raising synchronous exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Whene we raise a synchronous exception, if HCR_EL2.TGE is set then
exceptions targeting NS EL1 must be redirected to EL2.  Implement
this in raise_exception() -- all synchronous exceptions go through
this function.

(Asynchronous exceptions go via arm_cpu_exec_interrupt(), which
already honours HCR_EL2.TGE when it determines the target EL
in arm_phys_excp_target_el().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180724115950.17316-4-peter.maydell@linaro.org
---
 target/arm/op_helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index f728f25e4bf..d550978b5b9 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -33,6 +33,20 @@ static void raise_exception(CPUARMState *env, uint32_t excp,
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
 
+    if ((env->cp15.hcr_el2 & HCR_TGE) &&
+        target_el == 1 && !arm_is_secure(env)) {
+        /*
+         * Redirect NS EL1 exceptions to NS EL2. These are reported with
+         * their original syndrome register value, with the exception of
+         * SIMD/FP access traps, which are reported as uncategorized
+         * (see DDI0478C.a D1.10.4)
+         */
+        target_el = 2;
+        if (syndrome >> ARM_EL_EC_SHIFT == EC_ADVSIMDFPACCESSTRAP) {
+            syndrome = syn_uncategorized();
+        }
+    }
+
     assert(!excp_is_internal(excp));
     cs->exception_index = excp;
     env->exception.syndrome = syndrome;
-- 
2.18.0
