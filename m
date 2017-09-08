Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-00025u-1I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdx-0003AK-80
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:29 +1000
Message-Id: <20170908103558.31632-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/40] spapr_iommu: pass object ownership to
 parent/owner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

TCE table objects attach themselves to an owner as a child
property. unref afterward to allow them to be finalized
when their owner is finalized.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 84d03df5ef..25c5f6d795 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -321,6 +321,7 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
     tmp = g_strdup_printf("tce-table-%x", liobn);
     object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
     g_free(tmp);
+    object_unref(OBJECT(tcet));
 
     object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
 
-- 
2.13.5
