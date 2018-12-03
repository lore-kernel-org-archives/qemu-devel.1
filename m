Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzb-000689-6E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzX-0005pE-DC
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:59 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:40813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzX-0005nq-7a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:55 -0500
Received: by mail-oi1-x233.google.com with SMTP id t204so12202010oie.7
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:36 -0600
Message-Id: <20181203203839.757-8-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 07/10] target/arm: Tidy scr_write
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

Because EL3 has a fixed execution mode, we can properly decide
which of the bits are RES{0,1}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 --
 target/arm/helper.c | 14 +++++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e871b946c8..a84101efa9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1312,8 +1312,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_FIEN              (1U << 21)
 #define SCR_ENSCXT            (1U << 25)
 #define SCR_ATA               (1U << 26)
-#define SCR_AARCH32_MASK      (0x3fff & ~(SCR_RW | SCR_ST))
-#define SCR_AARCH64_MASK      (0x3fff & ~SCR_NET)
 
 /* Return the current FPSCR value.  */
 uint32_t vfp_get_fpscr(CPUARMState *env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b248dfcd39..faf7f922bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1279,11 +1279,15 @@ static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    /* We only mask off bits that are RES0 both for AArch64 and AArch32.
-     * For bits that vary between AArch32/64, code needs to check the
-     * current execution mode before directly using the feature bit.
-     */
-    uint32_t valid_mask = SCR_AARCH64_MASK | SCR_AARCH32_MASK;
+    /* Begin with base v8.0 state.  */
+    uint32_t valid_mask = 0x3fff;
+
+    if (arm_el_is_aa64(env, 3)) {
+        value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
+        valid_mask &= ~SCR_NET;
+    } else {
+        valid_mask &= ~(SCR_RW | SCR_ST);
+    }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         valid_mask &= ~SCR_HCE;
-- 
2.17.2
