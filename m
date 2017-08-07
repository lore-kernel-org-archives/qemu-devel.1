Received: from eggs.gnu.org ([2001:4830:134:3::10]:43755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1delmG-0004S1-Ry
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1delmB-0002Uf-Vf
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:25:16 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1delmB-0002TA-Pg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:25:11 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 65A948B49E
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 19:25:10 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 07 Aug 2017 19:25:03 +0200
Message-ID: <150212670348.12227.5534815630591997333.stgit@bahia>
In-Reply-To: <150212666472.12227.5292551535430570753.stgit@bahia>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.10 PATCH 3/3] spapr: error out if PHB fails to
 setup PCI DRCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

It is currently possible to start QEMU with two PHBs without using the
index property:

-device spapr-pci-host-bridge,id=pci1,\
                              buid=0x800000020000001,\
                              liobn=0x80000100,\
                              liobn64=0x80000101,\
                              mem_win_addr=0x200100000000,\
                              mem64_win_addr=0x220000000000,\
                              io_win_addr=0x200000010000 \
-device spapr-pci-host-bridge,id=pci2,\
                              buid=0x800000020000002,\
                              liobn=0x80000200,\
                              liobn64=0x80000201,\
                              mem_win_addr=0x200180000000,\
                              mem64_win_addr=0x230000000000,\
                              io_win_addr=0x200000020000 \

Each PHB has its index property equal to -1. As a consequence, each PHB
will want to create PCI DRCs with the same ids:

    /* allocate connectors for child PCI devices */
    if (sphb->dr_enabled) {
        for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
                                   (sphb->index << 16) | i);
        }
    }

When DRC objects are added to the composition tree, an alias using the
DRC id is created in the "/dr-connector" path. But DRC ids are supposed
to be globally unique and the alias creation fails, leaving the DRC
object unrealized, which isn't expected by the rest of the DR logic.

This has the effect of silently turning-off PCI hotplug support (ie, PCI
hotplug no longer works on any PHB and no error message is printed).

This bug always existed and would even cause a non-fatal error to be
reported on the console (until recent commit bf26ae32a92a). This patch
causes the error message to be printed again and QEMU to exit.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 4b7882e3613d..4a1e6c5f697c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1731,9 +1731,16 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     /* allocate connectors for child PCI devices */
     if (sphb->dr_enabled) {
+        Error *local_err = NULL;
+
         for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
-                                   (sphb->index << 16) | i, NULL);
+                                   (sphb->index << 16) | i, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                error_prepend(errp, "Failed to create DRC: ");
+                return;
+            }
         }
     }
 
