Received: from eggs.gnu.org ([209.51.188.92]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvF-0000P5-9e
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvE-0004xk-He
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:33 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvE-0004x5-By
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:32 -0500
Received: by mail-pg1-x541.google.com with SMTP id y4so2343324pgc.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:19 +1000
Message-Id: <20190108223129.5570-22-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 21/31] target/arm: Add
 aa64_va_parameters_both
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

We will want to check TBI for I and D simultaneously.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 15 ++++++++++++---
 target/arm/helper.c    | 10 ++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 82cf685695..acd99b579c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -957,9 +957,9 @@ typedef struct ARMVAParameters {
 } ARMVAParameters;
 
 #ifdef CONFIG_USER_ONLY
-static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
-                                                 uint64_t va,
-                                                 ARMMMUIdx mmu_idx, bool data)
+static inline ARMVAParameters aa64_va_parameters_both(CPUARMState *env,
+                                                      uint64_t va,
+                                                      ARMMMUIdx mmu_idx)
 {
     return (ARMVAParameters) {
         /* 48-bit address space */
@@ -968,7 +968,16 @@ static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
         .tbi = false,
     };
 }
+
+static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
+                                                 uint64_t va,
+                                                 ARMMMUIdx mmu_idx, bool data)
+{
+    return aa64_va_parameters_both(env, va, mmu_idx);
+}
 #else
+ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
+                                        ARMMMUIdx mmu_idx);
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f4538c9f82..28322ae109 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9744,8 +9744,8 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
 
-ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data)
+ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
+                                        ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
@@ -9799,6 +9799,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     };
 }
 
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
+{
+    return aa64_va_parameters_both(env, va, mmu_idx);
+}
+
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
-- 
2.17.2
