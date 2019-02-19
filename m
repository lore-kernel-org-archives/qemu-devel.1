Received: from eggs.gnu.org ([209.51.188.92]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw92P-0002Wa-0R
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw92N-0007mA-0B
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw92K-0007Zj-Qd
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEPGh069627
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrmswvc90-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:23 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:18:21 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:18:13 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059669374.1466090.12943228478046223856.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 08/17] spapr_irq: Expose the phandle of the
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

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v5: - return phandle by value
v4: - return phandle via a pointer
---
 hw/ppc/spapr_irq.c         |   21 +++++++++++++++++++++
 include/hw/ppc/spapr_irq.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 359761494c6e..4145079d7fa5 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -638,6 +638,27 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **errp)
+{
+    const char *nodename = spapr->irq->get_nodename(spapr);
+    int offset, phandle;
+
+    offset = fdt_subnode_offset(fdt, 0, nodename);
+    if (offset < 0) {
+        error_setg(errp, "Can't find node \"%s\": %s", nodename,
+                   fdt_strerror(offset));
+        return -1;
+    }
+
+    phandle = fdt_get_phandle(fdt, offset);
+    if (!phandle) {
+        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
+        return -1;
+    }
+
+    return phandle;
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 8bf1a7291966..ec1ee64fa62b 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -61,6 +61,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
 void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **errp);
 
 /*
  * XICS legacy routines
