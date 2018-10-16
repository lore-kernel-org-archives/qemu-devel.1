Received: from eggs.gnu.org ([2001:4830:134:3::10]:53707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsG-0001ag-Ml
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsA-0005Uw-9n
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXs8-0005Eq-1h
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:28 -0400
Received: by mail-pf1-x441.google.com with SMTP id r64-v6so12134898pfb.13
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:10 -0700
Message-Id: <20181016223115.24100-4-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 3/8] target/arm: Convert v8 extensions from
 feature bits to isar tests
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

Most of the v8 extensions are self-contained within the ISAR
registers and are not implied by other feature bits, which
makes them the easiest to convert.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 131 +++++++++++++++++++++++++++++++++----
 target/arm/translate.h     |   7 ++
 linux-user/elfload.c       |  46 ++++++++-----
 target/arm/cpu.c           |  27 +++++---
 target/arm/cpu64.c         |  57 +++++++++-------
 target/arm/translate-a64.c | 101 ++++++++++++++--------------
 target/arm/translate.c     |  36 +++++-----
 7 files changed, 273 insertions(+), 132 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cff739b74d..a87edbe869 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -669,6 +669,8 @@ typedef enum ARMPSCIState {
     PSCI_ON_PENDING = 2
 } ARMPSCIState;
 
+typedef struct ARMISARegisters ARMISARegisters;
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -1577,30 +1579,18 @@ enum arm_features {
     ARM_FEATURE_LPAE, /* has Large Physical Address Extension */
     ARM_FEATURE_V8,
     ARM_FEATURE_AARCH64, /* supports 64 bit mode */
-    ARM_FEATURE_V8_AES, /* implements AES part of v8 Crypto Extensions */
     ARM_FEATURE_CBAR, /* has cp15 CBAR */
     ARM_FEATURE_CRC, /* ARMv8 CRC instructions */
     ARM_FEATURE_CBAR_RO, /* has cp15 CBAR and it is read-only */
     ARM_FEATURE_EL2, /* has EL2 Virtualization support */
     ARM_FEATURE_EL3, /* has EL3 Secure monitor support */
-    ARM_FEATURE_V8_SHA1, /* implements SHA1 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_SHA256, /* implements SHA256 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_PMULL, /* implements PMULL part of v8 Crypto Extensions */
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
-    ARM_FEATURE_V8_SHA512, /* implements SHA512 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_ATOMICS, /* ARMv8.1-Atomics feature */
-    ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
-    ARM_FEATURE_V8_DOTPROD, /* implements v8.2 simd dot product */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
-    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 };
 
@@ -3152,4 +3142,121 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 /* Shared between translate-sve.c and sve_helper.c.  */
 extern const uint64_t pred_esz_masks[4];
 
+/*
+ * 32-bit feature tests via id registers.
+ */
+static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
+}
+
+static inline bool isar_feature_aa32_pmull(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) > 1;
+}
+
+static inline bool isar_feature_aa32_sha1(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA1) != 0;
+}
+
+static inline bool isar_feature_aa32_sha2(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA2) != 0;
+}
+
+static inline bool isar_feature_aa32_crc32(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, CRC32) != 0;
+}
+
+static inline bool isar_feature_aa32_rdm(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, RDM) != 0;
+}
+
+static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
+}
+
+static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
+}
+
+/*
+ * 64-bit feature tests via id registers.
+ */
+static inline bool isar_feature_aa64_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) != 0;
+}
+
+static inline bool isar_feature_aa64_pmull(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) > 1;
+}
+
+static inline bool isar_feature_aa64_sha1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA1) != 0;
+}
+
+static inline bool isar_feature_aa64_sha256(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) != 0;
+}
+
+static inline bool isar_feature_aa64_sha512(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) > 1;
+}
+
+static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, CRC32) != 0;
+}
+
+static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
+}
+
+static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
+}
+
+static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA3) != 0;
+}
+
+static inline bool isar_feature_aa64_sm3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM3) != 0;
+}
+
+static inline bool isar_feature_aa64_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM4) != 0;
+}
+
+static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
+}
+
+static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
+}
+
+/*
+ * Forward to the above feature tests given an ARMCPU pointer.
+ */
+#define cpu_isar_feature(name, cpu) \
+    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
+
 #endif
