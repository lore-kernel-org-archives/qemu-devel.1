Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eHEyS-0001Ws-Mw
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 15:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eHEyP-0000yi-J8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 15:16:52 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 21 Nov 2017 21:16:43 +0100
Message-Id: <20171121201643.29638-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc: fix VTB migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Migration of a system under stress (for example, with
"stress-ng --numa 2") triggers on the destination
some kernel watchdog messages like:

NMI watchdog: BUG: soft lockup - CPU#0 stuck for 3489660870s!
NMI watchdog: BUG: soft lockup - CPU#1 stuck for 3489660884s!

This problem appears with the changes introduced by
    42043e4 spapr: clock should count only if vm is running

I think this commit only triggers the problem.

Kernel computes the soft lockup duration using the
Virtual Timebase register (VTB), not using the Timebase
Register (TBR, the one 42043e4 stops).

It appears VTB is not migrated, so this patch adds it in
the list of the SPRs to migrate, and fixes the problem.

For the migration, I've tested a migration from qemu-2.8.0 and
pseries-2.8.0 to a patched master (qemu-2.11.0-rc1). The received
VTB is 0 (as is it not initialized by qemu-2.8.0), but the value
seems to be ignored by KVM and a non zero VTB is used by the kernel.
I have no explanation for that, but as the original problem appears
only with SMP system under stress I suspect some problems in KVM
(I think because VTB is shared by all threads of a core).

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/ppc/translate_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index b9c49c22f2..4e11e6f489 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8081,10 +8081,10 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
 /* Virtual Time Base */
 static void gen_spr_vtb(CPUPPCState *env)
 {
-    spr_register(env, SPR_VTB, "VTB",
+    spr_register_kvm(env, SPR_VTB, "VTB",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
-                 0x00000000);
+                 KVM_REG_PPC_VTB, 0x00000000);
 }
 
 static void gen_spr_power8_fscr(CPUPPCState *env)
-- 
2.13.6
