Received: from eggs.gnu.org ([209.51.188.92]:42983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0002lM-VX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007MX-Jl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Kj-BI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id b11so4784784wmj.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:41 +0000
Message-Id: <20190118145805.6852-26-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/49] target/arm: Add aa64_va_parameters_both
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

We will want to check TBI for I and D simultaneously.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 15 ++++++++++++---
 target/arm/helper.c    | 10 ++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 82cf6856957..acd99b579cd 100644
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
index 0f197d2dd1b..75a6004decd 100644
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
@@ -9800,6 +9800,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
2.20.1
