Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f8TMY-0000VX-F4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f8TMT-0004tY-GM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:21:46 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Tue, 17 Apr 2018 12:21:35 -0400
Message-Id: <1523982095-17175-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13] spapr: Correct max associativity
 domains value for non-NUMA configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

In non-NUMA configurations nb_numa_nodes is zero and we set 5th cell
in ibm,max-associativity-domains to -1. That causes to stall Linux
guests during boot after following line:

[    0.000000] NUMA associativity depth for CPU/Memory: 4

Make last possible NUMA in property zero to correct support for
non-NUMA guests.

Fixes: c1df49a670ef ("spapr: Add ibm,max-associativity-domains property")
Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7b2bc4e..bff2125 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -914,7 +914,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
         cpu_to_be32(0),
         cpu_to_be32(0),
         cpu_to_be32(0),
-        cpu_to_be32(nb_numa_nodes - 1),
+        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
     };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
-- 
1.8.3.1
