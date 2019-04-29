Received: from eggs.gnu.org ([209.51.188.92]:34188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eV-0004Wh-N8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eS-0006aN-4K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eK-0006RW-GN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p21so186918wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:05 +0100
Message-Id: <20190429170030.11323-18-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/42] target/arm: Allow for floating point in
 callee stack integrity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The magic value pushed onto the callee stack as an integrity
check is different if floating point is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-15-peter.maydell@linaro.org
---
 target/arm/helper.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index da0b6202400..c7b1a8d231d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7979,6 +7979,21 @@ load_fail:
     return false;
 }
 
+static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
+{
+    /*
+     * Return the integrity signature value for the callee-saves
+     * stack frame section. @lr is the exception return payload/LR value
+     * whose FType bit forms bit 0 of the signature if FP is present.
+     */
+    uint32_t sig = 0xfefa125a;
+
+    if (!arm_feature(env, ARM_FEATURE_VFP) || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
+        sig |= 1;
+    }
+    return sig;
+}
+
 static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                                   bool ignore_faults)
 {
@@ -7993,6 +8008,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     bool stacked_ok;
     uint32_t limit;
     bool want_psp;
+    uint32_t sig;
 
     if (dotailchain) {
         bool mode = lr & R_V7M_EXCRET_MODE_MASK;
@@ -8034,8 +8050,9 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     /* Write as much of the stack frame as we can. A write failure may
      * cause us to pend a derived exception.
      */
+    sig = v7m_integrity_sig(env, lr);
     stacked_ok =
-        v7m_stack_write(cpu, frameptr, 0xfefa125b, mmu_idx, ignore_faults) &&
+        v7m_stack_write(cpu, frameptr, sig, mmu_idx, ignore_faults) &&
         v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx,
                         ignore_faults) &&
         v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx,
@@ -8640,12 +8657,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         if (return_to_secure &&
             ((excret & R_V7M_EXCRET_ES_MASK) == 0 ||
              (excret & R_V7M_EXCRET_DCRS_MASK) == 0)) {
-            uint32_t expected_sig = 0xfefa125b;
             uint32_t actual_sig;
 
             pop_ok = v7m_stack_read(cpu, &actual_sig, frameptr, mmu_idx);
 
-            if (pop_ok && expected_sig != actual_sig) {
+            if (pop_ok && v7m_integrity_sig(env, excret) != actual_sig) {
                 /* Take a SecureFault on the current stack */
                 env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-- 
2.20.1
