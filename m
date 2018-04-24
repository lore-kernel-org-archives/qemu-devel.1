Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwA6-0003fX-6H
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwA1-0003h4-FJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:06 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:50572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAwA1-0003eI-9S
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:01 -0400
Received: from player774.ha.ovh.net (unknown [10.109.108.70])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9398DF1059
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 13:30:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 24 Apr 2018 13:30:41 +0200
Message-Id: <20180424113045.25687-2-clg@kaod.org>
In-Reply-To: <20180424113045.25687-1-clg@kaod.org>
References: <20180424113045.25687-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] target/ppc: return a nil HPT base
 address on sPAPR machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
hypervisor") exported a set of methods to manipulate the HPT from the
core hash MMU. But SPR_SDR1 is still used under some circumstances to
get the base address of the HPT, which is incorrect for the sPAPR
machines.

Only the logging should be impacted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v3:

 - removed spapr_hpt_base() ops and just return zero instead

 target/ppc/mmu-hash64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f23b78d78754..53dcec5b9316 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -101,6 +101,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
=20
 static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
 {
+    if (cpu->vhyp) {
+        return 0;
+    }
     return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
 }
=20
--=20
2.13.6
