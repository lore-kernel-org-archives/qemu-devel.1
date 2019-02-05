Received: from eggs.gnu.org ([209.51.188.92]:53072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zg-0007vH-9U
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5ze-0004Nx-7D
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5zd-00044k-PZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so4869875wra.6
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:21 +0000
Message-Id: <20190205190224.2198-4-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
References: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/6] target/arm: expose MPIDR_EL1 to
 userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As this is a single register we could expose it with a simple ifdef
but we use the existing modify_arm_cp_regs mechanism for consistency.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f90754cc11..f2f868ff92 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3657,13 +3657,6 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return mpidr_read_val(env);
 }
 
-static const ARMCPRegInfo mpidr_cp_reginfo[] = {
-    { .name = "MPIDR", .state = ARM_CP_STATE_BOTH,
-      .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
-      .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
-    REGINFO_SENTINEL
-};
-
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
     /* NOP AMAIR0/1 */
     { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
@@ -6445,6 +6438,20 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     if (arm_feature(env, ARM_FEATURE_MPIDR)) {
+        ARMCPRegInfo mpidr_cp_reginfo[] = {
+            { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
+              .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
+              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+            REGINFO_SENTINEL
+        };
+#ifdef CONFIG_USER_ONLY
+        ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
+            { .name = "MPIDR_EL1",
+              .fixed_bits = 0x0000000080000000 },
+            REGUSERINFO_SENTINEL
+        };
+        modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
+#endif
         define_arm_cp_regs(cpu, mpidr_cp_reginfo);
     }
 
-- 
2.20.1
