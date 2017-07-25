Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da485-000263-HL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da482-0001dp-IJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:21 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:50717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da482-0001dL-BF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:18 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1D3821165DB
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:17 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:00:09 +0200
Message-ID: <150100560947.27487.8779404117672050454.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 10/26] spapr_iommu: pass object
 ownership to parent/owner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

TCE table objects attach themselves to an owner as a child
property. unref afterward to allow them to be finalized
when their owner is finalized.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- s/DRC/TCE table/ in changelog
---
 hw/ppc/spapr_iommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index d4eca2a77225..8ec4e7a40834 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -321,6 +321,7 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
     tmp = g_strdup_printf("tce-table-%x", liobn);
     object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
     g_free(tmp);
+    object_unref(OBJECT(tcet));
 
     object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
 
