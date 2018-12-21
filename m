Received: from eggs.gnu.org ([2001:4830:134:3::10]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8pB-0006j7-7n
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8p8-0008Ns-1k
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:37:57 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:60920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8p7-0008Lj-QL
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:37:53 -0500
Received: from player739.ha.ovh.net (unknown [10.109.160.5])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 80AA635890
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:37:52 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:37:36 +0100
Message-ID: <154535265622.862554.13338931723631685938.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 09/15] spapr: populate PHB DRC entries for root
 DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

This add entries to the root OF node to advertise our PHBs as being
DR-capable in accordance with PAPR specification.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 280e45037704..4f9d11b14666 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1350,6 +1350,14 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
         exit(1);
     }
 
+    if (smc->dr_phb_enabled) {
+        ret = spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
+        if (ret < 0) {
+            error_report("Couldn't set up PHB DR device tree properties");
+            exit(1);
+        }
+    }
+
     return fdt;
 }
 
