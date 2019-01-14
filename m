Received: from eggs.gnu.org ([209.51.188.92]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnt-0006GG-Q2
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnr-0001Et-II
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:37 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnr-00019N-8K
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id s198so8751217pgs.2
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:21 +1100
Message-Id: <20190114011122.5995-17-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/17] target/arm: Enable MTE
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

??? It does not yet work for system mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 10 ++++++++++
 target/arm/cpu64.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5eff6995ee..aae30207b9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -180,6 +180,16 @@ static void arm_cpu_reset(CPUState *s)
          * make no difference to the user-level emulation.
          */
         env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
+        /* Enable MTE allocation tags.  */
+        env->cp15.hcr_el2 |= HCR_ATA;
+        env->cp15.scr_el3 |= SCR_ATA;
+        env->cp15.sctlr_el[1] |= SCTLR_ATA0;
+        /* Enable synchronous tag check failures.  */
+        env->cp15.sctlr_el[1] |= 1ull << 38;
+#ifdef TARGET_AARCH64
+        /* Set MTE seed to non-zero value, otherwise RandomTag fails.  */
+        env->cp15.rgsr_el1 = 0x123400;
+#endif
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 64fbe75eca..49fdad69ce 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -374,6 +374,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.17.2
