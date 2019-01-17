Received: from eggs.gnu.org ([209.51.188.92]:37484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGe-0002m1-7l
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGV-0008Re-5S
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBGU-0008PC-TR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHETGa019878
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2v6bwcpu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:35 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:15:32 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:15:25 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774532548.1208625.1331299923906836771.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 09/19] spapr: populate PHB DRC entries for
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
index 5be8f76351fd..83ec79caf48e 100644
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
 
