Received: from eggs.gnu.org ([2001:4830:134:3::10]:43178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkr-00062W-AB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkn-0007HX-Ez
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:14 +1000
Message-Id: <20180504055930.3786-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/17] target/ppc: return a nil HPT base address
 on sPAPR machines
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

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
hypervisor") exported a set of methods to manipulate the HPT from the
core hash MMU. But SPR_SDR1 is still used under some circumstances to
get the base address of the HPT, which is incorrect for the sPAPR
machines.

Only the logging should be impacted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d5fc03441d..f6349ccdb3 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -102,6 +102,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
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
2.17.0
