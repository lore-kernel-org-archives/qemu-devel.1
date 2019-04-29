Received: from eggs.gnu.org ([209.51.188.92]:34428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0004uW-A3
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0006mW-HO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ep-0006Oe-IN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id j13so174106wmh.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.46
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:00 +0100
Message-Id: <20190429170030.11323-13-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/42] target/arm/helper: don't return early for
 STKOF faults during stacking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently the code in v7m_push_stack() which detects a violation
of the v8M stack limit simply returns early if it does so. This
is OK for the current integer-only code, but won't work for the
floating point handling we're about to add. We need to continue
executing the rest of the function so that we check for other
exceptions like not having permission to use the FPU and so
that we correctly set the FPCCR state if we are doing lazy
stacking. Refactor to avoid the early return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-10-peter.maydell@linaro.org
---
 target/arm/helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e801744673f..142d301b651 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8182,7 +8182,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * should ignore further stack faults trying to process
      * that derived exception.)
      */
-    bool stacked_ok;
+    bool stacked_ok = true, limitviol = false;
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
     uint32_t frameptr = env->regs[13];
@@ -8213,7 +8213,14 @@ static bool v7m_push_stack(ARMCPU *cpu)
             armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
                                     env->v7m.secure);
             env->regs[13] = limit;
-            return true;
+            /*
+             * We won't try to perform any further memory accesses but
+             * we must continue through the following code to check for
+             * permission faults during FPU state preservation, and we
+             * must update FPCCR if lazy stacking is enabled.
+             */
+            limitviol = true;
+            stacked_ok = false;
         }
     }
 
@@ -8222,7 +8229,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * (which may be taken in preference to the one we started with
      * if it has higher priority).
      */
-    stacked_ok =
+    stacked_ok = stacked_ok &&
         v7m_stack_write(cpu, frameptr, env->regs[0], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 4, env->regs[1], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 8, env->regs[2], mmu_idx, false) &&
@@ -8232,8 +8239,14 @@ static bool v7m_push_stack(ARMCPU *cpu)
         v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
 
-    /* Update SP regardless of whether any of the stack accesses failed. */
-    env->regs[13] = frameptr;
+    /*
+     * If we broke a stack limit then SP was already updated earlier;
+     * otherwise we update SP regardless of whether any of the stack
+     * accesses failed or we took some other kind of fault.
+     */
+    if (!limitviol) {
+        env->regs[13] = frameptr;
+    }
 
     return !stacked_ok;
 }
-- 
2.20.1
