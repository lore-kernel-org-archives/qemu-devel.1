Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaZ-0000BO-77
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNaY-00080c-CG
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:39 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Feb 2017 20:02:21 +0000
Message-Id: <1486065742-28639-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] armv7m: Simpler and faster exception start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

From: Michael Davidsaver <mdavidsaver@gmail.com>

All the places in armv7m_cpu_do_interrupt() which pend an
exception in the NVIC are doing so for synchronous
exceptions. We know that we will always take some
exception in this case, so we can just acknowledge it
immediately, rather than returning and then immediately
being called again because the NVIC has raised its outbound
IRQ line.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: tweaked commit message; added DEBUG to the set of
exceptions we handle immediately, since it is synchronous
when it results from the BKPT instruction]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 78bf9ab..8bdd99c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6071,22 +6071,22 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         env->v7m.cfsr |= R_V7M_CFSR_UNDEFINSTR_MASK;
-        return;
+        break;
     case EXCP_NOCP:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         env->v7m.cfsr |= R_V7M_CFSR_NOCP_MASK;
-        return;
+        break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC);
-        return;
+        break;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
         /* TODO: if we implemented the MPU registers, this is where we
          * should set the MMFAR, etc from exception.fsr and exception.vaddress.
          */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
-        return;
+        break;
     case EXCP_BKPT:
         if (semihosting_enabled()) {
             int nr;
@@ -6101,9 +6101,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             }
         }
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
-        return;
+        break;
     case EXCP_IRQ:
-        armv7m_nvic_acknowledge_irq(env->nvic);
         break;
     case EXCP_EXCEPTION_EXIT:
         do_v7m_exception_exit(env);
@@ -6113,6 +6112,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         return; /* Never happens.  Keep compiler happy.  */
     }
 
+    armv7m_nvic_acknowledge_irq(env->nvic);
+
+    qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
+
     /* Align stack pointer if the guest wants that */
     if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
         env->regs[13] -= 4;
-- 
2.7.4
