Received: from eggs.gnu.org ([2001:4830:134:3::10]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLC-0004PZ-OV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLA-0005g4-Vq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:58 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:17 -0500
Message-Id: <20180723201748.25573-9-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/99] target/ppc: always set PPC_MEM_TLBIE in
 pre 2.8 migration hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The pseries-2.7 and older machine types require CPUPPCState::insns_flags
to be strictly equal between source and destination. This checking is
abusive and breaks migration of KVM guests when the host CPU models
are different, even if they are compatible enough to allow the guest
to run transparently. This buggy behaviour was fixed for pseries-2.8
and we added some hacks to allow backward migration of older machine
types. These hacks assume that the CPU belongs to the POWER8 family,
which was true for most KVM based setup we cared about at the time.
But now POWER9 systems are coming, and backward migration of pre 2.8
guests running in POWER8 architected mode from a POWER9 host to a
POWER8 host is broken:

qemu-system-ppc64: error while loading state for instance 0x0 of device
 'cpu'
qemu-system-ppc64: load of migration failed: Invalid argument

This happens because POWER9 doesn't set PPC_MEM_TLBIE in insns_flags,
while POWER8 does. Let's force PPC_MEM_TLBIE in the migration hack to
fix the issue. This is an acceptable hack because these old machine
types only support CPU models that do set PPC_MEM_TLBIE.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit bce009645b9f1d59195518e35747c8ea30f985f7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 0634cdb295..cf44b97ced 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -200,6 +200,11 @@ static int cpu_pre_save(void *opaque)
             ;
         cpu->mig_msr_mask = env->msr_mask & ~metamask;
         cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
+        /* CPU models supported by old machines all have PPC_MEM_TLBIE,
+         * so we set it unconditionally to allow backward migration from
+         * a POWER9 host to a POWER8 host.
+         */
+        cpu->mig_insns_flags |= PPC_MEM_TLBIE;
         cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
         cpu->mig_nb_BATs = env->nb_BATs;
     }
-- 
2.17.1
