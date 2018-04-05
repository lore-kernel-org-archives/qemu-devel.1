Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zF-0007RJ-ID
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zB-0001Qg-KU
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:37 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Thu,  5 Apr 2018 10:35:23 -0400
Message-Id: <1522938923-96058-3-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13 2/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Now recent kernels (i.e. since linux-stable commit a346137e9142
("powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes")
support this property to mark initially memory-less NUMA nodes as "possible"
to allow further memory hot-add to them.

Advertise this property for pSeries machines to let guest kernels detect
maximum supported node configuration and benefit from kernel side change
when hot-add memory to specific, possibly empty before, NUMA node.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 hw/ppc/spapr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3ad4545..e02fc94 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -909,6 +909,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
         0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
         cpu_to_be32(max_cpus / smp_threads),
     };
+    uint32_t maxdomains[] = {
+        cpu_to_be32(5),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(nb_numa_nodes - 1),
+        cpu_to_be32(max_cpus - 1),
+    };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
@@ -945,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
                      refpoints, sizeof(refpoints)));
 
+    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
+                     maxdomains, sizeof(maxdomains)));
+
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
-- 
1.8.3.1
