Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9e-00061u-7x
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9b-0008Ep-3M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:42 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9a-0008Dq-VB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:39 -0500
Received: by mail-pl0-x243.google.com with SMTP id b96so5209742pli.2
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:21 -0800
Message-Id: <20171218172425.18200-8-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/11] target/arm: Add ARM_FEATURE_V8_FCMA
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
 linux-user/elfload.c | 1 +
 target/arm/cpu.c     | 1 +
 target/arm/cpu64.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e047756b80..7a705a09a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1353,6 +1353,7 @@ enum arm_features {
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
+    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 95f550518e..e07184902f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -541,6 +541,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SHA256, ARM_HWCAP_A64_SHA2);
     GET_FEATURE(ARM_FEATURE_CRC, ARM_HWCAP_A64_CRC32);
     GET_FEATURE(ARM_FEATURE_V8_1_SIMD, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
 #undef GET_FEATURE
 
     return hwcaps;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index afe84645af..6cd8ae1459 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1629,6 +1629,7 @@ static void arm_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
     cpu->midr = 0xffffffff;
 }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 67a01bf7ce..43b42f95fd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -228,6 +228,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
     set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 }
-- 
2.14.3
