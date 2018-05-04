Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkv-00068Y-PV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETku-0007V7-0e
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:28 +1000
Message-Id: <20180504055930.3786-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/17] target/ppc: always set PPC_MEM_TLBIE in
 pre 2.8 migration hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
---
 target/ppc/machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 3d6434a006..ba1b9e531f 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -212,6 +212,11 @@ static int cpu_pre_save(void *opaque)
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
2.17.0
