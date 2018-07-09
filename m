Received: from eggs.gnu.org ([2001:4830:134:3::10]:57028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcVYC-0001q5-77
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcVYB-0006XX-Au
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:45:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 13:45:35 +0100
Message-Id: <20180709124535.1116-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] target/arm: Use correct mmu_idx for
 exception-return unstacking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Adithya Baglody <adithya.nagaraj.baglody@intel.com>

For M-profile exception returns, the mmu index to use for exception
return unstacking is supposed to be that of wherever we are returning to:
 * if returning to handler mode, privileged
 * if returning to thread mode, privileged or unprivileged depending on
   CONTROL.nPRIV for the destination security state

We were passing the wrong thing as the 'priv' argument to
arm_v7m_mmu_idx_for_secstate_and_priv(). The effect was that guests
which programmed the MPU to behave differently for privileged and
unprivileged code could get spurious MemManage Unstack exceptions.

Reported-by: Adithya Baglody <adithya.nagaraj.baglody@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2ac96084e7..0604a0efbe2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7171,9 +7171,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         uint32_t frameptr = *frame_sp_p;
         bool pop_ok = true;
         ARMMMUIdx mmu_idx;
+        bool return_to_priv = return_to_handler ||
+            !(env->v7m.control[return_to_secure] & R_V7M_CONTROL_NPRIV_MASK);
 
         mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, return_to_secure,
-                                                        !return_to_handler);
+                                                        return_to_priv);
 
         if (!QEMU_IS_ALIGNED(frameptr, 8) &&
             arm_feature(env, ARM_FEATURE_V8)) {
-- 
2.17.1
