Received: from eggs.gnu.org ([209.51.188.92]:52840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvC-0000LZ-Fa
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvB-0004ue-OU
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:30 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvB-0004ts-Iv
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:29 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so2559686plp.9
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:18 +1000
Message-Id: <20190108223129.5570-21-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 20/31] target/arm: Export aa64_va_parameters
 to internals.h
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

We need to reuse this from helper-a64.c.  Provide a stub
definition for CONFIG_USER_ONLY.  This matches the stub
definitions that we removed for arm_regime_tbi{0,1} before.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 17 +++++++++++++++++
 target/arm/helper.c    |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fdda2c866a..82cf685695 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -956,4 +956,21 @@ typedef struct ARMVAParameters {
     bool using64k   : 1;
 } ARMVAParameters;
 
+#ifdef CONFIG_USER_ONLY
+static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
+                                                 uint64_t va,
+                                                 ARMMMUIdx mmu_idx, bool data)
+{
+    return (ARMVAParameters) {
+        /* 48-bit address space */
+        .tsz = 16,
+        /* We can't handle tagged addresses properly in user-only mode */
+        .tbi = false,
+    };
+}
+#else
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data);
+#endif
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f934c80c28..f4538c9f82 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9744,8 +9744,8 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
 
-static ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                          ARMMMUIdx mmu_idx, bool data)
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-- 
2.17.2
