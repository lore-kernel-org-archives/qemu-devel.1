Received: from eggs.gnu.org ([2001:4830:134:3::10]:60745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhn-0007AG-8U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhl-0007Nl-A2
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIZhk-0007Ax-5Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id v24-v6so2038679wmh.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 13:41:09 +0000
Message-Id: <20181102134112.26370-2-richard.henderson@linaro.org>
In-Reply-To: <20181102134112.26370-1-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 1/4] target/arm: Move id_aa64mmfr* to
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
Cc: qemu-arm@nongnu.org

At the same time, define the fields for these registers,
and use those defines in arm_pamax().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 22 ++++++++++++++++++++--
 target/arm/internals.h |  3 ++-
 target/arm/cpu64.c     |  6 +++---
 target/arm/helper.c    |  4 ++--
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8e6779936e..2ce5e80dfc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -815,6 +815,8 @@ struct ARMCPU {
         uint64_t id_aa64isar1;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
+        uint64_t id_aa64mmfr0;
+        uint64_t id_aa64mmfr1;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -836,8 +838,6 @@ struct ARMCPU {
     uint64_t id_aa64dfr1;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
-    uint64_t id_aa64mmfr0;
-    uint64_t id_aa64mmfr1;
     uint32_t dbgdidr;
     uint32_t clidr;
     uint64_t mp_affinity; /* MP ID without feature bits */
@@ -1554,6 +1554,24 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
 
+FIELD(ID_AA64MMFR0, PARange, 0, 4)
+FIELD(ID_AA64MMFR0, ASIDBits, 4, 4)
+FIELD(ID_AA64MMFR0, BigEnd, 8, 4)
+FIELD(ID_AA64MMFR0, SNSMem, 12, 4)
+FIELD(ID_AA64MMFR0, BigEndEL0, 16, 4)
+FIELD(ID_AA64MMFR0, TGran16, 20, 4)
+FIELD(ID_AA64MMFR0, TGran64, 24, 4)
+FIELD(ID_AA64MMFR0, TGran4, 28, 4)
+
+FIELD(ID_AA64MMFR1, HAFDBS, 0, 4)
+FIELD(ID_AA64MMFR1, VMIDBits, 4, 4)
+FIELD(ID_AA64MMFR1, VH, 8, 4)
+FIELD(ID_AA64MMFR1, HPDS, 12, 4)
+FIELD(ID_AA64MMFR1, LO, 16, 4)
+FIELD(ID_AA64MMFR1, PAN, 20, 4)
+FIELD(ID_AA64MMFR1, SpecSEI, 24, 4)
+FIELD(ID_AA64MMFR1, XNX, 28, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6c2bb2deeb..bf844abc47 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -213,7 +213,8 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
         [4] = 44,
         [5] = 48,
     };
-    unsigned int parange = extract32(cpu->id_aa64mmfr0, 0, 4);
+    unsigned int parange =
+        FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARange);
 
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
index 0ea95b0815..70376764cb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5228,11 +5228,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
-- 
2.17.2
