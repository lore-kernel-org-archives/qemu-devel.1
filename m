Received: from eggs.gnu.org ([2001:4830:134:3::10]:42260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzR-0005zH-D8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzO-0005ZZ-9F
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:49 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzO-0005YZ-4B
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:46 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so12988440otk.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:30 -0600
Message-Id: <20181203203839.757-2-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/10] target/arm: Move id_aa64mmfr* to
 ARMISARegisters
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

At the same time, define the fields for these registers,
and use those defines in arm_pamax().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

----
v2: Include the v8.5 fields; init the registers for kvm.
    Upcase all of the field names.
---
 target/arm/cpu.h       | 26 ++++++++++++++++++++++++--
 target/arm/internals.h |  3 ++-
 target/arm/cpu64.c     |  6 +++---
 target/arm/helper.c    |  4 ++--
 target/arm/kvm64.c     |  4 ++++
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a73fed9a0..656a96a8f8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -818,6 +818,8 @@ struct ARMCPU {
         uint64_t id_aa64isar1;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
+        uint64_t id_aa64mmfr0;
+        uint64_t id_aa64mmfr1;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -839,8 +841,6 @@ struct ARMCPU {
     uint64_t id_aa64dfr1;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
-    uint64_t id_aa64mmfr0;
-    uint64_t id_aa64mmfr1;
     uint32_t dbgdidr;
     uint32_t clidr;
     uint64_t mp_affinity; /* MP ID without feature bits */
@@ -1557,6 +1557,28 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
 
+FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
+FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
+FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
+FIELD(ID_AA64MMFR0, SNSMEM, 12, 4)
+FIELD(ID_AA64MMFR0, BIGENDEL0, 16, 4)
+FIELD(ID_AA64MMFR0, TGRAN16, 20, 4)
+FIELD(ID_AA64MMFR0, TGRAN64, 24, 4)
+FIELD(ID_AA64MMFR0, TGRAN4, 28, 4)
+FIELD(ID_AA64MMFR0, TGRAN16_2, 32, 4)
+FIELD(ID_AA64MMFR0, TGRAN64_2, 36, 4)
+FIELD(ID_AA64MMFR0, TGRAN4_2, 40, 4)
+FIELD(ID_AA64MMFR0, EXS, 44, 4)
+
+FIELD(ID_AA64MMFR1, HAFDBS, 0, 4)
+FIELD(ID_AA64MMFR1, VMIDBITS, 4, 4)
+FIELD(ID_AA64MMFR1, VH, 8, 4)
+FIELD(ID_AA64MMFR1, HPDS, 12, 4)
+FIELD(ID_AA64MMFR1, LO, 16, 4)
+FIELD(ID_AA64MMFR1, PAN, 20, 4)
+FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
+FIELD(ID_AA64MMFR1, XNX, 28, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/internals.h b/target/arm/internals.h
index d208b70a64..78e026d6e9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -229,7 +229,8 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
         [4] = 44,
         [5] = 48,
     };
-    unsigned int parange = extract32(cpu->id_aa64mmfr0, 0, 4);
+    unsigned int parange =
+        FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
 
     /* id_aa64mmfr0 is a read-only register so values outside of the
      * supported mappings can be considered an implementation error.  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 873f059bf2..0babe483ac 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -141,7 +141,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->id_aa64mmfr0 = 0x00001124;
+    cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
@@ -195,7 +195,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
+    cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
@@ -249,7 +249,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->id_aa64mmfr0 = 0x00001124;
+    cpu->isar.id_aa64mmfr0 = 0x00001124;
     cpu->dbgdidr = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0da1424f72..04c4a91b04 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5207,11 +5207,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64mmfr0 },
+              .resetvalue = cpu->isar.id_aa64mmfr0 },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64mmfr1 },
+              .resetvalue = cpu->isar.id_aa64mmfr1 },
             { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0a502091e7..ad83e1479c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -538,6 +538,10 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
+        err |= read_sys_reg64(fdarray[2], &achf->isar.id_aa64mmfr0,
+                              ARM64_SYS_REG(3, 0, 0, 7, 0));
+        err |= read_sys_reg64(fdarray[2], &achf->isar.id_aa64mmfr1,
+                              ARM64_SYS_REG(3, 0, 0, 7, 1));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.17.2
