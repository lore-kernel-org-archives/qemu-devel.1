Received: from eggs.gnu.org ([209.51.188.92]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbV-0002mW-In
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0007OI-Cy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Jt-1e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: by mail-wr1-x42c.google.com with SMTP id p4so15417773wrt.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:40 +0000
Message-Id: <20190118145805.6852-25-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/49] target/arm: Export aa64_va_parameters to
 internals.h
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

We need to reuse this from helper-a64.c.  Provide a stub
definition for CONFIG_USER_ONLY.  This matches the stub
definitions that we removed for arm_regime_tbi{0,1} before.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 17 +++++++++++++++++
 target/arm/helper.c    |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fdda2c866a3..82cf6856957 100644
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
index 97a24ed5908..0f197d2dd1b 100644
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
2.20.1
