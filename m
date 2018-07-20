Received: from eggs.gnu.org ([2001:4830:134:3::10]:48677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq4-0000TW-M8
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq3-00061O-Lk
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:57:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 15:56:47 +0100
Message-Id: <20180720145647.8810-5-peter.maydell@linaro.org>
In-Reply-To: <20180720145647.8810-1-peter.maydell@linaro.org>
References: <20180720145647.8810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Implement tailchaining for M
 profile cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Tailchaining is an optimization in handling of exception return
for M-profile cores: if we are about to pop the exception stack
for an exception return, but there is a pending exception which
is higher priority than the priority we are returning to, then
instead of unstacking and then immediately taking the exception
and stacking registers again, we can chain to the pending
exception without unstacking and stacking.

For v6M and v7M it is IMPDEF whether tailchaining happens for pending
exceptions; for v8M this is architecturally required.  Implement it
in QEMU for all M-profile cores, since in practice v6M and v7M
hardware implementations generally do have it.

(We were already doing tailchaining for derived exceptions which
happened during exception return, like the validity checks and
stack access failures; these have always been required to be
tailchained for all versions of the architecture.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff947416c9d..c9e9f95051c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7162,6 +7162,22 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
 
+    /*
+     * Tailchaining: if there is currently a pending exception that
+     * is high enough priority to preempt execution at the level we're
+     * about to return to, then just directly take that exception now,
+     * avoiding an unstack-and-then-stack. Note that now we have
+     * deactivated the previous exception by calling armv7m_nvic_complete_irq()
+     * our current execution priority is already the execution priority we are
+     * returning to -- none of the state we would unstack or set based on
+     * the EXCRET value affects it.
+     */
+    if (armv7m_nvic_can_take_pending_exception(env->nvic)) {
+        qemu_log_mask(CPU_LOG_INT, "...tailchaining to pending exception\n");
+        v7m_exception_taken(cpu, excret, true, false);
+        return;
+    }
+
     switch_v7m_security_state(env, return_to_secure);
 
     {
-- 
2.17.1
