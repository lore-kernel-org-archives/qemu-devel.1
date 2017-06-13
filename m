Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKjQ2-0007XH-6A
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKjPx-0005ut-7w
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:51:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKjPx-0005uj-23
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:51:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKjPu-0002Q0-KZ
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:51:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 971862E819A
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:51:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 10:37:24 -0000
From: Thomas Huth <1694998@bugs.launchpad.net>
Reply-To: Bug 1694998 <1694998@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149632651904.23369.12296046707149421968.malonedeb@wampee.canonical.com>
Message-Id: <149735024413.7917.7058297931800314045.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1694998] Re: PPC: msgsnd instruction leads to
 assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could you please check whether this patch fixes the issue for you:

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
@@ -1132,6 +1133,7 @@ void helper_msgsnd(target_ulong rb)
         return;
     }
 =

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

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1694998

Title:
  PPC: msgsnd instruction leads to assertion

Status in QEMU:
  New

Bug description:
  I tried to send doorbells (using msgsnd) between cores in guest OS. On QE=
MU v2.9.0 usage of msgsnd instruction leads to error:
  ERROR: <...>/qemu-new/translate-common.c:34:tcg_handle_interrupt: asserti=
on failed: (qemu_mutex_iothread_locked())

  =

  QEMU v2.8.0 works fine.

  QEMU run options: qemu-system-ppc -serial stdio -M ppce500 -cpu e500mc
  -smp 2 -m 512M -kernel pok.elf

  pok.elf attached

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1694998/+subscriptions
