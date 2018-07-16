Received: from eggs.gnu.org ([2001:4830:134:3::10]:39984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1P-0001B8-Ei
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1N-0004yS-6s
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 16 Jul 2018 18:38:05 +1000
Message-Id: <20180716083809.17115-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180716083809.17115-1-david@gibson.dropbear.id.au>
References: <20180716083809.17115-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/6] spapr: Correct inverted test in
 spapr_pc_dimm_node()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This function was introduced between v2.11 and v2.12 to replace obsolete
ways of specifying the NUMA nodes for DIMMs.  It's used to find the correct
node for an LMB, by locating which DIMM object it lies within.

Unfortunately, one of the checks is inverted, so we check whether the
address is less than two different things, rather than actually checking
a range.  This introduced a regression, meaning that after a reboot qemu
will advertise incorrect node information for memory to the guest.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3f5e1d3ec2..421b2dd09b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -665,7 +665,7 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
         if (value && value->type == MEMORY_DEVICE_INFO_KIND_DIMM) {
             PCDIMMDeviceInfo *pcdimm_info = value->u.dimm.data;
 
-            if (pcdimm_info->addr >= addr &&
+            if (addr >= pcdimm_info->addr &&
                 addr < (pcdimm_info->addr + pcdimm_info->size)) {
                 return pcdimm_info->node;
             }
-- 
2.17.1
