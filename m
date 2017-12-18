Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9V-0005r2-98
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9R-00081J-WA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:33 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9R-000805-Qu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:29 -0500
Received: by mail-pf0-x243.google.com with SMTP id u19so9926586pfa.12
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:15 -0800
Message-Id: <20171218172425.18200-2-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/11] target/arm: Add ARM_FEATURE_V8_1_SIMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Enable it for the "any" CPU used by *-linux-user.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 1 +
 linux-user/elfload.c | 9 +++++++++
 target/arm/cpu.c     | 1 +
 target/arm/cpu64.c   | 1 +
 4 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 715ec6a476..e047756b80 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1351,6 +1351,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
+    ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
 };
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..95f550518e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -512,6 +512,14 @@ enum {
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
 };
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -532,6 +540,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SHA1, ARM_HWCAP_A64_SHA1);
     GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
     GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
+    GET_FEATURE(ARM_FEATURE_V8_1_SIMD, ARM_HWCAP_A64_ASIMDRDM);
 #undef GET_FEATURE
 
     return hwcaps;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7f7a3d1e32..afe84645af 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1628,6 +1628,7 @@ static void arm_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
     cpu->midr = 0xffffffff;
 }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0dc4debd9c..67a01bf7ce 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -226,6 +226,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
     set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
-- 
2.14.3
