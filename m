Received: from eggs.gnu.org ([2001:4830:134:3::10]:59264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVJ-0008HH-Ak
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVH-0007tA-MT
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:05 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVH-0007t2-Gl
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:03 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so3000547oii.5
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:23 -0600
Message-Id: <20181207103631.28193-19-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/26] target/arm: Export aa64_va_parameters to
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
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

We need to reuse this from helper-a64.c.  Provide a stub
definition for CONFIG_USER_ONLY.  This matches the stub
definitions that we removed for arm_regime_tbi{0,1} before.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 29 +++++++++++++++++++++++++++++
 target/arm/helper.c    | 16 ++--------------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6bc0daf560..4d25b267e8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -912,4 +912,33 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+typedef struct ARMVAParameters {
+    unsigned tsz    : 8;
+    unsigned select : 1;
+    bool tbi        : 1;
+    bool epd        : 1;
+    bool hpd        : 1;
+    bool ha         : 1;
+    bool hd         : 1;
+    bool using16k   : 1;
+    bool using64k   : 1;
+} ARMVAParameters;
+
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
index 3ad5909b1e..c73525f813 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9712,20 +9712,8 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
     return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
 }
 
-typedef struct ARMVAParameters {
-    unsigned tsz    : 8;
-    unsigned select : 1;
-    bool tbi        : 1;
-    bool epd        : 1;
-    bool hpd        : 1;
-    bool ha         : 1;
-    bool hd         : 1;
-    bool using16k   : 1;
-    bool using64k   : 1;
-} ARMVAParameters;
-
-static ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                          ARMMMUIdx mmu_idx, bool data)
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-- 
2.17.2
