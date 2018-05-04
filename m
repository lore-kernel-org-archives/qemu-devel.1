Received: from eggs.gnu.org ([2001:4830:134:3::10]:51642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ9-0005bk-1C
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ7-0000WL-On
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ7-0000Q4-Gs
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ4-0002zz-Rc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:18 +0100
Message-Id: <20180504171540.25813-3-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/24] target/arm: Correct MPUIR privilege level
 in register_cp_regs_for_features() conditional case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Mathew Maidment <mathew1800@gmail.com>

The duplication of id_tlbtr_reginfo was unintentionally added within
3281af8114c6b8ead02f08b58e3c36895c1ea047 which should have been
id_mpuir_reginfo.

The effect was that for OMAP and StrongARM CPUs we would
incorrectly UNDEF writes to MPUIR rather than NOPing them.

Signed-off-by: Mathew Maidment <mathew1800@gmail.com>
Message-id: 20180501184933.37609-2-mathew1800@gmail.com
[PMM: tweak commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 52a88e0297..0fef5d4d06 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5347,7 +5347,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             for (r = id_cp_reginfo; r->type != ARM_CP_SENTINEL; r++) {
                 r->access = PL1_RW;
             }
-            id_tlbtr_reginfo.access = PL1_RW;
+            id_mpuir_reginfo.access = PL1_RW;
             id_tlbtr_reginfo.access = PL1_RW;
         }
         if (arm_feature(env, ARM_FEATURE_V8)) {
-- 
2.17.0
