Received: from eggs.gnu.org ([209.51.188.92]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbm-00038C-Di
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbl-0007fO-GD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbl-0007eb-AP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z5so15377752wrt.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:59 +0000
Message-Id: <20190118145805.6852-44-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/49] target/arm: Make PMCEID[01]_EL0 64 bit
 registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-9-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  4 ++--
 target/arm/helper.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 79378df96e6..34c7fceefb9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -852,8 +852,8 @@ struct ARMCPU {
     uint32_t id_pfr0;
     uint32_t id_pfr1;
     uint32_t id_dfr0;
-    uint32_t pmceid0;
-    uint32_t pmceid1;
+    uint64_t pmceid0;
+    uint64_t pmceid1;
     uint32_t id_afr0;
     uint32_t id_mmfr0;
     uint32_t id_mmfr1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 460ab713d20..5c00e0164cc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5425,6 +5425,21 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
+    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
+            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
+        ARMCPRegInfo v81_pmu_regs[] = {
+            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
+            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, v81_pmu_regs);
+    }
     if (arm_feature(env, ARM_FEATURE_V8)) {
         /* AArch64 ID registers, which all have impdef reset values.
          * Note that within the ID register ranges the unused slots
@@ -5601,7 +5616,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "PMCEID0", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 6,
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = cpu->pmceid0 },
+              .resetvalue = extract64(cpu->pmceid0, 0, 32) },
             { .name = "PMCEID0_EL0", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 6,
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
@@ -5609,7 +5624,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "PMCEID1", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 7,
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = cpu->pmceid1 },
+              .resetvalue = extract64(cpu->pmceid1, 0, 32) },
             { .name = "PMCEID1_EL0", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 7,
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-- 
2.20.1
