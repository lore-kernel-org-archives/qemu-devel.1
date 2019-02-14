Received: from eggs.gnu.org ([209.51.188.92]:53849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKv-0007kR-Hk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKu-0004hg-94
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKu-0004gr-1q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id v26so7192853wmh.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:44 +0000
Message-Id: <20190214190603.25030-9-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/27] target/arm: expose MPIDR_EL1 to userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

As this is a single register we could expose it with a simple ifdef
but we use the existing modify_arm_cp_regs mechanism for consistency.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190205190224.2198-4-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b2abaf5b225..77c73056948 100644
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
@@ -6451,6 +6444,20 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