diff --git a/target/arm/translate.h b/target/arm/translate.h
index c1b65f3efb..5bc15819c3 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -7,6 +7,7 @@
 /* internal defines */
 typedef struct DisasContext {
     DisasContextBase base;
+    const ARMISARegisters *isar;
 
     target_ulong pc;
     target_ulong page_start;
@@ -190,4 +191,10 @@ static inline TCGv_i32 get_ahp_flag(void)
     return ret;
 }
 
+/*
+ * Forward to the isar_feature_* tests given a DisasContext pointer.
+ */
+#define dc_isar_feature(name, ctx) \
+    ({ DisasContext *ctx_ = (ctx); isar_feature_##name(ctx_->isar); })
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 10bca65b99..97014959ff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -458,6 +458,10 @@ static uint32_t get_elf_hwcap(void)
     /* probe for the extra features */
 #define GET_FEATURE(feat, hwcap) \
     do { if (arm_feature(&cpu->env, feat)) { hwcaps |= hwcap; } } while (0)
+
+#define GET_FEATURE_ID(feat, hwcap) \
+    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
+
     /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
     GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
@@ -485,15 +489,16 @@ static uint32_t get_elf_hwcap2(void)
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
 
-    GET_FEATURE(ARM_FEATURE_V8_AES, ARM_HWCAP2_ARM_AES);
-    GET_FEATURE(ARM_FEATURE_V8_PMULL, ARM_HWCAP2_ARM_PMULL);
-    GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP2_ARM_SHA1);
-    GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP2_ARM_SHA2);
-    GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP2_ARM_CRC32);
+    GET_FEATURE_ID(aa32_aes, ARM_HWCAP2_ARM_AES);
+    GET_FEATURE_ID(aa32_pmull, ARM_HWCAP2_ARM_PMULL);
+    GET_FEATURE_ID(aa32_sha1, ARM_HWCAP2_ARM_SHA1);
+    GET_FEATURE_ID(aa32_sha2, ARM_HWCAP2_ARM_SHA2);
+    GET_FEATURE_ID(aa32_crc32, ARM_HWCAP2_ARM_CRC32);
     return hwcaps;
 }
 
 #undef GET_FEATURE
+#undef GET_FEATURE_ID
 
 #else
 /* 64 bit ARM definitions */
@@ -570,23 +575,28 @@ static uint32_t get_elf_hwcap(void)
     /* probe for the extra features */
 #define GET_FEATURE(feat, hwcap) \
     do { if (arm_feature(&cpu->env, feat)) { hwcaps |= hwcap; } } while (0)
-    GET_FEATURE(ARM_FEATURE_V8_AES, ARM_HWCAP_A64_AES);
-    GET_FEATURE(ARM_FEATURE_V8_PMULL, ARM_HWCAP_A64_PMULL);
-    GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP_A64_SHA1);
-    GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
-    GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
-    GET_FEATURE(ARM_FEATURE_V8_SHA3, ARM_HWCAP_A64_SHA3);
-    GET_FEATURE(ARM_FEATURE_V8_SM3, ARM_HWCAP_A64_SM3);
-    GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
-    GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
+#define GET_FEATURE_ID(feat, hwcap) \
+    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
+
+    GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
+    GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
+    GET_FEATURE_ID(aa64_sha1, ARM_HWCAP_A64_SHA1);
+    GET_FEATURE_ID(aa64_sha256, ARM_HWCAP_A64_SHA2);
+    GET_FEATURE_ID(aa64_sha512, ARM_HWCAP_A64_SHA512);
+    GET_FEATURE_ID(aa64_crc32, ARM_HWCAP_A64_CRC32);
+    GET_FEATURE_ID(aa64_sha3, ARM_HWCAP_A64_SHA3);
+    GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
+    GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE(ARM_FEATURE_V8_FP16,
                 ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
-    GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
-    GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
-    GET_FEATURE(ARM_FEATURE_V8_DOTPROD, ARM_HWCAP_A64_ASIMDDP);
-    GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
+    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
+    GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
+
 #undef GET_FEATURE
+#undef GET_FEATURE_ID
 
     return hwcaps;
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 12e6273d60..6f27c33b55 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1834,17 +1834,26 @@ static void arm_max_initfn(Object *obj)
         cortex_a15_initfn(obj);
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
-         * since we don't correctly set the ID registers to advertise them,
+         * since we don't correctly set (all of) the ID registers to
+         * advertise them.
          */
         set_feature(&cpu->env, ARM_FEATURE_V8);
-        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-        set_feature(&cpu->env, ARM_FEATURE_CRC);
-        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
-        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+        {
+            uint32_t t;
+
+            t = cpu->isar.id_isar5;
+            t = FIELD_DP32(t, ID_ISAR5, AES, 2);
+            t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
+            t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
+            t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
+            t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
+            t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
+            cpu->isar.id_isar5 = t;
+
+            t = cpu->isar.id_isar6;
+            t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+            cpu->isar.id_isar6 = t;
+        }
 #endif
     }
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 79e551b618..eb5aba4870 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -109,11 +109,6 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-    set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
@@ -170,11 +165,6 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-    set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
@@ -229,11 +219,6 @@ static void aarch64_a72_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
-    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-    set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
@@ -312,7 +297,41 @@ static void aarch64_max_initfn(Object *obj)
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
+        uint64_t t;
+        uint32_t u;
         aarch64_a57_initfn(obj);
