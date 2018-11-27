Received: from eggs.gnu.org ([2001:4830:134:3::10]:59466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3S-0002kb-SS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd3P-0005g8-OH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:30 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:52663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd3P-0005cV-HD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:05:27 -0500
Received: from player787.ha.ovh.net (unknown [10.109.143.3])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 469F2174F25
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:05:24 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:05:18 +0100
Message-ID: <154332391807.541746.1568292963548614592.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 2/9] spapr: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_iommu.c |    2 +-
 hw/ppc/spapr_vio.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 1b0880ac9edb..b56466f89a64 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -93,7 +93,7 @@ static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
 
     if (!table) {
         *fd = -1;
-        table = g_malloc0(nb_table * sizeof(uint64_t));
+        table = g_new0(uint64_t, nb_table);
     }
 
     trace_spapr_iommu_new_table(liobn, table, *fd);
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 840d4a3c451c..7e8a9ad09337 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -730,7 +730,7 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     }
 
     /* Copy out into an array of pointers */
-    qdevs = g_malloc(sizeof(qdev) * num);
+    qdevs = g_new(DeviceState *, num);
     num = 0;
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
         qdevs[num++] = kid->child;
