Received: from eggs.gnu.org ([209.51.188.92]:38477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcji-00016G-Hl
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjg-0003an-Jm
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcjc-0003R2-Rg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJwe8064153
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm2xks7b4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:38 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:35 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:24:26 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <154999586635.690774.6503848986369114097.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/15] spapr_irq: Expose the phandle of the
 interrupt controller
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

This will be used by PHB hotplug in order to create the "interrupt-map"
property of the PHB node.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
v4: - return phandle via a pointer
---
 hw/ppc/spapr_irq.c         |   26 ++++++++++++++++++++++++++
 include/hw/ppc/spapr_irq.h |    2 ++
 2 files changed, 28 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b8d725e251ba..31495033c37c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -692,6 +692,32 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error=
 **errp)
     }
 }
=20
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
+                          uint32_t *phandle, Error **errp)
+{
+    const char *nodename =3D spapr->irq->get_nodename(spapr);
+    int offset, ph;
+
+    offset =3D fdt_subnode_offset(fdt, 0, nodename);
+    if (offset < 0) {
+        error_setg(errp, "Can't find node \"%s\": %s", nodename,
+                   fdt_strerror(offset));
+        return -1;
+    }
+
+    ph =3D fdt_get_phandle(fdt, offset);
+    if (!ph) {
+        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
+        return -1;
+    }
+
+    if (phandle) {
+        *phandle =3D ph;
+    }
+
+    return 0;
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ad7127355441..4b3303ef4f6a 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -62,6 +62,8 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, =
int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
 void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
+                          uint32_t *phandle, Error **errp);
=20
 /*
  * XICS legacy routines
