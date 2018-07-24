Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyw-0008A6-Cx
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyv-00037S-Ii
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:58 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:59:48 +0100
Message-Id: <20180724115950.17316-4-peter.maydell@linaro.org>
In-Reply-To: <20180724115950.17316-1-peter.maydell@linaro.org>
References: <20180724115950.17316-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] target/arm: Honour HCR_EL2.TGE when
 raising synchronous exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Whene we raise a synchronous exception, if HCR_EL2.TGE is set then
exceptions targeting NS EL1 must be redirected to EL2.  Implement
this in raise_exception() -- all synchronous exceptions go through
this function.

(Asynchronous exceptions go via arm_cpu_exec_interrupt(), which
already honours HCR_EL2.TGE when it determines the target EL
in arm_phys_excp_target_el().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.17.1
