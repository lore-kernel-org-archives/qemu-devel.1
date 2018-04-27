Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzag-0002LP-0t
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaf-0002OL-4x
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:21 +1000
Message-Id: <20180427092126.24812-45-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 44/49] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Serhii Popovych <spopovyc@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Serhii Popovych <spopovyc@redhat.com>

Now recent kernels (i.e. since linux-stable commit a346137e9142
("powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes")
support this property to mark initially memory-less NUMA nodes as "possible"
to allow further memory hot-add to them.

Advertise this property for pSeries machines to let guest kernels detect
maximum supported node configuration and benefit from kernel side change
when hot-add memory to specific, possibly empty before, NUMA node.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8c2e3ccb89..2203b6f46d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -909,6 +909,13 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
         0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
         cpu_to_be32(max_cpus / smp_threads),
     };
+    uint32_t maxdomains[] = {
+        cpu_to_be32(4),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
+    };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
@@ -945,6 +952,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
                      refpoints, sizeof(refpoints)));
 
+    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
+                     maxdomains, sizeof(maxdomains)));
+
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
-- 
2.14.3
