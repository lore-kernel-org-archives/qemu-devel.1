Received: from eggs.gnu.org ([209.51.188.92]:55620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNET-0002v4-P2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNES-0002YC-Um
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:05 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNES-0002Wz-Nc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:04 -0500
Received: by mail-pg1-x543.google.com with SMTP id h8so1426284pgp.6
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:54 -0800
Message-Id: <20190223023957.18865-4-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
References: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] target/arm: Implement ID_AA64MMFR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

This was res0 before ARMv8.2, but will shortly be used by
new processor definitions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 15 +++++++++++++++
 target/arm/helper.c |  4 ++--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c2899f0bed..02642a7db3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -855,6 +855,7 @@ struct ARMCPU {
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
+        uint64_t id_aa64mmfr2;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -1724,6 +1725,20 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
 FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
 FIELD(ID_AA64MMFR1, XNX, 28, 4)
 
+FIELD(ID_AA64MMFR2, CNP, 0, 4)
+FIELD(ID_AA64MMFR2, UAO, 4, 4)
+FIELD(ID_AA64MMFR2, LSM, 8, 4)
+FIELD(ID_AA64MMFR2, IESB, 12, 4)
+FIELD(ID_AA64MMFR2, VARANGE, 16, 4)
+FIELD(ID_AA64MMFR2, CCIDX, 20, 4)
+FIELD(ID_AA64MMFR2, NV, 24, 4)
+FIELD(ID_AA64MMFR2, ST, 28, 4)
+FIELD(ID_AA64MMFR2, AT, 32, 4)
+FIELD(ID_AA64MMFR2, IDS, 36, 4)
+FIELD(ID_AA64MMFR2, FWB, 40, 4)
+FIELD(ID_AA64MMFR2, TTL, 48, 4)
+FIELD(ID_AA64MMFR2, BBM, 52, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8903cc13d8..fbdca9324b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6052,10 +6052,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
-            { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64mmfr2 },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e3ba149248..c3d421b53b 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -542,6 +542,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 7, 2));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.17.2
