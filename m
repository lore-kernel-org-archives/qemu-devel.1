Received: from eggs.gnu.org ([2001:4830:134:3::10]:44693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKjU2-0008O9-EL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKjTx-0007DC-0f
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:55:38 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 13 Jun 2017 12:55:29 +0200
Message-Id: <1497351329-12936-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc/excp_helper: Take BQL before
 calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Since the introduction of MTTCG, using the msgsnd instruction
abort()s if being called without holding the BQL. So let's protect
that part of the code now with qemu_mutex_lock_iothread().

Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/excp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9cb2123..3a9f086 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
@@ -1132,6 +1133,7 @@ void helper_msgsnd(target_ulong rb)
         return;
     }
 
+    qemu_mutex_lock_iothread();
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *cenv = &cpu->env;
@@ -1141,5 +1143,6 @@ void helper_msgsnd(target_ulong rb)
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         }
     }
+    qemu_mutex_unlock_iothread();
 }
 #endif
-- 
1.8.3.1
