Received: from eggs.gnu.org ([2001:4830:134:3::10]:37339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELap-0001S4-TB
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELan-00006t-7e
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:47 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:57526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fELan-00005p-1f
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:16:45 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.37])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 60EE016B6D3
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 23:16:43 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 03 May 2018 23:16:29 +0200
Message-ID: <152538218900.223014.9011319433623501285.stgit@bahia.lan>
In-Reply-To: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: always set PPC_MEM_TLBIE in
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

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
---
 target/ppc/machine.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 3d6434a006fa..ba1b9e531f97 100644
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
