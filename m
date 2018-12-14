Received: from eggs.gnu.org ([2001:4830:134:3::10]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mW-4H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxo-0005Tr-4c
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxk-0005SN-Ft
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so4342304otk.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:02 -0600
Message-Id: <20181214052410.11863-20-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 19/27] target/arm: Export aa64_va_parameters
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 17 +++++++++++++++++
 target/arm/helper.c    |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9ef9d01ee2..4fbef58126 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -951,4 +951,21 @@ typedef struct ARMVAParameters {
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
index bd1b683766..b9ffc07fbc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9702,8 +9702,8 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
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
