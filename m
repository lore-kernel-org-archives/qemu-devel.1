Received: from eggs.gnu.org ([2001:4830:134:3::10]:47752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEK9D-0001OU-Hy
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cEK9C-00068n-N0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:07:23 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Dec 2016 17:46:17 +0000
Message-Id: <1481046379-32632-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1481046379-32632-1-git-send-email-peter.maydell@linaro.org>
References: <1481046379-32632-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] target-arm: Log AArch64 exception returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

We already log exception entry; add logging of the AArch64 exception
return path as well.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target-arm/op_helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target-arm/op_helper.c b/target-arm/op_helper.c
index cd94216..ba796d8 100644
--- a/target-arm/op_helper.c
+++ b/target-arm/op_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
@@ -972,6 +973,9 @@ void HELPER(exception_return)(CPUARMState *env)
         } else {
             env->regs[15] = env->elr_el[cur_el] & ~0x3;
         }
+        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
+                      "AArch32 EL%d PC 0x%" PRIx32 "\n",
+                      cur_el, new_el, env->regs[15]);
     } else {
         env->aarch64 = 1;
         pstate_write(env, spsr);
@@ -980,6 +984,9 @@ void HELPER(exception_return)(CPUARMState *env)
         }
         aarch64_restore_sp(env, new_el);
         env->pc = env->elr_el[cur_el];
+        qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
+                      "AArch64 EL%d PC 0x%" PRIx64 "\n",
+                      cur_el, new_el, env->pc);
     }
 
     arm_call_el_change_hook(arm_env_get_cpu(env));
@@ -1002,6 +1009,8 @@ illegal_return:
     if (!arm_singlestep_active(env)) {
         env->pstate &= ~PSTATE_SS;
     }
+    qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
+                  "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
 
 /* Return true if the linked breakpoint entry lbn passes its checks */
-- 
2.7.4
