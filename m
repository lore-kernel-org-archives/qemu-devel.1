Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f6KhB-0000S7-NY
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f6Kh7-0005Na-PQ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:42:13 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Wed, 11 Apr 2018 14:41:59 -0400
Message-Id: <1523472120-56496-2-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
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
 hw/ppc/spapr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a81570e..c05bbad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
         0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
         cpu_to_be32(max_cpus / smp_threads),
     };
+    uint32_t maxdomains[] = {
+        cpu_to_be32(4),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(0),
+        cpu_to_be32(nb_numa_nodes - 1),
+    };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
@@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
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
