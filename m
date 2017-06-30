Received: from eggs.gnu.org ([2001:4830:134:3::10]:34399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRk-0008T8-RS
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0007un-94
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:19 +1000
Message-Id: <20170630104632.27942-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/21] target/ppc/excp_helper: Take BQL before
 calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

Since the introduction of MTTCG, using the msgsnd instruction
abort()s if being called without holding the BQL. So let's protect
that part of the code now with qemu_mutex_lock_iothread().

Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9cb2123..3a9f086 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
@@ -1132,6 +1133,7 @@ void helper_msgsnd(target_ulong rb)
         return;
     }
=20
+    qemu_mutex_lock_iothread();
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
         CPUPPCState *cenv =3D &cpu->env;
@@ -1141,5 +1143,6 @@ void helper_msgsnd(target_ulong rb)
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         }
     }
+    qemu_mutex_unlock_iothread();
 }
 #endif
--=20
2.9.4
