Received: from eggs.gnu.org ([2001:4830:134:3::10]:60343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMxU-0005vS-1R
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMxT-00038A-3p
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:48:24 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Nov 2017 15:48:14 +1100
Message-Id: <20171122044814.3001-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171122044814.3001-1-david@gibson.dropbear.id.au>
References: <20171122044814.3001-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/3] ppc: fix VTB migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.14.3