+
+        t = cpu->isar.id_aa64isar0;
+        t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
+        t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2); /* SHA512 */
+        t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);
+        t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
+        cpu->isar.id_aa64isar0 = t;
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
+        cpu->isar.id_aa64isar1 = t;
+
+        /* Replicate the same data to the 32-bit id registers.  */
+        u = cpu->isar.id_isar5;
+        u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
+        u = FIELD_DP32(u, ID_ISAR5, SHA1, 1);
+        u = FIELD_DP32(u, ID_ISAR5, SHA2, 1);
+        u = FIELD_DP32(u, ID_ISAR5, CRC32, 1);
+        u = FIELD_DP32(u, ID_ISAR5, RDM, 1);
+        u = FIELD_DP32(u, ID_ISAR5, VCMA, 1);
+        cpu->isar.id_isar5 = u;
+
+        u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, DP, 1);
+        cpu->isar.id_isar6 = u;
+
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
          * since we don't correctly set the ID registers to advertise them,
@@ -320,15 +339,7 @@ static void aarch64_max_initfn(Object *obj)
          * whereas the architecture requires them to be present in both if
          * present in either.
          */
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
-        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
-        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
-        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
         set_feature(&cpu->env, ARM_FEATURE_SVE);
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8a24278d79..5979ba4778 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2322,7 +2322,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         }
         if (rt2 == 31
             && ((rt | rs) & 1) == 0
-            && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+            && dc_isar_feature(aa64_atomics, s)) {
             /* CASP / CASPL */
             gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
             return;
@@ -2344,7 +2344,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         }
         if (rt2 == 31
             && ((rt | rs) & 1) == 0
-            && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+            && dc_isar_feature(aa64_atomics, s)) {
             /* CASPA / CASPAL */
             gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
             return;
@@ -2355,7 +2355,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     case 0xb: /* CASL */
     case 0xe: /* CASA */
     case 0xf: /* CASAL */
-        if (rt2 == 31 && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+        if (rt2 == 31 && dc_isar_feature(aa64_atomics, s)) {
             gen_compare_and_swap(s, rs, rt, rn, size);
             return;
         }
@@ -2894,11 +2894,10 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     int rs = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int o3_opc = extract32(insn, 12, 4);
-    int feature = ARM_FEATURE_V8_ATOMICS;
     TCGv_i64 tcg_rn, tcg_rs;
     AtomicThreeOpFn *fn;
 
-    if (is_vector) {
+    if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
         return;
     }
@@ -2934,10 +2933,6 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
         unallocated_encoding(s);
         return;
     }
-    if (!arm_dc_feature(s, feature)) {
-        unallocated_encoding(s);
-        return;
-    }
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
@@ -4568,7 +4563,7 @@ static void handle_crc32(DisasContext *s,
     TCGv_i64 tcg_acc, tcg_val;
     TCGv_i32 tcg_bytes;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_CRC)
+    if (!dc_isar_feature(aa64_crc32, s)
         || (sf == 1 && sz != 3)
         || (sf == 0 && sz == 3)) {
         unallocated_encoding(s);
@@ -8612,7 +8607,7 @@ static void disas_simd_scalar_three_reg_same_extra(DisasContext *s,
     bool u = extract32(insn, 29, 1);
     TCGv_i32 ele1, ele2, ele3;
     TCGv_i64 res;
-    int feature;
+    bool feature;
 
     switch (u * 16 + opcode) {
     case 0x10: /* SQRDMLAH (vector) */
@@ -8621,13 +8616,13 @@ static void disas_simd_scalar_three_reg_same_extra(DisasContext *s,
             unallocated_encoding(s);
             return;
         }
-        feature = ARM_FEATURE_V8_RDM;
+        feature = dc_isar_feature(aa64_rdm, s);
         break;
     default:
         unallocated_encoding(s);
         return;
     }
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -10356,7 +10351,7 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
             return;
         }
         if (size == 3) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V8_PMULL)) {
+            if (!dc_isar_feature(aa64_pmull, s)) {
                 unallocated_encoding(s);
                 return;
             }
@@ -11408,7 +11403,8 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    int feature, rot;
+    bool feature;
+    int rot;
 
     switch (u * 16 + opcode) {
     case 0x10: /* SQRDMLAH (vector) */
@@ -11417,7 +11413,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        feature = ARM_FEATURE_V8_RDM;
+        feature = dc_isar_feature(aa64_rdm, s);
         break;
     case 0x02: /* SDOT (vector) */
     case 0x12: /* UDOT (vector) */
@@ -11425,7 +11421,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        feature = ARM_FEATURE_V8_DOTPROD;
+        feature = dc_isar_feature(aa64_dp, s);
         break;
     case 0x18: /* FCMLA, #0 */
     case 0x19: /* FCMLA, #90 */
@@ -11439,13 +11435,13 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        feature = ARM_FEATURE_V8_FCMA;
+        feature = dc_isar_feature(aa64_fcma, s);
         break;
     default:
         unallocated_encoding(s);
         return;
     }
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -12659,14 +12655,14 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_RDM)) {
+        if (!dc_isar_feature(aa64_rdm, s)) {
             unallocated_encoding(s);
             return;
         }
         break;
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
-        if (size != MO_32 || !arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+        if (size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -12675,7 +12671,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
     case 0x17: /* FCMLA #270 */
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
+        if (!dc_isar_feature(aa64_fcma, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -13202,8 +13198,7 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     TCGv_i32 tcg_decrypt;
     CryptoThreeOpIntFn *genfn;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
-        || size != 0) {
+    if (!dc_isar_feature(aa64_aes, s) || size != 0) {
         unallocated_encoding(s);
         return;
     }
@@ -13260,7 +13255,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
     CryptoThreeOpFn *genfn;
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
-    int feature = ARM_FEATURE_V8_SHA256;
+    bool feature;
 
     if (size != 0) {
         unallocated_encoding(s);
@@ -13273,23 +13268,26 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     case 2: /* SHA1M */
     case 3: /* SHA1SU0 */
         genfn = NULL;
-        feature = ARM_FEATURE_V8_SHA1;
+        feature = dc_isar_feature(aa64_sha1, s);
         break;
     case 4: /* SHA256H */
         genfn = gen_helper_crypto_sha256h;
+        feature = dc_isar_feature(aa64_sha256, s);
         break;
     case 5: /* SHA256H2 */
         genfn = gen_helper_crypto_sha256h2;
+        feature = dc_isar_feature(aa64_sha256, s);
         break;
     case 6: /* SHA256SU1 */
         genfn = gen_helper_crypto_sha256su1;
+        feature = dc_isar_feature(aa64_sha256, s);
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -13330,7 +13328,7 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     CryptoTwoOpFn *genfn;
-    int feature;
+    bool feature;
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
 
     if (size != 0) {
@@ -13340,15 +13338,15 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0: /* SHA1H */
-        feature = ARM_FEATURE_V8_SHA1;
+        feature = dc_isar_feature(aa64_sha1, s);
         genfn = gen_helper_crypto_sha1h;
         break;
     case 1: /* SHA1SU1 */
-        feature = ARM_FEATURE_V8_SHA1;
+        feature = dc_isar_feature(aa64_sha1, s);
         genfn = gen_helper_crypto_sha1su1;
         break;
     case 2: /* SHA256SU0 */
-        feature = ARM_FEATURE_V8_SHA256;
+        feature = dc_isar_feature(aa64_sha256, s);
         genfn = gen_helper_crypto_sha256su0;
         break;
     default:
@@ -13356,7 +13354,7 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -13387,40 +13385,40 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    int feature;
+    bool feature;
     CryptoThreeOpFn *genfn;
 
     if (o == 0) {
         switch (opcode) {
         case 0: /* SHA512H */
-            feature = ARM_FEATURE_V8_SHA512;
+            feature = dc_isar_feature(aa64_sha512, s);
             genfn = gen_helper_crypto_sha512h;
             break;
         case 1: /* SHA512H2 */
-            feature = ARM_FEATURE_V8_SHA512;
+            feature = dc_isar_feature(aa64_sha512, s);
             genfn = gen_helper_crypto_sha512h2;
             break;
         case 2: /* SHA512SU1 */
-            feature = ARM_FEATURE_V8_SHA512;
+            feature = dc_isar_feature(aa64_sha512, s);
             genfn = gen_helper_crypto_sha512su1;
             break;
         case 3: /* RAX1 */
-            feature = ARM_FEATURE_V8_SHA3;
+            feature = dc_isar_feature(aa64_sha3, s);
             genfn = NULL;
             break;
         }
     } else {
         switch (opcode) {
         case 0: /* SM3PARTW1 */
-            feature = ARM_FEATURE_V8_SM3;
+            feature = dc_isar_feature(aa64_sm3, s);
             genfn = gen_helper_crypto_sm3partw1;
             break;
         case 1: /* SM3PARTW2 */
-            feature = ARM_FEATURE_V8_SM3;
+            feature = dc_isar_feature(aa64_sm3, s);
             genfn = gen_helper_crypto_sm3partw2;
             break;
         case 2: /* SM4EKEY */
-            feature = ARM_FEATURE_V8_SM4;
+            feature = dc_isar_feature(aa64_sm4, s);
             genfn = gen_helper_crypto_sm4ekey;
             break;
         default:
@@ -13429,7 +13427,7 @@ static void disas_crypto_three_reg_sha512(DisasContext *s, uint32_t insn)
         }
     }
 
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -13488,16 +13486,16 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr;
-    int feature;
+    bool feature;
     CryptoTwoOpFn *genfn;
 
     switch (opcode) {
     case 0: /* SHA512SU0 */
-        feature = ARM_FEATURE_V8_SHA512;
+        feature = dc_isar_feature(aa64_sha512, s);
         genfn = gen_helper_crypto_sha512su0;
         break;
     case 1: /* SM4E */
-        feature = ARM_FEATURE_V8_SM4;
+        feature = dc_isar_feature(aa64_sm4, s);
         genfn = gen_helper_crypto_sm4e;
         break;
     default:
@@ -13505,7 +13503,7 @@ static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
         return;
     }
 
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -13536,22 +13534,22 @@ static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
     int ra = extract32(insn, 10, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    int feature;
+    bool feature;
 
     switch (op0) {
     case 0: /* EOR3 */
     case 1: /* BCAX */
-        feature = ARM_FEATURE_V8_SHA3;
+        feature = dc_isar_feature(aa64_sha3, s);
         break;
     case 2: /* SM3SS1 */
-        feature = ARM_FEATURE_V8_SM3;
+        feature = dc_isar_feature(aa64_sm3, s);
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
-    if (!arm_dc_feature(s, feature)) {
+    if (!feature) {
         unallocated_encoding(s);
         return;
     }
@@ -13638,7 +13636,7 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
     int pass;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA3)) {
+    if (!dc_isar_feature(aa64_sha3, s)) {
         unallocated_encoding(s);
         return;
     }
@@ -13684,7 +13682,7 @@ static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
     TCGv_i32 tcg_imm2, tcg_opcode;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_SM3)) {
+    if (!dc_isar_feature(aa64_sm3, s)) {
         unallocated_encoding(s);
         return;
     }
@@ -13833,6 +13831,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     ARMCPU *arm_cpu = arm_env_get_cpu(env);
     int bound;
 
+    dc->isar = &arm_cpu->isar;
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1b4bacb522..f621595197 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5689,7 +5689,7 @@ static const uint8_t neon_2rm_sizes[] = {
 static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                          int q, int rd, int rn, int rm)
 {
-    if (arm_dc_feature(s, ARM_FEATURE_V8_RDM)) {
+    if (dc_isar_feature(aa32_rdm, s)) {
         int opr_sz = (1 + q) * 8;
         tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
                            vfp_reg_offset(1, rn),
@@ -5763,7 +5763,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1;
             }
             if (!u) { /* SHA-1 */
-                if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
+                if (!dc_isar_feature(aa32_sha1, s)) {
                     return 1;
                 }
                 ptr1 = vfp_reg_ptr(true, rd);
@@ -5773,7 +5773,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
                 tcg_temp_free_i32(tmp4);
             } else { /* SHA-256 */
-                if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA256) || size == 3) {
+                if (!dc_isar_feature(aa32_sha2, s) || size == 3) {
                     return 1;
                 }
                 ptr1 = vfp_reg_ptr(true, rd);
@@ -6768,7 +6768,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 if (op == 14 && size == 2) {
                     TCGv_i64 tcg_rn, tcg_rm, tcg_rd;
 
-                    if (!arm_dc_feature(s, ARM_FEATURE_V8_PMULL)) {
+                    if (!dc_isar_feature(aa32_pmull, s)) {
                         return 1;
                     }
                     tcg_rn = tcg_temp_new_i64();
@@ -7085,7 +7085,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {
                         NeonGenThreeOpEnvFn *fn;
 
-                        if (!arm_dc_feature(s, ARM_FEATURE_V8_RDM)) {
+                        if (!dc_isar_feature(aa32_rdm, s)) {
                             return 1;
                         }
                         if (u && ((rd | rn) & 1)) {
@@ -7359,8 +7359,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     break;
                 }
                 case NEON_2RM_AESE: case NEON_2RM_AESMC:
-                    if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
-                        || ((rm | rd) & 1)) {
+                    if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
                     ptr1 = vfp_reg_ptr(true, rd);
@@ -7381,8 +7380,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tmp3);
                     break;
                 case NEON_2RM_SHA1H:
-                    if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)
-                        || ((rm | rd) & 1)) {
+                    if (!dc_isar_feature(aa32_sha1, s) || ((rm | rd) & 1)) {
                         return 1;
                     }
                     ptr1 = vfp_reg_ptr(true, rd);
@@ -7399,10 +7397,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     /* bit 6 (q): set -> SHA256SU0, cleared -> SHA1SU1 */
                     if (q) {
-                        if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA256)) {
+                        if (!dc_isar_feature(aa32_sha2, s)) {
                             return 1;
                         }
-                    } else if (!arm_dc_feature(s, ARM_FEATURE_V8_SHA1)) {
+                    } else if (!dc_isar_feature(aa32_sha1, s)) {
                         return 1;
                     }
                     ptr1 = vfp_reg_ptr(true, rd);
@@ -7813,7 +7811,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
         /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 23, 2); /* rot */
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
+        if (!dc_isar_feature(aa32_vcma, s)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
         }
@@ -7822,7 +7820,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
         /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 24, 1); /* rot */
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
+        if (!dc_isar_feature(aa32_vcma, s)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
         }
@@ -7830,7 +7828,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     } else if ((insn & 0xfeb00f00) == 0xfc200d00) {
         /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
         bool u = extract32(insn, 4, 1);
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+        if (!dc_isar_feature(aa32_dp, s)) {
             return 1;
         }
         fn_gvec = u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
@@ -7892,7 +7890,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         int size = extract32(insn, 23, 1);
         int index;
 
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
+        if (!dc_isar_feature(aa32_vcma, s)) {
             return 1;
         }
         if (size == 0) {
@@ -7913,7 +7911,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     } else if ((insn & 0xffb00f00) == 0xfe200d00) {
         /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
         int u = extract32(insn, 4, 1);
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+        if (!dc_isar_feature(aa32_dp, s)) {
             return 1;
         }
         fn_gvec = u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
@@ -8889,8 +8887,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
              * op1 == 3 is UNPREDICTABLE but handle as UNDEFINED.
              * Bits 8, 10 and 11 should be zero.
              */
-            if (!arm_dc_feature(s, ARM_FEATURE_CRC) || op1 == 0x3 ||
-                (c & 0xd) != 0) {
+            if (!dc_isar_feature(aa32_crc32, s) || op1 == 0x3 || (c & 0xd) != 0) {
                 goto illegal_op;
             }
 
@@ -10785,7 +10782,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x28:
                 case 0x29:
                 case 0x2a:
-                    if (!arm_dc_feature(s, ARM_FEATURE_CRC)) {
+                    if (!dc_isar_feature(aa32_crc32, s)) {
                         goto illegal_op;
                     }
                     break;
@@ -12586,6 +12583,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     CPUARMState *env = cs->env_ptr;
     ARMCPU *cpu = arm_env_get_cpu(env);
 
+    dc->isar = &cpu->isar;
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
 
-- 
2.17.2
