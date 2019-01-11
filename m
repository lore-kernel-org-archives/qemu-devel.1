Received: from eggs.gnu.org ([209.51.188.92]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3wg-0005Kw-U4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3wf-00022p-0o
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:02:26 -0500
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3wc-00021H-V5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:02:24 -0500
Received: from player763.ha.ovh.net (unknown [10.109.160.46])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 68E901C6C7C
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:02:21 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:02:01 +0100
Message-ID: <154724052141.525985.14534597290520128299.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 05/13] spapr: populate PHB DRC entries for
 root DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

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
index 9eeb6792e261..ef8984286587 100644
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
 
