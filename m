Received: from eggs.gnu.org ([2001:4830:134:3::10]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49W-0003LO-K4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49T-00030C-J0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:50 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da49T-0002yS-C4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:47 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C7DB611658C
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:01:45 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:01:38 +0200
Message-ID: <150100569817.27487.947951250042841104.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 17/26] spapr_pci: introduce drc_id
 property
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

With the addition of PHB hotplug, we have a static number of DRCs
that can be used to handle hotplug/unplug operations on our PHBs,
and need a consistent way to map PHBs to these connectors, and
assign a unique identifiers for the connectors.

This patch adds a drc_id property for that purpose.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c          |    1 +
 include/hw/pci-host/spapr.h |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 994d2f36105f..54533d8a3841 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1878,6 +1878,7 @@ static Property spapr_phb_properties[] = {
                      pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
                      pcie_ecs, true),
+    DEFINE_PROP_UINT32("drc_id", sPAPRPHBState, drc_id, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 5a4e9686d562..31bae68167f2 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -82,6 +82,8 @@ struct sPAPRPHBState {
 
     bool pcie_ecs; /* Allow access to PCIe extended config space? */
 
+    uint32_t drc_id;
+
     /* Fields for migration compatibility hacks */
     bool pre_2_8_migration;
     uint32_t mig_liobn;
