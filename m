Received: from eggs.gnu.org ([2001:4830:134:3::10]:38818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjZ-0005Fl-H2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejNjY-0005js-J1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ejNjY-0005jA-Bq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:17:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id t74so2448365wme.3
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:17:48 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed,  7 Feb 2018 11:17:29 +0000
Message-Id: <20180207111729.15737-6-ard.biesheuvel@linaro.org>
In-Reply-To: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH v6 5/5] target/arm: enable user-mode SHA-3, SM3,
 SM4 and SHA-512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instructions to
AArch64 user mode emulation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 linux-user/elfload.c | 19 +++++++++++++++++++
 target/arm/cpu64.c   |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c373..7922ab8eab79 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -512,6 +512,21 @@ enum {
     ARM_HWCAP_A64_SHA1          = 1 << 5,
     ARM_HWCAP_A64_SHA2          = 1 << 6,
     ARM_HWCAP_A64_CRC32         = 1 << 7,
+    ARM_HWCAP_A64_ATOMICS       = 1 << 8,
+    ARM_HWCAP_A64_FPHP          = 1 << 9,
+    ARM_HWCAP_A64_ASIMDHP       = 1 << 10,
+    ARM_HWCAP_A64_CPUID         = 1 << 11,
+    ARM_HWCAP_A64_ASIMDRDM      = 1 << 12,
+    ARM_HWCAP_A64_JSCVT         = 1 << 13,
+    ARM_HWCAP_A64_FCMA          = 1 << 14,
+    ARM_HWCAP_A64_LRCPC         = 1 << 15,
+    ARM_HWCAP_A64_DCPOP         = 1 << 16,
+    ARM_HWCAP_A64_SHA3          = 1 << 17,
+    ARM_HWCAP_A64_SM3           = 1 << 18,
+    ARM_HWCAP_A64_SM4           = 1 << 19,
+    ARM_HWCAP_A64_ASIMDDP       = 1 << 20,
+    ARM_HWCAP_A64_SHA512        = 1 << 21,
+    ARM_HWCAP_A64_SVE           = 1 << 22,
 };
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -532,6 +547,10 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP_A64_SHA1);
     GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
     GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
+    GET_FEATURE(ARM_FEATURE_V8_SHA3, ARM_HWCAP_A64_SHA3);
+    GET_FEATURE(ARM_FEATURE_V8_SM3, ARM_HWCAP_A64_SM3);
+    GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
+    GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
 #undef GET_FEATURE
 
     return hwcaps;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07ab6ed4..1c330adc281b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -224,6 +224,10 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_AES);
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-- 
2.11.0
